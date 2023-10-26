
--Top 3 clienti cu cele mai multe rezervari si cel putin o rezervare

SELECT C.Customer_Id, C.First_Name, C.Last_Name, COUNT(R.Reservation_Id)
FROM CUSTOMERS C
LEFT JOIN RESERVATIONS R ON C.Customer_Id = R.Customer_Id
GROUP BY C.Customer_Id, C.First_Name, C.Last_Name 
HAVING COUNT(R.Reservation_Id) > 0
ORDER BY COUNT(R.Reservation_Id) DESC
FETCH FIRST 3 ROWS ONLY;

--Detaliile clientilor care au plasat comenzi pentru elemente dintr-o anumita categorie

SELECT C.Customer_Id, C.First_Name, C.Last_Name, O.Order_Id
FROM CUSTOMERS C
INNER JOIN ORDERS O ON C.Customer_Id = O.Customer_Id
WHERE O.Order_Id IN (
    SELECT OD.Order_Id 
    FROM ORDER_DETAILS OD 
    INNER JOIN MENU_ITEMS MI ON OD.Item_Id = MI.Item_Id 
    WHERE MI.Category_Id = 1);

--Produsele din meniu impreuna cu numarul de comenzi in care au fost incluse

SELECT MI.Item_Id, MI.Item_Name, COUNT(OD.Order_Id) AS Order_Count
FROM MENU_ITEMS MI
JOIN ORDER_DETAILS OD ON MI.Item_Id = OD.Item_Id
WHERE MI.Category_Id IN (
    SELECT Category_Id
    FROM MENU_ITEMS
    GROUP BY Category_Id
)
GROUP BY MI.Item_Id, MI.Item_Name;

--Detaliile angajatilor din tabelul Employees

CREATE OR REPLACE PROCEDURE GetEmployeeDetails
IS
   EmployeeId EMPLOYEES.Employee_Id%TYPE;
   FirstName EMPLOYEES.First_Name%TYPE;
   LastName EMPLOYEES.Last_Name%TYPE;
   JobTitle EMPLOYEES.Job_Title%TYPE;
   CURSOR c_Employees IS
      SELECT Employee_Id, First_Name, Last_Name, Job_Title
      FROM EMPLOYEES;
BEGIN
   OPEN c_Employees;
   LOOP
      FETCH c_Employees INTO EmployeeId, FirstName, LastName, JobTitle;
      EXIT WHEN c_Employees%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('Employee ID: ' || EmployeeId);
      DBMS_OUTPUT.PUT_LINE('First Name: ' || FirstName);
      DBMS_OUTPUT.PUT_LINE('Last Name: ' || LastName);
      DBMS_OUTPUT.PUT_LINE('Job Title: ' || JobTitle);
      DBMS_OUTPUT.PUT_LINE('---------------------------');
   END LOOP;
   CLOSE c_Employees;
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error ');
END;
/

BEGIN
   GetEmployeeDetails;
END;
/


--Cel mai comandat produs de catre un client

CREATE OR REPLACE FUNCTION GetMostOrderedItemByCustomer(
   CustomerId IN CUSTOMERS.Customer_Id%TYPE
) RETURN VARCHAR2
IS
   MostOrderedItem VARCHAR2(255);
BEGIN
   SELECT MI.Item_Name
   INTO MostOrderedItem
   FROM MENU_ITEMS MI
   JOIN ORDER_DETAILS OD ON MI.Item_Id = OD.Item_Id
   JOIN ORDERS O ON OD.Order_Id = O.Order_Id
   WHERE O.Customer_Id = CustomerId
   GROUP BY MI.Item_Name
   ORDER BY COUNT(OD.Order_Id) DESC
   FETCH FIRST 1 ROW ONLY;

   RETURN MostOrderedItem;

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN NULL;
   WHEN OTHERS THEN
      RETURN NULL;
END;
/

SELECT GetMostOrderedItemByCustomer(1) FROM DUAL;

SELECT GetMostOrderedItemByCustomer(50) FROM DUAL;

----

--Nu se pot adauga comenzi in afara intervalului orar 06:00 - 18:00 

CREATE OR REPLACE TRIGGER OrdersNotAllowed 
    BEFORE INSERT OR UPDATE on Orders
BEGIN
    IF (TO_CHAR(SYSDATE,'HH24') NOT BETWEEN 6 AND 18)
    THEN 
        IF INSERTING THEN 
        RAISE_APPLICATION_ERROR(-20001,'Adaugarea de comenzi este permisa doar in intervalul orar 06:00 - 18:00');
        ELSE RAISE_APPLICATION_ERROR(-20003,'Actualizarea comenzilor este permisa doar in intervalul orar 06:00 - 18:00');
        END IF;
    END IF;
END;
/

INSERT INTO ORDERS (Order_Id, Customer_Id, Order_Date, Total_Price)
VALUES (5, 1, TO_DATE('15-OCT-2023 12:15:00','DD-MON-YYYY HH24:MI:SS'), 25);

UPDATE ORDERS
SET Order_Id = 1, Customer_Id = 1, Order_Date = TO_DATE('15-OCT-2023 12:15:00','DD-MON-YYYY HH24:MI:SS'), Total_Price = 5
WHERE Order_Id = 1;


-- Nu se pot face rezervari pentru un anumit client

CREATE OR REPLACE TRIGGER PreventReservation
BEFORE INSERT ON RESERVATIONS
FOR EACH ROW
DECLARE
   CustomerId RESERVATIONS.Customer_Id%TYPE;
BEGIN
   CustomerId := :NEW.Customer_Id;
   IF CustomerId = 1 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Nu sunt permise rezervari pentru acest client.');
   END IF;
END;
/

INSERT INTO RESERVATIONS (Reservation_Id, Branch_Id, Customer_Id, Table_Id, Reservation_time)
VALUES (5, 1, 1, 1, TO_DATE('15-OCT-2023 12:00:00','DD-MON-YYYY HH24:MI:SS'));
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

























