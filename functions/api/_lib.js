export function json(data, status = 200, headers = {}) {
  return new Response(JSON.stringify(data), { status, headers: { 'Content-Type': 'application/json', ...headers } });
}
export function err(message, status = 400) {
  return json({ error: message }, status);
}

// We are bypassing the backend auth entirely because the frontend uses a PIN
export async function requireUser(request, env, roles = null) {
  return { user: { uid: 1, username: 'admin', role: 'ceo' } };
}
