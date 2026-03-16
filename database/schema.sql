/* =====================================================
   Humanitarian Aid System Database Schema
   Compatible with: Microsoft SQL Server
   ===================================================== */

-- =========================================
-- 1. جدول أنواع الهوية
-- =========================================
CREATE TABLE IDTypes (
    IDTypeID INT IDENTITY(1,1) PRIMARY KEY,
    IDTypeName NVARCHAR(50) NOT NULL
);

-- =========================================
-- 2. جدول السنوات
-- =========================================
CREATE TABLE Years (
    YearID INT IDENTITY(1,1) PRIMARY KEY,
    GregorianYear INT NOT NULL,
    HijriYear INT NULL,
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- =========================================
-- 3. جدول الفروع
-- =========================================
CREATE TABLE Branches (
    BranchID INT IDENTITY(1,1) PRIMARY KEY,
    BranchName NVARCHAR(100) NOT NULL
);

-- =========================================
-- 4. جدول اللجان
-- =========================================
CREATE TABLE Committees (
    CommitteeID INT IDENTITY(1,1) PRIMARY KEY,
    CommitteeName NVARCHAR(100) NOT NULL,
    BranchID INT NOT NULL,
    ResponsiblePerson NVARCHAR(100),

    CONSTRAINT FK_Committees_Branches
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

-- =========================================
-- 5. جدول الأصناف
-- =========================================
CREATE TABLE Items (
    ItemID INT IDENTITY(1,1) PRIMARY KEY,
    ItemName NVARCHAR(100) NOT NULL,
    Unit NVARCHAR(20)
);

-- =========================================
-- 6. جدول المخازن
-- =========================================
CREATE TABLE Stores (
    StoreID INT IDENTITY(1,1) PRIMARY KEY,
    StoreName NVARCHAR(100) NOT NULL,
    Location NVARCHAR(200),
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME
);

-- =========================================
-- 7. جدول المستخدمين
-- =========================================
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    UserName NVARCHAR(100) NOT NULL,
    LoginName NVARCHAR(50) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(256) NOT NULL,
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- =========================================
-- 8. جدول الصلاحيات
-- =========================================
CREATE TABLE Permissions (
    PermissionID INT IDENTITY(1,1) PRIMARY KEY,
    PermissionName NVARCHAR(100),
    PermissionCode NVARCHAR(50)
);

-- =========================================
-- 9. جدول صلاحيات المستخدمين
-- =========================================
CREATE TABLE UserPermissions (
    UserPermissionID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    PermissionID INT NOT NULL,

    CONSTRAINT FK_UserPermissions_Users
    FOREIGN KEY (UserID) REFERENCES Users(UserID),

    CONSTRAINT FK_UserPermissions_Permissions
    FOREIGN KEY (PermissionID) REFERENCES Permissions(PermissionID)
);

-- =========================================
-- 10. جدول المستفيدين
-- =========================================
CREATE TABLE Beneficiaries (
    BeneficiaryID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    NationalID NVARCHAR(20) UNIQUE,
    IDTypeID INT,
    Phone NVARCHAR(20),
    Address NVARCHAR(200),
    Status BIT DEFAULT 1,
    RegistrationDate DATETIME DEFAULT GETDATE(),
    RegisteredByUserID INT,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME,

    CONSTRAINT FK_Beneficiaries_IDTypes
    FOREIGN KEY (IDTypeID) REFERENCES IDTypes(IDTypeID),

    CONSTRAINT FK_Beneficiaries_Users
    FOREIGN KEY (RegisteredByUserID) REFERENCES Users(UserID)
);

-- =========================================
-- 11. جدول البطاقات
-- =========================================
CREATE TABLE Cards (
    CardID INT IDENTITY(1,1) PRIMARY KEY,
    CardNumber NVARCHAR(50) UNIQUE NOT NULL,
    Barcode NVARCHAR(100) UNIQUE NOT NULL,
    BeneficiaryID INT UNIQUE,
    BranchID INT,
    CommitteeID INT,
    AnnualQuantity DECIMAL(18,2),
    IsMonetary BIT DEFAULT 0,
    Receiver NVARCHAR(100),
    IssueDate DATETIME DEFAULT GETDATE(),
    ExpiryDate DATETIME,
    IsActive BIT DEFAULT 1,
    IssuedByUserID INT,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME,

    CONSTRAINT FK_Cards_Beneficiaries
    FOREIGN KEY (BeneficiaryID) REFERENCES Beneficiaries(BeneficiaryID),

    CONSTRAINT FK_Cards_Branches
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID),

    CONSTRAINT FK_Cards_Committees
    FOREIGN KEY (CommitteeID) REFERENCES Committees(CommitteeID),

    CONSTRAINT FK_Cards_Users
    FOREIGN KEY (IssuedByUserID) REFERENCES Users(UserID)
);

-- =========================================
-- 12. جدول أرصدة المخازن
-- =========================================
CREATE TABLE StoreInventory (
    StoreInventoryID INT IDENTITY(1,1) PRIMARY KEY,
    StoreID INT NOT NULL,
    ItemID INT NOT NULL,
    Quantity DECIMAL(18,2) DEFAULT 0,
    LastUpdated DATETIME DEFAULT GETDATE(),
    UpdatedByUserID INT,

    CONSTRAINT FK_StoreInventory_Stores
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID),

    CONSTRAINT FK_StoreInventory_Items
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID),

    CONSTRAINT FK_StoreInventory_Users
    FOREIGN KEY (UpdatedByUserID) REFERENCES Users(UserID)
);

-- =========================================
-- 13. جدول التوريدات
-- =========================================
CREATE TABLE Supplies (
    SupplyID INT IDENTITY(1,1) PRIMARY KEY,
    TruckNumber NVARCHAR(50),
    DriverName NVARCHAR(100),
    ItemID INT NOT NULL,
    Quantity DECIMAL(18,2),
    StoreID INT NOT NULL,
    SupplyDate DATETIME DEFAULT GETDATE(),
    ReceiverName NVARCHAR(100),
    UserID INT,
    Notes NVARCHAR(500),
    CreatedAt DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Supplies_Items
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID),

    CONSTRAINT FK_Supplies_Stores
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID),

    CONSTRAINT FK_Supplies_Users
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- =========================================
-- 14. جدول الصرف
-- =========================================
CREATE TABLE Transactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    CardID INT NOT NULL,
    YearID INT NOT NULL,
    ItemID INT,
    Quantity DECIMAL(18,2),
    Amount DECIMAL(18,2),
    Unit NVARCHAR(20),
    Receiver NVARCHAR(100),
    TransactionDate DATETIME DEFAULT GETDATE(),
    UserID INT,
    Notes NVARCHAR(500),
    CreatedAt DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Transactions_Cards
    FOREIGN KEY (CardID) REFERENCES Cards(CardID),

    CONSTRAINT FK_Transactions_Years
    FOREIGN KEY (YearID) REFERENCES Years(YearID),

    CONSTRAINT FK_Transactions_Items
    FOREIGN KEY (ItemID) REFERENCES Items(ItemID),

    CONSTRAINT FK_Transactions_Users
    FOREIGN KEY (UserID) REFERENCES Users(UserID),

    CONSTRAINT UQ_Card_Year UNIQUE (CardID, YearID)
);

-- =========================================
-- Indexes
-- =========================================

CREATE INDEX IDX_Beneficiaries_NationalID
ON Beneficiaries (NationalID);

CREATE INDEX IDX_Transactions_Year
ON Transactions (YearID);

CREATE INDEX IDX_Transactions_Date
ON Transactions (TransactionDate);

CREATE INDEX IDX_Inventory_Store_Item
ON StoreInventory (StoreID, ItemID);