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