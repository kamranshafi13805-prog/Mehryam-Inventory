-- Clothing Inventory & Production Management System
-- MySQL 8.x compatible

CREATE TABLE roles (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL UNIQUE,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL
);

CREATE TABLE users (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  role_id BIGINT NOT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  archived_at TIMESTAMP NULL,
  FOREIGN KEY (role_id) REFERENCES roles(id)
);

CREATE TABLE activity_logs (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  action VARCHAR(120) NOT NULL,
  entity_type VARCHAR(80) NOT NULL,
  entity_id BIGINT NOT NULL,
  metadata JSON NULL,
  created_at TIMESTAMP NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE locations (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(120) NOT NULL,
  type ENUM('warehouse','outlet','franchise') NOT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  archived_at TIMESTAMP NULL
);

CREATE TABLE articles (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(160) NOT NULL,
  sku VARCHAR(80) NOT NULL UNIQUE,
  brand_name VARCHAR(120) NOT NULL,
  season ENUM('summer','winter','eid','festive') NOT NULL,
  gender ENUM('men','women','kids') NOT NULL,
  category ENUM('unstitched','stitched','semi-stitched') NOT NULL,
  fabric_type VARCHAR(120) NOT NULL,
  collection_name VARCHAR(120) NOT NULL,
  launch_date DATE NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  archived_at TIMESTAMP NULL
);

CREATE TABLE article_images (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  article_id BIGINT NOT NULL,
  color VARCHAR(80) NOT NULL,
  image_url VARCHAR(255) NOT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP NULL,
  FOREIGN KEY (article_id) REFERENCES articles(id)
);

CREATE TABLE sizes (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE colors (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE variants (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  article_id BIGINT NOT NULL,
  size_id BIGINT NOT NULL,
  color_id BIGINT NOT NULL,
  sku VARCHAR(100) NOT NULL UNIQUE,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  archived_at TIMESTAMP NULL,
  FOREIGN KEY (article_id) REFERENCES articles(id),
  FOREIGN KEY (size_id) REFERENCES sizes(id),
  FOREIGN KEY (color_id) REFERENCES colors(id)
);

CREATE TABLE stock_ledgers (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  location_id BIGINT NOT NULL,
  variant_id BIGINT NULL,
  fabric_id BIGINT NULL,
  accessory_id BIGINT NULL,
  direction ENUM('in','out') NOT NULL,
  reason VARCHAR(120) NOT NULL,
  quantity DECIMAL(12,2) NOT NULL,
  unit VARCHAR(20) NOT NULL,
  reference_type VARCHAR(60) NULL,
  reference_id BIGINT NULL,
  note TEXT NULL,
  created_by BIGINT NOT NULL,
  created_at TIMESTAMP NULL,
  FOREIGN KEY (location_id) REFERENCES locations(id),
  FOREIGN KEY (variant_id) REFERENCES variants(id),
  FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE stock_balances (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  location_id BIGINT NOT NULL,
  variant_id BIGINT NULL,
  fabric_id BIGINT NULL,
  accessory_id BIGINT NULL,
  quantity DECIMAL(12,2) NOT NULL DEFAULT 0,
  unit VARCHAR(20) NOT NULL,
  updated_at TIMESTAMP NULL,
  UNIQUE (location_id, variant_id, fabric_id, accessory_id),
  FOREIGN KEY (location_id) REFERENCES locations(id)
);

CREATE TABLE orders (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  order_number VARCHAR(60) NOT NULL UNIQUE,
  source ENUM('online','walk-in','dealer') NOT NULL,
  status ENUM('pending','packed','dispatched','delivered','cancelled','returned') NOT NULL,
  location_id BIGINT NOT NULL,
  customer_name VARCHAR(120) NULL,
  customer_phone VARCHAR(40) NULL,
  notes TEXT NULL,
  created_by BIGINT NOT NULL,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  cancelled_at TIMESTAMP NULL,
  returned_at TIMESTAMP NULL,
  FOREIGN KEY (location_id) REFERENCES locations(id),
  FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE order_items (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  order_id BIGINT NOT NULL,
  variant_id BIGINT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(12,2) NOT NULL,
  created_at TIMESTAMP NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (variant_id) REFERENCES variants(id)
);

CREATE TABLE fabrics (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(120) NOT NULL,
  fabric_type VARCHAR(120) NOT NULL,
  color VARCHAR(60) NOT NULL,
  roll_number VARCHAR(80) NOT NULL,
  supplier_name VARCHAR(120) NOT NULL,
  purchase_rate DECIMAL(12,2) NOT NULL,
  total_meters DECIMAL(12,2) NOT NULL,
  remaining_meters DECIMAL(12,2) NOT NULL,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  archived_at TIMESTAMP NULL
);

CREATE TABLE fabric_consumptions (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  fabric_id BIGINT NOT NULL,
  article_id BIGINT NOT NULL,
  meters_used DECIMAL(12,2) NOT NULL,
  wastage_meters DECIMAL(12,2) NOT NULL DEFAULT 0,
  note TEXT NULL,
  created_by BIGINT NOT NULL,
  created_at TIMESTAMP NULL,
  FOREIGN KEY (fabric_id) REFERENCES fabrics(id),
  FOREIGN KEY (article_id) REFERENCES articles(id),
  FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE accessories (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(120) NOT NULL,
  unit VARCHAR(20) NOT NULL,
  current_stock DECIMAL(12,2) NOT NULL DEFAULT 0,
  minimum_stock DECIMAL(12,2) NOT NULL DEFAULT 0,
  supplier_name VARCHAR(120) NOT NULL,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  archived_at TIMESTAMP NULL
);

CREATE TABLE accessory_usages (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  accessory_id BIGINT NOT NULL,
  article_id BIGINT NULL,
  quantity DECIMAL(12,2) NOT NULL,
  note TEXT NULL,
  created_by BIGINT NOT NULL,
  created_at TIMESTAMP NULL,
  FOREIGN KEY (accessory_id) REFERENCES accessories(id),
  FOREIGN KEY (article_id) REFERENCES articles(id),
  FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE productions (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  article_id BIGINT NOT NULL,
  step ENUM('cutting','stitching','finishing') NOT NULL,
  vendor_name VARCHAR(120) NOT NULL,
  issued_quantity INT NOT NULL,
  expected_return_date DATE NULL,
  received_quantity INT NULL,
  rejected_quantity INT NOT NULL DEFAULT 0,
  created_by BIGINT NOT NULL,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  FOREIGN KEY (article_id) REFERENCES articles(id),
  FOREIGN KEY (created_by) REFERENCES users(id)
);

CREATE TABLE transfers (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  from_location_id BIGINT NOT NULL,
  to_location_id BIGINT NOT NULL,
  status ENUM('pending','in_transit','received','cancelled') NOT NULL,
  requested_by BIGINT NOT NULL,
  approved_by BIGINT NULL,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  FOREIGN KEY (from_location_id) REFERENCES locations(id),
  FOREIGN KEY (to_location_id) REFERENCES locations(id),
  FOREIGN KEY (requested_by) REFERENCES users(id),
  FOREIGN KEY (approved_by) REFERENCES users(id)
);

CREATE TABLE transfer_items (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  transfer_id BIGINT NOT NULL,
  variant_id BIGINT NOT NULL,
  quantity INT NOT NULL,
  created_at TIMESTAMP NULL,
  FOREIGN KEY (transfer_id) REFERENCES transfers(id),
  FOREIGN KEY (variant_id) REFERENCES variants(id)
);

CREATE TABLE returns (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  order_id BIGINT NOT NULL,
  reason VARCHAR(255) NOT NULL,
  status ENUM('pending','approved','rejected') NOT NULL,
  created_by BIGINT NOT NULL,
  approved_by BIGINT NULL,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (created_by) REFERENCES users(id),
  FOREIGN KEY (approved_by) REFERENCES users(id)
);

CREATE TABLE return_items (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  return_id BIGINT NOT NULL,
  variant_id BIGINT NOT NULL,
  quantity INT NOT NULL,
  created_at TIMESTAMP NULL,
  FOREIGN KEY (return_id) REFERENCES returns(id),
  FOREIGN KEY (variant_id) REFERENCES variants(id)
);
