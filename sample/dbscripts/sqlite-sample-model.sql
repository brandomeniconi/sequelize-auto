DROP TABLE IF EXISTS "OrderItem";
DROP TABLE IF EXISTS "Product";
DROP TABLE IF EXISTS "Supplier";
DROP TABLE IF EXISTS "Order";
DROP TABLE IF EXISTS "Customer";

CREATE TABLE "Customer" (
   "Id"                   INTEGER             NOT NULL PRIMARY KEY,
   "FirstName"            VARCHAR(40)         NOT NULL,
   "LastName"             VARCHAR(40)         NOT NULL,
   "City"                 VARCHAR(40)         NULL,
   "Country"              VARCHAR(40)         NULL,
   "Phone"                VARCHAR(20)         NULL,
   CONSTRAINT "UN_Customer_LastName_Firstname" UNIQUE ("LastName", "FirstName")
);

CREATE TABLE "Supplier" (
   "Id"                   INTEGER             NOT NULL PRIMARY KEY,
   "CompanyName"          VARCHAR(40)         NOT NULL,
   "ContactName"          VARCHAR(50)         NULL,
   "ContactTitle"         VARCHAR(40)         NULL,
   "City"                 VARCHAR(40)         NULL,
   "Country"              VARCHAR(40)         NULL,
   "Phone"                VARCHAR(30)         NULL,
   "Fax"                  VARCHAR(30)         NULL,
   CONSTRAINT "UN_Supplier_CompanyName" UNIQUE ("CompanyName", "Country")
);

CREATE TABLE "Product" (
   "Id"                   INTEGER             NOT NULL PRIMARY KEY,
   "ProductName"          VARCHAR(50)         NOT NULL,
   "SupplierId"           INT                 NOT NULL,
   "UnitPrice"            DECIMAL(12,2)       NULL DEFAULT 0,
   "Package"              VARCHAR(30)         NULL,
   "IsDiscontinued"       BOOLEAN             NOT NULL DEFAULT false,
   CONSTRAINT "UN_Product_ProductName" UNIQUE ("ProductName"),
   FOREIGN KEY ("SupplierId") REFERENCES "Supplier" ("Id")
);

CREATE TABLE "Order" (
   "Id"                   INTEGER             NOT NULL PRIMARY KEY,
   "OrderDate"            TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP,
   "OrderNumber"          VARCHAR(10)         NULL,
   "CustomerId"           INT                 NOT NULL,
   "TotalAmount"          DECIMAL(12,2)       NULL DEFAULT 0,
   CONSTRAINT "UN_Order_CustomerId_OrderDate" UNIQUE ("CustomerId", "OrderDate", "OrderNumber"),
   CONSTRAINT "UN_Order_OrderNumber" UNIQUE ("OrderNumber"),
   FOREIGN KEY ("CustomerId") REFERENCES "Customer" ("Id")
);

CREATE TABLE "OrderItem" (
   "Id"                   INTEGER              NOT NULL PRIMARY KEY,
   "OrderId"              INT                  NOT NULL,
   "ProductId"            INT                  NOT NULL,
   "UnitPrice"            DECIMAL(12,2)        NOT NULL DEFAULT 0,
   "Quantity"             INT                  NOT NULL DEFAULT 1,
   CONSTRAINT "UN_OrderItem_OrderId_ProductId" UNIQUE ("OrderId", "ProductId"),
   FOREIGN KEY ("OrderId") REFERENCES "Order" ("Id"),
   FOREIGN KEY ("ProductId") REFERENCES "Product" ("Id")
);
