CREATE TABLE "DimEmployees" (
  "employee_id" SERIAL PRIMARY KEY,
  "name" varchar NOT NULL,
  "email" varchar NOT NULL,
  "salary" varchar,
  "entry" date NOT NULL,
  "role_id" integer,
  "status" boolean
);

CREATE TABLE "DimDepartments" (
  "department_id" SERIAL PRIMARY KEY,
  "name" varchar NOT NULL,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "DimRoles" (
  "role_id" SERIAL PRIMARY KEY,
  "department_id" integer NOT NULL,
  "title" varchar,
  "description" text,
  "created_at" timestamp NOT NULL,
  "status" boolean NOT NULL
);

CREATE TABLE "FactJob_history" (
  "job_id" SERIAL PRIMARY KEY,
  "employee_id" integer NOT NULL,
  "salary" float,
  "entry" date,
  "end_date" date,
  "duration" integer
);

CREATE TABLE "DimProducts" (
  "product_id" SERIAL PRIMARY KEY,
  "name" varchar NOT NULL,
  "description" text,
  "quantity" integer,
  "price" float,
  "category" text,
  "supplier_id" integer NOT NULL
);

CREATE TABLE "DimCustomers" (
  "customer_id" SERIAL PRIMARY KEY,
  "name" varchar,
  "address" varchar,
  "phone" varchar NOT NULL
);

CREATE TABLE "DimSuppliers" (
  "supplier_id" SERIAL PRIMARY KEY,
  "supplier_name" varchar,
  "contact_person" varchar NOT NULL,
  "email" varchar NOT NULL
);

CREATE TABLE "FactOrders" (
  "order_id" SERIAL PRIMARY KEY,
  "customer_id" integer NOT NULL,
  "employee_id" integer NOT NULL,
  "products" integer[],
  "order_time" timestamp,
  "delivery_date" date,
  "total_amount" float,
  "tax_amount" float,
  "revenue" float
);

CREATE TABLE "DimShipments" (
  "shipment_id" SERIAL PRIMARY KEY,
  "order_id" integer NOT NULL,
  "shipment_date" date,
  "status_id" integer NOT NULL
);

CREATE TABLE "DimStatuses" (
	"status_id" SERIAL PRIMARY KEY,
	"name" varchar NOT NULL
);

COMMENT ON COLUMN "DimRoles"."description" IS 'Specification of the role';

COMMENT ON COLUMN "FactJob_history"."duration" IS 'Duration in days';

COMMENT ON COLUMN "DimProducts"."description" IS 'Specification of the product';

ALTER TABLE "FactJob_history" ADD CONSTRAINT "job_history" FOREIGN KEY ("employee_id") REFERENCES "DimEmployees" ("employee_id");

ALTER TABLE "DimEmployees" ADD FOREIGN KEY ("role_id") REFERENCES "DimRoles" ("role_id");

ALTER TABLE "DimRoles" ADD FOREIGN KEY ("department_id") REFERENCES "DimDepartments" ("department_id");

ALTER TABLE "FactOrders" ADD FOREIGN KEY ("customer_id") REFERENCES "DimCustomers" ("customer_id");

ALTER TABLE "FactOrders" ADD FOREIGN KEY ("employee_id") REFERENCES "DimEmployees" ("employee_id");

ALTER TABLE "DimProducts" ADD FOREIGN KEY ("supplier_id") REFERENCES "DimSuppliers" ("supplier_id");

ALTER TABLE "DimShipments" ADD FOREIGN KEY ("order_id") REFERENCES "FactOrders" ("order_id");

ALTER TABLE "DimShipments" ADD FOREIGN KEY ("status_id") REFERENCES "DimStatuses" ("status_id");

