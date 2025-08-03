CREATE TABLE "DimEmployees" (
  "employee_id" integer PRIMARY KEY,
  "name" varchar,
  "email" varchar,
  "salary" varchar,
  "entry" datetime,
  "role_id" integer,
  "status" boolean
);

CREATE TABLE "DimDepartments" (
  "department_id" integer PRIMARY KEY,
  "name" varchar,
  "created_at" timestamp
);

CREATE TABLE "DimRoles" (
  "role_id" integer PRIMARY KEY,
  "department_id" integer,
  "title" varchar,
  "description" text,
  "created_at" timestamp,
  "status" boolean
);

CREATE TABLE "FactJob_history" (
  "job_id" integer PRIMARY KEY,
  "employee_id" integer,
  "salary" float,
  "entry" datetime,
  "end_date" datetime,
  "duration" integer
);

CREATE TABLE "DimProducts" (
  "product_id" integer PRIMARY KEY,
  "name" varchar,
  "description" text,
  "quantity" integer,
  "price" float,
  "category" text,
  "supplier_id" integer
);

CREATE TABLE "DimCustomers" (
  "customer_id" integer PRIMARY KEY,
  "name" varchar,
  "address" varchar,
  "phone" varchar
);

CREATE TABLE "DimSuppliers" (
  "supplier_id" integer PRIMARY KEY,
  "supplier_name" varchar,
  "contact_person" varchar,
  "email" varchar
);

CREATE TABLE "FactOrders" (
  "order_id" integer PRIMARY KEY,
  "customer_id" integer,
  "employee_id" integer,
  "products" integer[],
  "order_time" timestamp,
  "delivery_date" datetime,
  "total_amount" float,
  "tax_amount" float,
  "revenue" float
);

CREATE TABLE "DimShipments" (
  "shipment_id" integer PRIMARY KEY,
  "order_id" integer,
  "shipment_date" datetime,
  "status" varchar
);

COMMENT ON COLUMN "DimRoles"."description" IS 'Specification of the role';

COMMENT ON COLUMN "FactJob_history"."duration" IS 'Duration in days';

COMMENT ON COLUMN "DimProducts"."description" IS 'Specification of the product';

ALTER TABLE "FactJob_history" ADD CONSTRAINT "job_history" FOREIGN KEY ("employee_id") REFERENCES "DimEmployees" ("employee_id");

ALTER TABLE "DimEmployees" ADD FOREIGN KEY ("role_id") REFERENCES "DimRoles" ("role_id");

ALTER TABLE "DimRoles" ADD FOREIGN KEY ("department_id") REFERENCES "DimDepartments" ("department_id");

ALTER TABLE "FactOrders" ADD FOREIGN KEY ("customer_id") REFERENCES "DimCustomers" ("customer_id");

ALTER TABLE "FactOrders" ADD FOREIGN KEY ("employee_id") REFERENCES "DimEmployees" ("employee_id");

ALTER TABLE "DimProducts" ADD FOREIGN KEY ("product_id") REFERENCES "FactOrders" ("products");

ALTER TABLE "DimProducts" ADD FOREIGN KEY ("supplier_id") REFERENCES "DimSuppliers" ("supplier_id");

ALTER TABLE "FactOrders" ADD FOREIGN KEY ("order_id") REFERENCES "DimShipments" ("order_id");
