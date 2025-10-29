-- ============================================
-- 50个商品数据插入脚本
-- 包含8个分类，模拟真实电商商品
-- ============================================

-- 清空商品表（可选，如果需要重新插入）
-- TRUNCATE TABLE t_product;

-- 插入50个商品数据
INSERT INTO t_product (product_name, product_code, price, stock, category) VALUES
-- Electronics (10个)
('iPhone 15 Pro Max 256GB', 'P000001', 8999.00, 150, 'Electronics'),
('Huawei Mate 60 Pro 512GB', 'P000002', 6999.00, 200, 'Electronics'),
('Xiaomi 14 Ultra Flagship', 'P000003', 5999.00, 180, 'Electronics'),
('MacBook Pro 14-inch M3', 'P000004', 14999.00, 80, 'Electronics'),
('Dell XPS 13 Business Laptop', 'P000005', 8999.00, 120, 'Electronics'),
('Sony WH-1000XM5 Headphones', 'P000006', 2399.00, 300, 'Electronics'),
('iPad Air 5th Gen 128GB', 'P000007', 4799.00, 250, 'Electronics'),
('AirPods Pro 2nd Generation', 'P000008', 1899.00, 400, 'Electronics'),
('Xiaomi TV 65-inch 4K', 'P000009', 3299.00, 100, 'Electronics'),
('Huawei MatePad Pro 12.6-inch', 'P000010', 3999.00, 150, 'Electronics'),

-- Books (6个)
('The Three-Body Problem Collection', 'P000011', 168.00, 500, 'Books'),
('To Live by Yu Hua', 'P000012', 39.00, 800, 'Books'),
('One Hundred Years of Solitude', 'P000013', 58.00, 600, 'Books'),
('The Kite Runner', 'P000014', 45.00, 700, 'Books'),
('Ordinary World Trilogy', 'P000015', 108.00, 450, 'Books'),
('Sapiens: A Brief History of Humankind', 'P000016', 68.00, 550, 'Books'),

-- Clothing (8个)
('Uniqlo Cotton T-Shirt Men', 'P000017', 99.00, 1000, 'Clothing'),
('Nike Air Max 270 Sneakers', 'P000018', 899.00, 300, 'Clothing'),
('Levi\'s 501 Classic Jeans', 'P000019', 599.00, 400, 'Clothing'),
('Adidas Originals Hoodie', 'P000020', 499.00, 500, 'Clothing'),
('Zara Women\'s Dress', 'P000021', 399.00, 350, 'Clothing'),
('Columbia Waterproof Jacket', 'P000022', 899.00, 200, 'Clothing'),
('Uniqlo Fleece Jacket', 'P000023', 199.00, 600, 'Clothing'),
('Anta Sports Pants Breathable', 'P000024', 259.00, 450, 'Clothing'),

-- Food (7个)
('Three Squirrels Daily Nuts Gift Pack', 'P000025', 129.00, 2000, 'Food'),
('Snack Combo Package', 'P000026', 89.00, 1500, 'Food'),
('Mengniu Pure Milk 250ml*24', 'P000027', 68.00, 3000, 'Food'),
('Master Kong Beef Noodles Box', 'P000028', 58.00, 2500, 'Food'),
('Unified Ice Tea 500ml*15', 'P000029', 39.00, 4000, 'Food'),
('Pork Floss Snack', 'P000030', 35.00, 1800, 'Food'),
('Candy Gift Box Assorted', 'P000031', 78.00, 1200, 'Food'),

-- Home (6个)
('IKEA Nordic Simple Sofa', 'P000032', 2999.00, 50, 'Home'),
('Midea Inverter Air Conditioner', 'P000033', 2599.00, 150, 'Home'),
('Gree Floor Standing Fan', 'P000034', 299.00, 300, 'Home'),
('Joyoung Blender Soy Milk Maker', 'P000035', 499.00, 400, 'Home'),
('Supor Non-stick Wok 30cm', 'P000036', 199.00, 600, 'Home'),
('MUJI Storage Box 3-piece Set', 'P000037', 159.00, 500, 'Home'),

-- Sports (5个)
('Li-Ning Wade Basketball Shoes', 'P000038', 699.00, 200, 'Sports'),
('Decathlon Dumbbell Set 20kg', 'P000039', 299.00, 300, 'Sports'),
('Anta Sports Backpack Large', 'P000040', 159.00, 400, 'Sports'),
('Wilson Tennis Racket Beginner', 'P000041', 399.00, 150, 'Sports'),
('Xiaomi Treadmill Foldable Home', 'P000042', 1999.00, 100, 'Sports'),

-- Beauty (4个)
('Estee Lauder Advanced Night Repair', 'P000043', 899.00, 300, 'Beauty'),
('Lancome Lipstick Color 196', 'P000044', 299.00, 500, 'Beauty'),
('L\'Oreal Shampoo 400ml', 'P000045', 89.00, 800, 'Beauty'),
('SK-II Facial Treatment Essence', 'P000046', 1590.00, 200, 'Beauty'),

-- Toys (4个)
('LEGO Star Wars Series', 'P000047', 899.00, 150, 'Toys'),
('Barbie Dream House', 'P000048', 599.00, 200, 'Toys'),
('Ultraman Transformer Official', 'P000049', 199.00, 400, 'Toys'),
('RC Car Off-road Vehicle', 'P000050', 259.00, 300, 'Toys');

-- ============================================
-- 验证数据
-- ============================================

-- 查看插入的商品数量
SELECT COUNT(*) AS total_products FROM t_product;

-- 查看各分类商品数量
SELECT 
    category AS 分类,
    COUNT(*) AS 商品数量,
    CONCAT(ROUND(COUNT(*) * 100.0 / 50, 1), '%') AS 占比
FROM t_product
GROUP BY category
ORDER BY COUNT(*) DESC;

-- 查看价格分布
SELECT 
    CASE 
        WHEN price < 100 THEN '0-100元'
        WHEN price < 500 THEN '100-500元'
        WHEN price < 1000 THEN '500-1000元'
        WHEN price < 5000 THEN '1000-5000元'
        ELSE '5000元以上'
    END AS 价格区间,
    COUNT(*) AS 商品数量
FROM t_product
GROUP BY 
    CASE 
        WHEN price < 100 THEN '0-100元'
        WHEN price < 500 THEN '100-500元'
        WHEN price < 1000 THEN '500-1000元'
        WHEN price < 5000 THEN '1000-5000元'
        ELSE '5000元以上'
    END
ORDER BY MIN(price);

-- 查看库存分布
SELECT 
    CASE 
        WHEN stock < 200 THEN '低库存(0-200)'
        WHEN stock < 500 THEN '中库存(200-500)'
        WHEN stock < 1000 THEN '高库存(500-1000)'
        ELSE '超高库存(1000+)'
    END AS 库存等级,
    COUNT(*) AS 商品数量
FROM t_product
GROUP BY 
    CASE 
        WHEN stock < 200 THEN '低库存(0-200)'
        WHEN stock < 500 THEN '中库存(200-500)'
        WHEN stock < 1000 THEN '高库存(500-1000)'
        ELSE '超高库存(1000+)'
    END;

-- 查看前10个商品
SELECT 
    product_code AS 商品编码,
    product_name AS 商品名称,
    price AS 价格,
    stock AS 库存,
    category AS 分类
FROM t_product
ORDER BY id
LIMIT 10;

