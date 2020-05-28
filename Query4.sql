with t1 as
(select cust, prod,sum(quant),avg(quant),count(quant)
from sales
group by prod,cust),

t2 as
(select cust, prod, avg(quant) Q1
from sales
where month in (1,2,3)
group by cust,prod),

t3 as
(select cust, prod, avg(quant) Q2
from sales
where month in (4,5,6)
group by cust,prod),

t4 as
(select cust, prod, avg(quant) Q3
from sales
where month in (7,8,9)
group by cust,prod),

t5 as
(select cust, prod, avg(quant) Q4
from sales
where month in (10,11,12)
group by cust,prod)

select t1.cust,t1.prod,t2.Q1,t3.Q2,t4.Q3,t5.Q4,t1.avg,t1.sum as total,t1.count 
from t1 left join t2 on t2.cust=t1.cust and t2.prod=t1.prod
left join t3 on t3.cust=t1.cust and t3.prod=t1.prod
left join t4 on t4.cust=t1.cust and t4.prod=t1.prod
left join t5 on t5.cust=t1.cust and t5.prod=t1.prod