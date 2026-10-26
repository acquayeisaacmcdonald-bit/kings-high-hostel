import { requireUser, json, err } from './_lib.js';

export async function onRequestGet({ request, env }) {
  const auth = await requireUser(request, env);
  if (auth.error) return auth.error;
  const rows = await env.DB.prepare("SELECT form, amount FROM form_fees ORDER BY form").all();
  return json({ fees: rows.results });
}

export async function onRequestPut({ request, env }) {
  const auth = await requireUser(request, env);
  if (auth.error) return auth.error;
  
  const { form, amount } = await request.json();
  if (!form || !amount || Number(amount) < 400) return err('Fee must be >= 400');
  
  await env.DB.prepare("UPDATE form_fees SET amount = ? WHERE form = ?").bind(Number(amount), Number(form)).run();
  return json({ ok: true });
}
