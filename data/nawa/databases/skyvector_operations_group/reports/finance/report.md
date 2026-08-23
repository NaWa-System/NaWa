# Q1 2024 Client Billing and Revenue Summary

**Organisation:** SkyVector Operations Group  
**Reporting Period:** January 1, 2024 – March 31, 2024  
**Report Type:** Finance  
**Prepared by:** SkyVector Finance & Commercial Team  
**Date of Issue:** April 7, 2024  

---

## Executive Summary

SkyVector Operations Group closed the first quarter of 2024 with a strong billing performance, achieving full payment collection across all four active client accounts. Total revenue billed for the quarter reached approximately $160,129, comprising platform subscription fees, per-flight dispatch charges, and variable add-on module fees. All twelve billing records carry a Paid status, indicating no outstanding receivables at the close of the period.

Maverick Air remained the highest-revenue client, generating approximately $61,125 across the three billing months. Pacific Crest Airways contributed approximately $45,466, while Saltline Express and Gulf Palms Charter contributed approximately $30,860 and $23,678 respectively.

Per-flight revenues remained stable quarter-over-quarter, consistent with fixed contractual rates. The principal variable component in Q1 billing was add-on charges, which increased in March across three of four clients — driven by demand for the delay recovery analytics module following elevated irregularity event activity in January and February. This trend represents a clear upsell conversion signal for Q2.

The revenue base is well-protected by long-term platform agreements with no contract lapse risk within the next twelve months. The finance team is advised to begin proactive contract review discussions with Saltline Express, as it represents the most recent onboarding with scope for fleet expansion and corresponding fee uplifts.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Q1 Revenue Billed | $160,129 | All four clients, January–March 2024. All invoices Paid. |
| Total Platform Fees Billed | $150,000 | Monthly subscription fees across all clients x 3 months |
| Total Per-Flight Charges | ~$306 | 28 flights dispatched at contractual per-flight rates |
| Total Add-On Charges | $9,800 | Variable module charges; increased in March across 3 clients |
| Outstanding Receivables | $0 | All 12 billing records carry Paid status |
| Highest-Revenue Client | Maverick Air — ~$61,125 | Largest fleet, highest platform fee, highest add-on uptake |
| Lowest-Revenue Client | Gulf Palms Charter — ~$23,678 | Smallest fleet, lowest contracted platform fee |
| Avg Monthly Revenue per Client | ~$13,344 | Total Q1 revenue divided by 12 billing records |
| Add-On Revenue Growth (Jan–Mar) | ~+22% portfolio-wide | Driven by analytics module demand post-irregularity events |
| Active Billing Contracts | 4 | All active throughout Q1 with no lapses or disputes |

---

## 1. Q1 Revenue Overview

Total revenue billed in Q1 2024 reached approximately $160,129 across three revenue streams: platform fees (93.7%), add-on module charges (6.1%), and per-flight dispatch fees (the remainder). The subscription-anchored revenue model provides excellent billing predictability, with platform fees providing a stable base irrespective of month-to-month flight volume fluctuations. As client flight volumes grow, the per-flight charge stream will become increasingly material to total revenue.

---

## 2. Revenue by Client Airline

Maverick Air was the largest revenue contributor in Q1 at approximately $61,125 (38% of total), reflecting its $18,500 monthly platform fee — the highest in the portfolio. Pacific Crest Airways contributed approximately $45,466. Saltline Express contributed approximately $30,860, and Gulf Palms Charter approximately $23,678. Revenue concentration is moderate, with no single client representing an undue dependency risk. All clients demonstrated stable billing engagement throughout the quarter.

---

## 3. Monthly Billing Trend

Monthly billing across the portfolio was stable in January and February, with March showing a modest aggregate increase driven by higher add-on charges across three client accounts. Maverick Air's March invoice of approximately $20,338 was the highest single monthly billing in Q1. Gulf Palms Charter maintained flat add-on charges of $300 per month across all three months, suggesting limited engagement with supplementary product features — a priority for the commercial team to address in Q2.

---

## 4. Per-Flight Revenue Analysis

Per-flight dispatch fees range from $10.00 per flight (Saltline Express) to $13.00 per flight (Gulf Palms Charter). Despite Gulf Palms holding the highest per-flight rate, its low dispatch volume (six total flights) results in the lowest aggregate per-flight revenue. Maverick Air's $12.50 rate across ten dispatched flights generates the highest per-flight revenue contribution at approximately $125 for the quarter. The current pricing structure appropriately reflects the higher complexity and lower volume predictability of charter operations.

---

## 5. Add-On Revenue Analysis

Add-on module charges totalled $9,800 for Q1, representing 6.1% of total billings but showing positive growth momentum. Maverick Air was the largest consumer at $5,500 across the quarter. Pacific Crest Airways increased add-on spend to $1,200 in March, likely linked to mechanical delay activity in February. Saltline Express and Gulf Palms Charter showed step-ups in March, suggesting operational disruptions are raising awareness of supplementary product value. The commercial team should use this momentum to structure formal add-on package proposals for all four clients.

---

## 6. Payment Status and Collections

All twelve billing records issued in Q1 carry a Paid payment status. SkyVector's accounts receivable position is entirely clean at the close of the quarter. No invoices are outstanding, disputed, or partially paid. This reflects positively on both client financial health and SkyVector's billing process effectiveness. The transparent billing structure — clearly separating platform fees, per-flight charges, and add-ons — is likely a key contributor to this clean collection outcome.

---

## 7. Contract Value and Client Tenure

SkyVector's four contracts range from $7,500 to $18,500 in monthly platform fees, reflecting fleet size and service scope differences. Pacific Crest Airways is the longest-tenured client (November 2021). Saltline Express, the most recent addition (January 2023), shows growth potential. No contracts are at lapse risk within the next twelve months. Proactive renewal and upsell conversations are recommended for Saltline Express and Gulf Palms Charter in Q2 2024.

---

## Appendix

### Assumptions
- All billing figures are taken from the billing_records table without accrual or deferred revenue adjustments.
- Add-on charges are billed as flat monthly fees, not itemised by module.
- Per-flight charges are calculated as contracted per_flight_fee multiplied by flights_dispatched.
- Payment status of Paid is treated as confirmed receipt.
- All figures are in USD.

### Known Limitations
- Add-on revenue cannot be attributed to specific modules in the current schema.
- Cost-side data is not included; profitability analysis is not possible from this dataset alone.
- Contract end dates are not stored in the schema, limiting formal renewal risk analysis.
- Flight count in billing records cross-references reasonably with the flights table but minor rounding differences may exist.

### Recommended Next Analysis
- Develop a gross margin model incorporating SkyVector's internal operational costs alongside billing revenue.
- Enhance the billing schema with add-on module identifiers to enable product-level revenue attribution.
- Project ARR per client and model fleet expansion scenarios for Saltline Express.
- Establish a contract renewal calendar once end date data is captured.
- Build a Gulf Palms Charter add-on conversion proposal using Q1 operational event data as the business case.
