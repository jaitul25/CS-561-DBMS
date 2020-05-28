with 
t1 as
(select distinct prod product
from sales
order by prod),

t2 as
(select month
from sales 
order by month),

t3 as
(select product,month
from t1 natural full outer join t2
group by product,month
order by product,month),

t4 as 
(select t3.product,t3.month,round(avg(quant),0)
from sales full outer join t3
on t3.product = sales.prod and t3.month = sales.month
group by t3.product,t3.month
order by product,month),

t5 as 
(select prod product, month as after_month, round(avg(quant),0) after_avg 
from sales 
group by prod, month 
order by prod, month),

t6 as 
(select prod product , month as before_month, round(avg(quant),0) before_avg 
from sales 
group by prod, month 
order by prod, month),

t7 as
(select t4.product, month,t6.before_avg,t5.after_avg
from (t4 left outer join t5 on t5.after_month=t4.month+1 and t4.product=t5.product) left outer join t6 on t6.before_month=t4.month-1 and t4.product=t6.product
order by product,month),

t8 as
(select t7.product,t7.month,s.quant
from t7 left outer join sales s
on t7.product = s.prod and t7.month = s.month and (s.quant between before_avg and after_avg or s.quant between after_avg and before_avg)
group by t7.product,t7.month, s.quant)

select t3.product,t3.month ,count(t8.quant) 
from t3 ,t8
where t3.product = t8.product and t3.month = t8.month
group by t3.product,t3.month


