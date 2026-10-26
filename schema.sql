PRAGMA foreign_keys = ON;

CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('supervisor','manager','ceo')),
  created_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE rooms (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  capacity INTEGER NOT NULL
);

CREATE TABLE beds (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  room_id INTEGER NOT NULL,
  bed_label TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'available' CHECK (status IN ('available','occupied')),
  FOREIGN KEY (room_id) REFERENCES rooms(id)
);

CREATE TABLE form_fees (
  form INTEGER PRIMARY KEY CHECK (form IN (1,2,3)),
  amount REAL NOT NULL DEFAULT 400,
  updated_by INTEGER,
  updated_at TEXT,
  FOREIGN KEY (updated_by) REFERENCES users(id)
);

CREATE TABLE students (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  unique_code TEXT UNIQUE NOT NULL,
  full_name TEXT NOT NULL,
  form INTEGER NOT NULL CHECK (form IN (1,2,3)),
  phone TEXT,
  created_at TEXT DEFAULT (datetime('now'))
);

CREATE TABLE allocations (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  student_id INTEGER NOT NULL,
  bed_id INTEGER NOT NULL,
  check_in_date TEXT NOT NULL,
  check_out_date TEXT,
  is_active INTEGER NOT NULL DEFAULT 1,
  balance_at_checkout REAL,
  checked_out_by INTEGER,
  FOREIGN KEY (student_id) REFERENCES students(id),
  FOREIGN KEY (bed_id) REFERENCES beds(id),
  FOREIGN KEY (checked_out_by) REFERENCES users(id)
);

CREATE TABLE payments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  student_id INTEGER NOT NULL,
  amount REAL NOT NULL,
  payment_type TEXT NOT NULL CHECK (payment_type IN ('full','part')),
  form_at_payment INTEGER NOT NULL,
  fee_expected REAL NOT NULL,
  receipt_no TEXT UNIQUE NOT NULL,
  recorded_by INTEGER,
  paid_at TEXT DEFAULT (datetime('now')),
  FOREIGN KEY (student_id) REFERENCES students(id),
  FOREIGN KEY (recorded_by) REFERENCES users(id)
);

CREATE INDEX idx_payments_student ON payments(student_id);
CREATE INDEX idx_payments_form ON payments(form_at_payment);
CREATE INDEX idx_alloc_student ON allocations(student_id);
CREATE INDEX idx_alloc_active ON allocations(is_active);
