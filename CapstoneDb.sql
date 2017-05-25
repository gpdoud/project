-- Database
USE master
IF EXISTS(select * from sys.databases where name='Capstone')
BEGIN
	DROP DATABASE Capstone
END
CREATE DATABASE Capstone
Go
CREATE TABLE Product (
	Id int primary key identity(1,1),
	VendorId int foreign key references Vendor(Id),
	Name nvarchar(50) not null,
	PartNumber nvarchar(20) not null,
	Price decimal(10,2) not null,
	Unit nvarchar(10) not null,
	PhotoPath nvarchar(255)
)
CREATE TABLE Vendor ()
CREATE TABLE User ()
CREATE TABLE Request ()
CREATE TABLE LineItem ();
var db = {
	Product: [
		{ Id: 1, ' },
	],
	Vendor: [
		{ Id: 1, Code: '', Name: '', Address: '', City: '', State: ''
			, Zip: '', Phone: '', Email: '', IsPreApproved: 0 },
	],
	User: [
		{ Id: 1, UserName: '', Password: '', FirstName: '', LastName: ''
			, Phone: '', Email: '', IsManager: 0 },
	],
	Request: [
		{ Id: 1, UserId: '', Description: '', Justification: ''
			, DateNeeded: '', DeliveryMode: '', DocsAttached: 0
			, Status: '', Total: 1.00, SubmittedDate: '' }, 
	]
	LineItem: [
		{ Id: 1, RequestId: 1, ProductId: 1, Quantity: 0 },
	]
}