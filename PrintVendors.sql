use prs
go
alter procedure PrintVendors
	@vendorName varchar(50) = null
as
begin
	declare curVendor cursor for
		select id, name, address, city, state, zip, phone, isRecommended from vendor

	declare @name varchar(50), @address varchar(50), @city varchar(50),
			@state varchar(2), @zip varchar(5), @phone varchar(12),
			@isRecommended bit, @vendorId int

	open curVendor

	fetch next from curVendor into
		@vendorId, @name, @address, @city, @state, @zip, @phone, @isRecommended
	while @@FETCH_STATUS = 0 BEGIN
		-- PROCESSING HERE
		print ' '
		print @name
		print @address
		print concat(@city, ', ', @state, ' ', @zip)
		print @phone
		IF @isRecommended = 1 BEGIN
			print 'Recommended Vendor'
		END
		print ' '
		exec PrintProducts @vendorId
		-- at the end, fetch next again
		fetch next from curVendor into
			@vendorId, @name, @address, @city, @state, @zip, @phone, @isRecommended
	END

	close curVendor
	deallocate curVendor
end
go
EXEC PrintVendors
go