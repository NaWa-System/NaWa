# Q1 2024 Sales Performance Report

**Organisation:** MediPath Pharmacy Group  
**Reporting Period:** January 1, 2024 – March 31, 2024  
**Report Type:** Sales Performance  
**Prepared by:** Business Intelligence & Analytics Team  
**Date of Issue:** April 2024

---

## Executive Summary

MediPath Pharmacy Group recorded a positive first quarter in 2024, with retail transaction volume and gross revenue tracking ahead of internal expectations across most store locations. Prescription dispensing continued to be the primary revenue driver, accounting for the largest share of total sales, while the over-the-counter (OTC) and supplement categories demonstrated meaningful complementary contribution, particularly in the Northwest region stores.

The Portland Main location delivered the strongest individual revenue performance, driven largely by specialty compounding sales and insulin-related dispensing, both of which command higher per-transaction values. The Spokane location showed encouraging growth momentum, particularly in cardiovascular prescription volume during February and March.

Loyalty programme members accounted for a disproportionate share of repeat transaction activity, reinforcing the strategic value of the programme in sustaining recurring prescription refill revenue. Non-loyalty customers tended to skew toward single-visit OTC purchases, suggesting an opportunity to convert high-frequency OTC shoppers into registered loyalty members.

Margin performance was broadly healthy across the prescription category, where formulary medications carried reliable volume-driven margins. The specialty compounding segment delivered the highest gross margin per unit. Discount activity remained modest and targeted, with no evidence of systemic margin erosion.

Looking ahead to Q2 2024, management should monitor allergy season demand patterns in OTC cold and allergy products, ensure compounding inventory readiness in high-performing locations, and continue evaluating opportunities to deepen GP clinic referral pipelines.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Transactions | 35 | Across 6 store locations, January–March 2024 |
| Prescription Revenue Share | ~58% | Dominant category by revenue type |
| Top Revenue Store | Portland Main | Led by compounding and insulin dispensing |
| Average Transaction Value | $26.52 | Blended across all transaction types |
| Loyalty Member Transaction Share | ~67% | Two-thirds of transactions from registered members |
| Top-Selling Product | Insulin Glargine 10ml | Highest per-unit revenue at $89.99 |
| Compounding Gross Margin | ~72% | Highest margin category in the portfolio |
| Total Discounts Applied | $17.50 | Minimal; no systemic margin erosion |
| Insurance Payment Share | ~54% | Reflecting prescription-heavy revenue mix |
| Monthly Revenue Trend | Increasing | Positive month-on-month trajectory Jan–Mar |

---

## Section 1: Revenue by Transaction Type

Prescription transactions constituted the largest share of revenue for Q1 2024, consistent with MediPath's core dispensing model. OTC transactions were the second largest category, with supplement sales contributing a smaller but growing proportion, particularly from stores in the Northwest region. The distinction between transaction types is critical for margin analysis, as prescription dispensing fees and branded formulary pricing differ structurally from retail OTC pricing. Across all stores, insurance-settled prescription transactions drove the bulk of the prescription revenue stream.

**Data fields:** transactions.transaction_type, transactions.total_amount, transactions.transaction_date, transactions.store_id

---

## Section 2: Store-Level Sales Performance

MediPath Portland Main emerged as the highest-revenue location in Q1 2024, underpinned by repeat dispensing of specialty compounding products and insulin therapy management. MediPath Seattle Central and MediPath Bellevue also performed strongly, benefiting from their higher customer registration base and more established loyalty membership density. MediPath Eugene and MediPath Spokane showed positive but comparatively lower absolute revenue figures, though their month-on-month growth trajectory through February and March was encouraging. Regional analysis places the Northwest region stores collectively ahead of Southwest and Eastern region stores.

**Data fields:** transactions.store_id, transactions.total_amount, transactions.transaction_date, stores.store_name, stores.region, stores.city

---

## Section 3: Product Category Revenue Contribution

Cardiovascular medications and diabetes care products jointly accounted for the majority of prescription item revenue. Within non-prescription categories, cold and allergy OTC products showed consistent sell-through. Vitamins and supplements represented the fastest-growing non-prescription sub-category. Specialty compounding, while limited in transaction frequency, contributed outsized per-unit margin relative to all other categories.

**Data fields:** transaction_items.product_id, transaction_items.unit_price, transaction_items.quantity, transaction_items.unit_cost, products.product_name, products.category_id, product_categories.category_name, product_categories.category_type

---

## Section 4: Gross Margin Analysis

Gross margin was calculated per transaction item as the difference between unit price and unit cost, net of any discount applied. Specialty compounding delivered the highest gross margin rate, exceeding 70%. Vitamins and supplements followed at approximately 65–70%. Prescription medications ranged between 55–70% depending on the product. OTC pain and fever products carried thinner margins. Discounting was modest, totalling $17.50 across the quarter, and did not materially impact overall margin performance.

**Data fields:** transaction_items.unit_price, transaction_items.unit_cost, transaction_items.discount_amount, transaction_items.quantity, products.product_name, product_categories.category_name

---

## Section 5: Loyalty Member vs. Non-Member Revenue

Customers registered in the MediPath loyalty programme accounted for approximately 67% of all Q1 transactions. Loyalty members exhibited higher average transaction frequency across multiple months in the quarter. Non-loyalty customers tended toward single OTC transactions, typically lower in value. This purchasing pattern validates the loyalty programme's role in sustaining recurring prescription revenue and suggests that targeted enrolment campaigns could yield meaningful revenue uplift.

**Data fields:** customers.loyalty_member, customers.customer_id, transactions.customer_id, transactions.total_amount, transactions.transaction_date

---

## Section 6: Payment Method Distribution

Insurance was the most common payment method, accounting for approximately 54% of all transactions, reflecting the prescription-dominant revenue mix. Credit card payments represented the second largest method, primarily associated with OTC and supplement purchases. Cash transactions were the least frequent. No payment disputes or refund transactions were recorded during the period. The high insurance payment concentration introduces a dependency on third-party payer relationships that warrants ongoing contract management attention.

**Data fields:** transactions.payment_method, transactions.total_amount, transactions.transaction_type, transactions.store_id

---

## Section 7: Monthly Revenue Trend

Revenue volume increased progressively from January through March 2024. January recorded the fewest transactions but included high-value insulin and compounding dispensing events. February saw broader activity across more store locations. March demonstrated the highest transaction count, reflecting the seasonal normalisation of prescription refill cycles and early allergy season OTC demand. The upward monthly trajectory is a positive indicator heading into Q2.

**Data fields:** transactions.transaction_date, transactions.total_amount, transactions.transaction_type, transactions.store_id

---

## Appendix

### Assumptions
- All transaction records are treated as completed and settled; no voids or refunds exist in this dataset.
- Unit prices in transaction_items reflect the actual charged price at point of sale.
- Loyalty membership status is based on the customers table as of the reporting date.
- Regional groupings are derived from the stores table.

### Known Limitations
- The dataset represents a sample and may not reflect full chain transaction volume; totals should be interpreted illustratively.
- Insurance reimbursement rates and co-payment splits are not modelled; total_amount reflects gross billed amount.
- Refund, void, or adjustment transactions are not included.
- GP referral source data is not captured in the current schema.

### Recommended Next Analysis
- Develop a prescription refill rate analysis by customer and product to identify adherence patterns and churn risk.
- Model insurance vs. out-of-pocket revenue split once reimbursement rate data is integrated.
- Conduct a seasonal demand forecast for Q2 2024 focusing on allergy and cold OTC categories.
- Evaluate loyalty programme enrolment conversion rates among non-member OTC customers.
