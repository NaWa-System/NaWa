# Premium & Claims Performance Report — Q1–Q3 2024

**Organisation:** Meridian Shield Insurance Group  
**Reporting Period:** January 2024 – September 2024  
**Report Type:** Finance  
**Prepared by:** Finance & Actuarial Analytics Team  
**Date Issued:** October 2024  

---

## Executive Summary

This report provides a financial overview of Meridian Shield Insurance Group's premium collection and claims activity for the period January through September 2024. The company continued to grow its active policy base across both personal and commercial lines, generating collected premiums that reflect a healthy mix of annual and semi-annual payment schedules. Commercial Lines policies, while fewer in number, account for a disproportionately large share of total premium volume, underscoring the revenue importance of the business customer segment.

Claims activity during the period was moderate, with the majority of submitted claims successfully resolved and closed within the reporting window. A subset of claims remains under review or pending, including two higher-value commercial liability and collision claims that may carry financial implications into Q4 2024. The overall loss ratio across closed claims remains within acceptable underwriting parameters.

The broker channel continues to generate the largest share of new and in-force premium, particularly in the Mid-Atlantic and New York Metro regions. The Direct Digital channel shows promising policy acquisition activity with a favourable risk profile. Regional diversification across New York, New England, and Mid-Atlantic states provides a natural hedge against localized exposure.

Looking ahead to Q4 2024, proactive retention outreach and competitive renewal pricing will be critical to preserving premium revenue momentum entering 2025.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Premiums Collected (YTD) | $52,215.00 | All payment receipts January–September 2024 |
| Total Claimed Amount (All Claims) | $173,300.00 | Includes open and closed claims |
| Total Approved Payouts (Closed Claims) | $115,600.00 | Sum of approved amounts for resolved claims |
| Claims Closure Rate | 73% | 11 of 15 claims fully resolved within period |
| Avg Approved Payout per Closed Claim | $10,509 | Elevated by large commercial claims in Q1–Q2 |
| Commercial Lines Premium Share | ~62% | BOP, Commercial Property, General Liability |
| Active Policies in Force | 16 | Excludes Expired and Lapsed policies |
| Claims Under Review / Pending | 3 | Combined claimed value exceeds $36,000 |

---

## Section 1: Premium Collections by Month

Premium collection activity was concentrated in January and February 2024, reflecting annual policy effective dates at calendar year start. Secondary collection peaks occurred in July and September as semi-annual payment plans for commercial clients triggered their second installment. The Direct Digital channel contributed incrementally throughout the year with smaller average payment amounts. ACH Transfer was the dominant payment method by volume, while Wire Transfer was exclusively used by commercial accounts.



**Data Fields:** premiums_collected.payment_date, premiums_collected.amount_paid, premiums_collected.payment_method

---

## Section 2: Premium by Line of Business and Policy Type

Commercial Lines policies collectively generate the highest share of annual premium volume despite representing a smaller number of policies. The Commercial Property policy at $8,750 annually and two BOP policies are the three largest single premium contributors. Within Personal Lines, Premium Homeowners and Comprehensive Auto products command meaningfully higher premiums than standard equivalents. Standard Auto remains the highest-frequency product by policy count.



**Data Fields:** policy_types.type_name, policy_types.line_of_business, policies.annual_premium, policies.policy_type_id

---

## Section 3: Claims Analysis by Type and Status

Fifteen claims were recorded during the reporting period. Property Damage, Liability, and Water Damage claims account for the highest approved payout values. Fire Damage and Liability claims in the commercial segment generated the two largest individual payouts. Three claims remain unresolved at period end. The average time from claim date to resolution for closed claims was approximately 55 days, within target service level parameters.



**Data Fields:** claims.claim_type, claims.claimed_amount, claims.approved_amount, claims.status, claims.claim_date, claims.resolution_date

---

## Section 4: Premium vs Claims by Region

New York Metro generated the highest aggregate premium volume. New England's claims activity remained low relative to premiums collected. The Mid-Atlantic region carries a disproportionately high claims exposure due to large commercial claims, representing a regional concentration risk that warrants attention in underwriting review cycles.



**Data Fields:** agents.region, policies.annual_premium, claims.approved_amount

---

## Section 5: Channel Performance — Broker vs Direct Digital

The broker channel accounts for the majority of both policy count and premium volume. Direct Digital policies skew toward personal lines with lower average premiums but also demonstrate lower average claims severity. Growing the Direct Digital channel could improve acquisition cost efficiency while maintaining acceptable loss ratios.



**Data Fields:** agents.channel, policies.annual_premium, claims.approved_amount

---

## Appendix & Notes

### Assumptions
- Premium revenue is recognised on a cash receipt basis; unearned premium adjustments are not reflected.
- Claims approved_amount is treated as estimated payout obligation; actual disbursement timing may differ.
- Semi-annual payments are split evenly and do not reflect installment fees.
- Regional attribution is based on the assigned agent's region.

### Known Limitations
- Three open claims with unresolved approved amounts are excluded from loss ratio calculations.
- Investment income on float is not captured in the current schema.
- Policy endorsements and mid-term adjustments are not separately tracked.
- The reporting period does not cover a full year; annual comparisons are not possible.

### Recommended Next Analysis
- Full loss ratio analysis incorporating earned premium calculations.
- Claims reserving report to estimate IBNR exposure.
- Broker performance scorecard comparing premium produced vs claims generated.
- Q4 scenario analysis for open claims under varying settlement outcomes.

---
*Meridian Shield Insurance Group — Confidential Internal Report*
