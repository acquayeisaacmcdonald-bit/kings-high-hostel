import { requireUser, json, err } from './_lib.js';

export async function onRequestGet({ request, env }) {
  const auth = await requireUser(request, env);
  if (auth.error) return auth.error;
  
  const rows = await env.DB.prepare(`
    SELECT s.id, s.unique_code, s.full_name, s.form, s.course, s.parent_name, s.parent_phone,
           a.id as allocation_id, b.bed_label, r.name as room_name,
           COALESCE(p.total_paid, 0) as total_paid,
           ff.amount as fee_expected
    FROM students s
    LEFT JOIN allocations a ON a.student_id = s.id AND a.is_active = 1
    LEFT JOIN beds b ON b.id = a.bed_id
    LEFT JOIN rooms r ON r.id = b.room_id
    LEFT JOIN (SELECT student_id, SUM(amount) as total_paid FROM payments GROUP BY student_id) p ON p.student_id = s.id
    LEFT JOIN form_fees ff ON ff.form = s.form
    ORDER BY s.id DESC
  `).all();
  
  const students = rows.results.map(s => {
    let status = 'unpaid';
    if (s.total_paid > 0) status = s.total_paid >= s.fee_expected ? 'full' : 'part';
    return { ...s, pay_status: status, balance: Math.max(0, s.fee_expected - s.total_paid) };
  });
  
  return json({ students });
}

export async function onRequestPost({ request, env }) {
  const auth = await requireUser(request, env);
  if (auth.error) return auth.error;
  
  try {
    const { full_name, form, phone, course, parent_name, parent_phone } = await request.json();
    
    // STRICT NAME VALIDATION
    if (!full_name || !/^[a-zA-Z\s]+$/.test(full_name)) {
      return err('Name can only contain letters and spaces. No symbols or periods allowed.');
    }
    if (![1,2,3].includes(Number(form))) return err('Invalid form');
    
    const existing = await env.DB.prepare("SELECT id FROM students WHERE full_name = ?").bind(full_name.trim()).first();
    if (existing) return err('A student with this exact name already exists.');
    
    const countRow = await env.DB.prepare("SELECT COUNT(*) AS c FROM students WHERE form = ?").bind(Number(form)).first();
    const unique_code = `KHH-F${form}-${String(countRow.c + 1).padStart(3, '0')}`;
    
    const result = await env.DB.prepare(
      "INSERT INTO students (unique_code, full_name, form, phone, course, parent_name, parent_phone) VALUES (?, ?, ?, ?, ?, ?, ?)"
    ).bind(unique_code, full_name.trim(), Number(form), phone || null, course || null, parent_name || null, parent_phone || null).run();
    
    return json({ ok: true, id: result.meta.last_row_id, unique_code }, 201);
  } catch (e) {
    return json({ error: e.message }, 500);
  }
}
