# Rental Revenue & Customer Channel Analysis Report — January to April 2024

**Organisation:** DriveEase Rentals  
**Reporting Period:** January 1, 2024 – April 30, 2024  
**Report Type:** Sales  
**Prepared by:** Sales Analytics & Revenue Management Team  
**Date Issued:** May 2024

---

## Executive Summary

This report provides a four-month revenue and customer channel analysis for DriveEase Rentals, covering January through April 2024. Over this period, DriveEase Rentals completed 25 paid rental transactions totalling approximately $10,413 in collected payments, with three additional rentals active at the end of April not yet reflected in closed revenue.

Monthly revenue exhibited an upward trend from January through March, with April showing a strong start driven by increased corporate bookings and a notable insurance-channel renewal. The corporate portal emerged as the highest-value booking channel on a revenue-per-transaction basis, while the online channel led in transaction volume.

Customer segmentation analysis reveals that corporate and insurance-designated customers consistently produced longer rental durations and higher total payment values. Platinum-tier loyalty members disproportionately contributed to corporate revenue, confirming the strategic importance of top-tier account management. Fuel Pre-Purchase adoption remained low across all channels and represents the clearest near-term upsell improvement opportunity.

Heading into Q2, the company's revenue trajectory and customer repeat rates position DriveEase Rentals well, though closing the performance gap between airport and inland branches should be a defined commercial priority.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Collected Revenue (Jan–Apr) | ~$10,413 | From 25 completed payment records |
| Total Completed Transactions | 25 | Excludes 3 active April rentals |
| Average Revenue Per Rental | ~$416 | Corporate bookings averaged significantly higher |
| Corporate Channel Revenue Share | ~45% | Highest revenue share despite lower volume |
| Insurance Channel Revenue Share | ~12% | Predictable 14-day bookings per event |
| Repeat Customer Rate | ~33% | Multiple customers appear in 2+ rental records |
| Online Channel Transaction Share | ~44% | Highest volume channel |
| Total Ancillary Revenue (Jan–Apr) | ~$1,449 | CDW, GPS, Additional Driver, Fuel Pre-Purchase |
| Top Performing Segment | Corporate / Platinum Tier | Highest avg. revenue per booking |
| Month-over-Month Revenue Trend | Positive Jan–Apr | April tracking above January baseline |

---

## Section 1: Monthly Revenue Trend

Revenue from completed rentals showed positive sequential growth from January through March 2024. January was the lightest month by transaction count, generating approximately $2,390 in collected payments across six completions. February produced approximately $2,726 across seven completions, driven in part by a 14-day insurance replacement rental. March was the strongest month of Q1 at over $3,100, led by two high-value corporate bookings on Premium vehicles. April demonstrated continued momentum with five confirmed payment completions already recorded at the reporting date.

**Data used:** payments.payment_date, payments.total_amount, payments.payment_status, rentals.pickup_date, rentals.status

---

## Section 2: Revenue by Booking Channel

The online channel generated the highest number of transactions but at lower average values, consistent with shorter leisure booking durations. The corporate portal produced approximately 45% of total collected revenue, reflecting longer durations, premium vehicle selections, and volume account relationships. The insurance portal contributed a stable share with predictable 14-day economy bookings. Walk-in bookings accounted for three transactions, concentrated at Branch 5 (Spokane), with modest average revenue.

**Data used:** rentals.booking_channel, rentals.base_rental_amount, rentals.rental_days, payments.total_amount, branches.branch_name

---

## Section 3: Customer Type & Loyalty Tier Analysis

Corporate customers drove a disproportionate share of total revenue through higher booking frequency and premium vehicle usage. Platinum-tier members Sophia Mendez, Noah Williams, and Charlotte Davis accounted for six completed rentals with an average payment per booking exceeding $750. Gold-tier leisure customers showed meaningful repeat patterns. Standard-tier leisure customers were the most numerous by headcount but lowest by average revenue per rental.

**Data used:** customers.customer_type, customers.loyalty_tier, customers.customer_id, rentals.customer_id, rentals.base_rental_amount, payments.total_amount

---

## Section 4: Ancillary Product Revenue Breakdown

Ancillary charges totalled approximately $1,449 across 38 charge records, representing roughly 14% of total collected revenue. CDW Insurance led by value and attachment rate (~80%). GPS Navigation was the second most adopted add-on. Additional Driver fees appeared on four corporate bookings at $35 each. Fuel Pre-Purchase was attached to only two rentals across four months, identifying it as the weakest-performing ancillary product and the strongest candidate for a focused attachment-rate improvement initiative.

**Data used:** ancillary_charges.charge_type, ancillary_charges.charge_amount, ancillary_charges.rental_id, rentals.booking_channel, rentals.rental_days

---

## Section 5: Branch-Level Sales Contribution

Seattle-Tacoma Airport (Branch 1) led the network by total collected revenue across the four-month period. Portland Airport (Branch 3) ranked second, benefiting from leisure volume and a high-value Platinum corporate account. Downtown branches (2 and 4) showed moderate contributions. Spokane Central (Branch 5) and Eugene (Branch 6) each recorded only two to three completions, lagging significantly behind airport locations. Targeted commercial strategies for inland branches are recommended to improve network revenue balance.

**Data used:** rentals.branch_id, branches.branch_name, branches.is_airport_location, payments.total_amount, rentals.pickup_date

---

## Section 6: Payment Method & Receivables Summary

Credit card was the most frequent payment method across individual transactions. Corporate invoice represented the highest aggregate payment value. Insurance invoice payments characterised by end-of-rental billing cycles. All 25 completed transactions recorded a payment status of 'completed', with no bad debt, chargebacks, or outstanding invoices noted within the reporting window.

**Data used:** payments.payment_method, payments.payment_status, payments.total_amount, payments.payment_date, rentals.booking_channel

---

## Appendix & Notes

### Assumptions
- Total collected revenue is taken from payments.total_amount, inclusive of base rental and ancillary charges.
- Monthly revenue is attributed to the payment_date field rather than rental pickup_date.
- Repeat customer rate is calculated by identifying customer_id values in more than one rental record within the period.
- Active rentals (status = 'active') in April are excluded from completed revenue totals.

### Known Limitations
- Three late-April active rentals are excluded and will contribute to May revenue upon completion.
- No cancellation or no-show records exist in the schema; cancellation rate cannot be calculated.
- Customer acquisition cost data is not captured, preventing channel-level ROI analysis.
- Revenue forecasting cannot be built robustly without data beyond the current four-month window.
- Negotiated corporate contract terms are not stored, limiting detailed corporate pricing analysis.

### Recommended Next Analysis
- Build a rolling 12-month revenue trend model to identify seasonal demand patterns.
- Develop a channel-level profitability model incorporating acquisition and servicing cost estimates.
- Implement Fuel Pre-Purchase conversion tracking to measure the impact of attachment-rate initiatives.
- Conduct customer lifetime value analysis segmented by loyalty tier and customer type.
- Establish branch-level revenue targets for Spokane and Eugene and compare against actuals quarterly.

---

*Report prepared by the DriveEase Rentals Sales Analytics & Revenue Management Team. For internal use only.*
