import { requireUser, json } from './_lib.js';

export async function onRequestGet({ request, env }) {
  const auth = await requireUser(request, env);
  if (auth.error) return auth.error;

  try {
    const d = await env.DB.prepare(`
      SELECT
        (SELECT COUNT(*) FROM students)                              AS total_students,
        (SELECT COUNT(*) FROM students WHERE form=1)                 AS students_f1,
        (SELECT COUNT(*) FROM students WHERE form=2)                 AS students_f2,
        (SELECT COUNT(*) FROM students WHERE form=3)                 AS students_f3,
        (SELECT COUNT(*) FROM payments WHERE payment_type='full')    AS full_all,
        (SELECT COUNT(*) FROM payments WHERE payment_type='part')    AS part_all,
        (SELECT COALESCE(SUM(amount),0) FROM payments)               AS total_collected,
        (SELECT COUNT(*) FROM allocations WHERE is_active=1)         AS currently_lodged
    `).first();

    return json({
      students: {
        total: d.total_students,
        byForm: { 1: d.students_f1, 2: d.students_f2, 3: d.students_f3 }
      },
      payments: {
        all: { full: d.full_all, part: d.part_all }
      },
      finance: { totalCollected: d.total_collected },
      occupancy: { lodged: d.currently_lodged }
    });
  } catch (error) {
    return json({ error: error.message }, 500);
  }
}
