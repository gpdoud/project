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
	on [product] (VendorId asc, PartNumber asc)

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
	RequestID int foreign key references [request](ID),
	ProductID int foreign key references [product](ID),
	Quantity int not null default 1
)

create unique index idx_line_item_requestid_productid
	on [line_item] (RequestId asc, ProductId asc)
go