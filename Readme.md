# Advanced SQL - Data Analysis Project

## Overview
Analysis of change over time, cumulative analysis, performance analysis, part to whole analysis, data segmentation for a company to improve customer retention and maximize revenue etc. and then creating views for customers and products (as customer report and product report)

## Business Questions
1. **Changes Over Time Analysis:** How have total sales, customer count, and quantity sold evolved monthly over times?
2. **Cumulative Analysis:** How do total monthly sales accumulate over time, and how does the average sales price per unit evolve monthly?
3. **Performance Analysis:** How did the sales of various products perform year-over-year relative to their average sales?
4. **Part to whole Analysis:** Which categories dominate the overall sales?
5. **Data Segmentation:** Which customer segment is the largest and which is the smallest?

## Analysis

### 1. Changes Over Time Analysis

**🖥️ Query**: [1_Changes_Over_Time_Analysis.sql](/sql%20file/Data_Analytics_project/1_Changes_Over_Time_Analysis.sql)

- Categorized customers based on total lifetime value (LTV)
- Assigned customers to High, Mid, and Low-value segments
- Calculated key metrics like total revenue

**📈 Visualization:**

![1_Changes_Over_Time_Analysis](/Project%20charts/1__Change%20over%20time%20analysis.png)

📊 **Key Findings:**
- There is a clear upward trend in total sales, customers, and quantity from late 2010 through 2013, indicating business growth.
- Significant spikes in total sales and customers occur in early 2013, with peak values observed in the latter part of 2013.
- The number of customers and quantity sold generally move in tandem with sales, suggesting consistent purchase behavior.
- January 2014 shows a sharp drop in total sales despite a relatively high number of customers and quantity, hinting at either lower purchase values per customer or possible seasonality effects.
- The steady increase in customers and quantity signals successful customer acquisition and engagement during this period.

### 2. Cumulative Analysis
**🖥️ Query**: [2_Cumulative_Analysis.sql](/sql%20file/Data_Analytics_project/2_Cumulative_Analysis.sql)

- Tracked revenue and customer count per cohorts
- Cohorts were grouped by year of first purchase
- Analyzed customer revenue at a cohort level


📊 **Key Findings:**
- **Running Total Trends:**
  - The `running_total` resets monthly here (likely calculated per month independently), indicating this metric may represent monthly totals rather than a cumulative one.
  - Total monthly sales increased steadily from 2010 to 2013, peaking in late 2013 before dropping significantly in January 2014.

- **Moving Average Price Patterns:**
  - From 2010 to early 2012, the moving average price per unit remained relatively high (~3,000).
  - A significant **price drop** is observed starting from January 2012, with average prices continuing to decline until early 2013.
  - From January 2013 onwards, the **average price falls drastically**, hitting low values around ~200–300, indicating a change in pricing strategy or a shift in product mix (e.g., more low-priced items sold).

- **Anomaly:**
  - January 2014 shows an extremely low average price (`23.17`), suggesting a large volume of very low-cost items or a data anomaly.



### 3. Performance Analysis
🖥️ Query: [3_Performance_Analysis.sql](/sql%20file/Data_Analytics_project/3_Performance_Analysis.sql)

**📈 Visualization:**

![Performance Analysis - Current v/s Average Sales](/Project%20charts/3_Curent%20vs%20avg%20sales_analysis.png)

![Performance Analysis - YoY Analysis](/Project%20charts/3_YoY_analysis.png)



📊 **Key Findings:**  
1. Performance Based on Average Sales

The product sales were evaluated against average performance benchmarks:

- 🔻 **Below Average Sales**:  
  **137 products** fell below the average sales threshold, indicating a significant portion of the portfolio is underperforming.

- 🔺 **Above Average Sales**:  
  **104 products** exceeded average sales, showing strong performance in several product lines.

- ⚖️ **Average Sales**:  
  Only **30 products** sold at levels close to the average, suggesting a polarized trend in sales — most products are either outperforming or underperforming, with very few performing at an average level.

2. Performance Compared to Previous Year

Sales were also compared against the previous year's performance to assess growth trends:

- ➖ **No Change**:  
  **130 products** showed no change in sales compared to the prior year, indicating a stable performance for the majority of the portfolio.

- 📈 **Increase in Sales**:  
  **96 products** recorded a year-over-year sales increase, highlighting positive momentum in the business.

- 📉 **Decrease in Sales**:  
  **45 products** experienced a decline in sales compared to the previous year.

### 4. Part to whole Analysis

**🖥️ Query**: [4_Part_to_whole_Analysis.sql](/sql%20file/Data_Analytics_project/4_Part_to_whole%20Analysis.sql)

**📈 Visualization:**

![Part to whole Analysis](/Project%20charts/4_Pat_to_whole_anlaysis.png)

📊 **Key Findings:**
- The **Bikes** category overwhelmingly dominates sales, accounting for **96.46%** of total sales.
- **Accessories** contribute a small but notable **2.39%** of overall sales.
- **Clothing** makes up the smallest portion, with only **1.16%** of total sales.
- This distribution indicates that the business's revenue heavily relies on bike sales, with accessories and clothing playing much smaller roles.
- Such insights can guide inventory, marketing, and resource allocation to maximize profitability by focusing more on the highest performing category.



### 5. Data Segmentation

**🖥️ Query**: [5_Data_Segmentation.sql](/sql%20file/Data_Analytics_project/5_Data_Segmentation.sql)

**📈 Visualization:**

![Data Segmentation](/Project%20charts/5_Data_segmentation.png)

📊 **Key Findings:**
- The **New** customer segment is by far the largest, with **14,631** customers.
- The **Regular** segment has a moderate size, consisting of **2,198** customers.
- The **VIP** segment is the smallest, with only **1,655** customers.
- This distribution suggests the business is acquiring many new customers but has fewer returning (Regular) and loyal (VIP) customers.
- Strategies could focus on increasing retention to grow the Regular and VIP segments and convert more New customers into loyal buyers.



## Strategic Recommendations

## 1. Changes Over Time Analysis
- Leverage the clear growth trend by investing more in marketing campaigns during periods showing spikes, such as early and late 2013.
- Investigate the drop in sales in January 2014 to identify and mitigate seasonality or pricing issues.
- Focus on strategies that sustain customer acquisition and engagement since customer count and quantity sold are increasing steadily.
- Consider promotional activities or loyalty programs during low-sales periods to stabilize revenue flow.

## 2. Cumulative Analysis
- Use cohort analysis to tailor marketing and retention strategies specific to the year of customer acquisition.
- Address the sharp decline in average sales price from 2012 to 2013 by reviewing pricing strategy or product mix.
- Monitor anomalies like the January 2014 dip to detect data quality issues or sudden market changes.
- Develop pricing models or product bundling that optimize average sales price without sacrificing volume.

## 3. Performance Analysis
- Focus inventory and marketing efforts on products showing strong second-year growth, optimizing lifecycle management.
- Investigate causes of third-year sales decline to improve product longevity or plan timely product refreshes.
- Use year-over-year sales performance insights to forecast demand and adjust procurement.
- Highlight high-performing products during peak years for targeted promotions.

## 4. Part to Whole Analysis
- Prioritize inventory and marketing budget allocation toward the Bikes category, given its dominance in sales.
- Explore opportunities to grow Accessories and Clothing segments to diversify revenue streams.
- Monitor category sales trends continuously to identify shifts in consumer preferences.
- Use insights to optimize product mix, pricing strategies, and promotional efforts.

## 5. Data Segmentation
- Develop targeted retention strategies aimed at converting New customers into Regular and VIP segments.
- Increase loyalty program benefits and personalized marketing for Regular and VIP segments to enhance customer lifetime value.
- Identify characteristics of VIP customers to attract more high-value buyers.
- Regularly monitor segment sizes to measure success of retention and acquisition campaigns.

### Tools and Environment
- **Database:** SQL Server, PostgreSQL, MySQL, or equivalent relational database supporting advanced window functions and CTEs.
- **SQL Client:** Tools like DBeaver, pgAdmin, SQL Server Management Studio, or command-line clients.
- **Visualization:** Exported query results to BI tools such as Power BI, or Excel for graphical presentation.
- **Version Control:** SQL scripts and visualization images organized in a project directory with version control (e.g., Git).

