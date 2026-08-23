# Policy Portfolio & Renewal Analysis — 2024 Year-to-Date

**Organisation:** Meridian Shield Insurance Group  
**Reporting Period:** January 2024 – November 2024  
**Report Type:** Operations  
**Prepared by:** Underwriting Operations & Strategy Team  
**Date Issued:** November 2024  

---

## Executive Summary

This operational report examines Meridian Shield Insurance Group's policy portfolio composition, growth, and renewal performance for the period January through November 2024. The active policy book comprises 16 in-force policies spanning seven product types across personal and commercial lines, with steady quarter-on-quarter growth in new policy issuance demonstrated throughout the year.

The renewal cycle for policies expiring in late 2024 and early 2025 is now underway. Of the ten renewal decisions tracked, two policies have been formally renewed, one has lapsed, one has been declined, and six remain pending. The combined annual premium at risk from pending decisions represents a meaningful share of the portfolio's revenue base and should be treated as a near-term operational priority.

Agent performance data confirms that the broker channel, led by Patricia Holloway and Michael Tran, produces the highest average premium per policy. The Direct Digital channel, while growing, tends toward shorter-tenure, lower-premium personal lines relationships. Building retention mechanisms into the digital customer journey is essential to improving lifetime value from this channel.

Two non-active policy records — one expired and one lapsed — represent revenue the company was unable to retain. Reducing lapse rates through targeted intervention programs will be a key lever for sustainable portfolio growth in 2025.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Active Policies | 16 | Excludes one Expired and one Lapsed policy |
| Total In-Force Annual Premium | $50,790.00 | Sum across all active policies |
| New Policies Issued (YTD) | 15 | Effective dates January–September 2024 |
| Renewal Conversion Rate (Decided) | 67% | 2 of 3 decided renewals successfully retained |
| Pending Renewal Decisions | 6 | Unresolved offers representing premium risk |
| Policies Lapsed or Declined | 2 | One lapsed, one renewal declined by customer |
| Average Annual Premium (Active) | $3,174 | Blended; commercial policies skew upward |
| Commercial Lines Policy Count | 6 | ~62% of total annual premium volume |
| Broker Channel Policy Share | 69% | ~11 of 16 active policies via broker channel |

---

## Section 1: Portfolio Composition by Product Type

The active portfolio spans all seven product types offered by Meridian Shield. Standard Auto is the most frequently held product by policy count, reflecting the broad personal auto market. Commercial products — BOP, Commercial Property, and General Liability — represent fewer policies but dominate premium contribution. The portfolio's diversification across product lines reduces concentration risk while maintaining a commercially viable book of business.



**Data Fields:** policy_types.type_name, policy_types.line_of_business, policies.policy_type_id, policies.annual_premium, policies.status

---

## Section 2: New Policy Issuance Trends

New policy issuance was front-loaded in Q1 2024, with seven policies commencing around January 1st reflecting year-end binding activity. February and March added additional volume, while Q2 saw moderate personal lines intake. The pace slowed in Q3, consistent with seasonal patterns in auto and homeowners markets. Monitoring the new business pipeline going into Q4 is important for 2025 premium planning.



**Data Fields:** policies.effective_date, policies.policy_type_id, policy_types.line_of_business, policies.status

---

## Section 3: Renewal Pipeline and Conversion Analysis

Ten renewal records are currently tracked. The two completed renewals represent the highest-value successful retentions. One renewal was lost to lapse and one was declined — possibly indicating competitive pressure from rival carriers. Six pending decisions collectively represent significant premium at risk. Outreach prioritisation should focus on the highest-premium pending accounts first.



**Data Fields:** renewals.renewal_decision, renewals.new_premium, renewals.renewal_offer_date, renewals.decision_date, renewals.policy_id, policies.annual_premium

---

## Section 4: Agent and Channel Performance

Patricia Holloway and Michael Tran are the top contributors by premium under management. James Rutherford maintains a steady mid-market personal lines book in New England. Direct Digital agents Kowalski and Simmons manage five policies with a lower average premium. Robert Esquivel handles two high-value commercial policies in Mid-Atlantic. All six agents are currently active.



**Data Fields:** agents.agent_name, agents.channel, agents.region, policies.agent_id, policies.annual_premium, policies.status

---

## Section 5: Customer Segment and Retention Profile

The customer base comprises 12 unique customers: eight Personal and four Commercial. Commercial customers each hold one to three policies, making multi-policy relationships a key retention priority. Longer-tenured personal customers represent the most stable segment of the book. Customers acquired in 2022 and 2023 have not yet experienced a full renewal cycle, making 2025 retention rates an important early performance indicator.



**Data Fields:** customers.customer_since, customers.customer_segment, customers.customer_id, policies.customer_id, policies.annual_premium, policies.status

---

## Section 6: Policy Status Overview

Of 18 total policy records, 16 are Active, one is Expired, and one is Lapsed. The Expired policy was subsequently replaced with a new active policy, indicating an effective renewal process for that customer. The Lapsed record represents a genuine attrition event with no corresponding renewal entry. Ensuring all expiring policies are systematically entered into the renewal workflow before their expiry date is a recommended operational improvement.



**Data Fields:** policies.status, policies.expiry_date, policies.effective_date, policies.policy_id, policies.customer_id

---

## Appendix & Notes

### Assumptions
- Policy status fields are assumed to be current and maintained in near-real-time.
- Renewal premium values represent offered rates; final bound premiums may differ after negotiation.
- The renewals table captures formal offers only; informal discussions not entered in the system are excluded.
- Customer segment classifications are assigned at onboarding and assumed accurate.

### Known Limitations
- Mid-term policy changes and endorsements are not captured; actual in-force premium may vary.
- New business pipeline data not yet bound is unavailable in the current schema.
- Reasons for renewal declinations or lapses are not currently recorded.
- Customer-level profitability cannot be fully computed without complete claims disbursement records.

### Recommended Next Analysis
- Build a full renewal funnel report tracking offer-to-decision conversion by product, channel, and region.
- Develop a customer lifetime value model using premium history, tenure, and claims frequency.
- Implement a lapse risk scoring model to prioritise proactive retention outreach.
- Analyse competitor pricing for BOP and Commercial Property in Mid-Atlantic to understand renewal decline drivers.

---
*Meridian Shield Insurance Group — Confidential Internal Report*
