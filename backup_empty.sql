PRAGMA defer_foreign_keys=TRUE;
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('supervisor','manager','ceo')),
  created_at TEXT DEFAULT (datetime('now'))
);
INSERT INTO "users" ("id","username","password_hash","role","created_at") VALUES(1,'supervisor1','41414d5d5ff7626b3bc7ff1220b62ec6:b5ec23e1b0e478321657c1629db79753702416fc447e054ae97ade92363586fe','supervisor','2026-10-24 16:33:54');
INSERT INTO "users" ("id","username","password_hash","role","created_at") VALUES(2,'manager1','d1553fdc53150b1e0b1deccba73b1db9:7c5659d2720b598dda0bddb6b146eda8bc6df216f7e7d1815dc0596245eaa3d4','manager','2026-10-24 16:33:54');
INSERT INTO "users" ("id","username","password_hash","role","created_at") VALUES(3,'ceo1','4605a5b368012d9cb056b3954e5dac67:51a025d85209ea2b94cb08bc6298e6833fc4209a833966cc96eb5ede9622c58a','ceo','2026-10-24 16:33:54');
CREATE TABLE rooms (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  capacity INTEGER NOT NULL
);
INSERT INTO "rooms" ("id","name","capacity") VALUES(1,'Room 1',10);
INSERT INTO "rooms" ("id","name","capacity") VALUES(2,'Room 2',8);
INSERT INTO "rooms" ("id","name","capacity") VALUES(3,'Room 3',8);
INSERT INTO "rooms" ("id","name","capacity") VALUES(4,'Room 4',6);
INSERT INTO "rooms" ("id","name","capacity") VALUES(5,'Room 5',6);
INSERT INTO "rooms" ("id","name","capacity") VALUES(6,'Room 6',6);
INSERT INTO "rooms" ("id","name","capacity") VALUES(7,'Room 7',4);
CREATE TABLE beds (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  room_id INTEGER NOT NULL,
  bed_label TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'available' CHECK (status IN ('available','occupied')),
  FOREIGN KEY (room_id) REFERENCES rooms(id)
);
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(1,1,'Bed 1','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(2,1,'Bed 2','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(3,1,'Bed 3','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(4,1,'Bed 4','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(5,1,'Bed 5','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(6,1,'Bed 6','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(7,1,'Bed 7','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(8,1,'Bed 8','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(9,1,'Bed 9','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(10,1,'Bed 10','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(11,1,'Bed 11','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(12,1,'Bed 12','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(13,1,'Bed 13','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(14,1,'Bed 14','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(15,1,'Bed 15','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(16,1,'Bed 16','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(17,1,'Bed 17','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(18,1,'Bed 18','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(19,1,'Bed 19','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(20,1,'Bed 20','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(21,2,'Bed 1','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(22,2,'Bed 2','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(23,2,'Bed 3','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(24,2,'Bed 4','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(25,2,'Bed 5','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(26,2,'Bed 6','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(27,2,'Bed 7','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(28,2,'Bed 8','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(29,2,'Bed 9','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(30,2,'Bed 10','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(31,2,'Bed 11','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(32,2,'Bed 12','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(33,2,'Bed 13','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(34,2,'Bed 14','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(35,2,'Bed 15','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(36,3,'Bed 1','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(37,3,'Bed 2','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(38,3,'Bed 3','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(39,3,'Bed 4','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(40,3,'Bed 5','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(41,3,'Bed 6','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(42,3,'Bed 7','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(43,3,'Bed 8','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(44,3,'Bed 9','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(45,3,'Bed 10','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(46,3,'Bed 11','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(47,3,'Bed 12','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(48,3,'Bed 13','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(49,3,'Bed 14','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(50,3,'Bed 15','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(51,4,'Bed 1','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(52,4,'Bed 2','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(53,4,'Bed 3','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(54,4,'Bed 4','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(55,4,'Bed 5','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(56,4,'Bed 6','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(57,4,'Bed 7','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(58,4,'Bed 8','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(59,4,'Bed 9','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(60,4,'Bed 10','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(61,4,'Bed 11','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(62,4,'Bed 12','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(63,4,'Bed 13','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(64,4,'Bed 14','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(65,4,'Bed 15','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(66,5,'Bed 1','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(67,5,'Bed 2','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(68,5,'Bed 3','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(69,5,'Bed 4','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(70,5,'Bed 5','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(71,5,'Bed 6','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(72,5,'Bed 7','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(73,5,'Bed 8','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(74,5,'Bed 9','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(75,5,'Bed 10','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(76,5,'Bed 11','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(77,5,'Bed 12','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(78,5,'Bed 13','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(79,5,'Bed 14','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(80,5,'Bed 15','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(81,6,'Bed 1','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(82,6,'Bed 2','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(83,6,'Bed 3','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(84,6,'Bed 4','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(85,6,'Bed 5','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(86,6,'Bed 6','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(87,6,'Bed 7','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(88,6,'Bed 8','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(89,6,'Bed 9','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(90,6,'Bed 10','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(91,6,'Bed 11','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(92,6,'Bed 12','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(93,6,'Bed 13','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(94,6,'Bed 14','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(95,6,'Bed 15','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(96,7,'Bed 1','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(97,7,'Bed 2','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(98,7,'Bed 3','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(99,7,'Bed 4','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(100,7,'Bed 5','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(101,7,'Bed 6','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(102,7,'Bed 7','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(103,7,'Bed 8','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(104,7,'Bed 9','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(105,7,'Bed 10','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(106,7,'Bed 11','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(107,7,'Bed 12','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(108,7,'Bed 13','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(109,7,'Bed 14','available');
INSERT INTO "beds" ("id","room_id","bed_label","status") VALUES(110,7,'Bed 15','available');
CREATE TABLE form_fees (
  form INTEGER PRIMARY KEY CHECK (form IN (1,2,3)),
  amount REAL NOT NULL DEFAULT 400,
  updated_by INTEGER,
  updated_at TEXT,
  FOREIGN KEY (updated_by) REFERENCES users(id)
);
INSERT INTO "form_fees" ("form","amount","updated_by","updated_at") VALUES(1,450,NULL,NULL);
INSERT INTO "form_fees" ("form","amount","updated_by","updated_at") VALUES(2,400,NULL,NULL);
INSERT INTO "form_fees" ("form","amount","updated_by","updated_at") VALUES(3,400,NULL,NULL);
CREATE TABLE students (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  unique_code TEXT UNIQUE NOT NULL,
  full_name TEXT NOT NULL,
  form INTEGER NOT NULL CHECK (form IN (1,2,3)),
  phone TEXT,
  created_at TEXT DEFAULT (datetime('now'))
, course TEXT, parent_name TEXT, parent_phone TEXT);
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
DELETE FROM sqlite_sequence;
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('rooms',7);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('users',3);
INSERT INTO "sqlite_sequence" ("name","seq") VALUES('beds',110);
CREATE INDEX idx_payments_student ON payments(student_id);
CREATE INDEX idx_payments_form ON payments(form_at_payment);
CREATE INDEX idx_alloc_student ON allocations(student_id);
CREATE INDEX idx_alloc_active ON allocations(is_active);
