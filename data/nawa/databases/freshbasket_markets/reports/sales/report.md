# Q1 2024 Sales Performance Report

**Organisation:** FreshBasket Markets  
**Reporting Period:** January 1, 2024 – March 31, 2024  
**Prepared by:** Business Intelligence & Reporting Team  
**Classification:** Internal Management Report

---

## Executive Summary

FreshBasket Markets recorded a solid first quarter in 2024, with total revenue across all five store locations trending upward through the period. January established a baseline of transactional activity that was built upon in February and March, with March emerging as the strongest revenue month of the quarter, driven in part by increased basket sizes at the Portland Central and Seattle North flagship stores.

The Meat & Seafood and Fresh Produce categories remained the highest contributors to gross revenue, reflecting customer preference for premium perishables and the enduring appeal of the company's locally sourced offer. Private-label products continued to demonstrate strong unit volume, particularly within Dairy & Eggs and Packaged Goods, underscoring the strategic value of the FreshBasket own-brand range in driving repeat visits and margin improvement.

The Click-and-Collect channel showed consistent engagement throughout the quarter, accounting for approximately 37% of total transaction volume — particularly across suburban locations such as Beaverton and Bellevue. This is consistent with the company's digital growth strategy and highlights an opportunity to invest further in fulfilment capacity at these stores.

Promotion-driven transactions contributed positively to basket value in each month, with the Spring Clean Household Discount and Protein Week promotions in March generating above-average transaction amounts. Gold tier loyalty customers demonstrated the highest average transaction values, reinforcing the importance of loyalty programme investment in retaining the company's most valuable shoppers.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Q1 Revenue | $1,313.30 | Across all 30 transactions, five stores, two channels |
| Total Transactions | 30 | Including loyalty-linked and anonymous purchases |
| Average Transaction Value | $43.78 | Driven higher by Meat & Seafood basket inclusions |
| Click-and-Collect Share | 37% | 11 of 30 transactions via digital channel |
| Total Discounts Applied | $74.00 | Concentrated in February and March promotion periods |
| Top Revenue Store | Portland Central | Highest transaction count and revenue across all months |
| Best-Selling Category | Meat & Seafood | Atlantic Salmon and Chicken Breast top contributors |
| Private-Label Unit Share | ~38% of items | Strong own-brand performance in Dairy and Packaged Goods |
| Gold Tier Avg. Basket | ~$58.24 | Gold customers consistently outspend other tiers |
| Month-on-Month Growth (Jan–Mar) | +14% (est.) | March significantly outperformed January |

---

## Report Sections

### 1. Overall Revenue Trend by Month

Revenue grew progressively across the quarter, with January representing the lowest monthly total and March recording the highest. This upward trajectory was supported by a combination of increased transaction frequency and larger average basket sizes, particularly at Portland Central and Seattle North. The presence of multiple active promotions in March contributed to higher average spend per visit. The trend suggests improving customer confidence and loyalty engagement as the quarter progressed.


**Data Fields:** transactions.transaction_date, transactions.total_amount, transactions.store_id, transactions.channel

---

### 2. Revenue and Volume by Store Location

Portland Central was the top-performing store by both transaction count and total revenue. Seattle North ranked second, with strong performance in March. Suburban stores — Beaverton and Bellevue — showed steady click-and-collect volumes. Eugene recorded the lowest absolute revenue but delivered consistent activity. Oregon stores collectively outperformed Washington stores in transaction volume during Q1.


**Data Fields:** transactions.store_id, transactions.total_amount, stores.store_name, stores.city, stores.region

---

### 3. Sales by Product Category

Meat & Seafood generated the highest combined revenue, driven by Atlantic Salmon Fillet and Chicken Breast. Fresh Produce and Dairy & Eggs ranked second and third. Packaged Goods and Bakery showed consistent unit volumes. Frozen Foods benefited from the winter promotion. Household & Cleaning received a boost from the March Spring Clean promotion.


**Data Fields:** transaction_items.product_id, transaction_items.unit_price, transaction_items.quantity, products.category_id, categories.category_name

---

### 4. Gross Margin Analysis by Product

Gross margin was highest in percentage terms for Packaged Goods and Bakery, where private-label products offered strong cost efficiency. Meat & Seafood operated on tighter margins despite high revenue. Dairy private-label products delivered reliable margin. Private-label items consistently outperformed branded equivalents on gross margin percentage.


**Data Fields:** transaction_items.unit_price, transaction_items.unit_cost, transaction_items.quantity, products.product_name, products.is_private_label

---

### 5. Channel Performance: In-Store vs. Click-and-Collect

In-store transactions accounted for approximately 63% of all Q1 transactions. Click-and-Collect represented 37% but recorded a marginally higher average basket value. Beaverton and Bellevue were primary click-and-collect drivers. Discount application rates were slightly higher on Click-and-Collect orders. Growing this channel remains a strategic priority.


**Data Fields:** transactions.channel, transactions.total_amount, transactions.discount_applied, stores.store_type

---

### 6. Loyalty Customer Behaviour

Loyalty-linked transactions accounted for 27 of 30 Q1 transactions. Gold tier customers generated the highest individual transaction totals. Silver tier customers showed consistent repeat visit patterns. Bronze tier customers made smaller, targeted purchases. Three anonymous transactions represent a gap in loyalty capture requiring attention.


**Data Fields:** transactions.customer_id, transactions.total_amount, customers.loyalty_tier, customers.first_name, customers.last_name

---

### 7. Promotional Impact on Sales

Five promotions were active during Q1 2024. Total discounts applied reached $74.00. The March promotions — Protein Week and Spring Clean — aligned with the quarter's highest-revenue period. The Valentines Bakery Special drove incremental Bakery sales in February. Monitoring discount-to-revenue ratios will be important going forward.


**Data Fields:** transactions.discount_applied, promotions.promotion_name, promotions.start_date, promotions.end_date, promotions.discount_percent

---

## Appendix & Notes

### Assumptions
- Revenue figures are based on transactions.total_amount and treated as net of returns not captured in this dataset.
- Gross margin calculations are derived from unit_price minus unit_cost and exclude operating overheads.
- All 30 transactions are treated as representative for analytical purposes.
- Channel classifications are taken directly from transactions.channel field.
- Loyalty tier classifications reflect customer records at time of data extraction.

### Known Limitations
- Dataset contains 30 transactions; a full operational dataset would contain thousands of daily records.
- Three anonymous transactions limit full loyalty programme coverage analysis.
- Promotional attribution relies on date overlap; no direct promotion flag exists on transactions.
- Inventory data is a point-in-time end-of-quarter snapshot only.
- No return or refund data is included.

### Recommended Next Analysis
- Year-over-year Q1 comparison once Q1 2023 data is available.
- Customer lifetime value model by loyalty tier.
- Promotion ROI analysis: margin uplift vs. discount cost per promotion.
- Click-and-Collect adoption forecast model for suburban stores.
- Anonymous transaction capture rate review by store.

---

*Report generated by FreshBasket Markets BI Team | Q1 2024 | Confidential — Internal Use Only*
