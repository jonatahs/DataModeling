-- Dim Sales Territory

CREATE TABLE [Dim_SalesTerritory] (
SK_Territory INT IDENTITY PRIMARY KEY,
SalesTerritoryID INT, Name VARCHAR(100)
);

INSERT INTO [Dim_SalesTerritory] SELECT
TerritoryID
,Name
FROM [SalesDatabase].[Sales].[SalesTerritory];
 

-- Dim StateProvince
CREATE TABLE [Dim_StateProvince] (
SK_StateProvince INT IDENTITY PRIMARY KEY, StateProvinceID INT,
Name VARCHAR(100),
SK_Territory INT
);

INSERT INTO Dim_StateProvince SELECT
T1.StateProvinceID, T1.Name, T2.SK_Territory
FROM [SalesDatabase].[Person].[StateProvince] T1 INNER JOIN Dim_SalesTerritory T2
ON T1.TerritoryID = T2.SalesTerritoryID

ALTER TABLE [Dim_StateProvince] ADD CONSTRAINT FK_Dim_StateProvince_Dim_SalesTerritory
FOREIGN KEY (SK_SalesTerritory) REFERENCES [Dim_SalesTerritory] (SK_SalesTerritory)

-- Dim Dim Address

CREATE TABLE [Dim_Address] (
SK_Address INT IDENTITY PRIMARY KEY,
AddressID INT, AddressLine [nvarchar](60),
[City] [nvarchar](30) NOT NULL, [PostalCode] [nvarchar](15) NOT NULL, SK_StateProvince INT
);
 

INSERT INTO [Dim_Address] SELECT
T1.AddressID
,CASE
WHEN T1.[AddressLine1] IS NULL THEN T1.AddressLine2 ELSE T1.AddressLine1
END AddressLine
,T1.[City]
,T1.[PostalCode]
,T2.SK_StateProvince
FROM [SalesDatabase].[Person].[Address] T1 INNER JOIN Dim_StateProvince T2
ON T1.StateProvinceID = T2.StateProvinceID

ALTER TABLE [Dim_Address] ADD CONSTRAINT FK_Dim_Address_Dim_StateProvince FOREIGN KEY (SK_StateProvince) REFERENCES [Dim_StateProvince] (SK_StateProvince)

-- Dim Customer
CREATE TABLE [Dim_Customer] (
SK_Customer INT IDENTITY PRIMARY KEY,
CustomerID INT, SK_Address INT
);
 

INSERT INTO [Dim_Customer] SELECT
T1.CustomerID
,T4.SK_Address
FROM [SalesDatabase].[Sales].[Customer] T1 INNER JOIN [SalesDatabase].[Person].[Person] T2 ON T1.PersonID = T2.BusinessEntityID
INNER JOIN [SalesDatabase].[Person].[BusinessEntityAddress] T3 ON T3.BusinessEntityID = T2.BusinessEntityID
INNER JOIN Dim_Address T4 ON T3.AddressID = T4.AddressID

ALTER TABLE [Dim_Customer] ADD CONSTRAINT FK_Dim_Customer_Dim_Address FOREIGN KEY (SK_Address) REFERENCES [Dim_Address] (SK_Address)

-- Dim Product Category
CREATE TABLE [Dim_ProductCategory] (
SK_ProductCategory INT IDENTITY PRIMARY KEY, ProductCategoryID INT,
Name VARCHAR(100)
)
 

INSERT INTO [Dim_ProductCategory] SELECT
ProductCategoryID, Name
FROM [Production].[ProductCategory]

-- Dim Product Subcategory
CREATE TABLE [Dim_ProductSubcategory] (
SK_ProductSubcategory INT IDENTITY PRIMARY KEY, ProductSubcategoryID INT,
Name VARCHAR(100),
SK_ProductCategory INT
)

INSERT INTO [Dim_ProductSubcategory] SELECT
PSC.ProductSubcategoryID, PSC.Name, DPC.SK_ProductCategory
FROM [Production].[ProductSubcategory] AS PSC JOIN [Dim_ProductCategory] AS DPC
ON PSC.ProductCategoryID = DPC.ProductCategoryID

ALTER TABLE [Dim_ProductSubcategory] ADD CONSTRAINT FK_Dim_ProductSubcategory_Dim_ProductCategory
FOREIGN KEY (SK_ProductCategory) REFERENCES [Dim_ProductCategory] (SK_ProductCategory)

-- Dim Product Model
CREATE TABLE [Dim_ProductModel] (
SK_ProductModel INT IDENTITY PRIMARY KEY,
ProductModelID INT, Name VARCHAR(100)
)
 


INSERT INTO [Dim_ProductModel] SELECT
[ProductModelID]
,[Name]
FROM [SalesDatabase].[Production].[ProductModel]

-- Dim color
CREATE TABLE [Dim_Color] (
SK_Color INT IDENTITY PRIMARY KEY, Name VARCHAR(100)
)

INSERT INTO [Dim_Color] SELECT DISTINCT
Color
FROM [SalesDatabase].[Production].[Product]

CREATE TABLE [Dim_Product] (
SK_Product INT IDENTITY PRIMARY KEY,
SK_Color INT, SK_ProductSubcategory INT, SK_ProductModel INT, ProductID INT,
Name VARCHAR(100)
)
 

INSERT INTO [Dim_Product] SELECT
T2.SK_Color
,T3.SK_ProductSubcategory
,T4.SK_ProductModel
,T1.ProductID
,T1.Name
FROM [SalesDatabase].[Production].[Product] T1 INNER JOIN [Dim_Color] T2
ON T1.Color = T2.Name
INNER JOIN [Dim_ProductSubcategory] T3
ON T1.ProductSubcategoryID = T3.ProductSubcategoryID INNER JOIN [Dim_ProductModel] T4
ON T1.ProductModelID = T4.ProductModelID

ALTER TABLE [Dim_Color] ADD CONSTRAINT [FK_Dim_Product_Dim_Color] FOREIGN KEY([SK_Color])
REFERENCES [Dim_Color] ([SK_Color])

ALTER TABLE [Dim_Product] ADD CONSTRAINT
[FK_Dim_Product_Dim_ProductSubcategory] FOREIGN KEY([SK_ProductSubcategory])
REFERENCES [Dim_ProductSubcategory] ([SK_ProductSubcategory])

ALTER TABLE [Dim_Product] ADD CONSTRAINT [FK_Dim_Product_Dim_ProductModel] FOREIGN KEY([SK_ProductModel])
REFERENCES [Dim_ProductModel] ([SK_ProductModel])
 

-- Dim Credit Card
CREATE TABLE [Dim_CreditCard] (
SK_CreditCard INT IDENTITY PRIMARY KEY,
[CreditCardID] INT, [CardType] [nvarchar](50), [CardNumber] [nvarchar](25), [ExpMonth] [tinyint], [ExpYear] [smallint]
)


INSERT INTO [Dim_CreditCard] SELECT [CreditCardID]
,[CardType]
,[CardNumber]
,[ExpMonth]
,[ExpYear]
FROM [SalesDatabase].[Sales].[CreditCard]

-- Dim Store
CREATE TABLE [Dim_Store] (
SK_Store INT IDENTITY PRIMARY KEY,
[BusinessEntityID] [int], [Name] VARCHAR(100),
[SalesPersonID] [int]
)
 

INSERT INTO [Dim_Store] SELECT
[BusinessEntityID]
,[Name]
,[SalesPersonID]
FROM [SalesDatabase].[Sales].[Store]

CREATE TABLE [Fato_OrderCustomers] (
SK_Customer INT
,SK_Product INT
,SK_CreditCard INT
,SK_Territory INT
,OrderQty INT
,Amount_Total DECIMAL(38,6)
,Order_Year INT
,Order_Month INT
)
 

INSERT INTO [Fato_OrderCustomers] SELECT
T1.SK_Customer
,T4.SK_Product
,T5.SK_CreditCard
,T8.SK_Territory
,T3.OrderQty
,T3.LineTotal AS Amount_Total
,YEAR(T2.OrderDate) AS Order_Year
,MONTH(T2.OrderDate) AS Order_Month FROM Dim_Customer T1
INNER JOIN [Sales].[SalesOrderHeader] T2 ON T1.CustomerID = T2.CustomerID INNER JOIN [Sales].[SalesOrderDetail] T3 ON T2.SalesOrderID = T3.SalesOrderID INNER JOIN Dim_Product T4
ON T3.ProductID = T4.ProductID INNER JOIN [Dim_CreditCard] T5
ON T2.CreditCardID = T5.CreditCardID INNER JOIN Dim_Address T6
ON T1.SK_Address = T6.SK_Address INNER JOIN Dim_StateProvince T7
ON T6.SK_StateProvince = T7.SK_StateProvince INNER JOIN Dim_SalesTerritory T8
ON T7.SK_Territory = T8.SK_Territory
 
