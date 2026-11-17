import { requireUser } from './_lib.js';

export async function onRequestGet({ request, env }) {
  const auth = await requireUser(request, env);
  if (auth.error) return auth.error;

  const unpaid = await env.DB.prepare(`
    SELECT s.unique_code, s.full_name, s.form, s.parent_phone,
           COALESCE(p.total_paid, 0) as total_paid,
           ff.amount as fee_expected,
           (ff.amount - COALESCE(p.total_paid, 0)) as balance
    FROM students s
    LEFT JOIN (SELECT student_id, SUM(amount) as total_paid FROM payments GROUP BY student_id) p ON p.student_id = s.id
    LEFT JOIN form_fees ff ON ff.form = s.form
    WHERE COALESCE(p.total_paid, 0) < ff.amount
    ORDER BY s.form, s.full_name
  `).all();

  let csv = "KINGS HIGH HOSTEL - SUNDAY RECONCILIATION\n";
  csv += "Generated: " + new Date().toLocaleString() + "\n\n";
  csv += "Code,Name,Form,Parent Phone,Paid,Expected,Balance\n";

  unpaid.results.forEach(s => {
    csv += `"${s.unique_code}","${s.full_name}","${s.form}","${s.parent_phone || ''}","${s.total_paid}","${s.fee_expected}","${s.balance}"\n`;
  });

  return new Response(csv, {
    headers: {
      'Content-Type': 'text/csv',
      'Content-Disposition': 'attachment; filename="sunday_reconciliation.csv"'
    }
  });
}
