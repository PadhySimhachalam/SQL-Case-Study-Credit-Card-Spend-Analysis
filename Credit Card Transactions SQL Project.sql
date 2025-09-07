select * from credit_card_transcations

--1. Query to print top 5 cities with highest spends and their percentage contribution of total credit card spends.

with total_cc_spends as(
select sum(cast(amount as bigint)) as total_spends
from credit_card_transcations)
,city_cc_spends as(
select top 5 city,sum(amount) as city_spends
from credit_card_transcations
group by city
order by sum(amount) desc)
select c.city,c.city_spends,t.total_spends, cast((c.city_spends*1.0/t.total_spends)*100 as decimal(5,2)) as percent_contribution
from city_cc_spends c cross join total_cc_spends t 

--2- Query to print highest spend month and amount spent in that month for each card type

with month_wise_cc_spent as(
select card_type,DATEPART(year,transaction_date) as trans_year,
DATEPART(month,transaction_date) as trans_month,sum(amount) as amt_spent
from credit_card_transcations
group by card_type,DATEPART(year,transaction_date),DATEPART(month,transaction_date))

select card_type,amt_spent from(
select *,rank() over(partition by card_type order by amt_spent desc) as rn
from month_wise_cc_spent) a
where rn = 1

--3-Query to print the transaction details(all columns from the table) for each card type when
 --it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)


 with  cc_spent as(
 select *,sum(amount) over(partition by card_type order by transaction_date,transaction_id) as cumulative_sum
 from credit_card_transcations)
select * from (
 select *,rank() over(partition by card_type order by cumulative_sum) as rn
 from cc_spent
 where cumulative_sum >= 1000000) a
where rn = 1

--4- Query to find city which had lowest percentage spend for gold card type
select top 1 * from (
select city,sum(amount) as total_card_amt,
sum(case when card_type = 'Gold' then amount end) as gold_spent,
(sum(case when card_type = 'Gold' then amount end) * 1.0)/sum(amount) * 100 as gold_card_percent
from credit_card_transcations
group by city
having sum(case when card_type = 'Gold' then amount end) > 0
) a
order by gold_card_percent

--5- Query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)
with expenses_spent as(
select city,exp_type,sum(amount) as exp_amt
from credit_card_transcations
group by city,exp_type)

,ranking_spents as(
select *,rank() over(partition by city order by exp_amt desc) rn
,rank() over(partition by city order by exp_amt) rn1
from  expenses_spent)

select city
, max(case when rn=1 then exp_type end) as highest_expense_type
, max(case when rn1 =1 then exp_type end) as lowest_expense_type
from ranking_spents
where rn=1 or rn1=1
group by city;

--6--Query to find percentage contribution of spends by females for each expense type

select exp_type,sum(amount) as exp_type_amt,
sum(case when gender = 'F' then amount end) as female_exp_amt,
cast(((sum(case when gender = 'F' then amount end)*1.0)/sum(amount)) * 100 as decimal(5,2)) as Female_Contribution
from credit_card_transcations
group by exp_type
order by Female_Contribution

--7- which card and expense type combination saw highest month over month growth in Jan-2014

with cte1 as(
select card_type,exp_type,DATEPART(year,transaction_date) as year_cc,
DATEPART(month,transaction_date) as month_cc,sum(amount) as total_amt
from credit_card_transcations
group by card_type,exp_type,DATEPART(year,transaction_date),DATEPART(month,transaction_date))

select top 1 *, (total_amt - prev_month_amt) as mom_growth
from(
select *,lag(total_amt,1) over(partition by card_type,exp_type order by year_cc,month_cc) as prev_month_amt
from cte1) a
where year_cc = 2014 and month_cc = 1
order by mom_growth desc

--8- during weekends which city has highest total spend to total no of transcations ratio 
select city,cast(sum(amount)*1.0/count(*) as decimal(8,2)) as ratio
from credit_card_transcations
where DATEPART(weekday,transaction_date) in (1,7)
group by city
order by ratio desc



--9- which city took least number of days to reach its 500th transaction after the first transaction in that city

with cte as (
select *
, row_number() over(partition by city order by transaction_date,transaction_id) as rn
from credit_card_transcations)
select city, min(transaction_date) as first_transaction,max(transaction_date) as last_transaction
, datediff(day,min(transaction_date),max(transaction_date)) as days_to_500
from cte
where rn in (1,500) 
group by city
having count(*)=2
order by days_to_500 asc



