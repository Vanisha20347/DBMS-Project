use ORSFinal1;

-- Indexing on the Orders part
create index customer_orders on orders(customerid);
create index order_value on orders(amount);
create index order_date on orders(orderdate);
create index order_quantity on orders(quantity);
create index order_delivery_date on orders(expecteddeliverydate);
show index from orders;

-- Indexing on transaction 
create index transaction_type on transaction(modeofpayment);
create index payment_status on transaction(paymentstatus);
create index transaction_date on transaction(transactiondate);
create index vendor_transactions on transaction(vendorid);
create index transaction_amount on transaction(amount);
create index transaction_discount on transaction(discount);
show index from transaction;

-- Indexing on cart 
create index cart_amount on cart(amount);
create index cart_discount on cart(discount);
show index from cart;

-- Indexing on CartContent
create index cart_content_amount on cartcontent(price);
create index cart_content_discount on cartcontent(discount);
show index from cartcontent;

-- Indexing on CustomerPaymentMethod
create index payment_method_mode on customerpaymentmethod(modeofpayment);
show index from customerpaymentmethod;

-- Indexing on ProductInventory
create index product_available on productinventory(quantity);
create index product_price on productinventory(price);
create index product_offer on productinventory(discount);
create index product_current_price_start_date on productinventory(pricestartdate);
create index product_current_offer_start_date on productinventory(offerstartdate);
show index from productinventory;

-- Indexing on the Product List
create index product_type on productlist(type);
create index product_status on productlist(status);
show index from productlist;

-- Indexing on the Price History
create index price_start_date on pricehistory(pricestartdate);
create index price_end_date on pricehistory(priceenddate);
create index price_history on pricehistory(price);
show index from pricehistory;

-- Indexing on the Offer History
create index offer_start_date on offerhistory(offerstartdate);
create index offer_end_date on offerhistory(offerenddate);
create index offer_history on offerhistory(discount);
show index from offerhistory;

-- Indexing on the Employee
create index emp_dept on employee(department);
show index from employee;

-- Indexing on the Works 
create index works_for on works(employer);
show index from works;

