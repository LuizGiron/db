create database dataset;
use dataset;

CREATE TABLE IF NOT EXISTS orders (
    
    order_id VARCHAR(50) NOT NULL,
    customer_id VARCHAR(50) NOT NULL,
    order_status VARCHAR(50),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,
    PRIMARY KEY (order_id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

describe orders;
ALTER TABLE orders
DROP COLUMN product_category_name;
ALTER TABLE orders
DROP COLUMN product_category_name_english;



LOAD DATA LOCAL INFILE 'C:/path/to/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_category_name, product_category_name_english, order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date);

SET GLOBAL max_allowed_packet = 104857600;
SET GLOBAL net_read_timeout = 600;
SET GLOBAL net_write_timeout = 600;
SET GLOBAL local_infile = 1;

SELECT COUNT(*) FROM orders;

select * from orders;

