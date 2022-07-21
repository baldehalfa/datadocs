-- SQL dump generated using DBML (dbml-lang.org)
-- Database: PostgreSQL
-- Generated at: 2022-07-21T05:59:22.905Z

CREATE TYPE "products_status" AS ENUM (
  'out_of_stock',
  'in_stock',
  'running_low'
);

CREATE TABLE "users" (
  "id" SERIAL PRIMARY KEY,
  "full_name" varchar,
  "created_at" timestamp,
  "country_code" int
);

CREATE TABLE "merchants" (
  "id" int PRIMARY KEY,
  "merchant_name" varchar,
  "country_code" int,
  "admin_id" int,
  "created_at" datetime DEFAULT (now())
);

CREATE TABLE "countries" (
  "code" int PRIMARY KEY,
  "name" varchar,
  "continent_name" varchar
);

CREATE TABLE "order_items" (
  "order_id" int,
  "product_id" int,
  "quantity" int DEFAULT 1
);

CREATE TABLE "orders" (
  "id" int PRIMARY KEY,
  "user_id" int UNIQUE NOT NULL,
  "status" varchar,
  "created_at" varchar
);

CREATE TABLE "products" (
  "id" int PRIMARY KEY,
  "name" varchar,
  "merchant_id" int NOT NULL,
  "price" int,
  "status" products_status,
  "created_at" datetime DEFAULT (now())
);

CREATE INDEX "product_status" ON "products" ("merchant_id", "status");

CREATE UNIQUE INDEX ON "products" ("id");

COMMENT ON TABLE "users" IS 'table "users" contains user information';

COMMENT ON TABLE "merchants" IS 'table "merchants" contains merchant information';

COMMENT ON COLUMN "merchants"."country_code" IS 'country of merchant';

COMMENT ON COLUMN "merchants"."created_at" IS 'created time';

COMMENT ON TABLE "order_items" IS 'items in an order';

COMMENT ON COLUMN "orders"."created_at" IS 'When order created';

ALTER TABLE "merchants" ADD FOREIGN KEY ("admin_id") REFERENCES "users" ("id");

ALTER TABLE "order_items" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");

ALTER TABLE "users" ADD FOREIGN KEY ("country_code") REFERENCES "countries" ("code");

ALTER TABLE "merchants" ADD FOREIGN KEY ("country_code") REFERENCES "countries" ("code");

ALTER TABLE "order_items" ADD FOREIGN KEY ("product_id") REFERENCES "products" ("id");

ALTER TABLE "products" ADD FOREIGN KEY ("merchant_id") REFERENCES "merchants" ("id");
