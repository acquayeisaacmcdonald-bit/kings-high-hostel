CREATE TABLE IF NOT EXISTS settings (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
);

INSERT INTO settings (key, value) VALUES 
('hostel_name', 'Kings High Hostel')
ON CONFLICT(key) DO NOTHING;

CREATE TABLE IF NOT EXISTS subscriptions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  trial_ends_at TEXT NOT NULL,
  is_active INTEGER DEFAULT 1
);

