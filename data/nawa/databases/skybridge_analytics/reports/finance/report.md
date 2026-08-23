# Q1 2024 Route Revenue & Cost Analysis

**Organisation:** SkyBridge Analytics — Meridian Air & Crestline Airways Network  
**Reporting Period:** January 2024 – March 2024  
**Prepared by:** SkyBridge Analytics Commercial Reporting Division  
**Date of Issue:** April 2024

---

## Executive Summary

This report provides a consolidated financial analysis of route-level revenue, cost, and margin performance across the Meridian Air and Crestline Airways networks for Q1 2024.

Total network fare revenue reached approximately $878,000 for the quarter, supplemented by ancillary revenues of approximately $31,000. Business class bookings, while accounting for a smaller share of passenger volumes, contributed a disproportionately high share of total fare revenue due to premium flexible-fare pricing.

Operating costs across the 30 scheduled flights totalled approximately $974,000, with fuel representing the largest single cost category at approximately 46% of total expenditure. Medium-haul routes — particularly Dublin–Athens and London–Rome — carried the highest absolute cost loads, though their elevated fare yields partially offset this cost premium.

Two cancellations in the quarter generated zero revenue while still absorbing fixed costs, representing a direct financial drag on Q1 performance. On completed routes, revenue consistently covered variable operating costs, indicating a broadly sustainable commercial model.

The quarter ended with an improving revenue trend, with March posting the strongest combined fare and ancillary revenue of the three months. This trajectory provides a positive basis for Q2 commercial planning.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Fare Revenue | ~$878,000 | Aggregated across all completed bookings, Q1 2024 |
| Total Ancillary Revenue | ~$31,000 | Add-on services; flexible-fare passengers yielded higher ancillary income |
| Total Operating Costs | ~$974,000 | All 30 flights, including cancellations |
| Business Class Revenue | ~$213,000 | Premium fare contribution from flexible business bookings |
| Cancelled Flight Revenue Loss | $0 (2 flights) | MA610 and CL504 generated no revenue despite incurring fixed costs |
| Avg. Economy Fare Per Booking | ~$140 | Varies by route length and fare type |
| Avg. Business Fare Per Booking | ~$800 | Flexible-fare premium significantly above economy equivalent |
| Fuel Cost as % of Total Costs | ~46% | Dominant cost driver across the network |
| Highest Revenue Route | Dublin–Athens (CL504) | Highest per-flight fare revenue of all operated routes |

---

## Report Sections

### 1. Total Revenue by Route

Route-level revenue analysis reveals meaningful variation across the ten operated routes. The Dublin–Athens medium-haul route generated the highest combined fare and ancillary revenue per flight. London–Madrid and London–Rome also posted strong results. Short-haul services such as London–Paris and London–Amsterdam produced lower absolute revenue, though their reduced operating costs partially compensate. Cancelled flights on the London–Vienna and Dublin–Athens routes represent direct revenue gaps in the quarterly totals.



---

### 2. Revenue by Cabin Class and Fare Type

Economy class accounted for the majority of booking volume, but business class flexible fares generated substantially higher revenue per passenger. Business bookings on long-haul routes yielded between $700 and $1,100 per booking, compared with $110–$175 for economy saver fares. Routes offering both cabin classes — Dublin–Athens, London–Rome, and London–Madrid — demonstrated the strongest blended revenue profiles.



---

### 3. Ancillary Revenue Analysis

Ancillary revenue contributed approximately 3.5% of total combined revenue in Q1. Ancillary income was highest on flights with larger passenger volumes and flexible-fare bookings, particularly on Dublin–Athens and London–Madrid. Short-haul saver bookings produced the lowest ancillary yield. The correlation between flexible fares and ancillary uptake suggests targeted upselling opportunities on premium routes could improve ancillary revenue contribution in Q2.



---

### 4. Operating Cost Breakdown by Category

Fuel costs represented approximately 46% of total operating expenditure. Crew costs accounted for approximately 17%, airport fees approximately 9%, and maintenance approximately 5%. Cancelled flights contributed sunk costs primarily through crew standby and airport access fees. Medium-haul services consistently incurred higher absolute costs across all categories, which is justified only where fare yields are proportionally higher.



---

### 5. Route-Level Revenue vs. Cost Comparison

Comparing total booking revenue against total operating costs on a per-route basis reveals that short-haul routes demonstrated the most favourable revenue-to-cost ratios. The Dublin–Athens route, while generating the highest absolute revenue, also carries the highest operating costs, narrowing its net margin. Routes with recurring delays — such as London–Rome and Manchester–Barcelona — may face additional hidden costs such as crew overtime and passenger compensation not fully captured in the current schema.



---

### 6. Monthly Revenue Trend

Monthly revenue showed an upward trend across Q1 2024. January was constrained by the London–Vienna cancellation and a high proportion of economy saver bookings. February saw increased business class and flexible-fare uptake on Crestline routes. March posted the highest revenue of the three months, supported by stronger booking mix and the successful operation of previously cancelled routes. The upward trajectory heading into Q2 is an encouraging commercial indicator.



---

## Appendix & Notes

### Assumptions
- Total fare revenue is summed from bookings.total_fare for all completed flight bookings.
- Ancillary revenue is summed from bookings.ancillary_revenue across all valid bookings.
- Operating costs per flight are aggregated from all five cost categories in the flight_costs table.
- Cancelled flights are included in cost totals but excluded from revenue calculations.
- Currency is assumed uniform (USD) across all records.

### Known Limitations
- The schema does not capture indirect costs such as crew overtime, passenger compensation, or rebooking charges.
- Tax and government surcharge components are not separated from base fares.
- Seasonal demand fluctuations within the quarter may not be fully visible at this flight frequency.
- No prior-period comparator data is currently available within the platform.

### Recommended Next Analysis
- Introduce a compensation cost field or table to capture the full financial impact of delays and cancellations.
- Segment revenue by booking lead time (days between booking date and departure) to evaluate pricing strategy.
- Model route contribution margins by subtracting fully allocated costs from per-route revenue.
- Benchmark Q1 2024 against Q1 2023 data once historical records are integrated.

---

*Report generated by SkyBridge Analytics. Data sourced from the SkyBridge Operations Intelligence Platform.*
