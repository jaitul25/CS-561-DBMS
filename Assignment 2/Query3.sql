with t1 as
(select distinct prod,month
from sales
order by prod,month),

t2 as
(select t1.prod,t1.month,sum(sales.quant)
from t1
left join sales using (prod,month)
group by t1.prod,t1.month
order by t1.prod,t1.month),


t3 as
(select t2.prod, max(t2.sum), min(t2.sum)
from t2 group by t2.prod),

t4 as
(select t2.prod,t2.month as most_fav_month 
from t3,t2 where t3.max = t2.sum),

t5 as
(select t2.prod,t2.month as least_fav_month 
from t3,t2 where t3.min = t2.sum)

select t4.prod,t4.most_fav_month,t5.least_fav_month
from t4,t5
where t4.prod = t5.prod 
order by prod
