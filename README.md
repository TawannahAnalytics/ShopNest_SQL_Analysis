# ShopNest_SQL_Analysis
Identified key revenue drivers, customer behavior patterns, and seller performance gaps through SQL analysis of e-commerce data.
# 🛒 ShopNest E-Commerce SQL Analysis
**Tool:** Microsoft SQL Server | **Dataset:** 100 orders, 20 customers, 8 sellers, 15 products | **Domain:** E-Commerce / Business Analytics

---

## 📌 Project Overview

ShopNest is a fast-growing Nigerian e-commerce marketplace connecting buyers to third-party sellers across multiple product categories. This project delivers a full SQL-based business analytics solution covering revenue performance, customer behaviour, seller analysis, and operational efficiency.

The analysis was built entirely in Microsoft SQL Server, progressing from database design and data population through to advanced analytical querying using CTEs, window functions, subqueries and conditional aggregation.

---

## 🚀 Key Business Insights

- Revenue grew 114% in 4 months (₦1.38M → ₦2.96M)
- Electronics generated 77.7% of total revenue (high dependency risk)
- VIP customers represent 40% of users but drive the majority of revenue
- Average Order Value increased from ₦76K to ₦98K
- Low cancellation (4%) and return rate (5%) indicate strong operations
- Only 2 out of 8 sellers are top performers, highlighting growth opportunities

  
## 🗂️ Database Schema

| Table | Description |
|---|---|
| Customers | 20 registered customers with demographic and location data |
| Sellers | 8 marketplace vendors across 5 product categories |
| Products | 15 products with pricing and stock information |
| Orders | 100 transactional records including payment method, delivery status and delivery days |

**Relationships:**
- One Customer → Many Orders
- One Seller → Many Products
- One Product → Many Orders

> **Schema Note:** The Orders table was initially designed with DECIMAL(5,2) for monetary fields, which caused an arithmetic overflow during data insertion for high-value transactions. The table was redesigned with DECIMAL(12,2) and repopulated. This correction is documented in the SQL file.

---

## 🛠️ Tools & Techniques

- **Microsoft SQL Server** — Database design, population and querying
- **DDL** — CREATE TABLE, DROP TABLE, ALTER TABLE, constraints
- **DML** — INSERT INTO, sample data population
- **DQL** — SELECT queries across all complexity levels
- **Techniques used:** INNER JOIN, LEFT JOIN, GROUP BY, HAVING, WHERE, ORDER BY, COUNT, SUM, AVG, MIN, MAX, CASE statements, CTEs, Window Functions (LAG, SUM OVER), Subqueries (scalar, correlated, FROM), DATEDIFF, FORMAT, DATENAME, CAST, ROUND, DECIMAL

---

## 📊 Analysis — 17 Business Questions

### SECTION B — KPI Summary Dashboard

---

**B1. What is the total revenue from delivered orders?**
```sql
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE DeliveryStatus = 'Delivered';
```
**Result:** ₦7,988,500
**Insight:** ShopNest generated ₦7.99M from successfully delivered orders, providing a reliable baseline for revenue performance tracking.

---

**B2. How many unique customers placed at least one order?**
```sql
SELECT COUNT(DISTINCT CustomerID) AS ActiveCustomers
FROM Orders;
```
**Result:** 20 active customers
**Insight:** All 20 registered customers have placed at least one order, indicating 100% customer activation in this dataset.

---

**B3. What is the Average Order Value (AOV) per month?**

| Month | TotalOrders | TotalRevenue | AOV |
|---|---|---|---|
| January | 18 | ₦1,382,000 | ₦76,778 |
| February | 26 | ₦2,044,500 | ₦78,635 |
| March | 26 | ₦2,216,500 | ₦85,250 |
| April | 30 | ₦2,964,000 | ₦98,800 |

**Insight:** Both order volume and AOV increased consistently month-on-month, suggesting growing customer confidence and higher-value purchases over time.

---

**B4. What is the cancellation and return rate?**

| TotalOrders | Delivered | Cancelled | Returned | CancellationRate | ReturnRate |
|---|---|---|---|---|---|
| 100 | 86 | 4 | 5 | 4.00% | 5.00% |

**Insight:** ShopNest maintains a low cancellation rate (4%) and a moderate return rate (5%), indicating generally healthy fulfilment performance with room to reduce returns.

---

**B5. What is the revenue breakdown by product category?**

| Category | TotalOrders | TotalRevenue | RevenueShare |
|---|---|---|---|
| Electronics | 45 | ₦8,053,500 | 77.77% |
| Home & Living | 18 | ₦724,000 | 6.99% |
| Sports | 20 | ₦587,000 | 5.67% |
| Fashion | 29 | ₦493,500 | 4.77% |
| Books | 13 | ₦446,500 | 4.31% |

**Insight:** Electronics dominates revenue at 77.77%, creating significant business dependency on a single category. Diversification into other categories represents a key growth opportunity.

---

### SECTION C — Business Questions

---

**C1. Top 5 products by total revenue**

**Result:** iPhone 14 Pro leads at ₦3,570,000, followed by Samsung Galaxy A54 at ₦1,309,000.
**Insight:** High-value electronics dominate the top 5, with GadgetKing and TechZone NG as the primary revenue-generating sellers.

---

**C2. Which payment method generates the most revenue?**

**Result:** Card payments lead at ~38% revenue share, followed by Bank Transfer at ~34%.
**Insight:** Digital payment methods dominate. Cash on Delivery contributes the least (~3.5%), suggesting ShopNest's customer base is digitally comfortable.

---

**C3. Monthly revenue trend with month-over-month growth**

| Month | TotalRevenue | PreviousMonth | Growth (₦) | GrowthRate |
|---|---|---|---|---|
| January | ₦1,382,000 | NULL | NULL | NULL |
| February | ₦2,044,500 | ₦1,382,000 | ₦662,500 | 47.94% |
| March | ₦2,216,500 | ₦2,044,500 | ₦172,000 | 8.41% |
| April | ₦2,964,000 | ₦2,216,500 | ₦747,500 | 33.72% |

**Insight:** Revenue grew consistently across all four months. February's 47.94% spike likely reflects early customer acquisition. Growth slowed in March before recovering strongly in April at 33.72%.

---

**C4. Customers with more than 3 orders**

**Result:** 20 customers qualify — 10 with 6 orders each and 10 with 4 orders each.
**Insight:** Chinedu Okafor leads with ₦958,500 in total spend. Early adopters (January sign-ups) are the most loyal customers, placing the highest order volumes.

---

**C5. Churned early adopters — first order January 2024, no orders since February**

**Result:** No customers returned.
**Insight:** All ShopNest customers ordered across multiple months, confirming no early churn in this dataset. Query logic verified by testing across January and February 2024.

---

**C6. Customer segmentation by spend tier**

| Tier | Customers |
|---|---|
| VIP (>₦500,000) | 8 |
| Regular (₦100K–₦500K) | 10 |
| Casual (<₦100,000) | 2 |

**Insight:** 40% of customers are VIP, contributing the majority of revenue. Regular customers represent an upselling opportunity.

---

**C7. Product category with highest average delivery time**

| Category | AvgDeliveryDays | Min | Max |
|---|---|---|---|
| Home & Living | 4 | 2 | 7 |
| Electronics | 3 | 3 | 6 |
| Fashion | 3 | 2 | 4 |
| Books | 3 | 2 | 5 |
| Sports | 2 | 2 | 4 |

**Insight:** Home & Living has the slowest average delivery at 4 days. Sports is the fastest at 2 days. Logistics optimisation for Home & Living could improve customer satisfaction.

---

**C8. Products never ordered**

**Result:** No products returned.
**Insight:** All 15 products have been ordered at least once. Query verified by confirming 15 distinct ProductIDs exist in Orders.

---

**C9. Seller performance ranking with CASE classification**

| Seller | Category | TotalRevenue | Label |
|---|---|---|---|
| GadgetKing | Electronics | ₦5,073,000 | Top Seller |
| TechZone NG | Electronics | ₦1,620,500 | Top Seller |
| SportZone | Sports | ₦587,000 | Growing |
| Others | Various | <₦500,000 | Needs Growth |

**Insight:** Only Electronics sellers qualify as Top Sellers. BookNest has the highest rating (4.8) but lowest revenue — quality alone doesn't drive sales volume.

---

**C10. Sellers with above-average delivery times**

**Result:** GadgetKing, HomeGlow Interiors, KitchenPlus and SportZone all average 4 days — 1 day above the platform average of 3 days.
**Insight:** Operations team should investigate these 4 sellers to understand delivery delays and implement improvement measures.

---

### SECTION D — CTE Challenge

---

**D1. Seller Performance Scorecard (Two CTEs)**

- **CTE 1 — SellerMetrics:** Calculates TotalOrders, TotalRevenue, TotalDiscounts, AvgDeliveryDays, CancelledOrders and ReturnedOrders per seller
- **CTE 2 — SellerScore:** Adds CancellationRate, ReturnRate and a ReliabilityScore label (Excellent / Good / Poor)

**Key findings:**
- GadgetKing and TechZone NG — Excellent reliability with 0% cancellation
- SportZone and KitchenPlus — Poor rating due to higher cancellation/return rates
- FashionHub — flagged as Excellent despite 16.67% return rate, highlighting a gap in the scoring logic where ReturnRate is not factored into ReliabilityScore

---

**D2. Customer Purchase Journey (Two CTEs)**

- **CTE 1 — CustomerOrders:** Aggregates TotalOrders, TotalSpent, TotalDiscount, FirstOrderDate, LastOrderDate and FavouriteCategory (using a correlated subquery to identify most ordered category per customer)
- **CTE 2 — CustomerJourney:** Adds CustomerLifespanDays, AvgDaysBetweenOrders and SpendTier (VIP / Regular / Casual)
- **Final SELECT:** Joins back to Customers table for full demographic context

**Key findings:**
- Electronics is the favourite category for 12 out of 20 customers
- Average 17 days between orders — consistent purchasing behaviour
- VIP customers represent 40% of the base but the majority of revenue
- Casual customers (Zainab Garba, Halima Mohammed) are candidates for re-engagement campaigns

---

## 💡 Overall Business Conclusions

**Revenue** — ShopNest grew from ₦1.38M in January to ₦2.96M in April, a 114% increase in 4 months. Electronics drives 77.77% of all revenue — significant concentration risk.

**Customers** — Strong retention with all customers placing multiple orders. VIP customers deliver disproportionate value. Regular tier represents the biggest conversion opportunity.

**Sellers** — Only 2 of 8 sellers qualify as Top Sellers. Majority fall into Needs Growth, indicating platform-wide seller development is needed for sustainable growth.

**Operations** — Low cancellation (4%) and return (5%) rates indicate healthy fulfilment. Four sellers consistently deliver above the platform average — targeted intervention recommended.

---

## 📁 Project Structure

```
ShopNest_SQL_Analysis/
│
├── Shop_Nest_SQL_Project_P.sql   # Complete database setup and analytical queries
└── README.md                     # Project documentation and key insights
```

---

*This project was completed as a structured SQL analytics assignment. All data is fictitious and created solely for analytical demonstration purposes.*
