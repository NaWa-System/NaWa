# Q1 2024 Sales Performance Report

**Organisation:** Harvest Ridge Supply Co.
**Reporting Period:** January 1, 2024 – March 31, 2024
**Report Type:** Sales Performance
**Prepared By:** Business Analytics Team
**Date Issued:** April 5, 2024

---

## Executive Summary

Harvest Ridge Supply Co. recorded a strong first quarter of 2024, driven by robust demand in the Crop Inputs category as the spring planting season approached. Sales activity accelerated meaningfully in March as commercial farm accounts increased order volumes for corn and soybean seed, fertilizers, and crop protection chemicals. Revenue grew month-over-month across all three months of the quarter, with March representing the highest sales month, consistent with historical pre-season purchasing patterns.

Commercial Farm customers continued to be the highest-value segment, accounting for the majority of revenue in Q1. Repeat orders from established accounts such as Brandt Family Farms, Greenfield Grain Inc., and Ridgeway Cattle Co. formed a stable base of transactional activity. The online channel demonstrated meaningful growth, particularly from out-of-state customers in Oklahoma and Nebraska, indicating early success in Harvest Ridge's regional e-commerce expansion.

Gross margin performance was solid across product categories, with Seeds and Crop Protection delivering the highest per-unit margins. Livestock Feed, while generating strong unit volume, operated at thinner margins due to competitive pricing pressures in that category.

Looking ahead, the business is well-positioned to capitalize on peak spring demand in April and May. Management should monitor stock levels for high-velocity items and continue investing in online channel development and targeted outreach to Commercial Farm accounts.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Gross Revenue (Q1 2024) | $128,640 | Aggregated from all completed order line items across January–March 2024. |
| Total Gross Profit (Q1 2024) | $51,490 | Total revenue minus total cost of goods sold across all order items. |
| Overall Gross Margin | 40.0% | Seeds and Crop Protection drive margin above the portfolio average. |
| Total Orders Processed | 22 | All orders completed; no cancellations or returns in the period. |
| Average Order Value | $5,847 | Elevated by large commercial farm orders. |
| Top Revenue Channel | In-Store (~58% of orders) | In-store is dominant but online is growing in share. |
| Top Product Category by Revenue | Seeds & Seed Treatments | Corn and soybean seed drove the highest category-level revenue. |
| Top Customer by Revenue | Brandt Family Farms | Placed three orders in Q1, including large seed and fertilizer purchases. |
| New Customers Acquired | 2 | Terry Vogel (January) and Marcus Lee (February). |
| Online Channel Share | ~42% | Online orders include customers from KS, OK, and NE. |

---

## Report Sections

### 1. Monthly Revenue Trend

Revenue showed a clear upward trajectory across Q1 2024. January established a moderate baseline as early-season orders were placed by established commercial accounts. February saw moderate growth with increased activity in Livestock and Crop Protection. March delivered the strongest month, as pre-planting seed and fertilizer purchases surged from commercial farm customers. This pattern aligns with typical Central Plains agricultural seasonality.

**Data fields:** orders.order_date, order_items.quantity, order_items.unit_price, orders.order_id

---

### 2. Revenue by Product Category

Seeds & Seed Treatments was the highest-revenue category, driven by bulk purchases of Corn Seed Hybrid H200 and Soybean Seed XR7. Fertilizers ranked second. Crop Protection posted notable revenue from Glyphosate Herbicide. Livestock Feed generated the highest unit volume but contributed lower gross profit due to thinner margins. Farm Equipment Accessories and Irrigation contributed a smaller but consistent share of revenue.

**Data fields:** categories.category_name, products.product_id, order_items.quantity, order_items.unit_price, order_items.unit_cost

---

### 3. Sales by Customer Type

Commercial Farm accounts generated the largest share of Q1 revenue. Rancher customers contributed moderate order values focused on livestock and equipment products. Hobby Farmers placed a higher number of smaller orders. The customer mix confirms that retention and deepening of Commercial Farm relationships should remain the top sales priority.

**Data fields:** customers.customer_type, customers.customer_id, orders.order_id, order_items.unit_price, order_items.quantity

---

### 4. Channel Performance: In-Store vs. Online

In-store sales accounted for the majority of Q1 orders by count. The online channel demonstrated consistent activity across all three months, capturing orders from Oklahoma and Nebraska. Online orders tended to concentrate in Livestock Feed, Crop Protection, and Irrigation categories. The growing online channel represents a strategic opportunity to expand regional market share.

**Data fields:** orders.channel, orders.order_date, orders.order_id, customers.state, order_items.unit_price, order_items.quantity

---

### 5. Top 5 Products by Revenue

Corn Seed Hybrid H200 ranked as the single highest-revenue product in Q1 2024. Soybean Seed XR7 ranked second. Premium Cattle Feed ranked third by total revenue on consistent high-volume repeat orders. Urea Fertilizer 46-0-0 followed, with steady demand throughout the quarter. Glyphosate Herbicide 2.5gal rounded out the top five. These five products collectively represent the core of Harvest Ridge's revenue base.

**Data fields:** products.product_name, products.product_id, order_items.quantity, order_items.unit_price, categories.category_name

---

### 6. Gross Margin by Category

Seeds & Seed Treatments and Crop Protection delivered the highest margin percentages, both exceeding 40%. Farm Equipment Accessories also performed well on a per-unit basis. Fertilizers maintained a solid mid-to-high-thirties percent margin. Livestock Feed operated at a tighter margin due to commoditized pricing. This margin profile demonstrates a well-balanced category mix.

**Data fields:** categories.category_name, order_items.unit_price, order_items.unit_cost, products.category_id

---

### 7. Customer Retention and Repeat Order Activity

Brandt Family Farms placed orders in January, February, and March — the most active customer by frequency. Greenfield Grain Inc. and Ridgeway Cattle Co. each placed two orders. Prairie Wind Organics placed two online orders. Two new customers were onboarded in Q1. Repeat activity among commercial accounts indicates strong loyalty and provides a stable revenue foundation.

**Data fields:** customers.customer_name, customers.customer_type, customers.created_date, orders.customer_id, orders.order_date

---

## Appendix

### Assumptions
- All completed orders are included in revenue calculations; no returns or credits were recorded.
- Revenue is calculated as quantity × unit_price from order_items.
- Gross profit is calculated as (unit_price − unit_cost) × quantity per line item.
- Customer type is based on the customer_type field recorded at account creation.
- Reporting period: January 1 – March 31, 2024.

### Known Limitations
- No returns, refunds, or credit notes are captured; net revenue may be marginally overstated.
- Promotional pricing or volume discounts are not reflected in the schema.
- No marketing attribution data is available for online orders.
- Customer lifetime value analysis is limited by the transaction history available.

### Recommended Next Analysis
- Q2 sales forecast model using Q1 patterns and seasonal trends.
- Customer segmentation analysis to identify high-value accounts at risk of churn.
- Online vs. in-store channel conversion and AOV analysis.
- Product margin ranking report to identify pricing or supplier renegotiation opportunities.
- Monthly new customer acquisition tracking with Q2 targets.

---
*Report generated by Harvest Ridge Supply Co. Business Analytics Team. For internal use only.*
