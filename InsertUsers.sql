-- ============================================
-- 100个用户数据插入脚本
-- 包含真实的英文用户名和邮箱
-- ============================================

-- 清空用户表（可选，如果需要重新插入）
-- TRUNCATE TABLE t_user;

-- 插入100个用户数据
INSERT INTO t_user (username, nickname, phone, email) VALUES
('john_smith', 'John', '13800000001', 'john.smith@example.com'),
('emily_johnson', 'Emily', '13800000002', 'emily.johnson@example.com'),
('michael_brown', 'Michael', '13800000003', 'michael.brown@example.com'),
('sarah_davis', 'Sarah', '13800000004', 'sarah.davis@example.com'),
('david_miller', 'David', '13800000005', 'david.miller@example.com'),
('emma_wilson', 'Emma', '13800000006', 'emma.wilson@example.com'),
('james_moore', 'James', '13800000007', 'james.moore@example.com'),
('olivia_taylor', 'Olivia', '13800000008', 'olivia.taylor@example.com'),
('robert_anderson', 'Robert', '13800000009', 'robert.anderson@example.com'),
('sophia_thomas', 'Sophia', '13800000010', 'sophia.thomas@example.com'),

('william_jackson', 'William', '13800000011', 'william.jackson@example.com'),
('ava_white', 'Ava', '13800000012', 'ava.white@example.com'),
('daniel_harris', 'Daniel', '13800000013', 'daniel.harris@example.com'),
('isabella_martin', 'Isabella', '13800000014', 'isabella.martin@example.com'),
('joseph_thompson', 'Joseph', '13800000015', 'joseph.thompson@example.com'),
('mia_garcia', 'Mia', '13800000016', 'mia.garcia@example.com'),
('charles_martinez', 'Charles', '13800000017', 'charles.martinez@example.com'),
('charlotte_robinson', 'Charlotte', '13800000018', 'charlotte.robinson@example.com'),
('thomas_clark', 'Thomas', '13800000019', 'thomas.clark@example.com'),
('amelia_rodriguez', 'Amelia', '13800000020', 'amelia.rodriguez@example.com'),

('christopher_lewis', 'Chris', '13800000021', 'christopher.lewis@example.com'),
('harper_lee', 'Harper', '13800000022', 'harper.lee@example.com'),
('matthew_walker', 'Matthew', '13800000023', 'matthew.walker@example.com'),
('evelyn_hall', 'Evelyn', '13800000024', 'evelyn.hall@example.com'),
('andrew_allen', 'Andrew', '13800000025', 'andrew.allen@example.com'),
('abigail_young', 'Abigail', '13800000026', 'abigail.young@example.com'),
('joshua_king', 'Joshua', '13800000027', 'joshua.king@example.com'),
('emily_wright', 'Emily W', '13800000028', 'emily.wright@example.com'),
('ryan_lopez', 'Ryan', '13800000029', 'ryan.lopez@example.com'),
('ella_hill', 'Ella', '13800000030', 'ella.hill@example.com'),

('nathan_scott', 'Nathan', '13800000031', 'nathan.scott@example.com'),
('grace_green', 'Grace', '13800000032', 'grace.green@example.com'),
('ethan_adams', 'Ethan', '13800000033', 'ethan.adams@example.com'),
('chloe_baker', 'Chloe', '13800000034', 'chloe.baker@example.com'),
('alexander_nelson', 'Alex', '13800000035', 'alexander.nelson@example.com'),
('lily_carter', 'Lily', '13800000036', 'lily.carter@example.com'),
('benjamin_mitchell', 'Benjamin', '13800000037', 'benjamin.mitchell@example.com'),
('zoe_perez', 'Zoe', '13800000038', 'zoe.perez@example.com'),
('samuel_roberts', 'Samuel', '13800000039', 'samuel.roberts@example.com'),
('victoria_turner', 'Victoria', '13800000040', 'victoria.turner@example.com'),

('jackson_phillips', 'Jackson', '13800000041', 'jackson.phillips@example.com'),
('hannah_campbell', 'Hannah', '13800000042', 'hannah.campbell@example.com'),
('lucas_parker', 'Lucas', '13800000043', 'lucas.parker@example.com'),
('madison_evans', 'Madison', '13800000044', 'madison.evans@example.com'),
('henry_edwards', 'Henry', '13800000045', 'henry.edwards@example.com'),
('scarlett_collins', 'Scarlett', '13800000046', 'scarlett.collins@example.com'),
('owen_stewart', 'Owen', '13800000047', 'owen.stewart@example.com'),
('aria_sanchez', 'Aria', '13800000048', 'aria.sanchez@example.com'),
('sebastian_morris', 'Sebastian', '13800000049', 'sebastian.morris@example.com'),
('layla_rogers', 'Layla', '13800000050', 'layla.rogers@example.com'),

('jacob_reed', 'Jacob', '13800000051', 'jacob.reed@example.com'),
('penelope_cook', 'Penelope', '13800000052', 'penelope.cook@example.com'),
('jack_morgan', 'Jack', '13800000053', 'jack.morgan@example.com'),
('riley_bell', 'Riley', '13800000054', 'riley.bell@example.com'),
('logan_murphy', 'Logan', '13800000055', 'logan.murphy@example.com'),
('nora_bailey', 'Nora', '13800000056', 'nora.bailey@example.com'),
('wyatt_rivera', 'Wyatt', '13800000057', 'wyatt.rivera@example.com'),
('stella_cooper', 'Stella', '13800000058', 'stella.cooper@example.com'),
('elijah_richardson', 'Elijah', '13800000059', 'elijah.richardson@example.com'),
('hazel_cox', 'Hazel', '13800000060', 'hazel.cox@example.com'),

('levi_howard', 'Levi', '13800000061', 'levi.howard@example.com'),
('aurora_ward', 'Aurora', '13800000062', 'aurora.ward@example.com'),
('mason_torres', 'Mason', '13800000063', 'mason.torres@example.com'),
('violet_peterson', 'Violet', '13800000064', 'violet.peterson@example.com'),
('carter_gray', 'Carter', '13800000065', 'carter.gray@example.com'),
('savannah_ramirez', 'Savannah', '13800000066', 'savannah.ramirez@example.com'),
('grayson_james', 'Grayson', '13800000067', 'grayson.james@example.com'),
('brooklyn_watson', 'Brooklyn', '13800000068', 'brooklyn.watson@example.com'),
('isaac_brooks', 'Isaac', '13800000069', 'isaac.brooks@example.com'),
('lucy_kelly', 'Lucy', '13800000070', 'lucy.kelly@example.com'),

('julian_sanders', 'Julian', '13800000071', 'julian.sanders@example.com'),
('claire_price', 'Claire', '13800000072', 'claire.price@example.com'),
('leo_bennett', 'Leo', '13800000073', 'leo.bennett@example.com'),
('ellie_wood', 'Ellie', '13800000074', 'ellie.wood@example.com'),
('jayden_barnes', 'Jayden', '13800000075', 'jayden.barnes@example.com'),
('paisley_ross', 'Paisley', '13800000076', 'paisley.ross@example.com'),
('lincoln_henderson', 'Lincoln', '13800000077', 'lincoln.henderson@example.com'),
('audrey_coleman', 'Audrey', '13800000078', 'audrey.coleman@example.com'),
('austin_jenkins', 'Austin', '13800000079', 'austin.jenkins@example.com'),
('ruby_perry', 'Ruby', '13800000080', 'ruby.perry@example.com'),

('adam_powell', 'Adam', '13800000081', 'adam.powell@example.com'),
('skylar_long', 'Skylar', '13800000082', 'skylar.long@example.com'),
('dylan_patterson', 'Dylan', '13800000083', 'dylan.patterson@example.com'),
('alexa_hughes', 'Alexa', '13800000084', 'alexa.hughes@example.com'),
('ezra_flores', 'Ezra', '13800000085', 'ezra.flores@example.com'),
('anna_washington', 'Anna', '13800000086', 'anna.washington@example.com'),
('miles_butler', 'Miles', '13800000087', 'miles.butler@example.com'),
('sophie_simmons', 'Sophie', '13800000088', 'sophie.simmons@example.com'),
('hunter_foster', 'Hunter', '13800000089', 'hunter.foster@example.com'),
('natalie_gonzales', 'Natalie', '13800000090', 'natalie.gonzales@example.com'),

('caleb_bryant', 'Caleb', '13800000091', 'caleb.bryant@example.com'),
('alice_alexander', 'Alice', '13800000092', 'alice.alexander@example.com'),
('nolan_russell', 'Nolan', '13800000093', 'nolan.russell@example.com'),
('sadie_griffin', 'Sadie', '13800000094', 'sadie.griffin@example.com'),
('ian_diaz', 'Ian', '13800000095', 'ian.diaz@example.com'),
('bella_hayes', 'Bella', '13800000096', 'bella.hayes@example.com'),
('connor_myers', 'Connor', '13800000097', 'connor.myers@example.com'),
('gabriella_ford', 'Gabriella', '13800000098', 'gabriella.ford@example.com'),
('jason_hamilton', 'Jason', '13800000099', 'jason.hamilton@example.com'),
('caroline_graham', 'Caroline', '13800000100', 'caroline.graham@example.com');

-- ============================================
-- 验证数据
-- ============================================

-- 查看插入的用户数量
SELECT COUNT(*) AS total_users FROM t_user;

-- 查看前10个用户
SELECT 
    id AS 用户ID,
    username AS 用户名,
    nickname AS 昵称,
    phone AS 手机号,
    email AS 邮箱
FROM t_user
ORDER BY id
LIMIT 10;

-- 查看最后10个用户
SELECT 
    id AS 用户ID,
    username AS 用户名,
    nickname AS 昵称,
    phone AS 手机号,
    email AS 邮箱
FROM t_user
ORDER BY id DESC
LIMIT 10;

-- 验证用户名唯一性
SELECT 
    username,
    COUNT(*) AS count
FROM t_user
GROUP BY username
HAVING COUNT(*) > 1;