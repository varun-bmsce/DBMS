create database bank;
use bank;
CREATE TABLE Branch (
    branch_name VARCHAR(50),
    branch_city VARCHAR(50),
    assets REAL,
    PRIMARY KEY (branch_name)
);

CREATE TABLE BankAccount (
    accno INT,
    branch_name VARCHAR(50),
    balance REAL,
    PRIMARY KEY (accno),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

CREATE TABLE BankCustomer (
    customer_name VARCHAR(50),
    customer_street VARCHAR(100),
    customer_city VARCHAR(50),
    PRIMARY KEY (customer_name)
);

CREATE TABLE Depositer (
    customer_name VARCHAR(50),
    accno INT,
    PRIMARY KEY (customer_name, accno),
    FOREIGN KEY (customer_name) REFERENCES BankCustomer(customer_name),
    FOREIGN KEY (accno) REFERENCES BankAccount(accno)
);

CREATE TABLE LOAN (
    loan_number INT,
    branch_name VARCHAR(50),
    amount REAL,
    PRIMARY KEY (loan_number),
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

CREATE TABLE Borrower (
    customer_name VARCHAR(50),
    loan_number INT,
    PRIMARY KEY (customer_name, loan_number),
    FOREIGN KEY (customer_name) REFERENCES BankCustomer(customer_name),
    FOREIGN KEY (loan_number) REFERENCES LOAN(loan_number)
);
INSERT INTO Branch (branch_name, branch_city, assets) VALUES
('SBI_ResidencyRoad', 'Bangalore', 1000000),
('HDFC_ChurchStreet', 'Bangalore', 800000),
('ICICI_MGRoad', 'Bangalore', 1200000);

INSERT INTO BankAccount (accno, branch_name, balance) VALUES
(101, 'SBI_ResidencyRoad', 50000),
(102, 'SBI_ResidencyRoad', 70000),
(103, 'HDFC_ChurchStreet', 30000);

INSERT INTO BankCustomer (customer_name, customer_street, customer_city) VALUES
('Alice', '1st Main', 'Bangalore'),
('Bob', '2nd Main', 'Bangalore'),
('Charlie', '3rd Main', 'Bangalore');

INSERT INTO Depositer (customer_name, accno) VALUES
('Alice', 101),
('Bob', 102),
('Alice', 103);  -- Alice has two accounts

INSERT INTO LOAN (loan_number, branch_name, amount) VALUES
(201, 'SBI_ResidencyRoad', 150000),
(202, 'HDFC_ChurchStreet', 200000),
(203, 'ICICI_MGRoad', 250000);

INSERT INTO Borrower (customer_name, loan_number) VALUES
('Alice', 201),
('Bob', 202),
('Charlie', 203);
SELECT branch_name, assets / 100000 AS "assets in lakhs"
FROM Branch;
SELECT customer_name, branch_name, COUNT(*) AS account_count
FROM Depositer
JOIN BankAccount ON Depositer.accno = BankAccount.accno
GROUP BY customer_name, branch_name
HAVING COUNT(*) >= 2;
CREATE VIEW BranchLoanSummary AS
SELECT branch_name, SUM(amount) AS total_loan_amount
FROM LOAN
GROUP BY branch_name;
