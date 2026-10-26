INSERT INTO rooms (name, capacity) VALUES
  ('Room 1', 10),
  ('Room 2', 8),
  ('Room 3', 8),
  ('Room 4', 6),
  ('Room 5', 6),
  ('Room 6', 6),
  ('Room 7', 4);

INSERT INTO form_fees (form, amount) VALUES (1, 400), (2, 400), (3, 400);

INSERT INTO users (username, password_hash, role) VALUES
  ('supervisor1', '41414d5d5ff7626b3bc7ff1220b62ec6:b5ec23e1b0e478321657c1629db79753702416fc447e054ae97ade92363586fe', 'supervisor'),
  ('manager1',    'd1553fdc53150b1e0b1deccba73b1db9:7c5659d2720b598dda0bddb6b146eda8bc6df216f7e7d1815dc0596245eaa3d4', 'manager'),
  ('ceo1',        '4605a5b368012d9cb056b3954e5dac67:51a025d85209ea2b94cb08bc6298e6833fc4209a833966cc96eb5ede9622c58a', 'ceo');
