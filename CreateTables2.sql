
CREATE TABLE `t_order` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Order ID',
  `order_no` VARCHAR(32) NOT NULL COMMENT 'Order Number',
  `user_id` BIGINT NOT NULL COMMENT 'User ID',
  `product_id` BIGINT NOT NULL COMMENT 'Product ID',
  `quantity` INT NOT NULL COMMENT 'Quantity',
  `total_amount` DECIMAL(10,2) NOT NULL COMMENT 'Total Amount',
  `status` TINYINT NOT NULL DEFAULT 0 COMMENT 'Order Status 0=Pending 1=Paid 2=Shipped 3=Completed 4=Cancelled',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',

  -- Unique index for order number
  UNIQUE KEY `uk_order_no` (`order_no`),

  -- Basic indexes
  KEY `idx_user_id` (`user_id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_status` (`status`),
  KEY `idx_create_time` (`create_time`),

  -- User order query: user + status + time
  KEY `idx_user_status_time` (`user_id`, `status`, `create_time`),

  -- Index for amount-based sorting/statistics
  KEY `idx_total_amount` (`total_amount`),

  -- Admin query: time + status
  KEY `idx_create_time_status` (`create_time`, `status`),

  -- Product sales statistics: product + status + time
  KEY `idx_product_status_time` (`product_id`, `status`, `create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Order Table';


CREATE TABLE `t_user` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'User ID',
  `userno` VARCHAR(10) UNIQUE NOT NULL COMMENT 'Unique User Identifier',
  `username` VARCHAR(50) NOT NULL COMMENT 'Username',
  `password` VARCHAR(100) NOT NULL COMMENT 'Encrypted Password (BCrypt Hash)',
  `nickname` VARCHAR(50) COMMENT 'Nickname',
  `phone` VARCHAR(20) COMMENT 'Phone Number',
  `email` VARCHAR(100) COMMENT 'Email Address',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation Time',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Update Time',

  -- unique and secondary indexes
  UNIQUE KEY `uk_username` (`username`),
  KEY `idx_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='User Table';

CREATE TABLE `t_product` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT 'Product ID',
  `product_name` VARCHAR(200) NOT NULL COMMENT 'Product Name',
  `product_code` VARCHAR(50) NOT NULL COMMENT 'Product Code',
  `price` DECIMAL(10,2) NOT NULL COMMENT 'Price',
  `stock` INT NOT NULL DEFAULT 0 COMMENT 'Stock Quantity',
  `category` VARCHAR(50) COMMENT 'Category',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Creation Time',

  -- unique and secondary indexes
  UNIQUE KEY `uk_product_code` (`product_code`),
  KEY `idx_category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Product Table';



/*
 * ==============================================================
 *  Table: outbox_event
 *  Purpose:
 *    Implements the Outbox Pattern for reliable message delivery
 *    in a distributed system. Each row represents a domain event
 *    that has been committed to the local database transaction.
 *    A background job or message relay process will later read
 *    unprocessed events (processed = 0) and publish them to
 *    RabbitMQ or another message broker, ensuring eventual
 *    consistency between services.
 *
 *  Notes:
 *    - The composite index (processed, created_at) optimizes
 *      polling for new events in chronological order.
 *    - Old processed events can be archived or deleted
 *      periodically to prevent table growth.
 * ==============================================================
 */
CREATE TABLE outbox_event (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    aggregate_type VARCHAR(100),
    aggregate_id VARCHAR(100),
    event_type VARCHAR(100),
    payload JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    processed TINYINT DEFAULT 0,
    INDEX idx_outbox_processed_created_at (processed, created_at)
);