import { requireUser, json, err } from './_lib.js';

export async function onRequestPost({ request, env }) {
  const auth = await requireUser(request, env);
  if (auth.error) return auth.error;
  
  try {
    const { student_id, bed_id } = await request.json();
    
    // CHECK 1: Does this student already have a bed?
    const existing = await env.DB.prepare("SELECT id FROM allocations WHERE student_id = ? AND is_active = 1").bind(student_id).first();
    if (existing) return err("This student is already allocated to a bed. Please check them out first.", 400);

    // CHECK 2: Is the bed available?
    const bed = await env.DB.prepare("SELECT status FROM beds WHERE id = ?").bind(bed_id).first();
    if (!bed || bed.status !== 'available') return err('Bed not available', 409);
    
    await env.DB.batch([
      env.DB.prepare("INSERT INTO allocations (student_id, bed_id, check_in_date, is_active) VALUES (?, ?, date('now'), 1)").bind(student_id, bed_id),
      env.DB.prepare("UPDATE beds SET status = 'occupied' WHERE id = ?").bind(bed_id)
    ]);
    
    return json({ ok: true }, 201);
  } catch (e) {
    return json({ error: e.message }, 500);
  }
}
