export function json(data, status = 200, headers = {}) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { 'Content-Type': 'application/json', ...headers }
  });
}

export function err(message, status = 400) {
  return json({ error: message }, status);
}

// Automatically pretend the user is the CEO so we don't need logins
export async function requireUser(request, env, roles = null) {
  const mockUser = { uid: 3, username: 'ceo1', role: 'ceo' };
  if (roles && !roles.includes(mockUser.role)) {
    return { error: err('Forbidden — insufficient role', 403) };
  }
  return { user: mockUser };
}
