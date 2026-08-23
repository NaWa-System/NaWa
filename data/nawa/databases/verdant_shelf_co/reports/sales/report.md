# Q1 2024 Sales Performance Report
## Product, Channel & Category Analysis

**Organisation:** Verdant Shelf Co.  
**Reporting Period:** January 1, 2024 – March 31, 2024  
**Prepared by:** Business Intelligence Team  
**Date Issued:** April 5, 2024  

---

## Executive Summary

Verdant Shelf Co. delivered a strong first quarter in 2024, recording 20 orders across its online and in-store channels with gross product revenue approaching $1,980 before discounts and the single refund recorded in late March. The quarter demonstrated healthy month-over-month volume growth, with March emerging as the highest-order-count month driven by the spring seasonal uplift and increased returning customer activity.

Tropical Plants and Accessories & Care remained the top-performing categories by revenue contribution, reflecting the core customer preference for statement plants paired with premium care products. The Online channel dominated order volume at approximately 75% of transactions, while in-store orders carried higher average basket values — particularly for large-format Tropical Plant SKUs.

One order was refunded during the period (Order #20, March 30), representing less than 5% of total orders. Discounts were applied selectively across six orders, indicating disciplined promotional activity. The spring season ahead presents a clear growth opportunity, and Verdant Shelf is well positioned to capitalise on increased consumer demand in Q2.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Orders | 20 | Across all channels; volume increased each month |
| Gross Product Revenue | ~$1,980 | Before discounts and the March refund |
| Average Order Value (AOV) | ~$94 | In-store AOV skews higher due to large Tropical Plant purchases |
| Online vs. In-Store Split | 75% / 25% | 15 online, 5 in-store orders |
| Top-Selling Product | Bird of Paradise (Large) | Highest single-unit revenue at $74.99 |
| Total Discounts Applied | $33.00 | Across 6 orders; average $5.50 per discounted order |
| Refund Rate | 5% (1 order) | Not material at current volumes; monitor in Q2 |
| Repeat Customer Orders | 5 returning customers | 33% repeat rate across the quarter |
| Total Shipping Revenue | ~$89.85 | Online orders at $5.99 flat rate |

---

## 1. Monthly Order Volume Trend

Order volume grew consistently across the quarter: January recorded 5 orders, February 6, and March delivered the strongest performance at 9 orders. The March spike aligns with the traditional spring houseplant buying season and coincides with the Spring Potting Party workshop event on March 9, which likely drove both footfall and online discovery.

The upward trend is encouraging and suggests natural seasonal tailwinds as the company enters Q2. Management should ensure inventory adequacy for Tropical Plants and growing kits ahead of April.



---

## 2. Revenue by Product Category

Tropical Plants generated the highest aggregate revenue, driven by high unit prices for the Monstera Deliciosa, Fiddle Leaf Fig, and Bird of Paradise. Accessories & Care performed strongly as a secondary category, with the Ceramic Pot Set and Premium Potting Mix regularly appearing as add-on items — a clear cross-sell pattern. Succulents & Cacti and Ferns & Foliage delivered moderate revenue; Growing Kits showed consistent but modest performance, suggesting bundle promotion potential.



---

## 3. Channel Performance: Online vs. In-Store

The Online channel processed 75% of all orders but in-store orders featured higher-priced items and carried zero shipping cost, improving net margin per transaction. In-store also serves as a physical gateway to workshop events, creating a dual commercial role disproportionate to its raw order count. The company should consider strategies to convert in-store browsers into online repeat purchasers via subscription upsell programmes.



---

## 4. Top Products by Units Sold and Revenue

The Monstera Deliciosa (Medium) was the most frequently ordered individual product, appearing in three orders. The Ceramic Pot Set ranked highly by units, reflecting strong accessory attach rates. The Bird of Paradise contributed the highest per-unit revenue. The Barrel Cactus was ordered in a quantity of 3 in a single transaction, suggesting gift or bulk purchasing behaviour. No products were out of stock during the period; however, high-velocity SKUs should be flagged for Q2 reorder planning.



---

## 5. Discount and Promotions Analysis

Six orders received discounts totalling $33.00 — approximately 1.7% of gross revenue. The largest single discount was $10.00 (Order #4); the average per discounted order was $5.50. Discounting was distributed across both channels with no over-concentration. The low discount rate is positive, indicating that demand is being captured at full price across most transactions. Monitor whether discounting increases during Q2 peak season.



---

## 6. Workshop Event Revenue

Five workshops were held in Q1 2024, collectively selling 96 of 110 available tickets (87% capacity utilisation). Total event revenue reached approximately $3,155. The Succulent Arrangement Masterclass (Feb 24) sold out completely at $45.00/ticket. The Spring Potting Party (Mar 9) drew the largest attendance at 27 of 30 seats. The Propagation Workshop (Mar 23) was the weakest performer at 14 of 20 seats. Events generate both direct ticket revenue and in-store purchase conversion.



---

## 7. Customer Acquisition and Repeat Purchase Behaviour

Fifteen unique customers transacted in Q1 2024, with five placing more than one order — a repeat rate of approximately 33%. The majority of new customer acquisitions occurred through the Online channel (10 of 15). Geographic spread is widening beyond Austin and Houston to include Denver, Portland, New Orleans, and Dallas, indicating growing organic national reach.



---

## Appendix

### Assumptions
- Gross product revenue excludes the refunded Order #20 and is calculated on completed orders only.
- In-store shipping cost is $0.00 for all in-store orders per channel assignment.
- Event revenue is reported separately from product order revenue.
- Subscription box revenue is covered in the Subscription Performance Report.

### Known Limitations
- Gross margin by order cannot be calculated without joining order_items to products.unit_cost in a dedicated report view.
- Return reason for Order #20 is not captured; root cause analysis is not possible.
- Marketing spend and customer acquisition cost are not tracked in the current schema.
- Q1 2024 only; year-over-year comparison is not available.

### Recommended Next Analysis
- Add a marketing_spend table to enable CAC and ROAS calculations in Q2.
- Introduce a returns table with reason codes for refund root cause tracking.
- Build a product margin report joining order_items to products.unit_cost.
- Develop a CLV model combining one-time order and subscription revenue per customer.
- Quantify event attendee-to-purchaser conversion rate if event attendees can be linked to customer records.
