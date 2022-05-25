
--  Query 1 -tbexplained


-- SELECT Totalitems,Discount,Amount FROM Cart WHERE Cart.CustomerID = (
-- SELECT CustomerID FROM(
-- 	SELECT CustomerID,Amount,
--     RANK() OVER (ORDER BY Quantity DESC) AS QuantityOrder
--     FROM Orders) as T
--     WHERE T.QuantityOrder=1
-- )

--  Query 2


-- SELECT CustomerID,TransactionID,PaymentStatus FROM Transaction WHERE Transaction.CustomerID IN
-- (SELECT CustomerID FROM
-- (SELECT CustomerID, OrderID ,Amount,
-- DENSE_RANK() OVER (ORDER BY Amount DESC) AS AmountDesc
-- FROM Orders where Status="Active") as T
-- WHERE AmountDesc <6)

-- Query 3

-- SELECT VendorID, Amount_Sum, Discount_Sum ,ModeOfPayment_max , dense_rank() OVER (Order by Amount_Sum DESC) as SumAmount_rank,
-- dense_rank() OVER (Order by Discount_Sum DESC) as SumDiscount_rank,
-- dense_rank() OVER (Order by ModeOfPayment_max  DESC) as MaxModeOfPayment_rank
-- FROM
-- (SELECT VendorID, Sum(Amount) AS Amount_Sum , Sum(Discount) AS Discount_Sum ,Max(ModeOfPayment) AS ModeOfPayment_max 
-- FROM
-- (SELECT* FROM Transaction WHERE PaymentStatus = "InProgress" OR PaymentStatus = "Pending" Having Amount > 3000) as T 
-- GROUP BY VendorID) AS M

-- Query 4 

-- SELECT V.VendorID,Vendorname,contact,OrderID,CustomerID,Amount,Quantity FROM Vendor V INNER JOIN orders O where V.VendorID = O.VendorID AND Status = "Active" AND Rating>3 And Quantity > 30  
-- Order by Amount DESC 


-- Query 5 

-- SELECT X.VendorID,Vendorname,contact,VAddress FROM AddressVendor AS X INNER JOIN 
-- (SELECT* FROM Vendor WHERE Vendor.VendorID IN (SELECT VendorID FROM ProductInventory WHERE Price > 400 and Quantity > 30) AND Rating < 4) As H
-- WHERE X.VendorID = H.VendorID

-- QUERY 6 

-- SELECT CustomerID,Totalitems,Amount,Discount 
-- FROM Cart 
-- INNER JOIN (SELECT CartID FROM CartContent WHERE Price = (SELECT MAX(Price) FROM CartContent)) 
-- AS D WHERE Cart.CartID = D.CartID  

-- query 7

-- SELECT* FROM CustomerPaymentMethod C 
-- WHERE C.CustomerID IN (SELECT CustomerID FROM (SELECT CustomerID, RANK() OVER (ORDER BY discount DESC) AS Dis_DEC FROM Cart) 
-- AS R WHERE Dis_DEC < 3)

--  Query 8

-- SELECT * FROM ProductInventory 
-- INNER JOIN (SELECT ProductID,Pname FROM ProductList WHERE Type= "CLOTHING" ) 
-- AS N WHERE N.ProductID = ProductInventory.ProductID

-- Query 9

-- SELECT * FROM Orders INNER JOIN
-- (SELECT DISTINCT(CustomerID) FROM CustomerPaymentMethod where ModeOfPayment = "Netbanking") AS J WHERE J.CustomerID = Orders.CustomerID AND Orders.Status = "Active"

-- query 10

-- SELECT OrderID,ProductID,Amount,Quantity, RANK() OVER (ORDER BY Amount DESC) AS Amount_Desc FROM 
-- (SELECT* FROM Orders WHERE OrderID IN (
-- SELECT distinct(OrderID) FROM Transaction WHere PaymentStatus="Done") AND Status ="Active") as o


-- Query 11 

-- Select Department FROM
-- (SELECT Department, DENSE_RANK() OVER(ORDER BY Salary Desc) 
-- AS SalaryOrder FROM
-- (SELECT Employee.EmployeeID,Employee.EName,contact,Salary,Department 
-- FROM Employee right 
-- outer join Works ON(Works.EmployeeID = Employee.EmployeeID)) as n) 
-- as c WHERE SalaryOrder<5;

-- Query 12 

-- SELECT* FROM Transaction JOIN
-- (SELECT OrderID FROM Orders WHERE VendorID IN (SELECT VendorID FROM Vendor WHERE Rating = 0 )) as N
-- WHERE N.OrderID = Transaction.OrderID

-- Query 13

-- SELECT AddressWareHouse.WarehousesID,WarehouseName,WAddress 
-- FROM AddressWareHouse 
-- JOIN
-- (SELECT Warehouses.WarehousesID,WarehouseName FROM Warehouses 
-- JOIN
-- (SELECT distinct(WarehousesID) FROM OwnedBy) as D 
-- where D.WarehousesID = Warehouses.WarehousesID) as l 
-- WHERE l.WarehousesID = AddressWareHouse.WarehousesID




 -- QUERY 14
-- SELECT DISTINCT(ProductInventory.VendorID) 
-- FROM ProductInventory JOIN 
-- (SELECT ProductID FROM OfferHistory WHERE OfferStartDate<"2022-07-01" and OfferEndDate>"2022-08-01") as j 
-- where j.ProductID = ProductInventory.ProductID AND ProductInventory.Status = "Available";
