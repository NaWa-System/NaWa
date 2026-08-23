# Hemköp Detaljhandel AB
## Store Sales Performance Report — Q4 2024
**Organisation:** Hemköp Detaljhandel AB  
**Reporting Period:** October – December 2024  
**Prepared by:** Commercial Analytics & Reporting  
**Date:** January 2025

---

## Executive Summary

This report presents store-level sales performance for Hemköp Detaljhandel AB across Q4 2024. The quarter followed a clear seasonal arc: October established a steady baseline, November grew moderately as early holiday preparation influenced shopping patterns, and December delivered the highest transaction volumes and basket sizes — particularly in the final week before Christmas.

The Stockholm region led aggregate sales, with Hemköp Sundbyberg as the top-performing individual store. Meat & Fish was the highest-value department, boosted by the Julmat Specialerbjudande promotion in December. Hemköp private-label products featured in the large majority of transactions, reinforcing the brand's value positioning.

Card payments dominated at approximately 75% of transactions, with mobile payments growing among Professional-segment and city-centre shoppers.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Sales Revenue (Q4) | SEK 10,195.20 | 36 transactions across 7 stores |
| Total Transactions | 36 | December had the highest concentration |
| Average Transaction Value | SEK 283.20 | December significantly above quarter average |
| Highest-Volume Store | Hemköp Sundbyberg | Largest footprint; Christmas Eve peak of SEK 632.40 |
| Top Department | Meat & Fish | Laxfilé and Nötfärs featured in high-value transactions |
| Hemköp Brand Presence | ~85% of transactions | Private-label across all departments |
| Dominant Payment Method | Card (~75%) | Mobile growing; cash declining |
| Active Promotions | 6 | Covering 5 departments across the quarter |

---

## Report Sections

### 1. Monthly Sales Volume Trend

October established the baseline with 12 transactions totalling approximately SEK 2,874. November recorded 10 transactions with a combined value of approximately SEK 2,681. December was the strongest month with 14 transactions and approximately SEK 4,091 in total — driven by Christmas-period basket inflation and elevated shopping frequency in the final two weeks. The December 24 transactions at Sundbyberg, Vasastan, and Linnégatan were among the highest single-transaction values of the quarter.

### 2. Sales Performance by Store

Hemköp Sundbyberg led total sales volume, benefiting from its 1,050 sqm footprint and high Family-segment frequency. Hemköp Östermalm performed strongly with Professional-segment shoppers and above-average basket values. Hemköp Linnégatan was the strongest performer outside Stockholm. Vasastan punched above its 680 sqm size in December due to proximity to high-density residential areas. Mölndal, Lund Centrum, and Västerås City each delivered stable, format-consistent results.

### 3. Top-Selling Products and Departments

Laxfilé Norsk and Hemköp Nötfärs were the highest-value line items throughout the quarter. Hemköp Ekologiska Tomater led Fresh Produce. Hemköp Surdegsbröd benefited from the December Advent promotion. Ramlösa Citron and Hemköp Apelsinjuice provided consistent beverage volumes. Hemköp Pasta Penne was a reliable Pantry contributor across all stores.

### 4. Hemköp Private-Label vs National Brand Mix

Hemköp own-brand products appeared in the large majority of transactions. Private-label strength was highest in Fresh Produce, Bakery, Meat, and Pantry. National brands (Arla, Barilla, Pågen) remained important basket staples but increasingly co-existed with Hemköp alternatives rather than dominating categories. The margin premium on private-label products contributes positively to gross margin across all high-penetration departments.

### 5. Promotional Activity Impact

Six promotions ran across the quarter. The Julmat Specialerbjudande (18% off Meat & Fish, December 9–24) coincided with peak Meat & Fish volumes. Advent Bakat Hemma supported Hemköp Surdegsbröd sales in December. Höst-Grönsaksveckan drove above-average Fresh Produce volume in early October. Promotion impact is inferred from timing correlation; direct attribution is not available in the current schema.

### 6. Payment Method Breakdown

Card payments represented approximately 75% of transactions. Mobile payments were concentrated among Professional-segment customers at city-centre locations. Cash was limited and declining, primarily at Sundbyberg and Lund Centrum. The payment mix supports continued investment in contactless and mobile infrastructure.

### 7. Customer Segment Contribution

Family-segment customers generated the highest aggregate transaction values. Professional-segment customers showed higher frequency but smaller baskets. Senior-segment customers demonstrated consistent moderate spending patterns. Unregistered walk-in transactions increased noticeably in late December, as expected during the Christmas period.

---

## Appendix

### Assumptions
- Transaction totals represent gross consumer spend including VAT.
- Private-label identification based on products.is_hemkop_brand flag.
- Promotional impact is inferred from timing correlation only.
- NULL customer_id represents walk-in / unregistered customers.

### Known Limitations
- 36-transaction sample is representative, not the full transaction population.
- No promotion-attribution linkage in the current schema.
- Returns and refunds are not modelled.
- Stock depletion during the quarter is not captured in transaction data.

### Recommended Next Analysis
- Add promotion_id to transaction_items for direct attribution.
- Integrate returns table for net revenue reporting.
- Conduct basket analysis for cross-sell opportunity identification.
- Q4 2024 vs Q4 2023 year-over-year comparison.
