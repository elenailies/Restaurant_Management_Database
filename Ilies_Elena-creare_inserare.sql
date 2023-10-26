DROP TABLE ITEM_DETAILS;

DROP TABLE ORDER_DETAILS;

DROP TABLE MENU_ITEMS;

DROP TABLE CATEGORIES;

DROP TABLE ORDERS;

DROP TABLE RESERVATIONS;

DROP TABLE TABLES;

DROP TABLE CUSTOMERS;

DROP TABLE SHIFTS;

DROP TABLE EMPLOYEES;

DROP TABLE BRANCHES;

DROP TABLE INGREDIENTS;

DROP TABLE SUPPLIERS;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE BRANCHES (
    Branch_Id INT NOT NULL,
    City VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    PRIMARY KEY (Branch_Id)
);

CREATE TABLE EMPLOYEES (
    Employee_Id INT NOT NULL,
    Branch_Id INT NOT NULL,
    Job_Title VARCHAR(255) NOT NULL,
    First_Name VARCHAR(255) NOT NULL,
    Last_Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Phone VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    PRIMARY KEY (Employee_Id),
    FOREIGN KEY (Branch_Id) REFERENCES Branches(Branch_Id)
);

CREATE TABLE SHIFTS (
Shift_Id INT NOT NULL,
Employee_Id INT NOT NULL,
Start_Time DATE NOT NULL,
End_Time DATE NOT NULL,
PRIMARY KEY (Shift_Id),
FOREIGN KEY (Employee_Id) REFERENCES Employees(Employee_Id)
);

CREATE TABLE CUSTOMERS (
    Customer_Id INT NOT NULL,
    First_Name VARCHAR(255) NOT NULL,
    Last_Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Phone VARCHAR(255) NOT NULL,
    PRIMARY KEY (Customer_Id)
);

CREATE TABLE TABLES (
Table_Id INT NOT NULL,
Capacity INT NOT NULL,
Location VARCHAR(255),
PRIMARY KEY (Table_Id)
);

CREATE TABLE RESERVATIONS (
    Reservation_Id INT NOT NULL,
    Branch_Id INT NOT NULL,
    Customer_Id INT NOT NULL,
    Table_Id INT NOT NULL,
    Reservation_time DATE NOT NULL,
    PRIMARY KEY (Reservation_Id),
    FOREIGN KEY (Branch_Id) REFERENCES Branches(Branch_Id),
    FOREIGN KEY (Customer_Id) REFERENCES Customers(Customer_Id),
    FOREIGN KEY (Table_Id) REFERENCES Tables(Table_Id)
);

CREATE TABLE ORDERS (
Order_Id INT NOT NULL,
Customer_Id INT NOT NULL,
Order_Date DATE,
Total_Price INT NOT NULL,
PRIMARY KEY (Order_Id),
FOREIGN  KEY (Customer_Id) REFERENCES Customers(Customer_Id)
);

CREATE TABLE CATEGORIES (
Category_Id INT NOT NULL,
Category_Name VARCHAR(255) NOT NULL,
PRIMARY KEY (Category_Id)
);

CREATE TABLE MENU_ITEMS (
Item_Id INT NOT NULL,
Category_Id INT NOT NULL,
Item_Name VARCHAR(255) NOT NULL,
Description VARCHAR(255),
Price INT NOT NULL,
PRIMARY KEY (Item_Id),
FOREIGN KEY (Category_Id) REFERENCES Categories(Category_Id)
);

CREATE TABLE ORDER_DETAILS (
Item_Id INT NOT NULL,
Order_Id INT NOT NULL,
FOREIGN  KEY (Item_Id) REFERENCES Menu_Items(Item_Id),
FOREIGN  KEY (Order_Id) REFERENCES Orders(Order_Id),
PRIMARY  KEY (Item_Id, Order_Id)
);

CREATE TABLE SUPPLIERS (
Supplier_Id INT NOT NULL,
Name VARCHAR(255) NOT NULL,
Phone VARCHAR(255) NOT NULL,
Email VARCHAR(255) NOT NULL,
PRIMARY KEY (Supplier_Id)
);

CREATE TABLE INGREDIENTS (
Ingredient_Id INT NOT NULL,
Supplier_Id INT NOT NULL,
Ingredient_Name VARCHAR(255) NOT NULL,
Price INT NOT NULL,
Date_Received DATE,
PRIMARY KEY (Ingredient_Id),
FOREIGN KEY (Supplier_Id) REFERENCES Suppliers(Supplier_Id)
);

CREATE TABLE ITEM_DETAILS (
Item_Id INT NOT NULL,
Ingredient_Id INT NOT NULL,
Ingredient_Quantity INT,
FOREIGN  KEY (Item_Id) REFERENCES Menu_Items(Item_Id),
FOREIGN  KEY (Ingredient_Id) REFERENCES Ingredients(Ingredient_Id),
PRIMARY  KEY (Item_Id, Ingredient_Id)
);
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

INSERT INTO BRANCHES (Branch_Id, City, Address)
VALUES (1, 'London', '23 Adrian Mountains');
INSERT INTO BRANCHES (Branch_Id, City, Address)
VALUES (2, 'Bucharest', '9903 Plumb Branch');
INSERT INTO BRANCHES (Branch_Id, City, Address)
VALUES (3, 'Iasi', '31 Rue du Centenaire');
INSERT INTO BRANCHES (Branch_Id, City, Address)
VALUES (4, 'Lyndhurst', '24 Riverside Street');

INSERT INTO EMPLOYEES (Employee_Id, Branch_Id, Job_Title, First_Name, Last_Name, Email, Phone, Address)
VALUES (1, 1, 'Manager', 'John', 'Doe', 'john.doe@gmail.com', '1234567890', 'Employee Address 1');
INSERT INTO EMPLOYEES (Employee_Id, Branch_Id, Job_Title, First_Name, Last_Name, Email, Phone, Address)
VALUES (2, 2, 'Assistant', 'Jane', 'Smith', 'jane.smith@gmail.com', '9876543210', 'Employee Address 2');
INSERT INTO EMPLOYEES (Employee_Id, Branch_Id, Job_Title, First_Name, Last_Name, Email, Phone, Address)
VALUES (3, 1, 'Clerk', 'Mark', 'Johnson', 'mark.johnson@gmail.com', '5555555555', 'Employee Address 3');
INSERT INTO EMPLOYEES (Employee_Id, Branch_Id, Job_Title, First_Name, Last_Name, Email, Phone, Address)
VALUES (4, 3, 'Supervisor', 'Emily', 'Brown', 'emily.brown@gmail.com', '9999999999', 'Employee Address 4');

INSERT INTO SHIFTS (Shift_Id, Employee_Id, Start_Time, End_Time)
VALUES (1, 1, TO_DATE('15-OCT-2023 08:00:00','DD-MON-YYYY HH24:MI:SS'), TO_DATE('15-OCT-2012 17:00:00','DD-MON-YYYY HH24:MI:SS'));
INSERT INTO SHIFTS (Shift_Id, Employee_Id, Start_Time, End_Time)
VALUES (2, 2, TO_DATE('15-OCT-2023 08:00:00','DD-MON-YYYY HH24:MI:SS'), TO_DATE('15-OCT-2012 17:00:00','DD-MON-YYYY HH24:MI:SS'));
INSERT INTO SHIFTS (Shift_Id, Employee_Id, Start_Time, End_Time)
VALUES (3, 3, TO_DATE('15-OCT-2023 06:00:00','DD-MON-YYYY HH24:MI:SS'), TO_DATE('15-OCT-2012 15:00:00','DD-MON-YYYY HH24:MI:SS'));
INSERT INTO SHIFTS (Shift_Id, Employee_Id, Start_Time, End_Time)
VALUES (4, 4,  TO_DATE('15-OCT-2023 09:00:00','DD-MON-YYYY HH24:MI:SS'), TO_DATE('15-OCT-2012 18:00:00','DD-MON-YYYY HH24:MI:SS'));

INSERT INTO CUSTOMERS (Customer_Id, First_Name, Last_Name, Email, Phone)
VALUES (1, 'Mia', 'Lee', 'mialee@gmail.com', '1151610111');
INSERT INTO CUSTOMERS (Customer_Id, First_Name, Last_Name, Email, Phone)
VALUES (2, 'Andrew', 'Pascal', 'Andrewp@gmail.com', '2282292222');
INSERT INTO CUSTOMERS (Customer_Id, First_Name, Last_Name, Email, Phone)
VALUES (3, 'Jay', 'Carson', 'Jaym@yahoo.com', '33336833933');
INSERT INTO CUSTOMERS (Customer_Id, First_Name, Last_Name, Email, Phone)
VALUES (4, 'Peter', 'Peter', 'peterpeter@yahoo.com', '4244464414');

INSERT INTO TABLES (Table_Id, Capacity, Location)
VALUES (1, 4, 'Indoors');
INSERT INTO TABLES (Table_Id, Capacity, Location)
VALUES (2, 2, 'Outdoors');
INSERT INTO TABLES (Table_Id, Capacity, Location)
VALUES (3, 6, 'Indoors');
INSERT INTO TABLES (Table_Id, Capacity, Location)
VALUES (4, 8, 'Outdoors');

INSERT INTO RESERVATIONS (Reservation_Id, Branch_Id, Customer_Id, Table_Id, Reservation_time)
VALUES (1, 1, 1, 1, TO_DATE('15-OCT-2023 12:00:00','DD-MON-YYYY HH24:MI:SS'));
INSERT INTO RESERVATIONS (Reservation_Id, Branch_Id, Customer_Id, Table_Id, Reservation_time)
VALUES (2, 2, 2, 2, TO_DATE('15-OCT-2023 11:00:00','DD-MON-YYYY HH24:MI:SS'));
INSERT INTO RESERVATIONS (Reservation_Id, Branch_Id, Customer_Id, Table_Id, Reservation_time)
VALUES (3, 3, 3, 3, TO_DATE('15-OCT-2023 10:00:00','DD-MON-YYYY HH24:MI:SS'));
INSERT INTO RESERVATIONS (Reservation_Id, Branch_Id, Customer_Id, Table_Id, Reservation_time)
VALUES (4, 4, 4, 4, TO_DATE('15-OCT-2023 15:00:00','DD-MON-YYYY HH24:MI:SS'));
INSERT INTO RESERVATIONS (Reservation_Id, Branch_Id, Customer_Id, Table_Id, Reservation_time)
VALUES (5, 4, 4, 4, TO_DATE('15-OCT-2023 15:00:00','DD-MON-YYYY HH24:MI:SS'));
INSERT INTO RESERVATIONS (Reservation_Id, Branch_Id, Customer_Id, Table_Id, Reservation_time)
VALUES (6, 4, 3, 4, TO_DATE('15-OCT-2023 15:00:00','DD-MON-YYYY HH24:MI:SS'));
INSERT INTO RESERVATIONS (Reservation_Id, Branch_Id, Customer_Id, Table_Id, Reservation_time)
VALUES (7, 2, 3, 4, TO_DATE('15-OCT-2023 15:00:00','DD-MON-YYYY HH24:MI:SS'));

INSERT INTO ORDERS (Order_Id, Customer_Id, Order_Date, Total_Price)
VALUES (1, 1, TO_DATE('15-OCT-2023 12:15:00','DD-MON-YYYY HH24:MI:SS'), 25);
INSERT INTO ORDERS (Order_Id, Customer_Id, Order_Date, Total_Price)
VALUES (2, 2, TO_DATE('15-OCT-2023 11:20:00','DD-MON-YYYY HH24:MI:SS'), 35);
INSERT INTO ORDERS (Order_Id, Customer_Id, Order_Date, Total_Price)
VALUES (3, 3, TO_DATE('15-OCT-2023 10:10:00','DD-MON-YYYY HH24:MI:SS'), 40);
INSERT INTO ORDERS (Order_Id, Customer_Id, Order_Date, Total_Price)
VALUES (4, 4, TO_DATE('15-OCT-2023 15:05:00','DD-MON-YYYY HH24:MI:SS'), 50);

INSERT INTO CATEGORIES (Category_Id, Category_Name)
VALUES (1, 'Appetizers');
INSERT INTO CATEGORIES (Category_Id, Category_Name)
VALUES (2, 'Main Course');
INSERT INTO CATEGORIES (Category_Id, Category_Name)
VALUES (3, 'Desserts');
INSERT INTO CATEGORIES (Category_Id, Category_Name)
VALUES (4, 'Beverages');

INSERT INTO MENU_ITEMS (Item_Id, Category_Id, Item_Name, Description, Price)
VALUES (1, 1, 'Appetizer1', 'Crab Cakes with Horseradish Cream', 10);
INSERT INTO MENU_ITEMS (Item_Id, Category_Id, Item_Name, Description, Price)
VALUES (2, 2, 'Chicken', 'Grilled Chicken with Fresh Cherry Salsa.', 15);
INSERT INTO MENU_ITEMS (Item_Id, Category_Id, Item_Name, Description, Price)
VALUES (3, 3, 'Baklava', 'Honey Baklava', 8);
INSERT INTO MENU_ITEMS (Item_Id, Category_Id, Item_Name, Description, Price)
VALUES (4, 4, 'Tea', 'Black tea', 5);

INSERT INTO ORDER_DETAILS (Item_Id, Order_Id)
VALUES (1, 1);
INSERT INTO ORDER_DETAILS (Item_Id, Order_Id)
VALUES (2, 2);
INSERT INTO ORDER_DETAILS (Item_Id, Order_Id)
VALUES (3, 3);
INSERT INTO ORDER_DETAILS (Item_Id, Order_Id)
VALUES (4, 4);
INSERT INTO ORDER_DETAILS (Item_Id, Order_Id)
VALUES (3, 2);
INSERT INTO ORDER_DETAILS (Item_Id, Order_Id)
VALUES (1, 4);
INSERT INTO ORDER_DETAILS (Item_Id, Order_Id)
VALUES (2, 4);
INSERT INTO ORDER_DETAILS (Item_Id, Order_Id)
VALUES (4, 1);
INSERT INTO ORDER_DETAILS (Item_Id, Order_Id)
VALUES (4, 2);

INSERT INTO SUPPLIERS (Supplier_Id, Name, Phone, Email)
VALUES (1, 'Supplier1', '1811181171', 'supplier1@gmail.com');
INSERT INTO SUPPLIERS (Supplier_Id, Name, Phone, Email)
VALUES (2, 'Supplier2', '2522292222', 'supplier2@gmail.com');
INSERT INTO SUPPLIERS (Supplier_Id, Name, Phone, Email)
VALUES (3, 'Supplier3', '3323333933', 'supplier3@gmail.com');
INSERT INTO SUPPLIERS (Supplier_Id, Name, Phone, Email)
VALUES (4, 'Supplier4', '4344840444', 'supplier4@gmail.com');

INSERT INTO INGREDIENTS (Ingredient_Id, Supplier_Id, Ingredient_Name, Price, Date_Received)
VALUES (1, 1, 'Crab', 5, TO_DATE('11-OCT-2023 13:00:00','DD-MON-YYYY HH24:MI:SS'));
INSERT INTO INGREDIENTS (Ingredient_Id, Supplier_Id, Ingredient_Name, Price, Date_Received)
VALUES (2, 2, 'Chicken', 3, TO_DATE('10-OCT-2023 11:00:00','DD-MON-YYYY HH24:MI:SS'));
INSERT INTO INGREDIENTS (Ingredient_Id, Supplier_Id, Ingredient_Name, Price, Date_Received)
VALUES (3, 3, 'Honey', 2, TO_DATE('12-OCT-2023 10:00:00','DD-MON-YYYY HH24:MI:SS'));
INSERT INTO INGREDIENTS (Ingredient_Id, Supplier_Id, Ingredient_Name, Price, Date_Received)
VALUES (4, 4, 'Tea', 4, TO_DATE('13-OCT-2023 15:00:00','DD-MON-YYYY HH24:MI:SS'));

INSERT INTO ITEM_DETAILS (Item_Id, Ingredient_Id, Ingredient_Quantity)
VALUES (1, 1, 2);
INSERT INTO ITEM_DETAILS (Item_Id, Ingredient_Id, Ingredient_Quantity)
VALUES (2, 2, 1);
INSERT INTO ITEM_DETAILS (Item_Id, Ingredient_Id, Ingredient_Quantity)
VALUES (3, 3, 3);
INSERT INTO ITEM_DETAILS (Item_Id, Ingredient_Id, Ingredient_Quantity)
VALUES (4, 4, 4);
INSERT INTO ITEM_DETAILS (Item_Id, Ingredient_Id, Ingredient_Quantity)
VALUES (1, 3, 5);
INSERT INTO ITEM_DETAILS (Item_Id, Ingredient_Id, Ingredient_Quantity)
VALUES (4, 1, 1);
INSERT INTO ITEM_DETAILS (Item_Id, Ingredient_Id, Ingredient_Quantity)
VALUES (2, 3, 2);
INSERT INTO ITEM_DETAILS (Item_Id, Ingredient_Id, Ingredient_Quantity)
VALUES (1, 2, 1);

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


























