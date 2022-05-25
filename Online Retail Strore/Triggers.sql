use ORSFinal1 ; 


-- Trigger 1 on Age checking before insertion 
delimiter //
CREATE TRIGGER age_check BEFORE UPDATE
ON Customer
FOR EACH ROW
IF NEW.age < 18 THEN
SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Person must be older than 18.';
END IF; //
delimiter ;


-- Trigger 2 on safely deleting  a product
delimiter //
create trigger deleted_products
after delete
on ProductList
for each row
insert into deleted_products values(old.ProductID, old.Type, old.PName, old.Quantity, old.Status, old.Size); //
delimiter ;


-- Trigger 3 on safely deleting a person
delimiter //
CREATE TRIGGER person_del BEFORE DELETE
ON Customer 
FOR EACH ROW
INSERT INTO person_archive (CustomerID,Name,Email,contact,age)
VALUES (OLD.CustomerID,OLD.Name,OLD.Email,OLD.contact,OLD.age); //
delimiter ;


-- Trigger 4 on checking the quantity at insertion
delimiter //
CREATE TRIGGER quant_check BEFORE INSERT
ON ProductList 
FOR EACH ROW
IF NEW.Quantity <=0 THEN
SIGNAL SQLSTATE '50001' SET MESSAGE_TEXT = 'Quantity should have more than 0 items';
END IF; //
delimiter ;