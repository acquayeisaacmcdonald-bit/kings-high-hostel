import { requireUser, json, err } from './_lib.js';

export async function onRequestPost({ request, env }) {
  const auth = await requireUser(request, env);
  if (auth.error) return auth.error;
  
  try {
    const { student_id, amount } = await request.json();
    const payAmount = Number(amount);
    
    if (!student_id || !payAmount || payAmount <= 0) return err('Please enter a valid figure.');

    const student = await env.DB.prepare(`
      SELECT s.*, b.bed_label, r.name as room_name 
      FROM students s
      LEFT JOIN allocations a ON a.student_id = s.id AND a.is_active = 1
      LEFT JOIN beds b ON b.id = a.bed_id
      LEFT JOIN rooms r ON r.id = b.room_id
      WHERE s.id = ?
    `).bind(student_id).first();
    
    if (!student) return err('Student not found', 404);
    
    const feeRow = await env.DB.prepare("SELECT amount FROM form_fees WHERE form = ?").bind(student.form).first();
    const expected = feeRow.amount;
    
    const prior = await env.DB.prepare("SELECT COALESCE(SUM(amount),0) AS total FROM payments WHERE student_id = ?").bind(student_id).first();
    const balance = Math.max(0, expected - prior.total);

    // PREVENT OVERPAYMENT
    if (payAmount > balance) {
      return err(`Amount exceeds balance! The remaining balance is GHC ${balance}.`, 400);
    }
    
    const totalAfter = prior.total + payAmount;
    const paymentType = totalAfter >= expected ? 'full' : 'part';
    const receipt_no = `RCP-${Date.now()}-${student_id}`;
    
    await env.DB.prepare(`
      INSERT INTO payments (student_id, amount, payment_type, form_at_payment, fee_expected, receipt_no)
      VALUES (?, ?, ?, ?, ?, ?)
    `).bind(student_id, payAmount, paymentType, student.form, expected, receipt_no).run();
    
    return json({ 
      ok: true, receipt_no, payment_type: paymentType, balance: Math.max(0, expected - totalAfter),
      amount: payAmount, fee_expected: expected, total_paid: totalAfter,
      student_id: student.id, student_name: student.full_name, student_code: student.unique_code,
      form: student.form, room: student.room_name ? `${student.room_name} / ${student.bed_label}` : 'Not allocated'
    }, 201);
  } catch (e) {
    return json({ error: e.message }, 500);
  }
}
