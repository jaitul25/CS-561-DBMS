with 
months as 
(select generate_series as month 
 from generate_series(1, 12)),

aggsale as
(select month, day, sum(quant) 
 from months left join sales using (month) 
 group by month, day), 
 
mostpop as 
(select distinct on (month) month, day, sum 
 from aggsale 
 order by month, sum desc), 
 
leastpop as 
(select distinct on (month) month, day, sum 
 from aggsale 
 order by month, sum asc)

select mostpop.month, mostpop.day as most_profit_day, mostpop.sum as most_profit_total, leastpop.day as least_profit_day, leastpop.sum as least_profit_total 
from mostpop join leastpop using (month)
