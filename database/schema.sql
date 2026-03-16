/* =============================================================
   Humanitarian Aid System Database Schema
   Compatible with: Microsoft SQL Server
   ============================================================= */

-- 1. جدول أنواع الهوية
CREATE TABLE IDTypes (
    IDTypeID INT IDENTITY(1,1) PRIMARY KEY,
    IDTypeName NVARCHAR(50) NOT NULL
);

-- 2. جدول السنوات
CREATE TABLE Years (
    YearID INT IDENTITY(1,1) PRIMARY KEY,
    GregorianYear INT NOT NULL,
    HijriYear INT NULL
);

-- 3. جدول الفروع
CREATE TABLE Branches (
    BranchID INT IDENTITY(1,1) PRIMARY KEY,
    BranchName NVARCHAR(100) NOT NULL
);

-- 4. جدول المستفيدين
CREATE TABLE Beneficiaries (
    BeneficiaryID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(200) NOT NULL,
    NationalID NVARCHAR(50) UNIQUE NOT NULL,
    IDTypeID INT FOREIGN KEY REFERENCES IDTypes(IDTypeID),
    Phone NVARCHAR(20),
    Address NVARCHAR(MAX),
    Status BIT DEFAULT 1 -- 1: Active, 0: Inactive
);

-- 5. جدول اللجان
CREATE TABLE Committees (
    CommitteeID INT IDENTITY(1,1) PRIMARY KEY,
    CommitteeName NVARCHAR(100) NOT NULL,
    BranchID INT FOREIGN KEY REFERENCES Branches(BranchID)
);

-- 6. جدول المشاريع
CREATE TABLE Projects (
    ProjectID INT IDENTITY(1,1) PRIMARY KEY,
    ProjectName NVARCHAR(100) NOT NULL
);

-- 7. جدول البطاقات
CREATE TABLE Cards (
    CardID INT IDENTITY(1,1) PRIMARY KEY,
    CardNumber NVARCHAR(50) UNIQUE NOT NULL,
    BeneficiaryID INT FOREIGN KEY REFERENCES Beneficiaries(BeneficiaryID),
    ProjectID INT FOREIGN KEY REFERENCES Projects(ProjectID),
    YearID INT FOREIGN KEY REFERENCES Years(YearID),
    BranchID INT FOREIGN KEY REFERENCES Branches(BranchID),
    CommitteeID INT FOREIGN KEY REFERENCES Committees(CommitteeID)
);

-- 8. جدول عمليات الصرف
CREATE TABLE Transactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    CardID INT FOREIGN KEY REFERENCES Cards(CardID),
    Quantity DECIMAL(18,2) NOT NULL,
    Amount DECIMAL(18,2) NULL, -- للصرف النقدي
    TransactionDate DATETIME DEFAULT GETDATE()
);

-- 9. جدول المخازن
CREATE TABLE Stores (
    StoreID INT IDENTITY(1,1) PRIMARY KEY,
    StoreName NVARCHAR(100) NOT NULL,
    BranchID INT FOREIGN KEY REFERENCES Branches(BranchID)
);

-- 10. جدول التوريدات
CREATE TABLE Supplies (
    SupplyID INT IDENTITY(1,1) PRIMARY KEY,
    StoreID INT FOREIGN KEY REFERENCES Stores(StoreID),
    ItemName NVARCHAR(100) NOT NULL,
    Quantity DECIMAL(18,2) NOT NULL,
    SupplyDate DATETIME DEFAULT GETDATE()
);
