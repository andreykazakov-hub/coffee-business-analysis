# Coffee Business Analysis
## Project overview
Orbit Roasters is a specialty coffee company operating across multiple regions, offering a variety of ethically sourced beans in standardized product sizes. The company focuses on pricing efficiency, customer retention, and regional sales performance. This project analyzes transactions data from 2019–2022 to evaluate overall sales performance, customer behavior, loyalty program impact, and pricing efficiency across product sizes.

## Executive summary
Across __957 orders__ from __913 customers__, the coffee business generated __$45,134.26 revenue__ and __$4,520.22 profit__ for an overall __10.02% margin__. The average order is __$47.16__.

The business is volume-driven by large sizes: the __2.5 size__ accounts for __$23,785.57 (52.7%) of revenue__, while margins remain flat near __10%__ across all sizes. Revenue is primarily concentrated in the __United States ($35,638.89 | 79.0%)__, with Ireland and the UK making up the remainder.

From __2019–2021__, revenue rose from __$12,187.17 → $13,766.11 (+13.6%)__; 2022 is partial (Jan 1–Aug 19) so it appears lower ($7,063.44).

<img width="1439" height="771" alt="coffee-excel-dashboard" src="https://github.com/user-attachments/assets/6bee90c7-1026-4fe5-9b30-49a1680a83b2" />

_coffee-dashboard.xlsx_

## Data Cleaning & Preparation

**1. Data Consolidation**

All relevant information (orders, customers, and coffee details) was merged into a single orders sheet.
The goal was to create one analysis-ready table where each row represents a complete transaction record.

**2. Data Completion**

Customer information was filled in by utilizing **XLOOKUP** by customer_id

<img width="954" height="100" alt="xlookup-coffee" src="https://github.com/user-attachments/assets/5dce9331-b6a4-4a98-8b1e-9a870fc40cd3" />

Missing coffee/product information was filled using **INDEX_MATCH**

<img width="1008" height="165" alt="indexmatch-coffee" src="https://github.com/user-attachments/assets/a599f107-7152-48b3-82c9-12f340c85d38" />

*Populated multiple columns across rows (coffee type, roast, size, price)*

**3. Data Validation & Formatting**

To prepare the dataset for a **Pivot Table and SQL querying:**

- Standardized column formats (dates, text, numeric values)

- Checked and removed duplicate records

- Verified key relationships (order_id, customer_id, product_id)

- Ensured consistent structure for relational analysis

## Key insights

## Margin is “stuck” around ~10%

Overall margin is __~10.0%__, and it’s remarkably stable across time (~9.85%–10.09% from 2019–2022).

By size, margin barely changes:

- 0.2 kg: ~10.00%
- 0.5 kg: ~10.13%
- 1.0 kg: ~10.07%
- 2.5 kg: ~9.96%

_The pricing is scaling up, but profitability isn’t. Selling more units doesn't improve profit quality. This is a direct opportunity to redesign the margin structure._

_By pushing even a small margin shift (e.g., from __10% → 15%__) on the high-volume products, total profit moves disproportionately._

<img width="671" height="374" alt="roast-margin-bar-resized" src="https://github.com/user-attachments/assets/8c799afc-d9cf-4eeb-9b08-c1c630c7d4f6" />

## Best-selling Products: Liberica and Excelsa

- Liberica: $12,054.08 revenue (26.7%), $1,567.03 profit (34.7%), ~13% margin
- Excelsa: $12,306.44 (27.3%), $1,353.71 (29.9%), ~11% margin
- Arabica: $11,768.50 (26.1%), $1,059.16 (23.4%), ~9% margin
- Robusta: $9,005.25 (20.0%), $540.31 (12.0%), ~6% margin

_Robusta generates meaningful revenue, but it’s the biggest profit leak per dollar sold. This is the most obvious place to raise price, improve sourcing/cost, or reposition (bundle/upsell rather than compete on price)._

## 2.5 kg dominates revenue (and can fund growth)

__2.5 kg__ accounts for __~52.7% of total revenue__ ($23,785.57 out of $45,134.26).

Other sizes:

- 1.0 kg: $11,010.75 (~24.4%)
- 0.5 kg: $7,029.99 (~15.6%)
- 0.2 kg: $3,307.95 (~7.3%)

_The business is heavily supported by “bulk” orders. __By improving margin on 2.5 kg__ even slightly, it will increase total profit._

<img width="672" height="373" alt="size-percentage-bar-resized" src="https://github.com/user-attachments/assets/ddbf8c94-68aa-44c4-a217-c0ab175d71fd" />

## Size economics: 2.5 dominates revenue, but “value per 100g” drops as size increases

Average price per 100g drops consistently with size:

- 0.2 kg: ~1.864
- 0.5 kg: ~1.491
- 1.0 kg: ~1.243
- 2.5 kg: ~1.143

_That’s a big “bulk discount curve,” yet margin stays flat ~10%._
_The pricing ladder is mostly scaling revenue, not improving profitability. There’s room to reduce the bulk discount slightly (especially on top sellers) while maintaining the value narrative._

## Retention is extremely low (loyalty doesn’t change behavior)

Only 2.7% of customers placed more than 1 order.

- Average Orders per customer: ~1.05 for both groups
- Repeat rate ≈ 2.6%–2.9% (tiny difference)
- Margin: both ~10%

## Almost every order is single-item

96.8% of orders contain only 1 line item.

Increase basket size: bundles (e.g., “tasting set”, “2-roast combo”), free shipping threshold, and add-ons at checkout to lift average order value without needing more traffic.

## Geographic concentration: US is the market to double-down

- United States: 743 orders, $35,638.89 revenue (79.0%)
- Ireland: 146 orders, $6,696.87 (14.8%)
- United Kingdom: 68 orders, $2,798.51 (6.2%)

<img width="496" height="456" alt="country-donut-chart" src="https://github.com/user-attachments/assets/2c6c9d2e-e9ac-4ee3-925d-44fb0284678f" />
