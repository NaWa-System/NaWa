# Q1 2024 Subscription Box Performance & Retention Report

**Organisation:** Verdant Shelf Co.  
**Reporting Period:** January 1, 2024 – March 31, 2024  
**Prepared by:** Business Intelligence Team  
**Date Issued:** April 5, 2024  

---

## Executive Summary

Verdant Shelf Co.'s subscription box programme ended Q1 2024 with 9 active subscribers across three plan tiers — Sprout ($24.99/month), Grow ($44.99/month), and Flourish ($69.99/month). The programme acquired 11 subscribers during the quarter and experienced 2 cancellations, yielding a net growth to 9 active subscribers and a Q1 cohort churn rate of approximately 18%.

Estimated monthly recurring revenue (MRR) at quarter-end is approximately $389, with an annualised run-rate approaching $4,670. The Grow plan proved the most popular tier by active subscriber count, while Flourish delivered the highest revenue per subscriber, confirming that the premium tier resonates well with the company's engaged plant enthusiast audience.

Both cancellations originated from the January cohort — subscribers who joined early and did not renew past their first or second month. This signals that first-box experience and onboarding quality are critical retention levers and should be prioritised operationally in Q2. Subscriber acquisition accelerated through the quarter, with six of eleven sign-ups occurring after January, indicating growing momentum through digital discovery and word-of-mouth.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Active Subscribers (End of Q1) | 9 | Across all three tiers after 2 cancellations |
| Total Subscribers Acquired in Q1 | 11 | 5 in Jan, 3 in Feb, 3 in Mar |
| Cancellations in Q1 | 2 | Both from the January sign-up cohort |
| Churn Rate (Q1 Cohort) | ~18% | 2 of 11 Q1 subscribers cancelled |
| Estimated MRR (End of Q1) | ~$389/month | Based on active subscription plan pricing |
| Annualised Subscription Run Rate | ~$4,670 | MRR extrapolated over 12 months |
| Most Popular Plan | Grow ($44.99/month) | 4 active subscribers |
| Average Revenue Per Subscriber (ARPU) | ~$43.25/month | Weighted average across active plan mix |

---

## 1. Subscriber Acquisition by Month

Subscriber acquisition grew progressively across the quarter: five subscribers joined in January, three in February, and three more in March. The acceleration of sign-ups through the quarter is a positive leading indicator, particularly if supported by seasonal gardening interest and word-of-mouth referrals from satisfied early adopters. Maintaining this month-over-month growth trajectory through Q2 will be important for reaching a self-sustaining subscriber base.



---

## 2. Plan Tier Distribution and MRR Breakdown

At the end of Q1 2024, active subscriptions comprised 3 on Sprout, 4 on Grow, and 3 on Flourish. The relatively even distribution across tiers is commercially healthy and reduces revenue concentration risk. The Grow plan accounted for the largest absolute MRR contribution, while Flourish delivered the highest revenue per subscriber at $69.99/month. The Flourish plan's strong uptake relative to its price suggests the premium box value proposition is resonating effectively with the target customer segment.

| Plan | Monthly Price | Box Size | Active Subscribers | MRR Contribution |
|---|---|---|---|---|
| Sprout | $24.99 | Small | 3 | ~$75 |
| Grow | $44.99 | Medium | 4 | ~$180 |
| Flourish | $69.99 | Large | 3 | ~$210 |
| **Total** | | | **9** | **~$465** |

*Note: MRR figures above reflect the 9 active subscribers at quarter-end. Small rounding differences may apply.*



---

## 3. Churn Analysis and Cancellation Detail

Two subscribers cancelled during Q1: Ethan Cho (Flourish, cancelled March 22 after ~2 months) and Ravi Kapoor (Grow, cancelled February 28 after ~1 month). Both originated from the January cohort. The concentration of early churn within the January cohort suggests that first-impression and onboarding quality are key retention levers for new subscribers. No cancellations were recorded among February or March joiners.

A post-cancellation survey mechanism is strongly recommended to capture structured exit feedback and identify correctable causes of early churn.



---

## 4. Subscriber Profile and Channel Origin

All 11 subscribers were acquired through either the Online or In-Store channel. A majority originated online, consistent with the broader customer acquisition pattern. Geographically, Austin-based subscribers dominate, with online-acquired subscribers spread to Houston, Denver, Dallas, New Orleans, and Portland. The geographic diversity confirms that the subscription product has national appeal and is not limited to local in-store discovery — a strong foundation for scaling acquisition through digital marketing.



---

## 5. Subscription Revenue vs. One-Time Order Revenue

Subscription MRR at the end of Q1 (~$389–$465/month) represents a meaningful but still growing proportion of total company revenue relative to Q1 gross product sales of approximately $1,980. The subscription channel provides a predictable, recurring revenue base that is structurally more valuable than equivalent one-time order revenue due to improved cash flow predictability and reduced month-to-month volatility.

Notably, several subscribers — including Ava Lindqvist, Priya Nair, and Naomi Adeyemi — also placed one-time product orders during the quarter, indicating that the subscription product drives incremental spending rather than cannibalising product sales.



---

## 6. Retention Rate and Forward Outlook

Of the 5 January subscribers, 3 remained active at the end of March — a 60% retention rate at the approximately 60-day mark. The February cohort (3 subscribers) was 100% retained at quarter-end. The March cohort was too recent to assess.

The company should target a 70%+ 90-day retention rate as a Q2 operational benchmark. Key levers include personalised plant recommendations, post-delivery care guides, and a loyalty incentive for subscribers active beyond three months.



---

## Appendix

### Assumptions
- MRR is calculated as the sum of monthly_price for all subscriptions with status = 'Active' as of March 31, 2024.
- Churn rate is cancellations divided by total Q1 acquisitions (not a start-of-period base, as the programme launched in Q1).
- ARPU is estimated end-of-Q1 MRR divided by 9 active subscribers.
- Subscription revenue is inferred from plan pricing and active status; no billing table exists in the schema.

### Known Limitations
- No subscription billing/invoice table exists; actual cash collected cannot be reconciled.
- Box contents per shipment are not tracked; subscription COGS cannot be calculated.
- No customer satisfaction or NPS data is captured.
- Only Active and Cancelled statuses are available; paused or skipped subscriptions are not tracked.
- Small subscriber base (11 total); conclusions are directional, not statistically definitive.

### Recommended Next Analysis
- Introduce a subscription_invoices table to enable accurate MRR, ARR, and payment reconciliation.
- Add an exit_survey_responses table to capture structured cancellation reasons.
- Track box contents per shipment to calculate subscription-specific gross margin.
- Build a subscriber lifetime value (sLTV) model once 6+ months of cohort data is available.
- Design a cross-sell analysis quantifying how subscription membership influences incremental one-time order spend.
