import { requireUser, json } from './_lib.js';

export async function onRequestGet({ request, env }) {
  try {
    const auth = await requireUser(request, env);
    if (auth.error) return auth.error;

    // Collected per form — direct from payments table
    const collected = await env.DB.prepare(`
      SELECT form_at_payment as form, 
             SUM(amount) as total_collected,
             COUNT(*) as transaction_count
      FROM payments
      GROUP BY form_at_payment
      ORDER BY form_at_payment
    `).all();

    // Unpaid/partial students — based on student's form vs total paid
    const unpaidList = await env.DB.prepare(`
      SELECT s.id, s.unique_code, s.full_name, s.form,
             COALESCE(p.total_paid, 0) as total_paid,
             ff.amount as fee_expected,
             (ff.amount - COALESCE(p.total_paid, 0)) as balance
      FROM students s
      LEFT JOIN (SELECT student_id, SUM(amount) as total_paid FROM payments GROUP BY student_id) p ON p.student_id = s.id
      LEFT JOIN form_fees ff ON ff.form = s.form
      WHERE COALESCE(p.total_paid, 0) < ff.amount
      ORDER BY s.form, s.full_name
    `).all();

    return json({
      collected: collected.results,
      unpaid_students: unpaidList.results
    });
  } catch (e) {
    return json({ error: e.message, stack: e.stack }, 500);
  }
}
