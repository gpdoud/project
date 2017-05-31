use master
go
drop database if exists prs
go
create database prs
go
use prs
go

drop table if exists [line_item]
drop table if exists [request]
drop table if exists [product]
drop table if exists [vendor]
drop table if exists [user]
go

create table [user] (
	ID int identity(1,1) primary key,
	UserName varchar(20) not null,
	Password varchar(10) not null, -- encrypt this? No
	FirstName varchar(20) not null,
	LastName varchar(20) not null,
	Phone varchar(12),
	Email varchar(75) not null, -- required for password reset?
	IsReviewer bit not null default 0,
	IsAdmin bit not null default 0 -- to load tables?
)

create unique index idx_user_username
	on [user] (UserName asc) 

create table [vendor] (
	ID int identity(1,1) primary key,
	Code varchar(10) not null,
	Name varchar(255) not null,
	Address varchar(255) not null,
	City varchar(255) not null,
	State varchar(2) not null,
	Zip varchar(5) not null,
	Phone varchar(12),
	Email varchar(255),
	IsRecommended bit default 0 -- Purpose? vendors listed first
)

create unique index idx_vendor_code
	on [vendor] (Code asc)

create table [product] (
	ID int identity(1,1) primary key,
	VendorId int foreign key references [vendor](ID),
	Name varchar(150) not null,
	VendorPartNumber varchar(50) not null,
	Price decimal(10,2) not null default(0.0),
	Unit varchar(10) not null default 'Each',
	PhotoPath varchar(255)
)

create unique index idx_product_vendorid_partnumber
	on [product] (VendorId asc, VendorPartNumber asc)

create table [purchaseRequest] (
	ID int identity(1,1) primary key,
	UserID int foreign key references [user](ID),
	Description varchar(100),
	Justification varchar(255) not null,
	DateNeeded DateTime,
	DeliveryMode varchar(25), -- set of items in document
	DocsAttached bit not null default 0, -- probably remove this
	Status varchar(10), -- set of items in document
	Total decimal(10,2) not null default 0.0, -- readonly from UI
	SubmittedDate DateTime not null default getdate()
)

create table [line_item] (
	ID int identity(1,1) primary key,
	RequestID int foreign key references [purchaseRequest](ID),
	ProductID int foreign key references [product](ID),
	Quantity int not null default 1
)

create unique index idx_line_item_requestid_productid
	on [line_item] (RequestId asc, ProductId asc)
go
-- load user
insert into [user] (UserName, Password, FirstName, LastName, Phone, Email, IsReviewer)
	values ('user1', 'password', 'Jane', 'Doe', '513-555-1212', 'jdoe@gmail.com', 1)

insert into [user] (UserName, Password, FirstName, LastName, Phone, Email, IsReviewer)
	values ('user2', 'password', 'Jim', 'Doe', '513-555-1212', 'jdoe@gmail.com', 0)

insert into [user] (UserName, Password, FirstName, LastName, Phone, Email, IsReviewer)
	values ('user3', 'password', 'James', 'Doe', '513-555-1212', 'jdoe@gmail.com', 0)

-- load vendor
insert into [vendor] (Code, Name, Address, City, State, Zip, Phone, Email, IsRecommended)
	values ('AMAZ0001', 'Amazon', '123 Any Street', 'Cincinnati', 'OH', '45201', '513-555-1212', 'info@amazon.com', 1)

insert into [vendor] (Code, Name, Address, City, State, Zip, Phone, Email, IsRecommended)
	values ('TARG0100', 'Target', '123 Any Street', 'Cincinnati', 'OH', '45201', '513-555-1212', 'info@target.com', 1)

insert into [vendor] (Code, Name, Address, City, State, Zip, Phone, Email, IsRecommended)
	values ('COST0333', 'Costco', '123 Any Street', 'Cincinnati', 'OH', '45201', '513-555-1212', 'info@costco.com', 0)

-- load product
declare @amazonId int

-- Amazon products - get the ID for Amazon
select @amazonId = id from [vendor] where code = 'AMAZ0001'

insert into [product] (VendorId, Name, VendorPartNumber, Price, Unit, PhotoPath)
	values (@amazonId, 'Echo', 'AMZN-Echo', 99.99, 'Each', NULL)

insert into [product] (VendorId, Name, VendorPartNumber, Price, Unit, PhotoPath)
	values (@amazonId, 'Prime', 'AMZN-Prime', 10.99, 'Month', NULL)

insert into [product] (VendorId, Name, VendorPartNumber, Price, Unit, PhotoPath)
	values (@amazonId, 'AWS', 'AMZN-AWS', 0.00, 'Subscript', NULL)

declare @targetId int

-- Target products - get the ID for Target
select @targetId = id from [vendor] where code = 'TARG0100'

insert into [product] (VendorId, Name, VendorPartNumber, Price, Unit, PhotoPath)
	values (@targetId, 'Writing Desk', 'TARG-Desk', 619.99, 'Each', NULL)

insert into [product] (VendorId, Name, VendorPartNumber, Price, Unit, PhotoPath)
	values (@targetId, 'Chair', 'TARG-Chair', 254.99, 'Each', NULL)

insert into [product] (VendorId, Name, VendorPartNumber, Price, Unit, PhotoPath)
	values (@targetId, 'Bookcase', 'TARG-BCase', 799.99, 'Each', NULL)

declare @costcoId int

-- Target products - get the ID for Target
select @costcoId = id from [vendor] where code = 'COST0333'

insert into [product] (VendorId, Name, VendorPartNumber, Price, Unit, PhotoPath)
	values (@costcoId, 'Filing Cabinet', 'COST-Cabinet', 3299.99, 'Each', NULL)

insert into [product] (VendorId, Name, VendorPartNumber, Price, Unit, PhotoPath)
	values (@costcoId, 'Cubicle', 'TARG-Cube', 1048.99, 'Each', NULL)

insert into [product] (VendorId, Name, VendorPartNumber, Price, Unit, PhotoPath)
	values (@costcoId, 'Conf Table', 'TARG-Table', 1689.99, 'Each', NULL)