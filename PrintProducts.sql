use prs;
go
alter procedure PrintProducts
	@vendorId int = null
as
begin
	declare @name varchar(30), @price float, @unit varchar(10)
	if @vendorId is null begin
		declare cur cursor for
			select name, price, unit from product order by price
	end else begin
		declare cur cursor for
			select name, price, unit from product 
				where vendorId = @vendorId 
				order by price
	end
	open cur
	print 'Product Name        Price     Unit'
	print '------------------- --------- ----------'
	fetch next from cur into @name, @price, @unit
	while @@FETCH_STATUS = 0 begin
		print concat(left(@name + space(20), 20), left('$'+format(@price, 'f2')+space(10), 10), @unit)
		fetch next from cur into @name, @price, @unit
	end
	print '------------------- --------- ----------'
	close cur
	deallocate cur
end
go
exec PrintProducts