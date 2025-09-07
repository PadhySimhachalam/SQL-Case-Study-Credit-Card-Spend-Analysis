Credit Card Spend Analysis with SQL
----------------------------------------

 Project Overview
 --------------------------
A comprehensive SQL-based analytics project built to explore **credit card transactions data** and uncover key business insights.  

This project focuses on analyzing spending behavior across cities, card types, genders, and expense categories by leveraging SQL Server queries with advanced analytical functions.


Tech Stack
--------------
- SQL Server – Storage and analytical querying  
- SQL– Querying, aggregations, and window functions  


Data Source
-----------------------------
Source: `credit_card_transactions.csv`  

- Transaction details → Transaction ID, Date, City, Card Type, Expense Type, Gender , Amount
 


 Goal of the Project
 ----------------------------
- Track spending patterns across cities, card types, and categories 
- Identify top cities by credit crad spends
- Measure female contribution to spends 


Key Analysis
-----------------------

# Top 5 Cities by Spend & % Contribution 

Identifies the cities contributing the most to overall spends.  

# Highest Spend Month per Card Type  

Finds peak-spend months for each credit card type.  

# First Transaction Where Spend Crosses ₹10,00,000 per Card Type  

Highlights milestone transactions by card type.  

# City with Lowest Gold Card Spend %  
Finds the city where Gold cards had the lowest contribution to overall spends.  

# Highest vs Lowest Expense Type per City  
Identifies dominant and least-used expense categories in each city.  

# Female Contribution by Expense Type  
Calculates % of spending contributed by female customers in each expense category.  

# Highest Month-over-Month Growth (Jan 2014)  
Finds which card + expense type combination saw the highest MoM growth.  

# Weekend Spending Ratio  
Analyzes which city had the highest **total spend / number of transactions** ratio on weekends.  

# Fastest City to Reach 500 Transactions  
Determines which city reached 500 transactions the quickest since its first transaction.  


 Insights
 ----------
- **City Leaders** → Spending is concentrated in a handful of top cities.  
- **Seasonal Trends** → Certain card types dominate in specific months.  
- **Gold Card Weak Spots** → Some cities show very low gold card penetration.  
- **Gender Insights** → Female customers contribute significantly in select expense categories.  
- **Weekend Behavior** → Some cities exhibit higher spending intensity over weekends.  
- **Growth Opportunities** → Categories with consistent MoM growth are potential business drivers.  


