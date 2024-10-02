select * from sales
	
create table report_table(
	product_id int primary key,
	sum_of_sales float,
	sum_of_profit float
)

create or replace function update_product_report()
Returns trigger as $$
declare
    sumofsales float;
    sumofprofit float;
    count_report int;
begin
    select sum(sales),sum(profit)into sumofsales,sumofprofit from sales
	where produt_id = new.product_id;

	select count(*) into count_report from report_table where  produt_id = new.product_id;

		if count_report = 0 then
		insert into report_table values (new.product_id,sumofsales,sumofprofit);
   else
	   update report_table set sum_of_sales = sumofsales,sum_of_profit = sumofprofit
	   where produt_id = new.product_id;
	   end if;
return new;
end;
$$ language plpgsql

select * from sales 
	
create trigger update_report_trigger
after insert on sales
for each row
execute function update_product_report()

select sum(sales),sum(profit) from sales where product_id ='TEC-PH-10004093'

--846.216,95.1993

insert into sales (order_line,order_id,order_date,ship_date,ship_mode,customer_id,product_id,sales,quantity,discount,profit)
values(9998,'CA-2016-152156','2024-08-17','2024-09-17','Second class','CG-12520','OFF-PA-10002365',150,2,2,20);	
alter table sales alter column order_id type varchar

select * from report_table