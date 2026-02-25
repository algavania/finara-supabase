-- ============================================
-- Finara: Personas Seed Data
-- Generated from personas.md
-- ============================================
-- Copy-paste this into Supabase SQL Editor
-- Prerequisites: profiles must exist (from auth), categories must be seeded
-- ============================================

-- ============================================
-- 1. UPDATE PROFILES (income, savings, risk_tolerance)
-- ============================================

-- Rina Maharani
UPDATE profiles SET
  monthly_income = 2500000.00,
  savings = 800000.00,
  risk_tolerance = 'low',
  updated_at = NOW()
WHERE id = '17dc4bed-91c9-4900-8b08-57246fe10ab1';

-- Budi Santoso
UPDATE profiles SET
  monthly_income = 8000000.00,
  savings = 5000000.00,
  risk_tolerance = 'medium',
  updated_at = NOW()
WHERE id = '92889a30-f790-4e6f-a1ca-f16112fc9dd0';

-- Siti Aisyah
UPDATE profiles SET
  monthly_income = 5500000.00,
  savings = 2500000.00,
  risk_tolerance = 'high',
  updated_at = NOW()
WHERE id = '3aca0966-b2e2-4a00-817b-d8f649bce275';

-- Arief Pratama
UPDATE profiles SET
  monthly_income = 12000000.00,
  savings = 15000000.00,
  risk_tolerance = 'low',
  updated_at = NOW()
WHERE id = '65e3862b-93b7-46c8-8643-80ed785f2c49';

-- Dewi Kartika
UPDATE profiles SET
  monthly_income = 1500000.00,
  savings = 200000.00,
  risk_tolerance = 'high',
  updated_at = NOW()
WHERE id = 'e784da4d-e951-42eb-b939-6e0715d51e55';


-- ============================================
-- 2. INSERT DEBTS
-- ============================================

-- --- Rina Maharani ---
INSERT INTO debts (user_id, name, creditor, type, principal, current_balance, interest_rate, minimum_payment, due_date, penalty_rate, stress_level, status) VALUES
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', 'Shopee PayLater', 'Shopee', 'bnpl', 1200000.00, 900000.00, 0.0295, 250000.00, 15, 0.0500, 8, 'active'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', 'Pinjaman Teman', NULL, 'personal_loan', 500000.00, 500000.00, 0.0000, 100000.00, 25, 0.0000, 6, 'active');

-- --- Budi Santoso ---
INSERT INTO debts (user_id, name, creditor, type, principal, current_balance, interest_rate, minimum_payment, due_date, penalty_rate, stress_level, status) VALUES
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', 'Kredit Motor Honda Vario', 'Dealer Honda', 'personal_loan', 18000000.00, 12500000.00, 0.0150, 850000.00, 10, 0.0300, 5, 'active'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', 'KTA Bank BRI', 'Bank BRI', 'personal_loan', 10000000.00, 7200000.00, 0.0120, 500000.00, 20, 0.0400, 4, 'active'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', 'Traveloka PayLater', 'Traveloka', 'bnpl', 3500000.00, 2100000.00, 0.0250, 350000.00, 5, 0.0500, 7, 'active');

-- --- Siti Aisyah ---
INSERT INTO debts (user_id, name, creditor, type, principal, current_balance, interest_rate, minimum_payment, due_date, penalty_rate, stress_level, status) VALUES
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', 'Akulaku Installment (Laptop)', 'Akulaku', 'bnpl', 8000000.00, 5500000.00, 0.0320, 600000.00, 12, 0.0600, 7, 'active'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', 'KTA Bank BNI', 'Bank BNI', 'personal_loan', 15000000.00, 11000000.00, 0.0180, 750000.00, 28, 0.0350, 6, 'active'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', 'Kredivo Balance', 'Kredivo', 'credit_card', 2000000.00, 1800000.00, 0.0295, 200000.00, 1, 0.0500, 9, 'active');

-- --- Arief Pratama ---
INSERT INTO debts (user_id, name, creditor, type, principal, current_balance, interest_rate, minimum_payment, due_date, penalty_rate, stress_level, status) VALUES
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', 'KPR Apartment', 'Bank Mandiri', 'mortgage', 250000000.00, 220000000.00, 0.0075, 3200000.00, 5, 0.0200, 3, 'active'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', 'Kartu Kredit BCA', 'Bank BCA', 'credit_card', 8000000.00, 4500000.00, 0.0225, 450000.00, 15, 0.0500, 5, 'active'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', 'Pinjaman Keluarga', NULL, 'personal_loan', 5000000.00, 3000000.00, 0.0000, 500000.00, NULL, 0.0000, 2, 'active');

-- --- Dewi Kartika ---
INSERT INTO debts (user_id, name, creditor, type, principal, current_balance, interest_rate, minimum_payment, due_date, penalty_rate, stress_level, status) VALUES
  ('e784da4d-e951-42eb-b939-6e0715d51e55', 'SPayLater Shopee', 'Shopee', 'bnpl', 800000.00, 600000.00, 0.0295, 150000.00, 20, 0.0500, 9, 'active'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', 'GoPay PayLater', 'GoPay', 'bnpl', 500000.00, 450000.00, 0.0250, 100000.00, 10, 0.0400, 8, 'active'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', 'Pinjol Online Lending', 'Pinjol App', 'personal_loan', 1000000.00, 1200000.00, 0.1000, 300000.00, 3, 0.1500, 10, 'active');


-- ============================================
-- 3. INSERT TRANSACTIONS (last 2 months of realistic data)
-- ============================================

-- --- Rina Maharani (income: 2.5M, top: Food 40%, Transport 20%, Shopping 15%) ---
INSERT INTO transactions (user_id, category_id, amount, type, description, merchant, date, is_recurring, source) VALUES
  -- Income
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Salary' LIMIT 1), 1200000.00, 'income', 'Gaji part-time Januari', 'Starbucks', '2026-01-25', true, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Other Income' LIMIT 1), 1300000.00, 'income', 'Uang saku dari orang tua', NULL, '2026-01-05', true, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Salary' LIMIT 1), 1200000.00, 'income', 'Gaji part-time Februari', 'Starbucks', '2026-02-25', true, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Other Income' LIMIT 1), 1300000.00, 'income', 'Uang saku dari orang tua', NULL, '2026-02-05', true, 'manual'),
  -- Food & Dining (40% of ~2.5M = ~1M)
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 35000.00, 'expense', 'Makan siang', 'Warteg Bu Sari', '2026-01-06', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 45000.00, 'expense', 'GrabFood dinner', 'GrabFood', '2026-01-08', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 28000.00, 'expense', 'Kopi dan snack', 'Kopi Kenangan', '2026-01-10', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 55000.00, 'expense', 'Makan bareng teman', 'McDonald''s', '2026-01-14', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 120000.00, 'expense', 'Weekly groceries', 'Alfamart', '2026-01-15', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 40000.00, 'expense', 'GoFood lunch', 'GoFood', '2026-01-18', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 65000.00, 'expense', 'Dinner out', 'Solaria', '2026-01-22', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 150000.00, 'expense', 'Weekly groceries', 'Indomaret', '2026-01-28', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 42000.00, 'expense', 'Makan malam', 'Warteg Bu Sari', '2026-02-03', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 38000.00, 'expense', 'ShopeeFood order', 'ShopeeFood', '2026-02-07', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 95000.00, 'expense', 'Hangout cafe', 'Janji Jiwa', '2026-02-12', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 130000.00, 'expense', 'Weekly groceries', 'Alfamart', '2026-02-15', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 50000.00, 'expense', 'GrabFood dinner', 'GrabFood', '2026-02-20', false, 'manual'),
  -- Transport (20% = ~500K)
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 15000.00, 'expense', 'Gojek ke kampus', 'Gojek', '2026-01-07', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 25000.00, 'expense', 'Grab ke mall', 'Grab', '2026-01-12', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 100000.00, 'expense', 'Bensin motor', 'Pertamina', '2026-01-20', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 80000.00, 'expense', 'Bensin motor', 'Pertamina', '2026-02-01', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 18000.00, 'expense', 'Gojek ke kampus', 'Gojek', '2026-02-10', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 30000.00, 'expense', 'Grab ke shift kerja', 'Grab', '2026-02-18', false, 'manual'),
  -- Shopping (15% = ~375K — impulsive payday shopping)
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Shopping' LIMIT 1), 189000.00, 'expense', 'Baju baru Shopee (PayLater)', 'Shopee', '2026-01-26', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Shopping' LIMIT 1), 99000.00, 'expense', 'Skincare Tokopedia', 'Tokopedia', '2026-01-27', false, 'manual'),
  ('17dc4bed-91c9-4900-8b08-57246fe10ab1', (SELECT id FROM categories WHERE name = 'Shopping' LIMIT 1), 149000.00, 'expense', 'Case HP + accessories', 'Shopee', '2026-02-22', false, 'manual');


-- --- Budi Santoso (income: 8M, top: Housing 30%, Food 20%, Subscriptions 10%, Transport 10%) ---
INSERT INTO transactions (user_id, category_id, amount, type, description, merchant, date, is_recurring, source) VALUES
  -- Income
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Salary' LIMIT 1), 8000000.00, 'income', 'Gaji Januari', 'PT Startup Nusantara', '2026-01-28', true, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Salary' LIMIT 1), 8000000.00, 'income', 'Gaji Februari', 'PT Startup Nusantara', '2026-02-25', true, 'manual'),
  -- Housing (30% = ~2.4M)
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Housing' LIMIT 1), 2200000.00, 'expense', 'Kost bulanan Januari', 'Kost Bapak Heri', '2026-01-05', true, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Housing' LIMIT 1), 2200000.00, 'expense', 'Kost bulanan Februari', 'Kost Bapak Heri', '2026-02-05', true, 'manual'),
  -- Food & Dining (20% = ~1.6M)
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 50000.00, 'expense', 'Makan siang kantor', 'Kantin Kantor', '2026-01-06', false, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 85000.00, 'expense', 'Dinner with colleagues', 'Hokben', '2026-01-10', false, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 250000.00, 'expense', 'Groceries mingguan', 'Superindo', '2026-01-13', false, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 75000.00, 'expense', 'GrabFood weekend', 'GrabFood', '2026-01-18', false, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 300000.00, 'expense', 'Groceries mingguan', 'Superindo', '2026-01-27', false, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 65000.00, 'expense', 'Makan siang', 'Solaria', '2026-02-04', false, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 280000.00, 'expense', 'Groceries mingguan', 'Superindo', '2026-02-10', false, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 90000.00, 'expense', 'Dinner date', 'Pizza Hut', '2026-02-14', false, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 55000.00, 'expense', 'Coffee shop kerja', 'Fore Coffee', '2026-02-19', false, 'manual'),
  -- Subscriptions (10% = ~800K) → using "Bills & Utilities" category
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Bills & Utilities' LIMIT 1), 186000.00, 'expense', 'Spotify + Netflix', 'Google Play', '2026-01-01', true, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Bills & Utilities' LIMIT 1), 150000.00, 'expense', 'Internet IndiHome', 'Telkom', '2026-01-10', true, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Bills & Utilities' LIMIT 1), 186000.00, 'expense', 'Spotify + Netflix', 'Google Play', '2026-02-01', true, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Bills & Utilities' LIMIT 1), 150000.00, 'expense', 'Internet IndiHome', 'Telkom', '2026-02-10', true, 'manual'),
  -- Transport (10% = ~800K)
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 150000.00, 'expense', 'Bensin motor', 'Shell', '2026-01-08', false, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 200000.00, 'expense', 'Servis motor rutin', 'AHASS', '2026-01-20', false, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 150000.00, 'expense', 'Bensin motor', 'Shell', '2026-02-06', false, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 120000.00, 'expense', 'Bensin motor', 'Pertamina', '2026-02-18', false, 'manual'),
  -- Lifestyle inflation (gadgets, entertainment)
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Entertainment' LIMIT 1), 350000.00, 'expense', 'Nonton bioskop + dinner', 'CGV', '2026-01-11', false, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Shopping' LIMIT 1), 450000.00, 'expense', 'Mechanical keyboard', 'Tokopedia', '2026-01-30', false, 'manual'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Entertainment' LIMIT 1), 200000.00, 'expense', 'Weekend hangout', 'Karaoke', '2026-02-08', false, 'manual');


-- --- Siti Aisyah (income: variable ~5.5M, top: Bills 25%, Food 20%, Education 15%, Personal Care 10%) ---
INSERT INTO transactions (user_id, category_id, amount, type, description, merchant, date, is_recurring, source) VALUES
  -- Income (variable)
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Freelance' LIMIT 1), 3500000.00, 'income', 'Project desain logo (client A)', 'Freelance', '2026-01-10', false, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Freelance' LIMIT 1), 1500000.00, 'income', 'Desain feed IG (client B)', 'Freelance', '2026-01-22', false, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Freelance' LIMIT 1), 4000000.00, 'income', 'Branding package (client C)', 'Freelance', '2026-02-08', false, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Freelance' LIMIT 1), 2000000.00, 'income', 'Social media assets', 'Freelance', '2026-02-20', false, 'manual'),
  -- Bills & Utilities (25% = ~1.4M)
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Bills & Utilities' LIMIT 1), 350000.00, 'expense', 'Listrik + Air', 'PLN', '2026-01-05', true, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Bills & Utilities' LIMIT 1), 200000.00, 'expense', 'Internet rumah', 'Biznet', '2026-01-10', true, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Bills & Utilities' LIMIT 1), 89000.00, 'expense', 'Paket data XL', 'XL Axiata', '2026-01-15', true, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Bills & Utilities' LIMIT 1), 350000.00, 'expense', 'Listrik + Air', 'PLN', '2026-02-05', true, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Bills & Utilities' LIMIT 1), 200000.00, 'expense', 'Internet rumah', 'Biznet', '2026-02-10', true, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Bills & Utilities' LIMIT 1), 89000.00, 'expense', 'Paket data XL', 'XL Axiata', '2026-02-15', true, 'manual'),
  -- Food & Dining (20% = ~1.1M)
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 35000.00, 'expense', 'Makan siang', 'Warteg', '2026-01-07', false, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 180000.00, 'expense', 'Groceries mingguan', 'Alfamart', '2026-01-12', false, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 65000.00, 'expense', 'Coffee shop kerja', 'Kopi Tuku', '2026-01-16', false, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 45000.00, 'expense', 'GoFood delivery', 'GoFood', '2026-01-23', false, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 200000.00, 'expense', 'Groceries mingguan', 'Indomaret', '2026-01-28', false, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 55000.00, 'expense', 'Makan bareng teman', 'Bakmi GM', '2026-02-06', false, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 190000.00, 'expense', 'Groceries mingguan', 'Alfamart', '2026-02-13', false, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 70000.00, 'expense', 'Coffee meeting client', 'Starbucks', '2026-02-18', false, 'manual'),
  -- Education (15% = ~825K)
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Education' LIMIT 1), 350000.00, 'expense', 'Kelas UI/UX Udemy', 'Udemy', '2026-01-08', false, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Education' LIMIT 1), 500000.00, 'expense', 'Adobe Creative Cloud', 'Adobe', '2026-01-20', true, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Education' LIMIT 1), 500000.00, 'expense', 'Adobe Creative Cloud', 'Adobe', '2026-02-20', true, 'manual'),
  -- Personal Care (10% = ~550K)
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Personal Care' LIMIT 1), 250000.00, 'expense', 'Skincare routine', 'Sociolla', '2026-01-14', false, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Personal Care' LIMIT 1), 150000.00, 'expense', 'Potong rambut + treatment', 'Salon', '2026-02-02', false, 'manual'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Personal Care' LIMIT 1), 120000.00, 'expense', 'Skincare refill', 'Guardian', '2026-02-16', false, 'manual');


-- --- Arief Pratama (income: 12M, top: Housing 35%, Food 15%, Entertainment 12%, Shopping 10%, Insurance 8%) ---
INSERT INTO transactions (user_id, category_id, amount, type, description, merchant, date, is_recurring, source) VALUES
  -- Income
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Salary' LIMIT 1), 12000000.00, 'income', 'Gaji Januari', 'PT Marketing Jaya', '2026-01-28', true, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Salary' LIMIT 1), 12000000.00, 'income', 'Gaji Februari', 'PT Marketing Jaya', '2026-02-25', true, 'manual'),
  -- Housing (35% = ~4.2M — mortgage already in debts, this is utilities/maintenance)
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Housing' LIMIT 1), 500000.00, 'expense', 'IPL Apartemen Januari', 'Pengelola Apartemen', '2026-01-05', true, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Bills & Utilities' LIMIT 1), 450000.00, 'expense', 'Listrik + Air + Internet', 'PLN/Biznet', '2026-01-10', true, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Housing' LIMIT 1), 500000.00, 'expense', 'IPL Apartemen Februari', 'Pengelola Apartemen', '2026-02-05', true, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Bills & Utilities' LIMIT 1), 450000.00, 'expense', 'Listrik + Air + Internet', 'PLN/Biznet', '2026-02-10', true, 'manual'),
  -- Food & Dining (15% = ~1.8M)
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 350000.00, 'expense', 'Groceries mingguan', 'Ranch Market', '2026-01-06', false, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 120000.00, 'expense', 'Business lunch', 'Sate Khas Senayan', '2026-01-09', false, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 380000.00, 'expense', 'Groceries mingguan', 'Ranch Market', '2026-01-20', false, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 150000.00, 'expense', 'Dinner with wife', 'Marugame Udon', '2026-01-25', false, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 400000.00, 'expense', 'Groceries mingguan', 'Ranch Market', '2026-02-03', false, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 95000.00, 'expense', 'Coffee meeting', 'Anomali Coffee', '2026-02-11', false, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 180000.00, 'expense', 'Dinner Valentine', 'The Holy Crab', '2026-02-14', false, 'manual'),
  -- Entertainment (12% = ~1.4M)
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Entertainment' LIMIT 1), 250000.00, 'expense', 'Nonton bioskop', 'XXI', '2026-01-11', false, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Entertainment' LIMIT 1), 186000.00, 'expense', 'Netflix + Spotify', 'Google Play', '2026-01-01', true, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Entertainment' LIMIT 1), 400000.00, 'expense', 'Weekend staycation', 'Traveloka', '2026-01-18', false, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Entertainment' LIMIT 1), 186000.00, 'expense', 'Netflix + Spotify', 'Google Play', '2026-02-01', true, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Entertainment' LIMIT 1), 300000.00, 'expense', 'Board game cafe', 'Dice & Cards', '2026-02-15', false, 'manual'),
  -- Shopping (10% = ~1.2M — uses credit card for cashback)
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Shopping' LIMIT 1), 599000.00, 'expense', 'Sepatu olahraga (CC BCA)', 'Nike Store', '2026-01-15', false, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Shopping' LIMIT 1), 350000.00, 'expense', 'Baju formal kerja (CC BCA)', 'Uniqlo', '2026-02-08', false, 'manual'),
  -- Insurance (8% = ~960K)
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Insurance' LIMIT 1), 500000.00, 'expense', 'Asuransi kesehatan', 'Prudential', '2026-01-03', true, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Insurance' LIMIT 1), 500000.00, 'expense', 'Asuransi kesehatan', 'Prudential', '2026-02-03', true, 'manual'),
  -- Transport
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 300000.00, 'expense', 'Bensin mobil', 'Shell', '2026-01-12', false, 'manual'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 350000.00, 'expense', 'Bensin mobil', 'Shell', '2026-02-09', false, 'manual');


-- --- Dewi Kartika (income: 1.5M, top: Food 35%, Shopping 30%, Entertainment 20%, Transport 10%) ---
INSERT INTO transactions (user_id, category_id, amount, type, description, merchant, date, is_recurring, source) VALUES
  -- Income (allowance)
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Other Income' LIMIT 1), 750000.00, 'income', 'Uang saku dari mama', NULL, '2026-01-01', true, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Other Income' LIMIT 1), 750000.00, 'income', 'Uang saku dari papa', NULL, '2026-01-15', true, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Other Income' LIMIT 1), 750000.00, 'income', 'Uang saku dari mama', NULL, '2026-02-01', true, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Other Income' LIMIT 1), 750000.00, 'income', 'Uang saku dari papa', NULL, '2026-02-15', true, 'manual'),
  -- Food & Dining (35% = ~525K — heavy on food delivery)
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 45000.00, 'expense', 'ShopeeFood', 'ShopeeFood', '2026-01-02', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 38000.00, 'expense', 'GrabFood', 'GrabFood', '2026-01-05', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 55000.00, 'expense', 'Boba tea + snack', 'Chatime', '2026-01-08', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 32000.00, 'expense', 'Makan siang kampus', 'Kantin Kampus', '2026-01-12', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 48000.00, 'expense', 'GoFood dinner', 'GoFood', '2026-01-16', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 60000.00, 'expense', 'Hanging out cafe', 'Janji Jiwa', '2026-01-20', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 42000.00, 'expense', 'ShopeeFood', 'ShopeeFood', '2026-01-25', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 35000.00, 'expense', 'GrabFood lunch', 'GrabFood', '2026-02-02', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 50000.00, 'expense', 'Makan bareng teman', 'McDonald''s', '2026-02-06', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 40000.00, 'expense', 'Boba + kopi', 'Kopi Kenangan', '2026-02-10', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 55000.00, 'expense', 'GoFood delivery', 'GoFood', '2026-02-16', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 30000.00, 'expense', 'Snack kampus', 'Kantin', '2026-02-20', false, 'manual'),
  -- Shopping (30% = ~450K — impulsive e-commerce)
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Shopping' LIMIT 1), 89000.00, 'expense', 'Case HP lucu (SPayLater)', 'Shopee', '2026-01-03', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Shopping' LIMIT 1), 129000.00, 'expense', 'Baju baru (SPayLater)', 'Shopee', '2026-01-10', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Shopping' LIMIT 1), 75000.00, 'expense', 'Aksesoris (GoPay Later)', 'Tokopedia', '2026-01-22', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Shopping' LIMIT 1), 99000.00, 'expense', 'Skincare murah', 'Shopee', '2026-02-04', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Shopping' LIMIT 1), 65000.00, 'expense', 'Sticker aesthetic', 'Tokopedia', '2026-02-18', false, 'manual'),
  -- Entertainment (20% = ~300K)
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Entertainment' LIMIT 1), 55000.00, 'expense', 'Top-up game ML', 'Codashop', '2026-01-06', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Entertainment' LIMIT 1), 50000.00, 'expense', 'Nonton bioskop', 'CGV', '2026-01-17', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Entertainment' LIMIT 1), 100000.00, 'expense', 'Top-up game + skin', 'Codashop', '2026-02-01', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Entertainment' LIMIT 1), 75000.00, 'expense', 'Nonton bioskop + snack', 'XXI', '2026-02-12', false, 'manual'),
  -- Transport (10% = ~150K)
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 15000.00, 'expense', 'Gojek ke kampus', 'Gojek', '2026-01-07', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 20000.00, 'expense', 'Grab ke mall', 'Grab', '2026-01-14', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 25000.00, 'expense', 'Gojek ke kampus', 'Gojek', '2026-01-28', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 18000.00, 'expense', 'Grab ke mall', 'Grab', '2026-02-05', false, 'manual'),
  ('e784da4d-e951-42eb-b939-6e0715d51e55', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 22000.00, 'expense', 'Gojek ke kampus', 'Gojek', '2026-02-19', false, 'manual');


-- ============================================
-- 4. INSERT BUDGETS (for budget-aware personas)
-- ============================================

-- Arief Pratama (strong budget discipline)
INSERT INTO budgets (user_id, category_id, amount, period, start_date) VALUES
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 1800000.00, 'monthly', '2026-01-01'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Entertainment' LIMIT 1), 1500000.00, 'monthly', '2026-01-01'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Shopping' LIMIT 1), 1200000.00, 'monthly', '2026-01-01'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 800000.00, 'monthly', '2026-01-01'),
  ('65e3862b-93b7-46c8-8643-80ed785f2c49', (SELECT id FROM categories WHERE name = 'Insurance' LIMIT 1), 600000.00, 'monthly', '2026-01-01');

-- Budi Santoso (sets budgets but rarely reviews)
INSERT INTO budgets (user_id, category_id, amount, period, start_date) VALUES
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 2000000.00, 'monthly', '2026-01-01'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Transport' LIMIT 1), 1000000.00, 'monthly', '2026-01-01'),
  ('92889a30-f790-4e6f-a1ca-f16112fc9dd0', (SELECT id FROM categories WHERE name = 'Entertainment' LIMIT 1), 800000.00, 'monthly', '2026-01-01');

-- Siti Aisyah (aware but inconsistent)
INSERT INTO budgets (user_id, category_id, amount, period, start_date) VALUES
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Food & Dining' LIMIT 1), 1200000.00, 'monthly', '2026-01-01'),
  ('3aca0966-b2e2-4a00-817b-d8f649bce275', (SELECT id FROM categories WHERE name = 'Personal Care' LIMIT 1), 500000.00, 'monthly', '2026-01-01');


-- ============================================
-- Done! 🎉
-- 5 profiles updated, 14 debts, ~100 transactions, 10 budgets
-- ============================================
