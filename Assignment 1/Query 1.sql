with Q1 as
(
select cust, min(quant) min_q, max(quant) max_q, avg(quant) avg_q
from sales
	group by cust
),
Q2 as
(
select Q1.cust,Q1.min_q,s.prod,s.month,s.day,s.year,s.state,Q1.max_q,Q1.avg_q
	from Q1, sales s
	where Q1.cust = s.cust
	and Q1.min_q = s.quant
)
select Q2.cust,Q2.min_q,Q2.prod,Q2.month,Q2.day,Q2.year,Q2.state,Q2.max_q,s.prod,s.month,s.day,s.year,s.state,Q2.avg_q
	from Q2, sales s
	where Q2.cust = s.cust
	and Q2.max_q = s.quant
