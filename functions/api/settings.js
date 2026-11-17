import { requireUser, json, err } from './_lib.js';

export async function onRequestGet({ request, env }) {
  const auth = await requireUser(request, env);
  if (auth.error) return auth.error;

  const nameRow = await env.DB.prepare("SELECT value FROM settings WHERE key='hostel_name'").first();
  const subRow = await env.DB.prepare("SELECT trial_ends_at, is_active FROM subscriptions ORDER BY id DESC LIMIT 1").first();
  
  const today = new Date().toISOString().split('T')[0];
  const trialDate = subRow ? subRow.trial_ends_at : '2099-12-31';
  const isActive = subRow ? subRow.is_active : 1;
  const isLocked = trialDate < today && isActive === 0;

  return json({
    hostel_name: nameRow ? nameRow.value : 'My Hostel',
    trial_ends_at: trialDate,
    is_locked: isLocked
  });
}

export async function onRequestPut({ request, env }) {
  const auth = await requireUser(request, env, ['ceo']);
  if (auth.error) return auth.error;

  try {
    const { hostel_name, extend_trial_days } = await request.json();
    if (hostel_name) {
      await env.DB.prepare("UPDATE settings SET value = ? WHERE key = 'hostel_name'").bind(hostel_name).run();
    }
    if (extend_trial_days) {
      await env.DB.prepare(
        "UPDATE subscriptions SET trial_ends_at = date(trial_ends_at, '+' || ? || ' days'), is_active = 1 WHERE id = (SELECT id FROM subscriptions ORDER BY id DESC LIMIT 1)"
      ).bind(extend_trial_days).run();
    }
    return json({ ok: true });
  } catch (e) {
    return json({ error: e.message }, 500);
  }
}
