use ORSFinal;

 create user 'dbamanager'@'localhost' identified by 'dbamanager';
 grant all on orsfinal.* to 'dbamanager'@'localhost';
 
 create user 'customermanager'@'localhost' identified by 'customermanager';
 grant all on orsfinal.customer to 'customermanager'@'localhost';
 grant all on orsfinal.addresscustomer to 'customermanager'@'localhost';
 grant all on orsfinal.customerpaymentmethod to 'customermanager'@'localhost';
  
 create user 'vendormanager'@'localhost' identified by 'vendormanager';
 grant all on orsfinal.vendor to 'vendormanager'@'localhost';
 grant all on orsfinal.addressvendor to 'vendormanager'@'localhost';
 grant all on orsfinal.warehouses to 'vendormanager'@'localhost';
 grant all on orsfinal.productinventory to 'vendormanager'@'localhost';
 grant all on orsfinal.ownedby to 'vendormanager'@'localhost';
 grant all on orsfinal.warehousesinventory to 'vendormanager'@'localhost';
 grant all on orsfinal.addresswarehouses to 'vendormanager'@'localhost';