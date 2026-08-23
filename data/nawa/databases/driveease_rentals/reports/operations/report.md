# Fleet Operations & Revenue Performance Report — Q1 2024

**Organisation:** DriveEase Rentals  
**Reporting Period:** January 1, 2024 – March 31, 2024  
**Report Type:** Operations  
**Prepared by:** Business Intelligence & Operations Team  
**Date Issued:** April 2024

---

## Executive Summary

This report presents a comprehensive review of DriveEase Rentals' fleet operations and revenue performance for the first quarter of 2024, spanning January through March across all six regional branches. The quarter saw sustained rental activity with healthy occupancy across key vehicle categories, led by strong demand for Premium and SUV segments, particularly at airport-adjacent locations in Seattle and Portland.

Total base rental revenue from Q1 completed transactions reached approximately $7,638, with ancillary charges contributing an additional ~$1,117. Corporate and insurance-channel bookings accounted for a disproportionate share of revenue relative to volume, reflecting higher average rental durations typical of those customer segments.

Fleet maintenance activity was elevated through February and March, with Vehicle 7 (Jeep Grand Cherokee, Downtown Seattle) requiring three separate interventions, including a brake repair and a subsequent engine service in April, resulting in cumulative downtime that reduced that unit's revenue-generating availability.

Looking ahead to Q2, active rental demand and strong repeat engagement from Gold and Platinum loyalty tier clients suggest continued positive momentum. However, maintenance cost escalation for aging units and branch-level utilization disparities between airport and inland locations present operational areas requiring management attention.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Completed Rentals (Q1) | 20 | All completed; no material cancellations recorded |
| Total Base Rental Revenue (Q1) | ~$7,638 | Premium and SUV categories led by value |
| Total Ancillary Revenue (Q1) | ~$1,117 | CDW insurance dominant; GPS navigation second |
| Average Rental Duration (Q1) | 4.5 days | Corporate/insurance skewed higher than leisure |
| Fleet Maintenance Cost (Q1) | ~$3,825 | 11 events across 9 vehicles |
| Total Fleet Downtime Days (Q1) | 17 days | Vehicle 7 contributed 4 days within Q1 |
| Top Revenue Branch (Q1) | Seattle-Tacoma Airport (Branch 1) | Premium demand and corporate volume |
| CDW Attachment Rate (Q1) | ~80% | Strong upsell performance at point of booking |

---

## Section 1: Rental Volume by Branch

Seattle-Tacoma Airport (Branch 1) and Portland Airport (Branch 3) collectively accounted for the majority of Q1 rental transactions, consistent with the higher foot traffic typical of airport locations. Branch 1 recorded six completed rentals with a mix of economy, mid-size, and premium bookings, while Branch 3 contributed five completions. Inland branches — Spokane Central (Branch 5) and Eugene (Branch 6) — each recorded two completions, suggesting untapped demand in non-airport markets.

**Data used:** rentals.branch_id, rentals.status, rentals.pickup_date, branches.branch_name, branches.is_airport_location

---

## Section 2: Revenue by Vehicle Category

Premium vehicles generated the highest per-rental revenue during Q1, with two long-duration corporate bookings on BMW and Mercedes units each producing base rental amounts exceeding $769. SUV rentals were the second-highest aggregate contributor. Economy vehicles, while representing the highest count of individual rental events, contributed proportionally less base revenue but supported ancillary CDW and GPS attachment. The Van category showed limited Q1 activity, limited to a single corporate booking.

**Data used:** rentals.base_rental_amount, rentals.daily_rate, vehicles.category_id, vehicle_categories.category_name, vehicle_categories.daily_base_rate

---

## Section 3: Booking Channel Breakdown

The online booking channel remained the primary acquisition source for leisure rentals in Q1, accounting for approximately half of all completed transactions. The corporate portal was the second most active channel and produced the highest average revenue per rental. Insurance portal bookings featured notably long rental durations — often 14 days. Walk-in bookings were minimal, consistent with Branch 5's lower digital penetration.

**Data used:** rentals.booking_channel, rentals.rental_id, rentals.base_rental_amount, rentals.branch_id

---

## Section 4: Ancillary Revenue Analysis

Ancillary charges contributed approximately 15% of total collected revenue in Q1. CDW insurance was the largest component, appearing on approximately 80% of rentals. GPS Navigation was the most frequently purchased optional add-on. Fuel Pre-Purchase showed low adoption across only two rentals, suggesting an opportunity for bundling or point-of-sale prompting. The highest single ancillary contribution came from a seven-day corporate Premium rental generating $140 in combined CDW and additional driver fees.

**Data used:** ancillary_charges.charge_type, ancillary_charges.charge_amount, ancillary_charges.rental_id, rentals.pickup_date

---

## Section 5: Fleet Maintenance Summary

Eleven maintenance events were logged in Q1, covering routine servicing, tire replacements, brake repairs, AC repair, and a windshield replacement. Total direct maintenance expenditure was approximately $3,825. Brake and AC repairs carried the highest individual cost per event. Vehicle 7 (Jeep Grand Cherokee, Branch 2) was the most maintenance-intensive unit and warrants a formal lifecycle review given cumulative spend.

**Data used:** fleet_maintenance.vehicle_id, fleet_maintenance.maintenance_type, fleet_maintenance.cost, fleet_maintenance.days_out_of_service, vehicles.branch_id

---

## Section 6: Customer Segment Performance

Corporate customers generated the highest total revenue despite representing fewer unique individuals. Platinum-tier customers were responsible for multiple high-value rentals in Q1. Insurance-channel customers demonstrated consistent demand for Economy vehicles over extended periods. Gold-tier leisure customers showed repeat engagement, reinforcing the value of the loyalty programme.

**Data used:** customers.customer_type, customers.loyalty_tier, rentals.customer_id, rentals.base_rental_amount, payments.total_amount

---

## Section 7: Payment Collection & Method Distribution

All 20 Q1 completed rental payments recorded a 'completed' status, with no outstanding receivables or payment failures. Corporate invoice was the dominant payment method by revenue value. Credit card payments were the most frequent by transaction count. Insurance invoice payments aligned to longer billing cycles. The clean payment completion rate reflects effective billing processes and low credit risk in the current customer mix.

**Data used:** payments.payment_method, payments.payment_status, payments.total_amount, payments.payment_date, rentals.booking_channel

---

## Appendix & Notes

### Assumptions
- Base rental revenue is calculated as rental_days × daily_rate as recorded in the rentals table.
- Total collected revenue per rental is taken from payments.total_amount, inclusive of ancillary charges.
- Q1 figures include only rentals with pickup_date between 2024-01-01 and 2024-03-31 with status 'completed'.
- Maintenance cost does not include indirect costs such as staff labour or vehicle opportunity cost.

### Known Limitations
- Three April-initiated active rentals are excluded from Q1 revenue totals.
- Fleet utilization percentage cannot be precisely calculated without a daily availability log.
- No customer satisfaction or complaint data is captured in the current schema.
- No mileage or fuel consumption data is available.
- Branch-level operating costs are not included, preventing full profitability analysis.

### Recommended Next Analysis
- Introduce a daily fleet availability tracking table for precise utilization calculation.
- Conduct a lifecycle cost analysis for Vehicle 7 to assess replacement economics.
- Develop a branch-level profitability model with operating cost allocations.
- Analyse loyalty programme ROI across Standard, Gold, and Platinum tiers over a 12-month rolling period.
- Evaluate ancillary product attach rates by booking channel to identify upsell opportunities.

---

*Report prepared by the DriveEase Rentals Business Intelligence & Operations Team. For internal use only.*
