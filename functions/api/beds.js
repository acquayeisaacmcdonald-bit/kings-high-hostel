import { requireUser, json } from './_lib.js';

export async function onRequestGet({ request, env }) {
  const auth = await requireUser(request, env);
  if (auth.error) return auth.error;
  
  const rows = await env.DB.prepare(`
    SELECT b.id, b.bed_label, b.status, r.name as room_name
    FROM beds b JOIN rooms r ON r.id = b.room_id
    ORDER BY r.id, b.id
  `).all();
  return json({ beds: rows.results });
}
