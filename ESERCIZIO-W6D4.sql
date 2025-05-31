-- La consegna dell'esercizio mi chiedeva di mostrare La categoria e la sottocategoria di un prodotto all'interno della tabella dimproduct
-- La principale difficoltà è stata quella di trovare un punto di ancoraggio tra le tabelle in modo tale da poter effettuare il JOIN

-- ESERCIZI 1 E 2
SELECT ProductKey, EnglishProductName AS ProductName, StandardCost, Category.EnglishProductCategoryName AS Category, PC.EnglishProductSubcategoryName AS Subcategory
FROM dimproduct D
LEFT JOIN dimproductsubcategory PC ON D.ProductSubcategoryKey = PC.ProductSubcategoryKey
LEFT JOIN dimproductcategory Category ON PC.productcategorykey = Category.productcategorykey
;

-- ESERCIZIO 3
SELECT *
FROM dimproduct D
JOIN factresellersales S ON D.productkey = S.productkey
;

-- ESERCIZIO 4
-- Ho avuto difficoltà nel trovare il modo di filtrare solo i prodotti che non contenessero nessuno valore nella tabella FactSellerSales (e che quindi non avessere venduto)
-- Ho provato con 
-- AND S.SalesOrderNumber = NULL ma non funzionava, poi provando ho trovato la sintassi giusta
SELECT D.ProductKey, EnglishProductName AS ProductName, StandardCost, S.SalesOrderNumber, S.OrderDate, S.ResellerKey, S.EmployeeKey, S.SalesTerritoryKey, S.OrderQuantity, S. SalesAmount
FROM dimproduct D
LEFT JOIN factresellersales S ON D.productkey = S.productkey
WHERE FinishedGoodsFlag = 1 
AND S.SalesOrderNumber IS NULL
;

-- ESERCIZIO 5
SELECT EnglishProductName AS ProductName, S.OrderDate, S.OrderQuantity, S.UnitPrice, S.TotalProductCost, S.SalesAmount
FROM dimproduct D
JOIN factresellersales S ON D.productkey = S.productkey
;

-- ESERCIZIO 6
-- La categoria dei prodotti è la foreign key della tabella dimProductSubcategory. Quindi innazitutto ho dovuto fare un join tra i dati di vendita e collegarli al loro nome
-- Dopo di ché avendo il nome dei prodotti mi serviva la loro sottocategoria e quindi ho fatto JOIN con dimProductSubcategory. 
-- Infine il JOIN con la tabella dimproductcategory per avere la categoria
SELECT D.EnglishProductName AS ProductName,  CAT.EnglishProductCategoryName AS CategoryName, S.*
FROM factresellersales S
JOIN dimproduct D ON S.ProductKey = D.ProductKey
JOIN dimproductsubcategory SUB ON D.ProductSubcategoryKey = SUB.ProductSubcategoryKey
JOIN dimproductcategory CAT ON SUB.ProductCategoryKey = CAT.ProductCategoryKey
;

-- ESERCIZIO 7 E 8
SELECT ResellerKey, ResellerName, BusinessType, GEO.* 
FROM dimreseller RES
JOIN dimgeography GEO ON RES.GeographyKey = GEO.GeographyKey
;

-- ESERCIZIO 9
SELECT SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, OrderQuantity, TotalProductCost, EnglishProductName AS ProductName, EnglishProductCategoryName AS CategoryName, ResellerName, City, StateProvinceName, EnglishCountryRegionName AS CountryName
FROM factresellersales SALES
JOIN dimproduct DIM ON SALES.ProductKey = DIM.ProductKey
JOIN dimproductsubcategory SUB ON DIM.ProductSubcategoryKey = SUB.ProductSubcategoryKey
JOIN dimproductcategory CAT ON SUB.ProductCategoryKey = CAT.ProductCategoryKey
JOIN dimreseller RES ON SALES.ResellerKey = RES.ResellerKey
JOIN dimgeography GEO ON RES.GeographyKey = GEO.GeographyKey
;











