import { requireUser } from './_lib.js';

export async function onRequestGet({ request, env }) {
  const auth = await requireUser(request, env);
  if (auth.error) return auth.error;
  
  const rows = await env.DB.prepare(`
    SELECT s.unique_code, s.full_name, s.form, s.course, s.parent_name, s.parent_phone,
           r.name as room, b.bed_label,
           COALESCE(p.total_paid, 0) as total_paid,
           ff.amount as fee_expected
    FROM students s
    LEFT JOIN allocations a ON a.student_id = s.id AND a.is_active = 1
    LEFT JOIN beds b ON b.id = a.bed_id
    LEFT JOIN rooms r ON r.id = b.room_id
    LEFT JOIN (SELECT student_id, SUM(amount) as total_paid FROM payments GROUP BY student_id) p ON p.student_id = s.id
    LEFT JOIN form_fees ff ON ff.form = s.form
    ORDER BY s.form, s.full_name
  `).all();
  
  let csv = "Code,Name,Form,Course,Parent Name,Parent Phone,Room,Bed,Total Paid,Balance\n";
  rows.results.forEach(s => {
    const balance = Math.max(0, s.fee_expected - s.total_paid);
    csv += `"${s.unique_code}","${s.full_name}","${s.form}","${s.course || ''}","${s.parent_name || ''}","${s.parent_phone || ''}","${s.room || 'None'}","${s.bed_label || 'None'}","${s.total_paid}","${balance}"\n`;
  });
  
  return new Response(csv, {
    headers: {
      'Content-Type': 'text/csv',
      'Content-Disposition': 'attachment; filename="kings_high_hostel_students.csv"'
    }
  });
}
