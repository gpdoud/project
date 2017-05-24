// Database
var db = {
	Product: [
		{ Id: 1, VendorId: 1, Name: '', PartNumber: '', Price: 1.00
			, Unit: '', PhotoPath: '' },
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