import { requireUser, json, err } from '../../_lib.js';

export async function onRequestPost({ request, env, params }) {
  const auth = await requireUser(request, env);
  if (auth.error) return auth.error;
  
  try {
    const id = Number(params.id);
    const row = await env.DB.prepare(`
      SELECT a.student_id, a.bed_id, s.form
      FROM allocations a JOIN students s ON s.id = a.student_id
      WHERE a.id = ? AND a.is_active = 1
    `).bind(id).first();
    
    if (!row) return err('Allocation not found', 404);
    
    const fee = await env.DB.prepare("SELECT amount FROM form_fees WHERE form = ?").bind(row.form).first();
    const paid = await env.DB.prepare("SELECT COALESCE(SUM(amount),0) AS total FROM payments WHERE student_id = ?").bind(row.student_id).first();
    const balance = Math.max(0, fee.amount - paid.total);
    
    await env.DB.batch([
      env.DB.prepare("UPDATE allocations SET is_active = 0, check_out_date = date('now'), balance_at_checkout = ? WHERE id = ?").bind(balance, id),
      env.DB.prepare("UPDATE beds SET status = 'available' WHERE id = ?").bind(row.bed_id)
    ]);
    
    return json({ ok: true, balance_at_checkout: balance });
  } catch (e) {
    return json({ error: e.message }, 500);
  }
}
