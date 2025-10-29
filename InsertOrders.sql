-- ============================================
-- Part 1: 1000条订单生成存储过程
-- ============================================

DROP PROCEDURE IF EXISTS generate_orders_1000;
DELIMITER $$

CREATE PROCEDURE generate_orders_1000()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE v_order_no VARCHAR(32);
    DECLARE v_user_id BIGINT;
    DECLARE v_product_id BIGINT;
    DECLARE v_quantity INT;
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_total_amount DECIMAL(10,2);
    DECLARE v_status TINYINT;
    DECLARE v_create_time DATETIME;
    DECLARE v_date_prefix VARCHAR(8);
    DECLARE v_random_days INT;
    
    -- 获取日期前缀
    SET v_date_prefix = DATE_FORMAT(NOW(), '%Y%m%d');
    
    -- 开始生成
    WHILE i <= 1000 DO
        -- 生成订单编号
        SET v_order_no = CONCAT('ORD', v_date_prefix, LPAD(i, 10, '0'));
        
        -- 模拟真实场景：20%的用户是活跃用户（ID 1-20），占60%的订单
        IF RAND() < 0.6 THEN
            SET v_user_id = FLOOR(RAND() * 20) + 1;  -- 活跃用户 1-20
        ELSE
            SET v_user_id = FLOOR(RAND() * 80) + 21;  -- 普通用户 21-100
        END IF;
        
        -- 模拟真实场景：10%的商品是爆款（ID 1-5），占40%的销量
        IF RAND() < 0.4 THEN
            SET v_product_id = FLOOR(RAND() * 5) + 1;  -- 爆款商品 1-5
        ELSE
            SET v_product_id = FLOOR(RAND() * 45) + 6;  -- 普通商品 6-50
        END IF;
        
        -- 购买数量：1-5件，大多数是1-2件
        SET v_quantity = CASE 
            WHEN RAND() < 0.7 THEN FLOOR(RAND() * 2) + 1  -- 70%概率买1-2件
            ELSE FLOOR(RAND() * 4) + 2                     -- 30%概率买2-5件
        END;
        
        -- 从商品表获取真实价格（如果需要更真实的数据）
        -- SELECT price INTO v_price FROM t_product WHERE id = v_product_id;
        -- 这里为了性能，使用随机价格
        SET v_price = ROUND(RAND() * 9900 + 100, 2);
        
        -- 计算总金额
        SET v_total_amount = ROUND(v_price * v_quantity, 2);
        
        -- 订单状态分布：0待支付15%，1已支付20%，2已发货25%，3已完成35%，4已取消5%
        SET v_status = CASE 
            WHEN RAND() < 0.15 THEN 0
            WHEN RAND() < 0.35 THEN 1
            WHEN RAND() < 0.60 THEN 2
            WHEN RAND() < 0.95 THEN 3
            ELSE 4
        END;
        
        -- 创建时间：过去180天内随机分布（最近订单更多）
        SET v_random_days = CASE
            WHEN RAND() < 0.4 THEN FLOOR(RAND() * 30)      -- 40%在最近30天
            WHEN RAND() < 0.7 THEN FLOOR(RAND() * 60)      -- 30%在30-60天
            ELSE FLOOR(RAND() * 180)                        -- 30%在60-180天
        END;
        
        SET v_create_time = DATE_SUB(NOW(), INTERVAL v_random_days DAY);
        -- 添加随机时间（小时、分钟、秒）
        SET v_create_time = DATE_ADD(v_create_time, 
            INTERVAL CONCAT(
                FLOOR(RAND() * 24), ' ',
                FLOOR(RAND() * 60), ':',
                FLOOR(RAND() * 60)
            ) HOUR_SECOND
        );
        
        -- 插入订单
        INSERT INTO t_order (
            order_no, user_id, product_id, quantity, 
            total_amount, status, create_time
        ) VALUES (
            v_order_no, v_user_id, v_product_id, v_quantity,
            v_total_amount, v_status, v_create_time
        );
        
        -- 每100条提交一次
        IF i % 100 = 0 THEN
            COMMIT;
            SELECT CONCAT('已生成 ', i, ' 条订单...') AS progress;
        END IF;
        
        SET i = i + 1;
    END WHILE;
    
    COMMIT;
    SELECT '1000条订单数据生成完成！' AS result;
END$$

DELIMITER ;


-- ============================================
-- Part 2: 可扩展的订单生成存储过程（支持任意数量）
-- ============================================

DROP PROCEDURE IF EXISTS generate_orders_flexible;
DELIMITER $$

CREATE PROCEDURE generate_orders_flexible(
    IN order_count INT,           -- 生成订单数量
    IN batch_size INT             -- 批量提交大小
)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE v_order_no VARCHAR(32);
    DECLARE v_user_id BIGINT;
    DECLARE v_product_id BIGINT;
    DECLARE v_quantity INT;
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_total_amount DECIMAL(10,2);
    DECLARE v_status TINYINT;
    DECLARE v_create_time DATETIME;
    DECLARE v_date_prefix VARCHAR(8);
    DECLARE v_random_days INT;
    
    SET v_date_prefix = DATE_FORMAT(NOW(), '%Y%m%d');
    
    -- 为了提升大数据量插入速度，临时禁用索引检查（可选）
    IF order_count >= 100000 THEN
        SET @old_sql_log_bin = @@session.sql_log_bin;
        SET sql_log_bin = 0;
        ALTER TABLE t_order DISABLE KEYS;
    END IF;
    
    WHILE i <= order_count DO
        SET v_order_no = CONCAT('ORD', v_date_prefix, LPAD(i, 10, '0'));
        
        IF RAND() < 0.6 THEN
            SET v_user_id = FLOOR(RAND() * 20) + 1;
        ELSE
            SET v_user_id = FLOOR(RAND() * 80) + 21;
        END IF;
        
        IF RAND() < 0.4 THEN
            SET v_product_id = FLOOR(RAND() * 5) + 1;
        ELSE
            SET v_product_id = FLOOR(RAND() * 45) + 6;
        END IF;
        
        SET v_quantity = CASE 
            WHEN RAND() < 0.7 THEN FLOOR(RAND() * 2) + 1
            ELSE FLOOR(RAND() * 4) + 2
        END;
        
        SET v_price = ROUND(RAND() * 9900 + 100, 2);
        SET v_total_amount = ROUND(v_price * v_quantity, 2);
        
        SET v_status = CASE 
            WHEN RAND() < 0.15 THEN 0
            WHEN RAND() < 0.35 THEN 1
            WHEN RAND() < 0.60 THEN 2
            WHEN RAND() < 0.95 THEN 3
            ELSE 4
        END;
        
        SET v_random_days = CASE
            WHEN RAND() < 0.4 THEN FLOOR(RAND() * 30)
            WHEN RAND() < 0.7 THEN FLOOR(RAND() * 60)
            ELSE FLOOR(RAND() * 180)
        END;
        
        SET v_create_time = DATE_SUB(NOW(), INTERVAL v_random_days DAY);
        SET v_create_time = DATE_ADD(v_create_time, 
            INTERVAL CONCAT(
                FLOOR(RAND() * 24), ' ',
                FLOOR(RAND() * 60), ':',
                FLOOR(RAND() * 60)
            ) HOUR_SECOND
        );
        
        INSERT INTO t_order (
            order_no, user_id, product_id, quantity, 
            total_amount, status, create_time
        ) VALUES (
            v_order_no, v_user_id, v_product_id, v_quantity,
            v_total_amount, v_status, v_create_time
        );
        
        IF i % batch_size = 0 THEN
            COMMIT;
            SELECT CONCAT('进度: ', i, '/', order_count, ' (', 
                ROUND(i * 100.0 / order_count, 2), '%)') AS progress;
        END IF;
        
        SET i = i + 1;
    END WHILE;
    
    COMMIT;
    
    -- 恢复索引
    IF order_count >= 100000 THEN
        ALTER TABLE t_order ENABLE KEYS;
        SET sql_log_bin = @old_sql_log_bin;
    END IF;
    
    SELECT CONCAT('OK', order_count, '条订单数据生成完成！') AS result;
END$$

DELIMITER ;


-- ============================================
-- Part 3: 执行脚本
-- ============================================

-- 方式1: 生成1000条订单（固定）
-- CALL generate_orders_1000();

-- 方式2: 灵活生成任意数量
CALL generate_orders_flexible(1000, 100);      -- 生成1000条，每100条提交一次
-- CALL generate_orders_flexible(10000, 500);     -- 生成1万条
-- CALL generate_orders_flexible(100000, 1000);   -- 生成10万条
-- CALL generate_orders_flexible(1000000, 5000);  -- 生成100万条


-- ============================================
-- Part 4: 数据验证
-- ============================================

-- 查看订单总数
SELECT COUNT(*) AS total_orders FROM t_order;

-- 查看数据分布
SELECT 
    '订单状态分布' AS 分析项;
SELECT 
    CASE status
        WHEN 0 THEN '待支付'
        WHEN 1 THEN '已支付'
        WHEN 2 THEN '已发货'
        WHEN 3 THEN '已完成'
        WHEN 4 THEN '已取消'
    END AS 状态,
    COUNT(*) AS 数量,
    CONCAT(ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM t_order), 2), '%') AS 占比
FROM t_order
GROUP BY status
ORDER BY status;

-- 用户订单分布（Top 10）
SELECT 
    '用户订单分布 Top 10' AS 分析项;
SELECT 
    u.username AS 用户名,
    u.nickname AS 昵称,
    COUNT(o.id) AS 订单数,
    SUM(o.total_amount) AS 总消费金额
FROM t_order o
LEFT JOIN t_user u ON o.user_id = u.id
GROUP BY o.user_id
ORDER BY COUNT(o.id) DESC
LIMIT 10;

-- 商品销量排行（Top 10）
SELECT 
    '商品销量排行 Top 10' AS 分析项;
SELECT 
    p.product_name AS 商品名称,
    p.category AS 分类,
    COUNT(o.id) AS 销量,
    SUM(o.quantity) AS 总销售件数,
    SUM(o.total_amount) AS 总销售额
FROM t_order o
LEFT JOIN t_product p ON o.product_id = p.id
GROUP BY o.product_id
ORDER BY COUNT(o.id) DESC
LIMIT 10;

-- 时间分布
SELECT 
    '订单时间分布' AS 分析项;
SELECT 
    DATE_FORMAT(create_time, '%Y-%m') AS 月份,
    COUNT(*) AS 订单数
FROM t_order
GROUP BY DATE_FORMAT(create_time, '%Y-%m')
ORDER BY 月份 DESC;

-- 查看前10条订单
SELECT 
    '前10条订单详情' AS 分析项;
SELECT 
    o.order_no AS 订单号,
    u.username AS 用户,
    p.product_name AS 商品,
    o.quantity AS 数量,
    o.total_amount AS 金额,
    CASE o.status
        WHEN 0 THEN '待支付'
        WHEN 1 THEN '已支付'
        WHEN 2 THEN '已发货'
        WHEN 3 THEN '已完成'
        WHEN 4 THEN '已取消'
    END AS 状态,
    o.create_time AS 创建时间
FROM t_order o
LEFT JOIN t_user u ON o.user_id = u.id
LEFT JOIN t_product p ON o.product_id = p.id
ORDER BY o.id
LIMIT 10;

-- ============================================
-- Part 5: 索引效果测试
-- ============================================

-- 测试1: 查询某个用户的所有订单（使用 idx_user_id）
EXPLAIN SELECT * FROM t_order WHERE user_id = 1;

-- 测试2: 查询某个用户的待支付订单（使用 idx_user_status_time）
EXPLAIN SELECT * FROM t_order WHERE user_id = 1 AND status = 0;

-- 测试3: 查询最近30天的订单（使用 idx_create_time）
EXPLAIN SELECT * FROM t_order WHERE create_time >= DATE_SUB(NOW(), INTERVAL 30 DAY);

-- 测试4: 查询某个商品的销售记录（使用 idx_product_id）
EXPLAIN SELECT * FROM t_order WHERE product_id = 1;

-- 测试5: 联合索引效果测试
EXPLAIN SELECT * FROM t_order 
WHERE user_id = 1 
  AND status = 3 
  AND create_time >= DATE_SUB(NOW(), INTERVAL 90 DAY)
ORDER BY create_time DESC;