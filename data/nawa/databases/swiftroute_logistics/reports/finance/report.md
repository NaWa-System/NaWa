# Q1 2024 Revenue & Invoice Collections Report

**Organisation:** SwiftRoute Logistics  
**Reporting Period:** January 1 – March 31, 2024  
**Report Type:** Finance  
**Prepared By:** Finance & Billing Team  

---

## Executive Summary

SwiftRoute Logistics generated meaningful freight revenue across all three months of Q1 2024, with invoice totals rising progressively from January through March as shipment volumes increased. January and February invoices have been fully collected, reflecting a healthy payment culture among long-standing retainer and per-shipment clients alike. March invoices, issued at the end of the month with standard 14-day payment terms, show a mixed collections picture: two accounts fully paid, two outstanding, and one partially settled.

Total invoiced revenue across the quarter reached approximately $17,223, combining freight charges and fuel surcharges billed to eight active customers. The March invoice cycle accounts for the largest share of outstanding receivables, driven primarily by Greenfield Manufacturing and BlueSky Apparel — both per-shipment clients without retainer credit structures. These two accounts represent the primary near-term collections risk entering Q2.

Fuel surcharges, calculated as a consistent percentage add-on to base freight charges, contributed reliably across all shipments and regions. Retainer clients demonstrated strong and predictable payment behaviour throughout the quarter, reinforcing the strategic value of the retainer account model for revenue stability and cash flow predictability.

Management is advised to prioritise collections outreach to Greenfield Manufacturing (~$4,103 outstanding) and BlueSky Apparel (~$451 outstanding) as Q2 begins. The partial balance from Harborline Retail Co. should be resolved within the next billing cycle. Overall, the company's revenue trajectory is positive and the Q1 collections performance for January and February is commendable.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Q1 Invoiced Revenue | ~$17,223 | Sum of all invoice totals across January, February, and March billing cycles |
| Total Collected Revenue | ~$13,969 | Sum of paid_amount across all invoices |
| Outstanding Receivables | ~$3,254 | Unpaid and partially paid balances as of March 31, 2024 |
| Collection Rate (Jan–Feb) | 100% | All January and February invoices fully paid within due dates |
| March Collection Rate | ~58% | Three of eight March invoices outstanding or partially paid |
| Largest Outstanding Invoice | ~$4,103 | Greenfield Manufacturing; two large March shipments |
| Total Freight Charges Billed | ~$15,535 | Sum of freight_charge across all 30 Q1 shipments |
| Total Fuel Surcharges Billed | ~$1,553 | ~10% surcharge applied uniformly across all service types |
| Retainer vs. Per-Shipment Split | ~60% / ~40% | Retainer accounts generated majority of invoiced revenue with lower risk |

---

## Section 1: Monthly Invoiced Revenue Overview

Invoice totals grew month over month across Q1 2024. January invoicing totalled approximately $5,027, driven by a broad spread of shipments across all regions. February invoices reached approximately $4,390, with a slight reduction due to fewer high-value Express shipments. March recorded the highest monthly total at approximately $7,806, reflecting the surge in shipment activity in the final weeks of the quarter. This growth trajectory is encouraging, though the concentration of outstanding balances in March introduces short-term cash flow variability.


**Data Fields:** invoices.invoice_date, invoices.total_amount, invoices.paid_amount, invoices.status

---

## Section 2: Invoice Collections & Payment Status

January and February invoices were 100% collected across all billed customers. Of the eight March invoices issued, two were fully paid (Apex Wholesale Distributors and NorthEast Medical Supplies), one is partially settled (Harborline Retail Co., with ~$555 outstanding), and three are fully outstanding: Greenfield Manufacturing (~$4,103), BlueSky Apparel (~$451), and FreshMart Grocery Chain (~$390.50). The two outstanding per-shipment accounts represent the greatest near-term exposure and should be escalated before their April 14 due dates.


**Data Fields:** invoices.status, invoices.total_amount, invoices.paid_amount, invoices.due_date, invoices.customer_id, customers.company_name

---

## Section 3: Revenue by Customer Account

Greenfield Manufacturing was the highest-revenue customer in Q1, driven by large freight volumes on the Mid-Atlantic corridor including multiple Semi-Trailer loads. Apex Wholesale Distributors and Castleton Electronics followed as consistent contributors under their retainer agreements. Harborline Retail Co. generated steady, predictable revenue across all three months. Smaller per-shipment clients such as FreshMart Grocery Chain, BlueSky Apparel, and Pinecrest Home Goods contributed incrementally but show growth potential. NorthEast Medical Supplies remained a reliable mid-tier retainer contributor.


**Data Fields:** invoices.customer_id, invoices.total_amount, customers.company_name, customers.account_type, shipments.freight_charge, shipments.fuel_surcharge

---

## Section 4: Freight Charge vs. Fuel Surcharge Breakdown

Across all 30 Q1 shipments, freight charges constituted approximately 91% of total billed amounts, with fuel surcharges making up the remaining ~9%. The consistent surcharge rate ensures partial recovery of fuel cost exposure across all client types. The Mid-Atlantic region generated the highest absolute fuel surcharge revenue due to the weight and distance of its shipments. Express service shipments in Greater NYC produced the highest per-shipment surcharge values relative to freight charge.


**Data Fields:** shipments.freight_charge, shipments.fuel_surcharge, shipments.region_id, shipments.service_type, regions.region_name

---

## Section 5: Revenue by Service Type

Express shipments generated the highest average freight charge per job, making them the most valuable service tier on a per-shipment basis. Standard shipments drove the largest share of total revenue by count, being the most widely used tier across all customer segments. Same-Day shipments, while limited to short-haul urban routes, yielded moderate freight charges and are a key differentiator in Greater NYC. Service type mix should be actively managed to maximise revenue yield per deployment.


**Data Fields:** shipments.service_type, shipments.freight_charge, shipments.fuel_surcharge, shipments.weight_kg

---

## Section 6: Account Type Performance — Retainer vs. Per-Shipment

Retainer accounts provided predictable invoice cadence and zero payment defaults through Q1. Per-shipment accounts generated higher individual invoice variability and introduced the bulk of outstanding receivables risk. The data reinforces the strategic value of growing the retainer client base. Retainer accounts also tend to produce multi-shipment invoices that smooth revenue recognition across the billing cycle and reduce administrative collections burden.


**Data Fields:** customers.account_type, invoices.total_amount, invoices.paid_amount, invoices.status, customers.customer_id, customers.company_name

---

## Appendix

### Assumptions
- Invoice totals reflect freight charges and fuel surcharges as recorded in the shipments table.
- All January and February invoices with status Paid are assumed settled within their 14-day terms.
- The partial payment on invoice 16 is assumed received in good faith with balance expected within the extended window.
- Outstanding invoices are not yet overdue as of report preparation date given April 14 due dates.
- Fuel surcharge is assumed at approximately 10% of base freight charge uniformly across all shipments.

### Known Limitations
- No payment transactions table exists; payment dates and partial payment histories cannot be reconstructed in granular detail.
- Individually negotiated credit terms for retainer clients are not captured in the schema.
- Operational costs such as driver wages, fuel, and vehicle leasing are not tracked, preventing margin analysis.
- In-transit and delayed March shipments are included in billed invoice amounts and may require adjustment if services remain incomplete.

### Recommended Next Analysis
- Introduce a payment_transactions table to enable aging analysis and DSO calculation.
- Add a cost_records table to capture per-shipment operational costs and enable contribution margin reporting.
- Conduct a receivables aging analysis in April once March due dates pass.
- Model the revenue impact of converting BlueSky Apparel and FreshMart to retainer structures based on Q1 shipment frequency.
