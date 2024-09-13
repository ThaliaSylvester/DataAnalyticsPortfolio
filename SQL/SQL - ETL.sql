------------------------------Question Two-------------------------------
-----CREATING THE CUSTOMER DATAWEREHOUSE
create table customer_dw
(
data_source varchar(5),
customer_id number,
customer_first_name varchar(50),
customer_last_name varchar(50),
customer_address varchar(50),
customer_city varchar(50),
customer_state varchar(2),
customer_zip varchar(10),
customer_phone varchar(30),
constraint pk_id_source primary key (data_source, customer_id)
);
-------------------------------Question Three-----------------------------
--
-----CREATING THE EX_CUSTOMERS_VIEW
create or replace view ex_customers_view
as
select 'EX' as data_source,
customer_id, customer_first_name as customer_firstname,
customer_last_name as customer_lastname,
customer_address, customer_city,
customer_state, customer_zip,
substr(customer_phone,2,3) ||'-'|| substr(customer_phone,7,12) as
customer_phone
from customer_ex;
-----CREATING THE OM_CUSTOMERS_VIEW
create or replace view om_customer_view
as
select 'OM' as data_source,
customer_id, customer_first_name as customer_firstname,
customer_last_name as customer_lastname,
customer_address, customer_city,
customer_state, customer_zip,
substr(customer_phone,1,3) ||'-'|| substr(customer_phone,4,3) ||'-'||
substr(customer_phone,7,4) as customer_phone
from customer_om;
-----CREATING THE MGS_CUSTOMERS_VIEW
create or replace view mgs_customer_view
as
select
'MGS' as data_source,
mgs.customer_id,
mgs.first_name as customer_firstname,
mgs.last_name as customer_lastname,
nvl2(a.line2, a.line1 || ', ' || a.line2, a.line1) as
customer_address,
a. state as customer_state,
a. city as customer_city,
a. zip_code as customer_zip,
a. phone as customer_phone
from customer_mgs mgs
inner join address_mgs a on mgs.shipping_address_id = a.address_id;
-------------------------------Question Four------------------------------
-
---- INSERTING EX_CUSTOMERS_VIEW TO CUSTOMER_DB
insert into customer_dw
select exv.data_source, exv.customer_id,
exv.customer_firstname as first_name, exv.customer_lastname as
last_name,
exv.customer_address as address, exv.customer_city as city,
exv.customer_state as state, exv.customer_zip,
exv.customer_phone as phone
from ex_customers_view exv left join customer_dw dw
on exv.customer_id = dw.customer_id
and exv.data_source = dw.data_source
where dw.customer_id is null;
---- INSERTING OM_CUSTOMERS_VIEW TO CUSTOMER_DB
insert into customer_dw
select omv.data_source, omv.customer_id, omv.customer_firstname as
first_name, omv.customer_lastname as last_name, omv.customer_address as
address,
omv.customer_city as city, omv.customer_state as state,
omv.customer_zip,
omv.customer_phone as phone
from om_customer_view omv left join customer_dw dw
on omv.customer_id = dw.customer_id
and omv.data_source = dw.data_source
where dw.customer_id is null;
---- INSERTING MGS_CUSTOMERS_VIEW TO CUSTOMER_DB
insert into customer_dw
select mgsv.data_source, mgsv.customer_id, mgsv.customer_firstname as
first_name,
mgsv.customer_lastname as last_name, mgsv.customer_address as address,
mgsv.customer_city as city, mgsv.customer_state as state,
mgsv.customer_zip,
mgsv.customer_phone as phone
from mgs_customer_view mgsv
left join customer_dw dw on mgsv.customer_id = dw.customer_id and
mgsv.data_source = dw.data_source
where dw.customer_id is null;
-------------------------------Question Five------------------------------
-
--- MERGE STATEMNT:EX_CUSTOMERS_VIEW
merge into customer_dw dw
using ex_customers_view exv
on (dw.customer_id = exv.customer_id and dw.data_source = exv.data_source)
when matched then
update set dw.customer_first_name = exv.customer_firstname,
dw.customer_last_name = exv.customer_lastname,
dw.customer_address = exv.customer_address,
dw.customer_city = exv.customer_city,
dw.customer_state = exv.customer_state,
dw.customer_zip = exv.customer_zip,
dw.customer_phone = exv.customer_phone;
--- MERGE STATEMNT:OM_CUSTOMERS_VIEW
merge into customer_dw dw
using om_customer_view omv
on (dw.customer_id = omv.customer_id and dw.data_source = omv.data_source)
when matched then
update set dw.customer_first_name = omv.customer_firstname,
dw.customer_last_name = omv.customer_lastname,
dw.customer_address = omv.customer_address,
dw.customer_city = omv.customer_city,
dw.customer_state = omv.customer_state,
dw.customer_zip = omv.customer_zip,
dw.customer_phone = omv.customer_phone;
--- MERGE STATEMNT:MGS_CUSTOMERS_VIEW
merge into customer_dw dw
using mgs_customer_view mgs
on (dw.customer_id = mgs.customer_id and dw.data_source = mgs.data_source)
when matched then
update set dw.customer_first_name = mgs.customer_firstname,
dw.customer_last_name = mgs.customer_lastname,
dw.customer_address = mgs.customer_address,
dw.customer_city = mgs.customer_city,
dw.customer_state = mgs.customer_state,
dw.customer_zip = mgs.customer_zip,
dw.customer_phone = mgs.customer_phone;
-------------------------------Question Six-------------------------------
-----CREATING THE PROCEDURE customer_etl_proc
create or replace procedure customer_etl_proc is
BEGIN
insert into customer_dw
select exv.data_source, exv.customer_id,
exv.customer_firstname as first_name, exv.customer_lastname as
last_name,
exv.customer_address as address, exv.customer_city as city,
exv.customer_state as state, exv.customer_zip,
exv.customer_phone as phone
from ex_customers_view exv left join customer_dw dw
on exv.customer_id = dw.customer_id
and exv.data_source = dw.data_source
where dw.customer_id is null;
insert into customer_dw
select omv.data_source, omv.customer_id, omv.customer_firstname as
first_name, omv.customer_lastname as last_name, omv.customer_address as
address,
omv.customer_city as city, omv.customer_state as state,
omv.customer_zip,
omv.customer_phone as phone
from om_customer_view omv left join customer_dw dw
on omv.customer_id = dw.customer_id
and omv.data_source = dw.data_source
where dw.customer_id is null;
insert into customer_dw
select mgsv.data_source, mgsv.customer_id, mgsv.customer_firstname as
first_name, mgsv.customer_lastname as last_name,
mgsv.customer_address as address, mgsv.customer_city as city,
mgsv.customer_state as state, mgsv.customer_zip,
mgsv.customer_phone as phone
from mgs_customer_view mgsv left join customer_dw dw
on mgsv.customer_id = dw.customer_id
and mgsv.data_source = dw.data_source
where dw.customer_id is null;
merge into customer_dw dw
using ex_customers_view exv
on (dw.customer_id = exv.customer_id and dw.data_source = 'EX')
when matched then
update set dw.customer_first_name = exv.customer_firstname,
dw.customer_last_name = exv.customer_lastname,
dw.customer_address = exv.customer_address,
dw.customer_city = exv.customer_city,
dw.customer_state = exv.customer_state,
dw.customer_zip = exv.customer_zip,
dw.customer_phone = exv.customer_phone;
merge into customer_dw dw
using om_customer_view omv
on (dw.customer_id = omv.customer_id and dw.data_source = 'OM')
when matched then
update set dw.customer_first_name = omv.customer_firstname,
dw.customer_last_name = omv.customer_lastname,
dw.customer_address = omv.customer_address,
dw.customer_city = omv.customer_city,
dw.customer_state = omv.customer_state,
dw.customer_zip = omv.customer_zip,
dw.customer_phone = omv.customer_phone;
merge into customer_dw dw
using mgs_customer_view mgs
on (dw.customer_id = mgs.customer_id and dw.data_source = 'MGS')
when matched then
update set dw.customer_first_name = mgs.customer_firstname,
dw.customer_last_name = mgs.customer_lastname,
dw.customer_address = mgs.customer_address,
dw.customer_city = mgs.customer_city,
dw.customer_state = mgs.customer_state,
dw.customer_zip = mgs.customer_zip,
dw.customer_phone = mgs.customer_phone;
end ;
/