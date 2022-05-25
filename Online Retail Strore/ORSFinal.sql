drop database if exists ORSFinal1;
create database ORSFinal1;
use ORSFinal1;


create table Customer(
	CustomerID integer not null,
	Name varchar(50) not null,
	Email varchar(100) not null,
	contact varchar(50) not null unique,
	primary key(CustomerID)
);

create table Vendor(
	VendorID integer not null, 
	Vendorname varchar(50) not null,
	Email varchar(100) not null,
	contact varchar(50) not null unique,
	Rating integer not null default 0,
	primary key(VendorID)
);

create table ProductList(
	ProductID  integer not null ,
	Type varchar(50) not null ,
	Pname varchar(50) not null,
	Quantity integer not null default 0,
	Status enum('Available' , 'Unavailable'),
	Size integer not null default 0,
	primary key(ProductID)
);


create table ORS(
	UserID integer not null, 
    Usertype varchar(50) not null , 
    Username varchar(50) not null, 
	Password varchar(50) not null, 
    primary key(UserID , Usertype)
);

create table Orders(
	CustomerID integer not null,
	OrderID integer not null, 
	ProductID integer not null,
	VendorID integer not null,
	Amount integer not null default 0,
	Quantity integer not null default 0,
	Status enum ('Active'  , 'Completed'),
	OrderDate date ,
	ExpectedDeliveryDate date ,
	primary key(OrderID),
	foreign key (CustomerID) references Customer(CustomerID),
	foreign key (ProductID )references ProductList(ProductID),
	foreign key (VendorID) references Vendor(VendorID)

-- 1 is avaiable and 0 - unavailable

);

create table Transaction(
	CustomerID integer not null ,
	TransactionID integer not null ,
	OrderID integer not null,
	ProductID integer not null,
	VendorID integer not null,
	Amount integer not null default 0,
	Discount integer not null default 0,
	ModeOfPayment enum('Card' , 'NetBanking' , 'COD' , 'others'),
    TransactionRefID integer not null,
	TransactionDate date not null,
	PaymentStatus enum('Done' , 'InProgress' , 'Pending'),
	primary key(TransactionID),
	foreign key (CustomerID) references Customer(CustomerID),
	foreign key (OrderID) references Orders(OrderID)
);

create table Cart(
	CartID integer not null,
	CustomerID integer not null ,
	Totalitems integer not null default 0,
	Amount integer not null default 0,
	Discount integer not null default 0,
	primary key(CartID),
	foreign key (CustomerID) references Customer(CustomerID)
);

create table CartContent(
	CartID integer not null,
	ProductID integer not null,
	Price integer not null default 0,
	Discount integer not null default 0,
	foreign key (CartID) references Cart(CartId),
	foreign key (ProductID ) references ProductList(ProductID)

);

create table CustomerPaymentMethod(
	FinID integer not null , 
	CustomerID integer not null ,
	ModeOfPayment enum('Card' , 'NetBanking' , 'COD' , 'others'),
	Cardno varchar(50) not null ,
	ExpiryDateMonth integer not null,
	ExpiryDateYear integer not null,
	primary key (FinID),
	foreign key (CustomerID) references Customer(CustomerID)

);



-- create table ProductInventory(
-- 	SerialNo integer not null,
-- 	ProductID  integer not null ,
-- 	VendorID integer not null,
-- 	Status enum('Available' , 'Unavailable'),
-- 	Price integer not null default  0,
-- 	Discount integer not null default 0,
-- 	primary key(SerialNo),
-- 	foreign key (ProductID) references ProductList(ProductID),
-- 	foreign key (VendorID ) references Vendor(VendorID)

-- );


create table ProductInventory(
	VendorID integer not null, 
	ProductID  integer not null ,
	Price integer not null default  0,
	Discount integer not null default 0,
	PriceStartDate date not null,
	OfferStartDate date not null,
	Quantity integer not null default 0,
	Status enum('Available' , 'Unavailable'),
	foreign key (VendorID )references Vendor(VendorID),
	foreign key (ProductID )references ProductList(ProductID)
);

create table Warehouses(
	WarehousesID integer not null,
	WarehouseName varchar(50) not null,
	primary key (WarehousesID)
	
);

create table OwnedBy(
	WarehousesID integer not null,
	VendorID integer not null,
	foreign key (VendorID) references Vendor(VendorID),
	foreign key (WarehousesID) references Warehouses(WarehousesID)
);

create table WarehousesInventory(
	VendorID integer not null,
	ProductID  integer not null ,
	Quantity integer not null default 0,
	Status enum('Available' , 'Unavailable'),
	foreign key (VendorID) references Vendor(VendorID),
	foreign key (ProductID) references ProductList(ProductID)

);


create table PriceHistory(
	VendorID integer not null,
	ProductID  integer not null ,
	PriceStartDate date not null,
	PriceEndDate date not null,
	Price integer not null default  0,
	foreign key (VendorID) references Vendor(VendorID),
	foreign key (ProductID) references ProductList(ProductID),
	constraint PriceStartDate check (PriceStartDate<= PriceEndDate)

-- SELECT replace('Not-Avaiable' , 'Not-A' , 'Una' );
);


create table OfferHistory(
	VendorID integer not null,
	ProductID  integer not null ,
	OfferStartDate date not null,
	OfferEndDate date not null,
	Discount integer not null default 0,
	foreign key (VendorID ) references Vendor(VendorID),
	foreign key (ProductID )references ProductList(ProductID),
	constraint OfferStartDate check ( OfferStartDate <= OfferEndDate)
);

create table Employee(
	EmployeeID integer not null unique,
	EName varchar(100) not null,
	contact varchar(50) not null unique,
	Email varchar(100) not null,
	Salary integer not null default 0,
	Department varchar(50) not null ,
	primary key (EmployeeID)

);

create table Works(
	EmployeeID integer not null unique,
	Employer varchar(50) not null,
	EName varchar(100) not null,
	foreign key (EmployeeID) references Employee(EmployeeID) 
);

create table AddressCustomer(
	AddressID integer not null unique , 
	CustomerID integer not null ,
	Address varchar(200) not null,
	primary key(AddressID),
	foreign key (CustomerID) references Customer(CustomerID)
);

create table AddressWareHouse(
	WarehouseAddressID integer not null unique,
	WarehousesID integer not null,
	WAddress varchar(200) not null,
	primary key(WarehouseAddressID),
	foreign key (WarehousesID)references Warehouses(WarehousesID)
);

create table AddressVendor(
	VAddressID integer not null unique,
	VendorID integer not null,
	VAddress varchar(200) not null,
	primary key (VAddressID ),
	foreign key (VendorID ) references Vendor(VendorID)

);


-- Order Data
-- Active
-- Completed 


-- CustomerData
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (76,'Dyanne Grenfell','dgrenfell0@yahoo.co.jp','551-543-1359');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (42,'Udale Iliffe','uiliffe1@ucsd.edu','885-915-9150');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (1,'Alma Kornilyev','akornilyev2@time.com','587-552-8323');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (99,'Waneta Jelkes','wjelkes3@state.gov','642-701-0421');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (4,'Arielle Oldroyd','aoldroyd4@japanpost.jp','958-426-2412');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (3,'Malory Gilburt','mgilburt5@pen.io','826-422-0124');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (82,'Westleigh Cackett','wcackett6@dailymotion.com','938-776-1817');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (77,'Sibley Aymerich','saymerich7@tamu.edu','404-798-6679');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (46,'Ynez McGawn','ymcgawn8@php.net','230-153-7589');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (90,'Neel Brooke','nbrooke9@mayoclinic.com','178-239-5258');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (18,'Mair Adolthine','madolthinea@woothemes.com','401-387-7503');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (79,'Morie Carne','mcarneb@so-net.ne.jp','411-662-4521');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (100,'Ertha Godart','egodartc@xinhuanet.com','111-818-4986');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (10,'Hubert Pretious','hpretiousd@wp.com','149-275-4025');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (19,'Karlotta Olenin','kolenine@npr.org','390-213-1113');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (11,'Marcia Branni','mbrannif@patch.com','207-148-0606');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (27,'Constance Rableau','crableaug@seesaa.net','393-277-5050');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (80,'Corella Revie','crevieh@netscape.com','626-665-5405');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (110,'Adrienne Baldetti','abaldettii@bluehost.com','664-638-6623');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (54,'Andie Vahl','avahlj@purevolume.com','889-113-7813');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (88,'Aggie Joska','ajoskak@ucsd.edu','396-137-8289');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (15,'Gavrielle Seery','gseeryl@mapquest.com','845-327-7261');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (22,'Maryanne Witling','mwitlingm@delicious.com','567-224-3730');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (7,'Ashleigh O''Day','aodayn@tuttocitta.it','774-645-7699');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (34,'Dov Lauga','dlaugao@1und1.de','553-765-2950');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (33,'Johnath Matschoss','jmatschossp@creativecommons.org','888-909-3393');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (21,'Kendrick Barnewelle','kbarnewelleq@europa.eu','829-374-0953');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (62,'Nate Nockles','nnocklesr@squarespace.com','758-966-3439');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (43,'Joceline Storkes','jstorkess@mlb.com','663-919-3937');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (68,'Ivy Rudall','irudallt@nps.gov','647-296-1502');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (75,'Willard Schettini','wschettiniu@nhs.uk','415-990-5628');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (44,'Amabelle Readmire','areadmirev@yellowpages.com','988-447-2026');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (143,'Rik Adelsberg','radelsbergw@posterous.com','765-549-3221');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (60,'Mehetabel Askew','maskewx@timesonline.co.uk','773-720-4345');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (52,'Julienne Rivelin','jriveliny@cpanel.net','924-993-0763');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (57,'Milena Degoey','mdegoeyz@spotify.com','354-705-8641');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (41,'Carin McCaughey','cmccaughey10@cocolog-nifty.com','814-601-2187');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (93,'Xever Sloan','xsloan11@fema.gov','202-668-0236');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (85,'Devinne Tilzey','dtilzey12@wunderground.com','641-937-5875');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (121,'Mozelle Murty','mmurty13@ox.ac.uk','221-589-6139');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (112,'Flora Seatter','fseatter14@webeden.co.uk','832-373-8052');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (113,'Theodoric Prettyjohns','tprettyjohns15@tiny.cc','983-683-7577');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (39,'Ferrell Horley','fhorley16@unc.edu','270-405-0921');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (114,'La verne Cunniff','lverne17@hatena.ne.jp','886-663-3742');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (8,'Grange Fausch','gfausch18@yandex.ru','120-142-2384');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (20,'Cherin Grimolbie','cgrimolbie19@webeden.co.uk','744-540-6001');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (2,'Cosme Pitrollo','cpitrollo1a@utexas.edu','593-260-9784');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (28,'Reginald Wilshere','rwilshere1b@clickbank.net','870-392-3838');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (115,'Anselma Wagerfield','awagerfield1c@msu.edu','960-338-5765');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (116,'Daksh Gulati','daksh@gmail.com','126-939-6980');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (117,'Yashika Singh','yashika@gmail.com','126-939-6990');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (118,'Vanisha Singh','vanisha@gmail.com','126-939-6999');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (119,'Ritvik Pendyala','pendyala20096@iiitd.ac.in','126-939-6919');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (120,'Anurag Sista','anurag@gmail.com','126-939-6920');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (132,'Tejdeep Ch','tejdeep@gmail.com','126-939-6921');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (122,'Jaideep G','jaideep@gmail.com','126-939-6922');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (123,'Tushar Vemula','tushar@gmail.com','126-939-6923');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (124,'Jatin Tyagi','jatin@gmail.com','126-939-6924');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (125,'Divyam Gupta','divyam@gmail.com','126-939-6579');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (126,'Kishan Sinha','kishan@gmail.com','126-939-6925');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (127,'Faizan Haider','faizan@gmail.com','126-939-6926');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (128,'Akshansh Jaiswal','akshansh@gmail.com','126-939-6929');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (129,'Vishesh Jain','vishesh@gmail.com','126-939-6930');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (130,'Kabir Singh','kabir@gmail.com','126-939-6931');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (131,'Alvin Joseph','alvin@gmail.com','126-939-6932');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (142,'Pratyush Jain','prayush@gmail.com','126-939-6933');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (133,'Shivanshu Sharma','shivanshu@gmail.com','126-939-6934');
INSERT INTO Customer(CustomerID,Name,Email,contact) VALUES (134,'Vishnu','vishnu@gmail.com','126-939-6935');





-- Vendor
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (89,'Zoovu','ghartegan0@auda.org.au','262-734-8272',3);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (59,'Yacero','jlishmund1@oracle.com','769-572-4651',3);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (68,'Jaxworks','bforrestill2@dailymail.co.uk','994-572-6989',2);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (10,'Thoughtblab','kmirando3@cocolog-nifty.com','941-180-1114',1);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (49,'Gigabox','smulliner4@usatoday.com','910-323-3510',1);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (29,'Bubblemix','aofer5@intel.com','960-173-0740',2);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (3,'Avamm','kbraycotton6@shutterfly.com','537-286-8905',4);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (83,'Avamm','bhartigan7@ustream.tv','475-699-3601',1);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (6,'Kaymbo','mgrannell8@edublogs.org','762-577-0240',2);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (2,'Kwilith','ghanster9@histats.com','858-410-9532',2);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (17,'Innotype','kcoggena@histats.com','840-570-0277',5);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (41,'Twinte','agrimsdithb@cloudflare.com','870-837-9410',1);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (32,'Jamia','tcurmc@sina.com.cn','730-484-1104',2);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (73,'Wikizz','cbidmeadd@utexas.edu','875-784-1702',0);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (36,'Buzzshare','tkerrode@pinterest.com','262-127-0587',4);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (34,'Yombu','bferschkef@spotify.com','760-232-9711',4);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (60,'Abata','fiacobaccig@google.ca','194-976-8818',5);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (26,'Avamba','mcolleth@globo.com','646-517-9440',5);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (8,'Tanoodle','elowingi@plala.or.jp','672-262-3921',5);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (65,'Brightdog','nvarnej@twitter.com','599-136-4243',5);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (55,'Aimbo','dmccaigheyk@cnet.com','708-373-3315',2);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (21,'Riffpedia','shamnerl@wp.com','942-758-0334',3);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (42,'Vitz','dbrislenm@bravesites.com','866-837-4949',2);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (11001,'Eabox','dmcgookinn@ibm.com','297-822-3622',3);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (12,'Devbug','rshrubshallo@cocolog-nifty.com','566-595-7239',0);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (87,'Camido','hkerridgep@meetup.com','974-297-6397',1);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (30,'Dablist','gmorrottq@dagondesign.com','354-933-1773',2);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (11,'Kazu','lannwylr@ebay.com','221-212-1686',5);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (1,'Buzzbean','srodenburgs@myspace.com','259-863-7730',2);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (11101,'Twiyo','rpeattiet@mozilla.org','954-599-1238',3);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (80,'Digitube','tleeuwerinku@mayoclinic.com','608-549-1448',2);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (111,'Yozio','vmanharev@cbc.ca','393-980-2749',0);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (92,'Eare','nrubanenkow@newsvine.com','149-919-1100',5);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (112,'Buzzster','dfindlayx@princeton.edu','169-440-4281',2);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (113,'Yoveo','rogianyy@toplist.cz','122-489-3128',3);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (115,'Demizz','daronsz@foxnews.com','632-884-6242',0);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (96,'Gigazoom','bchiverstone10@paginegialle.it','207-524-0431',4);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (79,'Photobug','eandrzejowski11@techcrunch.com','627-794-0868',0);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (15,'Meezzy','mchate12@wordpress.org','963-591-8775',5);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (116,'Yabox','apullan13@constantcontact.com','134-902-3371',0);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (5,'Gigashots','hmackinder14@cocolog-nifty.com','801-654-2963',1);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (47,'Podcat','afranceschino15@huffingtonpost.com','838-992-3703',5);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (117,'Shufflebeat','mhedan16@bandcamp.com','525-628-1416',5);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (84,'Ailane','lgrimolbie17@w3.org','270-685-4300',5);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (62,'Twitterwire','owhelpdale18@scientificamerican.com','646-253-1140',2);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (118,'Bubblebox','lpichmann19@csmonitor.com','743-303-0248',3);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (70,'Yacero','gcole1a@miibeian.gov.cn','742-400-7388',5);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (119,'Trupe','ggoslin1b@163.com','884-281-9826',0);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (120,'Browsezoom','ctigner1c@tripadvisor.com','513-177-0617',4);
INSERT INTO Vendor(VendorID,VendorName,Email,contact,Rating) VALUES (121,'Flipopia','hduling1d@hatena.ne.jp','388-726-0795',0);

-- Product List
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (317519,'GROCERY','Pastry - French Mini Assorted',74,'Available',4);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (523448,'GROCERY','Wine - Zonnebloem Pinotage',20,'Available',9);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (940676,'GROCERY','Flounder - Fresh',14,'Available',1);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (184880,'GROCERY','Amaretto',47,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (994090,'GROCERY','Cheese Cloth No 100',100,'Unavailable',3);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (161239,'GROCERY','Potato - Sweet',2,'Available',3);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (895985,'GROCERY','Soup Campbells Beef With Veg',28,'Unavailable',10);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (560543,'GROCERY','Cheese - Bocconcini',96,'Unavailable',1);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (393134,'GROCERY','Chocolate - Dark',58,'Unavailable',7);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (692932,'GROCERY','Beef Ground Medium',59,'Unavailable',2);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (339973,'GROCERY','Bacardi Breezer - Tropical',4,'Unavailable',7);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (883920,'GROCERY','Eggplant - Baby',78,'Available',3);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (382562,'GROCERY','Grapefruit - Pink',85,'Available',9);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (698739,'GROCERY','Halibut - Steaks',40,'Unavailable',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (411521,'GROCERY','Rolled Oats',95,'Unavailable',8);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (216973,'GROCERY','Soup - Campbells Mushroom',100,'Available',9);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (757779,'GROCERY','Canadian Emmenthal',27,'Available',7);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (535913,'GROCERY','Wine - Red, Metus Rose',31,'Unavailable',2);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (445495,'GROCERY','Ice Cream Bar - Oreo Sandwich',50,'Unavailable',7);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (625634,'GROCERY','Lid Tray - 12in Dome',97,'Available',6);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (267579,'GROCERY','V8 Pet',30,'Unavailable',6);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (466599,'GROCERY','Syrup - Chocolate',89,'Unavailable',10);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (977217,'GROCERY','Muffin - Zero Transfat',13,'Unavailable',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (939169,'GROCERY','Rice Wine - Aji Mirin',68,'Available',8);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (828045,'GROCERY','Beef - Bresaola',39,'Unavailable',10);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (759437,'GROCERY','Tuna - Sushi Grade',46,'Available',2);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (965252,'GROCERY','Sauce - Soya, Dark',40,'Available',3);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (405447,'GROCERY','Pepper - Red Thai',89,'Unavailable',7);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (753506,'GROCERY','Smoked Tongue',88,'Unavailable',4);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (186186,'GROCERY','Hot Choc Vending',83,'Available',9);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (947840,'GROCERY','Trout Rainbow Whole',6,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (971583,'GROCERY','Olives - Green, Pitted',38,'Unavailable',7);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (667498,'GROCERY','Veal - Leg, Provimi - 50 Lb Max',85,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (598496,'GROCERY','Marjoram - Dried, Rubbed',90,'Unavailable',10);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (357308,'GROCERY','Oil - Peanut',71,'Available',3);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (703428,'GROCERY','Wine - Delicato Merlot',79,'Unavailable',1);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (538557,'GROCERY','Cheese - Le Cru Du Clocher',41,'Available',3);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (254721,'GROCERY','Garam Masala Powder',42,'Available',10);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (804226,'GROCERY','Fish - Base, Bouillion',8,'Available',3);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (673990,'GROCERY','Silicone Parch. 16.3x24.3',10,'Available',10);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (133425,'GROCERY','Slt - Individual Portions',73,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (345938,'GROCERY','Island Oasis - Strawberry',34,'Unavailable',10);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (125311,'GROCERY','Beer - Labatt Blue',21,'Unavailable',6);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (606207,'GROCERY','Munchies Honey Sweet Trail Mix',65,'Unavailable',7);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (296694,'GROCERY','Water - Evian 355 Ml',44,'Unavailable',1);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (840897,'GROCERY','Wine - Blue Nun Qualitatswein',88,'Unavailable',1);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (739081,'GROCERY','Flour - So Mix Cake White',48,'Unavailable',3);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (958979,'GROCERY','Garlic',38,'Available',10);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (240655,'GROCERY','Cake Sheet Combo Party Pack',29,'Unavailable',9);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (502890,'GROCERY','Cream - 18%',70,'Available',7);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (991991 , 'ELECTRONICS' , 'LAPTOP',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (991990 , 'ELECTRONICS' , 'PHONE',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (991992 , 'ELECTRONICS' , 'TAB',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (199990 , 'ELECTRONICS' , 'Iphone',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (199991 , 'ELECTRONICS' , 'Monitor',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (199992 , 'ELECTRONICS' , 'Ipad',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (199993 , 'ELECTRONICS' , 'Ipad',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (199994 , 'ELECTRONICS' , 'OfficeJet Printer',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (199995 , 'ELECTRONICS' , 'DeskJet Printer',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (199996 , 'ELECTRONICS' , 'InkJet Printer',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (199997 , 'ELECTRONICS' , 'Toner',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (199998 , 'ELECTRONICS' , 'RibbonCartridge',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (199999 , 'ELECTRONICS' , 'HDD',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (200000 , 'ELECTRONICS' , 'SDD',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (200001 , 'ELECTRONICS' , 'AllinOne',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (200002 , 'ELECTRONICS' , 'ApplePencil',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (200003 , 'ELECTRONICS' , 'Adapter',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100101 , 'CLOTHING' , 'TSHIRT',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100102 , 'CLOTHING' , 'JACKETS',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100104 , 'CLOTHING' , 'JEANS',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100105 , 'CLOTHING' , 'HOODIES',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100106 , 'CLOTHING' , 'SHOES',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100107 , 'CLOTHING' , 'SWEATSHIRT',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100108 , 'CLOTHING' , 'TROUSERS',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100109 , 'CLOTHING' , 'SHORTS',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100110 , 'CLOTHING' , 'BLAZERS',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100111 , 'CLOTHING' , 'WATCHES',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100112 , 'CLOTHING' , 'OVERCOAT',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100113 , 'CLOTHING' , 'SUIT',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100114 , 'CLOTHING' , 'CROCS',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100115 , 'SPORTS' , 'BASKETBALL',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100116 , 'SPORTS' , 'FOOTBALL',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100117 , 'SPORTS' , 'BASEBALL',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100118 , 'SPORTS' , 'CRICKETBALL',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100119 , 'SPORTS' , 'TENNISBALL',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100120 , 'SPORTS' , 'TTBAT',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100121 , 'SPORTS' , 'NIKESHOES',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100122 , 'SPORTS' , 'ADIDASSHOES',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100123 , 'SPORTS' , 'PUMASHOES',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100124 , 'SPORTS' , 'NIKECAPS',10,'Available',5);
INSERT INTO ProductList(ProductID,Type,PName,Quantity,Status,Size) VALUES (100125 , 'SPORTS' , 'ADIDASCAPS',10,'Available',5);

-- --ORDERS IS A PAIN FFS 

INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (116,101,317519,89,5083,10,'Completed','2021-12-12','2022-12-12');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (117,102,125311,59,9793,29,'Completed','2022-2-10','2022-3-23');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (118,103,125311,68,8502,5,'Completed','2021-6-11','2022-3-25');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (116,104,161239,10,3873,63,'Completed','2021-10-30','2022-3-15');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (117,105,317519,49,7554,3,'Active','2021-6-25','2022-3-28');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (119,106,184880,29,6980,90,'Completed','2021-11-22','2022-3-26');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (121,107,186186,3,6830,96,'Completed','2021-7-30','2022-3-13');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (121,108,317519,83,5836,44,'Active','2022-2-13','2022-3-16');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (112,109,216973,6,8288,56,'Completed','2022-1-4','2022-3-26');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (119,110,161239,2,9176,99,'Active','2021-3-8','2022-3-29');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (116,111,240655,17,3953,13,'Completed','2021-8-6','2022-3-16');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (79,112,186186,41,5221,92,'Active','2022-1-19','2022-3-23');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (117,113,216973,32,2745,89,'Active','2021-2-5','2022-3-14');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (118,114,216973,73,2047,48,'Active','2022-2-6','2022-3-13');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (119,115,254721,36,5594,7,'Completed','2022-2-20','2022-3-12');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (119,116,317519,34,7944,11,'Active','2021-12-9','2022-3-16');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (120,117,317519,60,9275,1,'Active','2021-10-25','2022-3-19');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (121,118,240655,26,9663,96,'Completed','2021-11-4','2022-3-21');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (119,119,161239,8,8379,53,'Active','2021-10-5','2022-3-30');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (118,120,317519,65,7041,71,'Active','2021-7-21','2022-3-18');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (117,121,240655,55,9372,58,'Completed','2021-9-6','2022-3-17');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (118,122,184880,21,6123,42,'Completed','2021-9-7','2022-3-11');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (119,123,317519,42,7940,31,'Active','2022-1-29','2022-3-19');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (116,124,216973,49,4382,60,'Active','2021-5-17','2022-3-29');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (116,125,216973,12,4811,3,'Active','2022-2-26','2022-3-14');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (132,126,125311,87,2073,66,'Completed','2021-9-15','2022-3-11');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (132,127,186186,30,4502,74,'Active','2021-5-29','2022-3-23');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (132,128,240655,11,4221,22,'Completed','2021-9-30','2022-3-23');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (132,129,317519,1,8248,75,'Active','2021-10-14','2022-3-22');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (122,130,184880,12,2126,11,'Active','2022-1-27','2022-3-23');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (122,131,240655,80,4678,98,'Active','2021-6-23','2022-3-12');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (122,132,161239,17,7461,64,'Completed','2021-11-8','2022-3-24');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (120,133,240655,92,8911,63,'Completed','2022-2-24','2022-3-21');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (119,134,254721,1,2126,7,'Completed','2021-11-2','2022-3-16');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (122,135,186186,49,2420,19,'Active','2021-5-16','2022-3-19');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (122,136,186186,2,2869,77,'Active','2022-3-2','2022-3-16');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (110,137,317519,96,3350,29,'Active','2021-1-7','2022-3-24');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (132,138,254721,79,4077,70,'Completed','2021-5-22','2022-3-19');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (116,139,254721,15,8630,37,'Active','2021-7-23','2022-3-16');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (116,140,267579,36,8722,41,'Completed','2022-2-19','2022-3-26');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (117,141,267579,5,4782,63,'Completed','2021-12-6','2022-3-17');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (117,142,267579,47,4651,6,'Completed','2021-7-21','2022-3-22');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (119,143,184880,29,8521,78,'Completed','2021-9-7','2022-3-12');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (120,144,125311,84,6516,84,'Active','2021-4-13','2022-3-14');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (116,145,317519,62,5778,38,'Active','2021-8-13','2022-3-21');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (132,146,184880,41,5103,97,'Completed','2021-10-30','2022-3-15');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (122,147,317519,70,3738,51,'Completed','2021-4-30','2022-3-16');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (123,148,296694,3,2006,12,'Active','2021-12-8','2022-3-12');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (132,149,296694,68,6549,5,'Completed','2022-2-17','2022-3-26');
INSERT INTO Orders(CustomerID,OrderID,ProductID,VendorID,Amount,Quantity,Status,OrderDate,ExpectedDeliveryDate) VALUES (119,150,296694,87,5191,81,'Completed','2021-5-25','2022-3-16');


-- -- Transaction Data 
-- -- TRANSACTION IS A PAIN 
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (116,100,101,2631,89,5083,46,'NetBanking',1000,'2022-05-20','InProgress');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (117,101,102,4249,59,9793,85,'Card',1001,'2022-05-21','InProgress');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (118,102,103,1995,68,8502,19,'Card',1002,'2022-09-27','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (116,103,104,7191,10,3873,16,'NetBanking',1003,'2022-08-23','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (117,104,105,9124,49,7554,7,'NetBanking',1004,'2022-03-09','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (119,105,106,4858,29,6980,29,'NetBanking',1005,'2022-04-15','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (121,106,107,4098,3,6830,61,'NetBanking',1006,'2022-03-09','InProgress');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (121,107,108,3782,83,5836,17,'Card',1007,'2022-09-26','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (112,108,109,9909,6,8288,44,'NetBanking',1008,'2022-03-05','InProgress');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (119,109,110,2271,2,9176,22,'NetBanking',1009,'2022-09-01','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (116,110,111,7031,17,3953,84,'Card',1010,'2022-06-07','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (79,111,112,5562,41,5221,3,'others',1011,'2022-07-25','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (117,112,113,5070,32,2745,2,'COD',1012,'2022-04-07','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (118,113,114,3550,73,2047,2,'NetBanking',1013,'2022-06-08','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (119,114,115,1913,36,5594,94,'Card',1014,'2022-04-09','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (119,115,116,3176,34,7944,68,'others',1015,'2022-08-12','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (120,116,117,1282,60,9275,82,'NetBanking',1016,'2022-05-05','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (121,117,118,9449,26,9663,17,'others',1017,'2022-05-06','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (119,118,119,2491,8,8379,11,'Card',1018,'2022-06-27','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (118,119,120,2407,65,7041,41,'others',1019,'2022-09-09','InProgress');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (117,120,121,4749,55,9372,75,'COD',1020,'2022-08-01','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (118,121,122,3377,21,6123,74,'others',1021,'2022-06-25','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (119,122,123,4573,42,7940,2,'COD',1022,'2022-09-28','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (116,123,124,3856,49,4382,23,'COD',1023,'2022-11-11','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (116,124,125,5269,12,4811,34,'NetBanking',1024,'2022-08-10','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (132,125,126,3489,87,2073,21,'NetBanking',1025,'2022-11-01','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (132,126,127,7300,30,4502,11,'Card',1026,'2022-04-08','InProgress');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (132,127,128,4754,11,4221,93,'others',1027,'2022-08-15','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (132,128,129,1287,1,8248,88,'others',1028,'2022-10-30','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (122,129,130,6177,12,2126,11,'NetBanking',1029,'2022-07-15','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (122,130,131,6553,80,4678,35,'COD',1030,'2022-04-03','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (122,131,132,6639,17,7461,91,'others',1031,'2022-05-28','InProgress');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (122,132,133,8362,92,8911,28,'Card',1032,'2022-03-13','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (120,133,134,1372,1,2126,49,'NetBanking',1033,'2022-10-07','InProgress');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (119,134,135,6175,49,2420,64,'others',1034,'2022-10-27','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (122,135,136,2151,2,2869,88,'others',1035,'2022-06-08','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (122,136,137,4781,96,3350,93,'Card',1036,'2022-08-31','InProgress');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (110,137,138,6264,79,4077,60,'NetBanking',1037,'2022-03-10','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (132,138,139,2051,15,8630,27,'COD',1038,'2022-03-10','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (116,139,140,2919,36,8722,35,'COD',1039,'2022-10-29','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (116,140,141,6337,5,4782,90,'Card',1040,'2022-04-01','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (117,141,142,1793,47,4651,41,'Card',1041,'2022-10-23','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (117,142,143,3657,29,8521,53,'Card',1042,'2022-05-28','InProgress');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (119,143,144,2552,84,6516,88,'Card',1043,'2022-10-21','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (120,144,145,6732,62,5778,19,'others',1044,'2022-11-05','InProgress');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (116,145,146,5609,41,5103,53,'NetBanking',1045,'2022-09-26','InProgress');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (132,146,147,3036,70,3738,39,'NetBanking',1046,'2022-06-16','InProgress');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (122,147,148,7295,3,2006,98,'NetBanking',1047,'2022-05-16','Pending');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (123,148,149,1093,68,6549,50,'COD',1048,'2022-10-03','Done');
INSERT INTO Transaction(CustomerID,TransactionID,OrderID,ProductID,VendorID,Amount,Discount,ModeOfPayment,TransactionRefID,TransactionDate,PaymentStatus) VALUES (132,149,150,5422,87,5191,11,'COD',1049,'2022-06-21','Done');

-- Cart Data
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (100,76,74,5083,46);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (101,42,20,9793,85);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (102,1,14,8502,19);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (103,76,47,3873,16);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (104,4,100,7554,7);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (105,3,2,6980,29);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (106,82,28,6830,61);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (107,77,96,5836,17);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (108,46,58,8288,44);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (109,90,59,9176,22);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (110,18,4,3953,84);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (111,79,78,5221,3);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (112,76,85,2745,2);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (113,10,40,2047,2);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (114,19,95,5594,94);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (115,10,100,7944,68);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (116,27,27,9275,82);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (117,80,31,9663,17);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (118,82,50,8379,11);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (119,54,97,7041,41);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (120,88,30,9372,75);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (121,15,89,6123,74);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (122,22,13,7940,2);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (123,7,68,4382,23);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (124,34,39,4811,34);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (125,33,46,2073,21);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (126,21,40,4502,11);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (127,62,89,4221,93);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (128,43,88,8248,88);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (129,68,83,2126,11);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (130,75,6,4678,35);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (131,44,38,7461,91);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (132,44,85,8911,28);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (133,60,90,2126,49);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (134,52,71,2420,64);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (135,57,79,2869,88);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (136,41,41,3350,93);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (137,93,42,4077,60);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (138,85,8,8630,27);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (139,77,10,8722,35);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (140,88,73,4782,90);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (141,11,34,4651,41);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (142,39,21,8521,53);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (143,76,65,6516,88);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (144,8,44,5778,19);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (145,20,88,5103,53);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (146,2,48,3738,39);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (147,28,38,2006,98);
INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (148,33,29,6549,50);
-- INSERT INTO Cart(CartID,CustomerID,Totalitems,Amount,Discount) VALUES (149,25,70,5191,11);

-- CartContentData
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (100,317519,310,46);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (101,523448,441,85);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (102,940676,211,19);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (103,184880,509,16);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (104,994090,124,7);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (105,161239,680,29);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (106,895985,419,61);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (107,560543,869,17);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (108,393134,257,44);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (109,692932,635,22);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (110,339973,585,84);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (111,883920,549,3);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (112,382562,888,2);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (113,698739,433,2);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (114,411521,520,94);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (115,216973,688,68);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (116,757779,497,82);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (117,535913,679,17);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (118,445495,366,11);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (119,625634,631,41);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (120,267579,511,75);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (121,466599,849,74);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (122,977217,961,2);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (123,939169,251,23);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (124,828045,709,34);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (125,759437,731,21);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (126,965252,274,11);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (127,405447,298,93);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (128,753506,888,88);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (129,186186,203,11);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (130,947840,885,35);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (131,971583,648,91);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (132,667498,292,28);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (133,598496,353,49);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (134,357308,368,64);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (135,703428,756,88);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (136,538557,392,93);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (137,254721,153,60);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (138,804226,988,27);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (139,673990,604,35);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (140,133425,92,90);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (141,345938,329,41);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (142,125311,460,53);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (143,606207,452,88);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (144,296694,400,19);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (145,840897,541,53);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (146,739081,537,39);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (147,958979,45,98);
INSERT INTO CartContent(CartID,ProductID,Price,Discount) VALUES (148,240655,418,50);


-- CustomerMode of payment method
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (5658266,76,'NetBanking',138446111948,11,2021);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (6267820,42,'Card',264054416660,8,2024);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (8021698,1,'Card',682430447530,7,2021);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (8343556,76,'NetBanking',886580304070,8,2023);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (3637496,4,'NetBanking',505020414380,6,2023);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (3101909,3,'NetBanking',491280712353,12,2028);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (9077308,82,'NetBanking',432431755360,8,2028);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (3108924,77,'Card',658170381334,5,2021);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (9897941,46,'NetBanking',608214357735,7,2025);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (4981073,90,'NetBanking',774783992786,12,2027);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (6010895,18,'Card',110204873672,10,2021);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (4303048,79,'others',370004645744,8,2028);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (9628447,76,'COD',477950429755,4,2025);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (7481649,10,'NetBanking',184020430336,7,2027);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (4478458,19,'Card',162644344047,10,2024);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (5624897,10,'others',599823542653,3,2027);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (6411356,27,'NetBanking',368197304768,11,2022);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (1680655,80,'others',577349474086,9,2023);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (8339143,82,'Card',719441848049,8,2028);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (9527720,54,'others',549929523862,4,2022);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (6761144,88,'COD',209200893665,8,2028);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (9832137,15,'others',917749450402,1,2023);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (9909860,22,'COD',484080807106,11,2024);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (6141697,7,'COD',172919254715,5,2025);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (8036196,116,'NetBanking',231141078352,4,2024);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (3308308,117,'NetBanking',144313316536,6,2022);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (2020620,118,'Card',432646505060,10,2026);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (5006613,119,'others',742235401173,12,2028);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (7160527,120,'others',327177539020,10,2027);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (8751343,121,'NetBanking',621368725532,9,2027);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (7048734,122,'COD',672157618845,1,2023);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (5916479,123,'others',651191764346,6,2023);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (4606396,124,'Card',967816214256,5,2025);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (2089098,125,'NetBanking',964517142037,3,2021);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (3781724,126,'others',960920335385,1,2027);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (9679465,127,'others',686373923430,4,2025);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (4673416,128,'Card',450817756473,6,2025);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (6957217,129,'NetBanking',856180377258,5,2025);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (3445804,130,'COD',686441097826,4,2026);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (3592282,131,'COD',433722437717,5,2022);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (7884391,132,'Card',265637942886,7,2022);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (1264928,133,'Card',865326975746,5,2027);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (9554725,134,'Card',891903194752,11,2025);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (2424405,115,'Card',760548759326,11,2023);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (6475341,114,'others',299863286685,5,2023);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (7129638,113,'NetBanking',641804283802,2,2026);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (5020434,112,'NetBanking',737394601850,10,2023);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (5335390,99,'NetBanking',397601300280,11,2022);
INSERT INTO CustomerPaymentMethod(FinID,CustomerID,ModeOfPayment,CardNo,ExpiryDateMonth,ExpiryDateYear) VALUES (3754890,110,'COD',933712820722,11,2022);


-- Product Inventory
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (907044,317519,89,'Available',310,46);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (639331,523448,59,'Available',441,85);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (473735,940676,68,'Available',211,19);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (194760,184880,10,'Available',509,16);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (325854,994090,49,'Unavailable',124,7);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (875734,161239,29,'Available',680,29);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (559564,895985,3,'Unavailable',419,61);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (152780,560543,83,'Available',869,17);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (696780,393134,6,'Unavailable',257,44);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (666228,692932,2,'Unavailable',635,22);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (846255,339973,17,'Unavailable',585,84);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (540156,883920,41,'Available',549,3);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (957997,382562,32,'Available',888,2);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (323652,698739,73,'Unavailable',433,2);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (604154,411521,36,'Unavailable',520,94);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (903103,216973,34,'Available',688,68);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (805912,757779,60,'Available',497,82);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (522223,535913,26,'Unavailable',679,17);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (895840,445495,8,'Unavailable',366,11);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (678202,625634,65,'Available',631,41);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (377759,267579,55,'Unavailable',511,75);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (693509,466599,21,'Unavailable',849,74);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (728660,977217,42,'Unavailable',961,2);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (609922,939169,49,'Available',251,23);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (870266,828045,12,'Unavailable',709,34);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (941551,759437,87,'Available',731,21);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (229475,965252,30,'Available',274,11);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (414105,405447,11,'Unavailable',298,93);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (672038,753506,1,'Unavailable',888,88);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (670723,186186,12,'Available',203,11);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (753284,947840,80,'Available',885,35);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (422570,971583,17,'Unavailable',648,91);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (407464,667498,92,'Available',292,28);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (586269,598496,1,'Unavailable',353,49);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (390178,357308,49,'Available',368,64);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (142063,703428,2,'Unavailable',756,88);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (507615,538557,96,'Available',392,93);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (664062,254721,79,'Available',153,60);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (725545,804226,15,'Available',988,27);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (507327,673990,36,'Available',604,35);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (147755,133425,5,'Available',92,90);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (299591,345938,47,'Unavailable',329,41);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (462539,125311,29,'Unavailable',460,53);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (599381,606207,84,'Unavailable',452,88);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (321401,296694,62,'Unavailable',400,19);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (381605,840897,41,'Unavailable',541,53);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (326331,739081,70,'Unavailable',537,39);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (571875,958979,3,'Available',45,98);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (588393,240655,68,'Unavailable',418,50);
-- INSERT INTO ProductInventory(SerialNo,ProductID,VendorID,Status,Price,Discount) VALUES (681877,502890,87,'Available',12,11);


-- Vendor Inventory
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (89,317519,310,46,'2022-3-8','2022-3-21',74,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (59,317519,441,85,'2022-3-11','2022-3-18',20,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (68,940676,211,19,'2022-3-14','2022-6-3',14,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (10,184880,509,16,'2022-3-28','2022-7-3',47,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (49,940676,124,7,'2022-3-19','2022-5-13',100,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (29,161239,680,29,'2022-3-7','2022-3-23',2,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (3,184880,419,61,'2022-3-4','2022-3-20',28,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (83,184880,869,17,'2022-3-22','2022-3-26',96,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (6,184880,257,44,'2022-3-2','2022-3-3',58,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (2,184880,635,22,'2022-3-22','2022-4-3',59,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (17,339973,585,84,'2022-3-22','2022-4-12',4,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (41,883920,549,3,'2022-3-27','2022-3-28',78,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (32,382562,888,2,'2022-3-16','2022-3-18',85,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (73,698739,433,2,'2022-3-18','2022-3-25',40,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (36,382562,520,94,'2022-3-15','2022-3-16',95,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (34,382562,688,68,'2022-3-30','2022-3-31',100,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (60,757779,497,82,'2022-3-26','2022-4-3',27,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (26,698739,679,17,'2022-3-7','2022-3-20',31,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (8,445495,366,11,'2022-3-12','2022-3-13',50,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (65,625634,631,41,'2022-3-14','2022-3-16',97,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (55,267579,511,75,'2022-3-2','2022-4-3',30,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (21,466599,849,74,'2022-2-3','2022-3-6',89,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (42,977217,961,2,'2022-3-25','2022-3-26',13,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (49,939169,251,23,'2022-3-12','2022-3-16',68,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (12,828045,709,34,'2022-3-12','2022-3-16',39,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (87,759437,731,21,'2022-3-13','2022-3-5',46,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (30,965252,274,11,'2022-3-19','2022-3-23',40,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (11,405447,298,93,'2022-3-4','2022-3-7',89,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (1,753506,888,88,'2022-3-12','2022-3-14',88,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (12,186186,203,11,'2022-3-9','2022-3-11',83,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (80,947840,885,35,'2022-3-12','2022-3-15',6,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (17,971583,648,91,'2022-3-12','2022-3-17',38,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (92,667498,292,28,'2022-3-4','2022-3-25',85,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (1,598496,353,49,'2022-3-18','2022-3-22',90,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (49,357308,368,64,'2022-3-2','2022-3-16',71,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (2,703428,756,88,'2022-3-20','2022-3-25',79,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (96,538557,392,93,'2022-3-8','2022-3-13',41,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (79,254721,153,60,'2022-3-10','2022-3-12',42,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (15,804226,988,27,'2022-3-16','2022-3-18',8,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (36,673990,604,35,'2022-3-5','2022-3-8',10,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (5,133425,92,90,'2022-3-6','2022-3-7',73,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (47,345938,329,41,'2022-3-2','2022-3-15',34,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (29,125311,460,53,'2022-3-16','2022-3-20',21,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (84,606207,452,88,'2022-3-5','2022-4-3',65,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (62,296694,400,19,'2022-3-12','2022-3-30',44,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (41,840897,541,53,'2022-3-6','2022-3-19',88,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (70,739081,537,39,'2022-3-9','2022-3-12',48,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (3,958979,45,98,'2022-3-28','2022-3-31',38,'Available');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (68,240655,418,50,'2022-3-16','2022-3-27',29,'Unavailable');
INSERT INTO ProductInventory(VendorID,ProductID,Price,Discount,PriceStartDate,OfferStartDate,Quantity,Status) VALUES (87,502890,12,11,'2022-3-27','2022-3-29',70,'Available');



-- Warehouses
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (52,'Prosacco-Rippin');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (75,'Bartoletti, White and Lindgren');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (48,'Reichert-Schaden');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (13,'Stracke-Kessler');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (43,'Dicki, Nienow and Hintz');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (41,'Zemlak, Marks and Keeling');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (44,'Orn-McCullough');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (81,'Gottlieb, Jerde and Swift');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (96,'Kling Inc');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (8,'Medhurst-Wilderman');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (99,'Schumm and Sons');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (101,'Schmeler and Sons');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (56,'Reilly, Corwin and Weber');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (26,'Raynor, Effertz and Emard');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (102,'Herzog-Kautzer');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (71,'Schinner, Jerde and Quitzon');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (93,'Kassulke-Skiles');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (103,'Bednar LLC');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (104,'Satterfield, Green and Harris');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (2,'Spencer Group');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (58,'Green-Ledner');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (77,'Bins-Treutel');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (105,'Heaney and Sons');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (49,'Little, McGlynn and Ward');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (91,'Weissnat and Sons');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (79,'Olson, Jast and Witting');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (86,'Wiegand Inc');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (51,'Dietrich, Reynolds and Glover');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (59,'Bosco Inc');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (61,'Conroy-McClure');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (106,'Considine-Wilkinson');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (63,'Schroeder, Klocko and Gislason');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (5,'Trantow, Swift and Sanford');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (62,'Klocko and Sons');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (27,'Lindgren-Hilpert');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (87,'Hoeger-Kreiger');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (7,'King, Sporer and Cummings');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (107,'Donnelly, Wiza and Gutmann');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (17,'Doyle Group');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (46,'Reynolds and Sons');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (108,'Boyer-Ziemann');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (80,'Stiedemann, Mayer and Halvorson');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (35,'VonRueden Group');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (92,'Okuneva-Johns');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (94,'Heathcote Group');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (85,'Kuhic, Corwin and Huels');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (109,'Barton, Thiel and White');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (20,'Yost-Heaney');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (110,'Skiles LLC');
INSERT INTO Warehouses(WarehousesID,WarehouseName) VALUES (111,'Cummerata LLC');

-- Owned by 
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (52,89);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (75,89);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (48,89);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (13,89);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (43,89);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (41,89);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (44,119);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (81,119);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (96,119);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (8,119);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (13,119);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (48,119);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (56,120);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (26,121);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (48,121);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (71,121);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (93,120);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (93,120);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (93,120);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (2,118);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (58,118);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (77,118);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (86,118);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (49,118);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (91,12);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (79,87);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (86,30);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (51,11);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (59,1);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (61,12);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (86,80);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (63,17);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (5,92);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (62,1);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (27,49);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (87,2);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (7,96);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (77,79);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (17,15);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (46,36);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (75,5);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (80,47);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (35,29);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (92,84);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (94,62);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (85,41);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (49,70);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (20,3);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (86,68);
INSERT INTO OwnedBy(WarehousesID,VendorID) VALUES (79,87);


-- Warehouse inventory
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (89,317519,74,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (59,523448,20,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (68,940676,14,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (10,184880,47,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (49,994090,100,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (29,161239,2,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (3,895985,28,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (83,560543,96,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (6,393134,58,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (2,692932,59,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (17,339973,4,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (41,883920,78,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (32,382562,85,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (73,698739,40,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (36,411521,95,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (34,216973,100,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (60,757779,27,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (26,535913,31,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (8,445495,50,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (65,625634,97,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (55,267579,30,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (21,466599,89,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (42,977217,13,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (49,939169,68,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (12,828045,39,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (87,759437,46,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (30,965252,40,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (11,405447,89,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (1,753506,88,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (12,186186,83,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (80,947840,6,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (17,971583,38,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (92,667498,85,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (1,598496,90,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (49,357308,71,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (2,703428,79,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (96,538557,41,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (79,254721,42,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (15,804226,8,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (36,673990,10,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (5,133425,73,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (47,345938,34,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (29,125311,21,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (84,606207,65,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (62,296694,44,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (41,840897,88,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (70,739081,48,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (3,958979,38,'Available');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (68,240655,29,'Unavailable');
INSERT INTO WarehousesInventory(VendorID,ProductID,Quantity,Status) VALUES (87,502890,70,'Available');


-- Price History
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (89,317519,'2022-3-8','2022-11-7',310);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (59,523448,'2022-3-11','2022-7-20',441);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (68,940676,'2022-3-14','2022-7-16',211);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (10,184880,'2022-3-28','2022-7-22',509);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (49,994090,'2022-3-19','2022-7-16',124);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (29,161239,'2022-3-7','2022-7-16',680);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (3,895985,'2022-3-24','2022-7-11',419);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (83,560543,'2022-3-22','2022-7-19',869);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (6,393134,'2022-3-2','2022-7-4',257);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (2,692932,'2022-3-22','2022-7-6',635);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (17,339973,'2022-3-22','2022-7-22',585);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (41,883920,'2022-3-27','2022-7-5',549);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (32,382562,'2022-3-16','2022-7-18',888);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (73,698739,'2022-3-18','2022-7-3',520);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (34,216973,'2022-3-30','2022-7-15',688);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (60,757779,'2022-3-26','2022-7-14',497);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (26,535913,'2022-3-7','2022-7-6',679);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (8,445495,'2022-3-12','2022-7-22',366);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (65,625634,'2022-3-14','2022-7-17',631);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (55,267579,'2022-3-29','2022-7-12',511);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (21,466599,'2022-3-20','2022-7-9',849);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (42,977217,'2022-3-25','2022-7-18',961);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (49,939169,'2022-3-30','2022-7-22',251);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (12,828045,'2022-3-12','2022-7-14',709);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (87,759437,'2022-3-12','2022-7-3',731);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (30,965252,'2022-3-19','2022-7-1',274);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (11,405447,'2022-3-13','2022-7-18',298);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (1,753506,'2022-3-21','2022-7-17',888);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (12,186186,'2022-3-27','2022-7-14',203);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (80,947840,'2022-3-13','2022-7-2',885);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (17,971583,'2022-3-24','2022-7-19',648);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (92,667498,'2022-3-4','2022-7-10',292);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (1,598496,'2022-3-18','2022-7-14',353);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (49,357308,'2022-3-2','2022-7-22',368);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (2,703428,'2022-3-20','2022-7-7',756);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (96,538557,'2022-3-8','2022-7-15',392);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (79,254721,'2022-3-22','2022-7-1',153);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (15,804226,'2022-3-16','2022-7-9',988);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (36,673990,'2022-3-17','2022-7-19',604);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (5,133425,'2022-3-6','2022-7-19',92);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (47,345938,'2022-3-2','2022-7-21',329);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (29,125311,'2022-3-16','2022-7-11',460);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (84,606207,'2022-3-5','2022-7-15',452);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (62,296694,'2022-3-6','2022-7-16',400);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (41,840897,'2022-3-6','2022-7-7',541);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (70,739081,'2022-3-15','2022-7-17',537);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (3,958979,'2022-3-28','2022-7-5',45);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (68,240655,'2022-3-16','2022-7-3',418);
INSERT INTO PriceHistory(VendorID,ProductID,PriceStartDate,PriceEndDate,Price) VALUES (87,502890,'2022-3-27','2022-7-13',12);

-- Offer History
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (89,317519,'2022-3-24','2022-11-7',46);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (59,523448,'2022-3-18','2022-7-2',85);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (68,940676,'2022-3-6','2022-7-19',19);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (10,184880,'2022-3-14','2022-7-1',16);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (49,994090,'2022-3-18','2022-7-7',7);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (29,161239,'2022-3-23','2022-7-15',29);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (3,895985,'2022-3-20','2022-7-4',61);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (83,560543,'2022-3-24','2022-7-5',17);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (6,393134,'2022-3-3','2022-7-2',44);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (2,692932,'2022-3-3','2022-7-13',22);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (17,339973,'2022-3-12','2022-7-13',84);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (41,883920,'2022-3-25','2022-7-1',3);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (32,382562,'2022-3-10','2022-7-18',2);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (73,698739,'2022-3-25','2022-7-9',2);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (36,411521,'2022-3-16','2022-7-21',94);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (34,216973,'2022-3-20','2022-7-10',68);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (60,757779,'2022-3-4','2022-7-10',82);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (26,535913,'2022-3-20','2022-8-7',17);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (8,445495,'2022-3-11','2022-7-1',11);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (65,625634,'2022-3-16','2022-7-1',41);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (55,267579,'2022-3-15','2022-7-1',75);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (21,466599,'2022-3-6','2022-7-9',74);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (42,977217,'2022-3-26','2022-7-2',2);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (49,939169,'2022-3-16','2022-7-20',23);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (12,828045,'2022-3-4','2022-7-17',34);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (87,759437,'2022-3-5','2022-7-8',21);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (30,965252,'2022-3-23','2022-7-7',11);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (11,405447,'2022-3-7','2022-7-11',93);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (1,753506,'2022-3-12','2022-7-1',88);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (12,186186,'2022-3-11','2022-7-5',11);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (80,947840,'2022-3-5','2022-7-13',35);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (17,971583,'2022-3-17','2022-7-7',91);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (92,667498,'2022-3-25','2022-7-14',28);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (1,598496,'2022-3-22','2022-7-10',49);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (49,357308,'2022-3-16','2022-7-1',64);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (2,703428,'2022-3-5','2022-7-20',88);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (96,538557,'2022-3-13','2022-7-12',93);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (79,254721,'2022-3-12','2022-7-18',60);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (15,804226,'2022-3-11','2022-7-19',27);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (36,673990,'2022-3-8','2022-7-8',35);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (5,133425,'2022-3-7','2022-7-22',90);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (47,345938,'2022-3-15','2022-7-15',41);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (29,125311,'2022-3-20','2022-7-8',53);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (84,606207,'2022-3-4','2022-7-10',88);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (62,296694,'2022-3-30','2022-7-10',19);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (41,840897,'2022-3-19','2022-7-9',53);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (70,739081,'2022-3-12','2022-7-21',39);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (3,958979,'2022-3-11','2022-7-18',98);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (68,240655,'2022-3-27','2022-7-4',50);
INSERT INTO OfferHistory(VendorID,ProductID,OfferStartDate,OfferEndDate,Discount) VALUES (87,502890,'2022-3-23','2022-7-15',11);

-- Employee Data
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (1,'Stanfield','112-395-2807','smontilla0@eventbrite.com',6921,'Structural & Misc Steel Erection');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (2,'Oran','536-975-7010','obarkes1@illinois.edu',6138,'Wall Protection');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (3,'Norby','941-493-8057','noloinn2@plala.or.jp',8884,'Marlite Panels (FED)');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (4,'Rancell','740-402-7316','rtatlock3@cnn.com',8702,'Fire Protection');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (5,'Gradey','475-230-2477','gdobbin4@gmpg.org',9239,'Drywall & Acoustical (MOB)');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (6,'Regan','527-680-2968','rgrestye5@yellowbook.com',9100,'Marlite Panels (FED)');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (7,'Clayson','735-672-5403','cvere6@hostgator.com',5247,'Termite Control');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (8,'Prinz','403-387-1771','ptuvey7@opensource.org',6197,'Termite Control');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (9,'Merwyn','578-897-9482','mrotherforth8@arizona.edu',5589,'HVAC');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (10,'Tanny','238-468-6921','ttrewhitt9@toplist.cz',6310,'Fire Sprinkler System');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (11,'Tirrell','287-297-4193','trummerya@ted.com',5089,'EIFS');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (12,'Homer','748-585-5662','hbyssheb@senate.gov',8864,'Framing (Wood)');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (13,'Tracie','767-138-2758','tpiccardc@xinhuanet.com',7558,'Ornamental Railings');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (14,'Kurt','202-458-4429','ktanswelld@seesaa.net',6382,'Drilled Shafts');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (15,'Giraldo','161-464-6876','gpierse@skyrock.com',9705,'EIFS');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (16,'Bradley','996-146-3321','bpriddisf@unesco.org',9416,'RF Shielding');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (17,'Ives','536-948-9590','itrobridgeg@ucsd.edu',7298,'Waterproofing & Caulking');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (18,'Elwyn','200-121-3167','ejaskiewiczh@sohu.com',8646,'Masonry');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (19,'Efrem','630-192-6702','einderi@chron.com',5360,'Glass & Glazing');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (20,'Husein','145-616-2174','hmucklestonj@cbc.ca',6296,'Curb & Gutter');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (21,'Judah','888-493-2600','jiannellok@narod.ru',5725,'Site Furnishings');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (22,'Kermie','436-925-6699','khakenl@altervista.org',9628,'Wall Protection');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (23,'Purcell','550-974-1907','ppavlovm@google.pl',8826,'Hard Tile & Stone');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (24,'Wilmar','694-218-4418','wapperleyn@abc.net.au',5924,'Framing (Steel)');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (25,'Preston','145-255-3290','ppeerso@xing.com',7723,'HVAC');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (26,'Augie','663-310-6285','afeldbrinp@delicious.com',6237,'Doors, Frames & Hardware');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (27,'Parke','121-643-8576','pebbettsq@blogger.com',7457,'Doors, Frames & Hardware');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (28,'Obie','406-608-1654','oelesanderr@cpanel.net',6016,'Granite Surfaces');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (29,'Hamnet','973-973-2662','hleavolds@bloglines.com',7086,'Ornamental Railings');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (30,'Padget','254-833-8558','pricardont@narod.ru',6429,'Drilled Shafts');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (31,'Demetris','268-565-8438','dbraveyu@skype.com',7619,'Prefabricated Aluminum Metal Canopies');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (32,'Tibold','532-811-6595','tbeggiov@europa.eu',7991,'Rebar & Wire Mesh Install');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (33,'Ellis','179-488-1665','eoverallw@dell.com',6604,'Soft Flooring and Base');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (34,'Stefano','211-230-7746','sperrottetx@cornell.edu',5494,'Retaining Wall and Brick Pavers');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (35,'Eustace','721-586-8973','echestony@php.net',6847,'Elevator');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (36,'Ilaire','255-486-8879','iogilbyz@taobao.com',8044,'Painting & Vinyl Wall Covering');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (37,'Tomlin','245-292-9539','tguyer10@wordpress.com',5863,'Asphalt Paving');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (38,'Jim','851-998-2990','jfilippucci11@1688.com',5454,'Plumbing & Medical Gas');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (39,'Jay','577-263-5988','jmontford12@princeton.edu',8448,'Granite Surfaces');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (40,'Mart','813-656-7348','mwinny13@newyorker.com',5587,'Masonry & Precast');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (41,'Jayme','191-850-9882','jattwill14@topsy.com',8828,'HVAC');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (42,'Wald','991-681-3570','wkissock15@slate.com',8102,'Painting & Vinyl Wall Covering');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (43,'Orren','542-719-8092','otrundle16@zimbio.com',5299,'EIFS');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (44,'Wallache','337-344-5015','wdubber17@4shared.com',6171,'Waterproofing & Caulking');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (45,'Edvard','890-227-1307','eniblo18@cnbc.com',8055,'Drywall & Acoustical (MOB)');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (46,'Edd','294-211-5425','eaherne19@bandcamp.com',6662,'Structural & Misc Steel Erection');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (47,'Durant','246-120-6125','dstonbridge1a@economist.com',8572,'Masonry & Precast');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (48,'Gawen','620-134-7743','gwedderburn1b@scientificamerican.com',9197,'Landscaping & Irrigation');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (49,'Geri','511-420-2444','gsandercock1c@livejournal.com',7123,'Fire Protection');
INSERT INTO Employee(EmployeeID,EName,contact,Email,Salary,Department) VALUES (50,'Paxton','871-628-5614','pcolleran1d@surveymonkey.com',5585,'Framing (Steel)');


-- Works
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (1,'Vendors','Stanfield');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (2,'Vendors','Oran');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (3,'Vendors','Norby');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (4,'ORS','Rancell');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (5,'Vendors','Gradey');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (6,'Vendors','Regan');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (7,'ORS','Clayson');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (8,'Vendors','Prinz');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (9,'ORS','Merwyn');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (10,'ORS','Tanny');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (11,'ORS','Tirrell');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (12,'ORS','Homer');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (13,'Vendors','Tracie');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (14,'ORS','Kurt');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (15,'Vendors','Giraldo');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (16,'ORS','Bradley');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (17,'Vendors','Ives');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (18,'ORS','Elwyn');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (19,'Vendors','Efrem');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (20,'Vendors','Husein');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (21,'Vendors','Judah');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (22,'ORS','Kermie');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (23,'Vendors','Purcell');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (24,'ORS','Wilmar');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (25,'ORS','Preston');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (26,'ORS','Augie');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (27,'Vendors','Parke');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (28,'Vendors','Obie');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (29,'ORS','Hamnet');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (30,'ORS','Padget');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (31,'ORS','Demetris');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (32,'Vendors','Tibold');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (33,'ORS','Ellis');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (34,'ORS','Stefano');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (35,'ORS','Eustace');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (36,'ORS','Ilaire');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (37,'Vendors','Tomlin');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (38,'ORS','Jim');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (39,'ORS','Jay');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (40,'ORS','Mart');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (41,'Vendors','Jayme');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (42,'Vendors','Wald');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (43,'ORS','Orren');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (44,'ORS','Wallache');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (45,'Vendors','Edvard');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (46,'Vendors','Edd');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (47,'Vendors','Durant');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (48,'ORS','Gawen');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (49,'Vendors','Geri');
INSERT INTO Works(EmployeeID,Employer,EName) VALUES (50,'Vendors','Paxton');

-- Customer Address
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (1,76,'78 Stoughton Lane');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (2,42,'647 Nobel Parkway');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (3,1,'95614 Roxbury Point');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (4,76,'1 Eastlawn Avenue');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (5,4,'64395 Bashford Crossing');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (6,3,'7690 Ridgeway Crossing');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (7,82,'0628 Monica Circle');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (8,77,'0 Transport Crossing');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (9,46,'9720 Tony Hill');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (10,90,'74 Mendota Pass');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (11,18,'22688 Maryland Terrace');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (12,79,'2 Homewood Terrace');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (13,76,'2446 Gale Plaza');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (14,10,'89 Comanche Parkway');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (15,19,'1234 Autumn Leaf Plaza');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (16,10,'520 Surrey Center');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (17,27,'999 Bultman Trail');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (18,80,'879 Spohn Terrace');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (19,82,'51 Ohio Circle');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (20,54,'512 Hansons Junction');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (21,88,'9661 Mifflin Plaza');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (22,15,'5286 Dexter Point');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (23,22,'10 Weeping Birch Hill');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (24,7,'4 Fallview Point');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (25,34,'012 Victoria Place');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (26,33,'5489 Dovetail Street');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (27,21,'7448 Vera Center');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (28,62,'952 Arkansas Crossing');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (29,43,'48478 Nobel Park');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (30,68,'3 Menomonie Avenue');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (31,75,'94128 Kings Circle');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (32,44,'35505 Jay Lane');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (33,44,'23473 Amoth Terrace');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (34,60,'0 Donald Junction');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (35,52,'2 Petterle Trail');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (36,57,'10 Rockefeller Junction');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (37,41,'38 Stang Junction');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (38,93,'3 Sloan Plaza');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (39,85,'09 Hoepker Road');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (40,77,'56 3rd Trail');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (41,88,'73 Kennedy Terrace');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (42,11,'875 Kingsford Place');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (43,39,'0260 Loomis Hill');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (44,76,'69 Monterey Parkway');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (45,8,'73303 Sachs Street');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (46,20,'37 Debs Lane');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (47,2,'614 Clove Avenue');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (48,28,'01 American Alley');
INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (49,33,'1974 Victoria Road');
-- INSERT INTO AddressCustomer(AddressID,CustomerID,Address) VALUES (50,25,'821 Pepper Wood Point');



-- Warehouse address
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (1,52,'228 Melody Point');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (2,75,'53175 Stang Park');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (3,48,'31530 Evergreen Parkway');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (4,13,'190 Burning Wood Trail');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (5,43,'89 Roth Parkway');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (6,41,'238 Hintze Plaza');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (7,44,'58647 Leroy Alley');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (8,81,'2158 Lerdahl Pass');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (9,96,'879 Knutson Way');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (10,8,'85 Stang Street');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (11,13,'78 Arapahoe Center');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (12,48,'32 Golf Course Pass');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (13,56,'9 Kenwood Way');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (14,26,'3 Continental Plaza');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (15,48,'4 Pleasure Lane');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (16,71,'59 Thompson Center');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (17,93,'7689 Dennis Park');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (18,93,'3 Fieldstone Place');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (19,93,'68965 Mccormick Terrace');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (20,2,'25944 Prairieview Pass');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (21,58,'2873 Florence Terrace');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (22,77,'707 Green Ridge Avenue');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (23,86,'194 Tennessee Point');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (24,49,'620 Nobel Road');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (25,91,'2 South Street');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (26,79,'49512 Hagan Court');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (27,86,'6 Westend Court');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (28,51,'76 Kingsford Pass');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (29,59,'53 Vera Way');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (30,61,'42 Longview Pass');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (31,86,'3 Manitowish Junction');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (32,63,'832 Beilfuss Park');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (33,5,'23 Hermina Avenue');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (34,62,'59 Summit Hill');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (35,27,'92 Calypso Pass');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (36,87,'81 Beilfuss Circle');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (37,7,'734 Oxford Circle');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (38,77,'22 Continental Parkway');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (39,17,'7 Sachs Road');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (40,46,'598 Dwight Circle');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (41,75,'0738 Mendota Plaza');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (42,80,'7160 Superior Center');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (43,35,'6494 Continental Road');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (44,92,'29 Swallow Alley');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (45,94,'0030 Westerfield Trail');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (46,85,'6490 Fairfield Plaza');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (47,49,'2 Cottonwood Plaza');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (48,20,'42 Arrowood Terrace');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (49,86,'457 Bellgrove Street');
INSERT INTO AddressWareHouse(WarehouseAddressID,WarehousesID,WAddress) VALUES (50,79,'3 Brown Place');

-- Vendor Address
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (1,89,'7 Hoard Way');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (2,59,'820 Parkside Hill');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (3,68,'2360 Hoard Way');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (4,10,'248 Oxford Trail');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (5,49,'76090 Sunfield Place');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (6,29,'2885 Moose Parkway');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (7,3,'4876 Lakewood Place');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (8,83,'79952 Mifflin Avenue');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (9,6,'0 Cordelia Point');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (10,2,'65247 Knutson Trail');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (11,17,'2619 Anzinger Place');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (12,41,'254 Schurz Court');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (13,32,'51 Fallview Avenue');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (14,73,'1953 Scofield Street');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (15,36,'9 Glendale Pass');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (16,34,'0 Sage Alley');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (17,60,'807 Algoma Place');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (18,26,'9846 Stuart Street');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (19,8,'07769 Sycamore Parkway');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (20,65,'941 Mayfield Avenue');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (21,55,'10 Esch Junction');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (22,21,'619 Carey Trail');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (23,42,'008 North Drive');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (24,49,'6704 Farmco Plaza');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (25,12,'637 Hudson Hill');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (26,87,'490 Straubel Terrace');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (27,30,'97560 Old Gate Parkway');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (28,11,'6726 Huxley Junction');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (29,1,'0 Barby Way');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (30,12,'0 Morrow Terrace');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (31,80,'04 Crescent Oaks Alley');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (32,17,'81 Bluejay Parkway');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (33,92,'2 Pleasure Junction');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (34,1,'30 Rutledge Road');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (35,49,'1 School Plaza');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (36,2,'0 Clemons Court');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (37,96,'8 Clyde Gallagher Place');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (38,79,'81525 High Crossing Road');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (39,15,'559 Hagan Avenue');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (40,36,'0659 East Road');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (41,5,'7204 Sunfield Trail');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (42,47,'25803 Golf Course Trail');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (43,29,'2294 Fair Oaks Park');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (44,84,'6 Pankratz Trail');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (45,62,'07 Manufacturers Drive');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (46,41,'53 Knutson Lane');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (47,70,'0542 Towne Parkway');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (48,3,'53 Hansons Hill');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (49,68,'758 Lake View Trail');
INSERT INTO AddressVendor(VAddressID,VendorID,VAddress) VALUES (50,87,'752 Hovde Point');

