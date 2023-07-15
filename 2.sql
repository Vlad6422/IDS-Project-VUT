-- Create the Client table
CREATE TABLE Client (
    ClientID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Age INT NOT NULL,
    Email VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL
);

-- Create the AccountMember table
CREATE TABLE AccountMember (
    AccountMemberID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Age INT NOT NULL
);

-- Create the Account table
CREATE TABLE Account (
    AccountID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    TransactionLimit INT NOT NULL,
    SecureWord VARCHAR(50) NOT NULL,
    Currency VARCHAR(10) NOT NULL,
    ClientID INT NOT NULL
);

-- Create the Transaction table
CREATE TABLE Transactionw (
    TransactionID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    TransactionType VARCHAR(50) NOT NULL,
    TransactionDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    BeneficiaryName VARCHAR(50) NOT NULL,
    AccountID INT NOT NULL
);

-- Create the AccountStatement table
CREATE TABLE AccountStatement (
    StatementID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    BankName VARCHAR(50) NOT NULL,
    DateFrom DATE NOT NULL,
    DateTo DATE NOT NULL,
    CreationDate DATE NOT NULL,
    AccountID INT NOT NULL
);

-- Create the BankEmployee table
CREATE TABLE BankEmployee (
    EmployeeID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL,
    Email VARCHAR(50) NOT NULL
);

-- Create the relationship between Account and AccountMember tables (1 account can have multiple AccountMembers)
CREATE TABLE AccountAccountMember (
AccountID NUMBER NOT NULL,
AccountMemberID NUMBER NOT NULL,
CONSTRAINT PK_AccountAccountMember PRIMARY KEY (AccountID, AccountMemberID),
CONSTRAINT FK_AccountAccountMember_Account FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
CONSTRAINT FK_AccountAccountMember_AccountMember FOREIGN KEY (AccountMemberID) REFERENCES AccountMember(AccountMemberID)
);

--RELATIONS--
-- Create the relationship between Account and Client tables (1 Klient can have multiple accounts)
 ALTER TABLE Account ADD CONSTRAINT FK_Client_Account FOREIGN KEY (ClientID) REFERENCES Client(ClientID);

-- Create the relationship between Account and Transaction tables (1 account can have multiple transactions)
ALTER TABLE Transactionw ADD CONSTRAINT FK_Account_Transaction FOREIGN KEY (AccountID) REFERENCES Account(AccountID);

-- Create the relationship between Client and AccountStatement tables (1 client can have multiple account statements)
ALTER TABLE AccountStatement ADD CONSTRAINT FK_Client_AccountStatement FOREIGN KEY (AccountID) REFERENCES Account(AccountID);

-- Create the relationship between BankEmployee and Client tables (1 bank employee can manage multiple clients)
CREATE TABLE BankEmployeeClient (
EmployeeID NUMBER NOT NULL,
ClientID NUMBER NOT NULL,
CONSTRAINT PK_BankEmployeeClient PRIMARY KEY (EmployeeID, ClientID),
CONSTRAINT FK_BankEmployeeClient_Employee FOREIGN KEY (EmployeeID) REFERENCES BankEmployee(EmployeeID),
CONSTRAINT FK_BankEmployeeClient_Client FOREIGN KEY (ClientID) REFERENCES Client(ClientID)
);

--CHECK--
ALTER TABLE Client ADD CONSTRAINT CHK_Client_Age CHECK (Age >= 18);
ALTER TABLE Account ADD CONSTRAINT CHK_Account_TransactionLimit CHECK (TransactionLimit >= 0);
ALTER TABLE Transactionw ADD CONSTRAINT CHK_Transaction_Amount CHECK (Amount > 0);
ALTER TABLE AccountStatement ADD CONSTRAINT CHK_AccountStatement_Dates CHECK (DateFrom <= DateTo);
ALTER TABLE BankEmployee ADD CONSTRAINT UQ_BankEmployee_Email UNIQUE (Email);
ALTER TABLE Client ADD CONSTRAINT UQ_Client_Email UNIQUE (Email);

-- Insert into Client table --
INSERT INTO Client (FirstName, LastName, Age, Email, PhoneNumber)
VALUES ('John', 'Doe', 35, 'johndoe@email.com', '123-456-7890');

-- Insert into AccountMember table --
INSERT INTO AccountMember (FirstName, LastName, Age)
VALUES ('Jane', 'Doe', 25);

-- Insert into Account table --
INSERT INTO Account (ClientID, Username, Password, TransactionLimit, SecureWord, Currency)
VALUES (1, 'johndoe', 'mypassword', 1000, 'mysecureword', 'USD');

-- Insert into Transaction table --
INSERT INTO Transactionw (TransactionType, TransactionDate, Amount, BeneficiaryName, AccountID)
VALUES ('Deposit', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 500, 'John Doe', 1);

-- Insert into AccountStatement table --
INSERT INTO AccountStatement (BankName, DateFrom, DateTo, CreationDate, AccountID)
VALUES ('MyBank', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-31', 'YYYY-MM-DD'), TO_DATE('2023-03-26', 'YYYY-MM-DD'), 1);

-- Insert into BankEmployee table --
INSERT INTO BankEmployee (FirstName, LastName, PhoneNumber, Email)
VALUES ('Alice', 'Smith', '555-1234', 'alicesmith@mybank.com');