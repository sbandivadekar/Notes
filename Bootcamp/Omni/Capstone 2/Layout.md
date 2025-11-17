## 🧭 **Dashboard Name:**

### “MakeMyTrip Travel Operations & Performance Dashboard”

### 🧩 **Goal:**

Track performance of bookings across Flights, Trains, and Buses — understand revenue trends, cancellations, customer satisfaction, and booking behavior over time.

# colors
Primary - **Red** (#E62829)
Secondary **Blue (#0071BC)**


## ⚙️ PAGE 1 — Executive Overview (KPIs & Trends)

**Purpose:**  
To give leadership a _high-level snapshot_ of company performance in one glance — no drilling, just insights.

**Why needed:**

- Management wants to instantly know _how the business is performing overall_ — total bookings, revenue, average value, and trends.
    
- These KPIs show **growth**, **health**, and **volume** of operations.
    
- Charts (trend, region, type) highlight _where revenue is coming from_ and _how it changes over time_.  
    ✅ Ideal for quick boardroom updates or monthly performance reviews.
---

## 🧭 PAGE 2 — Operational Insights (Efficiency & Performance)

**Purpose:**  
To help operations teams identify _efficiency gaps_ and _bottlenecks_ in execution.

**Why needed:**

- Understanding **cancellations**, **refunds**, and **profit margins** directly impacts cost control.
    
- You can discover:
    
    - Which regions or travel types cause more cancellations.
        
    - Whether longer trips (Distance_KM) actually increase profit or not.
        
    - How driver ratings correlate with profitability or cancellations.
        
- This helps operations managers **improve efficiency**, **reduce loss**, and **enhance service quality**.  
    ✅ Great for internal performance reviews and daily operations monitoring.

---

## 🌍 PAGE 3 — Customer & Market Insights

**Purpose:**  
To help marketing and strategy teams analyze **customer behavior and satisfaction** across segments.

**Why needed:**

- Identifies **who your best customers are** and which segments bring in the most value.
    
- Tracks **customer experience trends** via ratings.
    
- Helps in targeting **high-value** or **loyal** customers and planning retention campaigns.
    
- The region × travel type heatmap reveals _where market demand and revenue concentration are highest_.  
    ✅ Useful for marketing, product, and regional planning teams.
---



# 🧭 PAGE 1 — Executive Overview (KPI & Trends)

🎯 **Goal:**  
Quick snapshot of overall business performance — bookings, revenue, and high-level trends.

---

## 🧩 STEP 1 — KPI CARDS (Row of 5 Cards)

|KPI Name|Formula|Purpose|
|---|---|---|
|**Total Bookings**|`COUNT([Booking_ID])`|Measure total volume of bookings|
|**Total Revenue**|`SUM([Revenue_After_Discount])`|Overall revenue earned|
|**Avg Booking Value**|`AVG([Booking_Value])`|Typical transaction size|
|**Cancellation Rate (%)**|`COUNTIF([Booking_Status]="Cancelled") / COUNT([Booking_ID]) * 100`|Health of operations|
|**Avg Customer Rating**|`AVG([Customer_Rating])`|Service quality measure|

🧠 **Tip:** Create `Revenue_After_Discount = [Booking_Value] * (1 - [Discount_Applied]/100)` as a calculated column first.

---

## 📈 STEP 2 — LINE CHART: Monthly Revenue Trend

|Setting|Value|
|---|---|
|**X-Axis**|`Booking_Date` (Month bin)|
|**Y-Axis**|`SUM([Revenue_After_Discount])`|
|**Filter**|`Travel_Type` (Multi-select)|
|**Sort**|By Booking_Date ascending|
|**Title**|“Monthly Revenue Trend”|
|**Format**|₹ Currency, smooth line optional|

🧠 **Purpose:** Shows seasonality & revenue growth patterns over time.

---

## 📊 STEP 3 — BAR CHART: Revenue by Region

|Setting|Value|
|---|---|
|**X-Axis**|`Region`|
|**Y-Axis**|`SUM([Revenue_After_Discount])`|
|**Sort**|Descending by revenue|
|**Color**|MakeMyTrip Blue/Red|
|**Title**|“Revenue by Region”|

🧠 **Purpose:** Identify high-performing regions.

---

## 🚀 STEP 4 — TOP N BAR CHART: Top 5 Travel Types by Revenue

|Setting|Value|
|---|---|
|**X-Axis**|`Travel_Type`|
|**Y-Axis**|`SUM([Revenue_After_Discount])`|
|**Filter**|Limit → Top 5 by Revenue|
|**Color**|Different hue per type|
|**Title**|“Top 5 Travel Types by Revenue”|

🧠 **Purpose:** Focus on the most profitable travel modes.

---

## ❌ STEP 5 — LINE/AREA CHART: Monthly Cancellation Rate

| Setting     | Value                                                               |
| ----------- | ------------------------------------------------------------------- |
| **X-Axis**  | `Booking_Date` (Month bin)                                          |
| **Y-Axis**  | `Cancellation Rate (%)` (calculated field)                          |
| **Formula** | `COUNTIF([Booking_Status]="Cancelled") / COUNT([Booking_ID]) * 100` |
| **Title**   | “Cancellation Trend Over Time”                                      |

🧠 **Purpose:** Track cancellation spikes and seasonal reliability.

---

## 🎛 STEP 6 — FILTERS (Global Controls)

- `Travel_Type`
    
- `Region`
    
- `Season`
    
- `Year (from Booking_Date)`
    

---

# ⚙️ PAGE 2 — Operational Insights (Efficiency & Performance)

🎯 **Goal:**  
Measure efficiency, cost-effectiveness, and reliability of operations.

---

## 🧩 STEP 1 — KPI CARDS

|KPI|Formula|Purpose|
|---|---|---|
|**Avg Distance (KM)**|`AVG([Distance_KM])`|Trip length trends|
|**Avg Profit Margin (%)**|`AVG([Profit_Margin_%])`|Overall profitability|
|**Driver Cancellation %**|`COUNTIF([Cancellation_Reason]="Driver") / COUNT([Booking_ID]) * 100`|Reliability indicator|
|**Total Refunds (₹)**|`SUM([Refund_Amount])`|Financial impact of cancellations|

---

## 📊 STEP 2 — BAR CHART: Avg Profit Margin by Travel Type

|Setting|Value|
|---|---|
|**X-Axis**|`Travel_Type`|
|**Y-Axis**|`AVG([Profit_Margin_%])`|
|**Sort**|Descending by margin|
|**Title**|“Average Profit Margin by Travel Type”|

🧠 **Purpose:** Compare profitability across categories.

---

## 🚗 STEP 3 — STACKED BAR: Cancellation Reasons by Travel Type

|Setting|Value|
|---|---|
|**X-Axis**|`Travel_Type`|
|**Y-Axis**|`COUNT([Booking_ID])`|
|**Color by**|`Cancellation_Reason`|
|**Filter**|Only cancelled bookings|
|**Title**|“Cancellation Reasons by Travel Type”|

🧠 **Purpose:** See which type faces more customer vs driver cancellations.

---

## ⏱️ STEP 4 — LINE CHART: Avg Time Gap (Booking vs Travel)

|Setting|Value|
|---|---|
|**X-Axis**|`Booking_Date` (Month)|
|**Y-Axis**|`AVG(DATEDIFF([Travel_Date], [Booking_Date]))`|
|**Title**|“Avg Days Between Booking and Travel”|

🧠 **Purpose:** Understand booking behavior (advance vs last-minute).

---

## 🏆 STEP 5 — TOP N BAR: Top 5 Routes by Profit

|Setting|Value|
|---|---|
|**X-Axis**|`[Source_City] + " → " + [Destination_City]`|
|**Y-Axis**|`SUM([Revenue_After_Discount])`|
|**Filter**|Top 5 by Revenue or Profit|
|**Title**|“Top 5 Routes by Profitability”|

🧠 **Purpose:** Identify best-performing city pairs.

---

## 🎛 STEP 6 — FILTERS

- `Travel_Type`
    
- `Region`
    
- `Year`
    
- `Cancellation_Reason`
    

---

# 💰 PAGE 3 — Customer & Financial Insights (Experience & Loyalty)

🎯 **Goal:**  
Understand customer behavior, ratings, payments, and refund impact.

---

## 🧩 STEP 1 — KPI CARDS

|KPI|Formula|Purpose|
|---|---|---|
|**Avg Customer Rating**|`AVG([Customer_Rating])`|Quality perception|
|**Total Refund Amount (₹)**|`SUM([Refund_Amount])`|Financial leak tracking|
|**Avg Revenue per Customer**|`SUM([Revenue_After_Discount]) / COUNTDISTINCT([Customer_ID])`|Loyalty profitability|
|**Repeat Customers (%)**|_(Join to Customer_Details or logic via Customer_ID duplicates)_|Retention health|

---

## 📊 STEP 2 — BAR CHART: Avg Rating by Customer Segment

|Setting|Value|
|---|---|
|**X-Axis**|`Customer_Segment`|
|**Y-Axis**|`AVG([Customer_Rating])`|
|**Title**|“Average Rating by Customer Segment”|

🧠 **Purpose:** Identify which segment rates services best.

---

## 🍩 STEP 3 — DONUT CHART: Payment Method Split

|Setting|Value|
|---|---|
|**Category**|`Payment_Method`|
|**Value**|`COUNT([Booking_ID])`|
|**Title**|“Bookings by Payment Method”|

🧠 **Purpose:** Track transaction channel usage (credit, wallet, UPI, etc.)

---

## 💸 STEP 4 — LINE CHART: Refund Trend Over Time

|Setting|Value|
|---|---|
|**X-Axis**|`Booking_Date` (Month)|
|**Y-Axis**|`SUM([Refund_Amount])`|
|**Title**|“Refund Amount Trend Over Time”|

🧠 **Purpose:** Spot refund spikes and seasonal issues.

---

## 🌆 STEP 5 — TOP N BAR: Top 5 Cities by Avg Rating

|Setting|Value|
|---|---|
|**X-Axis**|`Source_City`|
|**Y-Axis**|`AVG([Customer_Rating])`|
|**Filter**|Top 5 by Rating|
|**Title**|“Top 5 Cities by Customer Rating”|

🧠 **Purpose:** Celebrate or learn from best-performing cities.

---

## 🎛 STEP 6 — FILTERS

- `Customer_Segment`
    
- `Travel_Type`
    
- `Year`
    
- `Region`