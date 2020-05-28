with

mix as 
(select cust, prod, max(quant) as max
from sales 
group by cust, prod,state),

nymax as 
(select cust as customer, prod as product, quant as quantity, day as nyday, month as nymonth, year as nyyear 
from sales 
where state='NY'),
 
njmax as 
(select cust as customer, prod as product, quant as quantity, day as njday, month as njmonth, year as njyear 
from sales 
where state='NJ'),

ctmax as 
(select cust as customer, prod as product, quant as quantity, day as ctday, month as ctmonth, year as ctyear 
from sales 
where state='CT'),

ny as (select ny.customer, ny.product, ny.quantity as ny_max, concat(ny.nymonth,'/',ny.nyday,'/',ny.nyyear) as nymax_date from (mix join nymax on mix.cust=nymax.customer and mix.prod=nymax.product and mix.max=nymax.quantity) as ny),
nj as (select nj.customer, nj.product, nj.quantity as nj_max, concat(nj.njmonth,'/',nj.njday,'/',nj.njyear) as njmax_date from (mix join njmax on mix.cust=njmax.customer and mix.prod=njmax.product and mix.max=njmax.quantity) as nj),
ct as (select ct.customer, ct.product, ct.quantity as ct_max, concat(ct.ctmonth,'/',ct.ctday,'/',ct.ctyear) as ctmax_date from (mix join ctmax on mix.cust=ctmax.customer and mix.prod=ctmax.product and mix.max=ctmax.quantity) as ct)

select * 
from ((ny natural full outer join nj) natural full outer join ct)
where ny.ny_max >nj.nj_max or ny.ny_max > ct.ct_max