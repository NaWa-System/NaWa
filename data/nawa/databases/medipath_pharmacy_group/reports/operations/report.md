# Q1 2024 Clinical Services & Inventory Operations Report

**Organisation:** MediPath Pharmacy Group  
**Reporting Period:** January 1, 2024 – March 31, 2024  
**Report Type:** Operations  
**Prepared by:** Pharmacy Operations & Analytics Team  
**Date of Issue:** April 2024

---

## Executive Summary

MediPath Pharmacy Group's clinical services programme continued to expand its reach during Q1 2024, with 20 service appointments recorded across all six store locations. The programme delivered flu vaccinations, medication therapy reviews, blood pressure checks, diabetes management reviews, and asthma management consultations. The overall service completion rate was 95%, with only one appointment cancelled during the period, reflecting strong operational reliability across the clinical team.

Medication Therapy Reviews and Diabetes Management Reviews represented the highest-fee clinical services, contributing meaningfully to supplementary revenue beyond the core dispensing business. Flu vaccination services demonstrated high volume throughput and served an important patient acquisition and community health function.

From an inventory operations perspective, analysis of stock-on-hand levels relative to reorder thresholds identified several locations approaching alert status. The Spokane location's Atorvastatin 20mg inventory stood at 22 units against a reorder level of 20. The Portland Main location's specialty compounding product held only 18 units against a reorder threshold of 10, warranting close monitoring given the product's high margin contribution.

Overall, the operational picture for Q1 2024 is positive. Proactive reorder processes should be initiated for at-risk products ahead of Q2, and clinical service scheduling capacity should be reviewed in preparation for anticipated spring demand increases.

---

## Key Metrics

| Metric | Value | Context |
|---|---|---|
| Total Clinical Services Delivered | 20 | Across all 6 store locations, Q1 2024 |
| Clinical Service Completion Rate | 95% | 1 cancellation recorded at MediPath Eugene |
| Total Clinical Service Revenue | $750.00 | Gross fees across all appointments |
| Most Frequent Service Type | Flu Vaccination | 5 appointments; highest volume service type |
| Highest-Fee Service Type | Diabetes/Asthma Management Review | $55.00 per session |
| Store with Most Clinical Services | MediPath Seattle Central | 4 events during the quarter |
| Inventory Items Near Reorder Level | 3 | Atorvastatin (Spokane), Compounding (Portland), Test Strips (Tacoma) |
| Average Clinical Service Fee | $37.50 | Blended average across all service types |
| Unique Patients Served (Clinical) | 12 | All registered customers accessed at least one service |
| Clinical Services per Store (avg.) | ~3.3 | Even distribution across the network |

---

## Section 1: Clinical Service Volume and Completion Rates

A total of 20 clinical service appointments were recorded across all six MediPath locations during Q1 2024. Of these, 19 were completed successfully, yielding a 95% completion rate. The single cancellation occurred at MediPath Eugene in late February and was recorded against a flu vaccination appointment. No no-show records were captured in the current dataset. Service delivery was broadly consistent across locations, with each store contributing between three and four appointments during the quarter. The high completion rate reflects well on the scheduling and clinical staffing model currently in operation.

**Data fields:** clinical_services.service_id, clinical_services.store_id, clinical_services.outcome_status, clinical_services.service_date, clinical_services.service_type

---

## Section 2: Clinical Service Revenue by Type

Medication Therapy Reviews and Management Reviews generated the highest revenue per appointment at $45.00 and $55.00 respectively. Flu vaccinations were the most frequently delivered service at $25.00 per appointment. Blood pressure checks, at $15.00 per session, provided a consistent and low-cost patient engagement touchpoint. Collectively, clinical services generated $750.00 in gross fee revenue during the quarter, representing a meaningful non-dispensing revenue stream.

**Data fields:** clinical_services.service_type, clinical_services.service_fee, clinical_services.outcome_status, clinical_services.service_date, clinical_services.store_id

---

## Section 3: Clinical Service Distribution by Store

MediPath Seattle Central conducted the highest number of clinical service events in Q1, with four appointments. MediPath Portland Main and MediPath Bellevue each delivered three events, including higher-fee management review services. Tacoma, Eugene, and Spokane each contributed three or four events, demonstrating an operationally even distribution across the network. Store-level variation in service type mix reflects local patient demographic differences, with chronic disease management reviews more prevalent at stores serving older patient populations.

**Data fields:** clinical_services.store_id, clinical_services.service_type, clinical_services.service_fee, clinical_services.service_date, stores.store_name, stores.region

---

## Section 4: Pharmacist Workload and Service Attribution

Clinical services were administered across six named pharmacists during Q1 2024, with each pharmacist aligned to a primary store location. Pharmacist Chen at Seattle Central and Pharmacist Ruiz at Portland Main each delivered multiple service types, demonstrating versatility. Pharmacist Kim at Eugene recorded the only cancellation of the quarter. No pharmacist delivered more than four services during the quarter, suggesting clinical service load is currently within manageable capacity bounds. As volumes grow, cross-location coverage protocols should be formalised.

**Data fields:** clinical_services.administered_by, clinical_services.service_type, clinical_services.outcome_status, clinical_services.store_id, clinical_services.service_date

---

## Section 5: Inventory Stock Level Assessment

An assessment of current inventory levels relative to reorder thresholds identified three products at elevated replenishment risk. At MediPath Spokane, Atorvastatin 20mg had 22 units on hand against a reorder level of 20. At MediPath Portland Main, the Custom Compound Topical Pain Gel held 18 units against a reorder level of 10; the specialised nature of this product and its longer replenishment lead time warrant proactive ordering. At MediPath Tacoma, Blood Glucose Test Strips held 35 units against a reorder level of 20. All other stocked products were observed to be holding inventory comfortably above their reorder thresholds.

**Data fields:** inventory.store_id, inventory.product_id, inventory.quantity_on_hand, inventory.reorder_level, inventory.last_restocked_date, stores.store_name, products.product_name

---

## Section 6: Patient Engagement Through Clinical Services

All 12 registered customers received at least one clinical service appointment during Q1 2024, indicating effective reach across the active patient population. Loyalty programme members were well-represented in clinical service activity, with customers managing chronic conditions accessing appointments aligned to their care needs. The intersection of clinical services and loyalty membership suggests an opportunity to use clinical appointment activity as a loyalty programme engagement mechanism.

**Data fields:** clinical_services.customer_id, clinical_services.service_type, clinical_services.service_date, customers.loyalty_member, customers.customer_id, customers.first_name, customers.last_name

---

## Section 7: Monthly Clinical Service Activity Trend

Clinical service activity was relatively evenly distributed across January, February, and March 2024, with six to seven appointments recorded in each month. January and March each recorded seven events, while February accounted for six, including the only cancellation. The consistency of monthly service volumes indicates stable operational delivery. The March figure, inclusive of new diabetes management and medication therapy review appointments, suggests growing patient awareness of and engagement with MediPath's clinical service offering.

**Data fields:** clinical_services.service_date, clinical_services.service_type, clinical_services.outcome_status, clinical_services.service_fee, clinical_services.store_id

---

## Appendix

### Assumptions
- Clinical service fees are recorded as gross billed amounts; insurance rebates or patient subsidies are not captured.
- 'Completed' outcome status indicates full service delivery by the administering pharmacist.
- Inventory quantities represent physical stock on hand as of the last_restocked_date.
- Each pharmacist is the primary clinical services administrator at their assigned store.

### Known Limitations
- The clinical_services table does not capture appointment booking lead time, patient wait times, or pharmacist hours per service.
- Inventory data does not include pending purchase orders, in-transit stock, or historical consumption rates.
- No supplier lead time or wholesale pricing data exists in the schema.
- The dataset is illustrative in scale; real-world reporting would reflect substantially higher volumes.

### Recommended Next Analysis
- Implement appointment booking and wait-time tracking to enable capacity planning and patient experience reporting.
- Develop an inventory consumption rate model using transaction_items dispensing data joined to inventory for days-of-supply calculations.
- Introduce a supplier and purchase order table to enable end-to-end procurement cost and lead time analysis.
- Analyse the correlation between clinical service participation and prescription refill adherence rates to quantify patient retention value.
