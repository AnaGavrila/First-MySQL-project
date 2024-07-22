#Crearea bazei de date pentru OpenCart
CREATE DATABASE IF NOT EXISTS opencart;
USE opencart;

#Tabelul pentru producători (oc_manufacturer)
CREATE TABLE oc_manufacturer (
    manufacturer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    sort_order INT
);

#inserare în tabelul oc_manufacturer folosind DML
INSERT INTO oc_manufacturer (name, sort_order) VALUES ('Apple', 1);
INSERT INTO oc_manufacturer (name, sort_order) VALUES ('Canon', 2);
INSERT INTO oc_manufacturer (name, sort_order) VALUES ('Samsung', 3);
INSERT INTO oc_manufacturer (name, sort_order) VALUES ('LG', 4);
INSERT INTO oc_manufacturer (name, sort_order) VALUES ('Phillips', 5);

#Tabelul pentru produse (oc_product)
CREATE TABLE oc_product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    quantity INT NOT NULL,
    manufacturer_id INT,
    date_added DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    status TINYINT(1) NOT NULL,
    FOREIGN KEY (manufacturer_id) REFERENCES oc_manufacturer(manufacturer_id)
);

#inserare în tabelul oc_product folosind DML
INSERT INTO oc_product (name, price, quantity, manufacturer_id, status) 
VALUES ('IPhone 15', 2099.99, 50, 1, 1);
INSERT INTO oc_product (name, price, quantity, manufacturer_id, status) 
VALUES ('IPad', 149.99, 30, 1, 1);
INSERT INTO oc_product (name, price, quantity, manufacturer_id, status) 
VALUES ('EOS R50', 179.99, 20, 2, 1);
INSERT INTO oc_product (name, price, quantity, manufacturer_id, status) 
VALUES ('Pixma', 299.99, 20, 2, 1);
INSERT INTO oc_product (name, price, quantity, manufacturer_id, status) 
VALUES ('Galaxy S22', 549.99, 20, 3, 1);
INSERT INTO oc_product (name, price, quantity, manufacturer_id, status) 
VALUES ('Tab 3', 549.99, 20, 3, 1);

#Tabelul pentru categorii (oc_category)
CREATE TABLE oc_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    sort_order INT
);

#inserare în tabelul oc_category folosind DML
INSERT INTO oc_category (name, sort_order) VALUES ('Phones and Tablets', 1);
INSERT INTO oc_category (name, sort_order) VALUES ('TV', 2);
INSERT INTO oc_category (name, sort_order) VALUES ('Cameras', 3);

#Tabelul pentru starea comenzilor (oc_order_status)
CREATE TABLE oc_order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(32) NOT NULL
);

#inserare în tabelul oc_order_status folosind DML
INSERT INTO oc_order_status (name) VALUES ('Pending');
INSERT INTO oc_order_status (name) VALUES ('Processing');
INSERT INTO oc_order_status (name) VALUES ('Complete');

#Tabelul pentru grupuri de clienți (oc_customer_group)
CREATE TABLE oc_customer_group (
    customer_group_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) NOT NULL
);

#inserare în tabelul oc_customer_group folosind DML
INSERT INTO oc_customer_group (name) VALUES ('Regular Customers');
INSERT INTO oc_customer_group (name) VALUES ('Wholesale Customers');

#Tabelul pentru clienți (oc_customer)
CREATE TABLE oc_customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(32) NOT NULL,
    lastname VARCHAR(32) NOT NULL,
    email VARCHAR(96) NOT NULL,
    customer_group_id INT,
    FOREIGN KEY (customer_group_id) REFERENCES oc_customer_group(customer_group_id)
);

#inserare în tabelul oc_customer folosind DML
INSERT INTO oc_customer (firstname, lastname, email, customer_group_id) 
VALUES ('John', 'Doe', 'john.doe@example.com', 1),
	   ('Vanessa', 'Joe', 'Vanessa123@example.com', 2),
       ('Barbara', 'Miller', 'BarbaraMil07@example.com', 1),
       ('Catalina', 'Smith', 'CatSmith99@example.com', 2);

#Tabelul pentru comenzi (oc_order)
CREATE TABLE oc_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    store VARCHAR(64),
    customer_id INT,
    order_status_id INT,
    date_added DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES oc_customer(customer_id),
    FOREIGN KEY (order_status_id) REFERENCES oc_order_status(order_status_id)
);

#inserare în tabelul oc_order folosind DML
INSERT INTO oc_order (store, customer_id, order_status_id) 
VALUES ('Your Store', 1, 1),
       ('Your Store', 2, 3),
       ('Your Store', 3, 2),
       ('Your Store', 4, 3);

#interogare simplă (DQL)
#Selectăm toate produsele și afișăm informațiile despre acestea
SELECT * FROM oc_product;
SELECT * FROM oc_manufacturer;
SELECT * FROM oc_category;
SELECT * FROM oc_order_status;
SELECT * FROM oc_customer_group;
SELECT * FROM oc_customer;
SELECT * FROM oc_order;

#interogare cu JOIN (DQL)
#Selectăm toate comenzile împreună cu numele clienților și statusul comenzii
SELECT o.order_id, c.firstname, c.lastname, os.name AS order_status
FROM oc_order o
JOIN oc_customer c ON o.customer_id = c.customer_id
JOIN oc_order_status os ON o.order_status_id = os.order_status_id;
