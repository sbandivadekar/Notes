## 🩵 **PAGE 1 – SALES PERFORMANCE**

### 🎯 KPIs (Top Section)

|KPI|Formula / Type|Description|
|---|---|---|
|**Total Revenue**|`SUM(Order Transactions → Sale Price)`|Total sales made|
|**Total Orders**|`COUNT DISTINCT(Order ID)`|Count of unique orders|
|**Average Order Value (AOV)**|`SUM(Sale Price)/COUNT DISTINCT(Order ID)`|Avg value per order|
|**Profit Margin**|`(Retail Price - Cost) / Retail Price * 100`|Excel-based calculation|

**💡 Add:**

- **Dynamic Date Range Filter**
    
- **Templated Filter** for _Category_ (Default = “Electronics”)
    
- **Sorting** enabled by _Revenue_ (descending)
    
- **Dynamic Top N** using a slider to show “Top N Categories”
    

---

### 📊 CHARTS (4)

#### 1️⃣ **Monthly Revenue Trend**

**Type:** Line Chart  
**X:** `Created At` (Month)  
**Y:** `Sale Price (SUM)`  
**Features:**

- Filter by `Date Range`
    
- Add **Period-over-Period (PoP)** comparison → `This Month vs Last Month`
    
- Add **Dynamic Text Tile** → “Revenue increased by {{delta}}% MoM”
    

---

#### 2️⃣ **Top N Categories by Revenue**

**Type:** Bar Chart  
**X:** `Products → Category`  
**Y:** `Sale Price (SUM)`  
**Dynamic Top N:** Controlled via slider input  
**Sort:** Descending  
**Field Control:** Choose Top 5 / Top 10 / Top 20 dynamically

---

#### 3️⃣ **Revenue by Department**

**Type:** Donut / Pie  
**Slice:** `Products → Department`  
**Value:** `Sale Price (SUM)`  
**Default Filter:** Department = “Consumer Goods”  
**Feature:** Drilldown to Brand Level (Parent → Child Control)

---

#### 4️⃣ **Profit Margin by Category**

**Type:** Vega-Lite Custom Chart (Bullet or Lollipop)  
**X:** `Products → Category`  
**Y:** Calculated Field → `Profit Margin`  
**Spec (Vega-Lite):**

```
{
  "mark": {"type": "bar", "cornerRadius": 4},
  "encoding": {
    "x": {"field": "Category", "type": "nominal", "sort": "-y"},
    "y": {"field": "Profit Margin", "type": "quantitative"},
    "color": {"field": "Profit Margin", "type": "quantitative", "scale": {"scheme": "greens"}}
  }
}

```
**Feature:** Interactive hover tooltips with Revenue, Cost, and Margin.

### 🧩 **Interactivity & Design**

- Filters: Date Range, Category, Region
    
- Templated Filter Default: _Electronics_
    
- Dynamic Top N slider
    
- Sort toggle on chart headers
    
- Add HTML/CSS Markdown tile:
```
<div style="text-align:center; font-size:18px; font-weight:bold; color:#333;">
  Sales Performance Overview — {{Date Range}}
</div>

```

- KPI Cards: Format numbers with `₹` and `,` separators

## 🧍‍♂️ **PAGE 2 – CUSTOMER INSIGHTS**

### 🎯 KPIs

| KPI                          | Formula                                               | Description          |
| ---------------------------- | ----------------------------------------------------- | -------------------- |
| **Total Customers**          | COUNT DISTINCT(Users → ID)                            | Total unique buyers  |
| **Average Age**              | AVG(Users → Age)                                      | Mean customer age    |
| **Repeat Purchase Rate**     | COUNT(Users with >1 Orders)/COUNT(DISTINCT Users)*100 | Loyalty indicator    |
| **Avg Lifetime Value (LTV)** | SUM(Sale Price) / COUNT(DISTINCT Users)               | Interface-based calc |

**💡 Add Filters:** Gender, Country, Age Range  
**Enable Sorting:** City or Country by Revenue

---

### 📊 CHARTS (4)

#### 1️⃣ **Orders by City**

**Type:** Horizontal Bar  
**X:** `Users → City`  
**Y:** `Order ID (COUNT)`  
**Dynamic Top N:** Select Top N Cities  
**Sorting:** Enabled (Descending)  
**Feature:** Drill to `State` (LOD aggregation)

---

#### 2️⃣ **Gender Distribution**

**Type:** Pie / Donut  
**Slice:** `Users → Gender`  
**Value:** `Users → ID (COUNT DISTINCT)`  
**Filter:** Country (templated)  
**Dynamic Label:** “{{Male%}}% Male • {{Female%}}% Female”

---

#### 3️⃣ **Top Countries by Revenue**

**Type:** Vertical Bar  
**X:** `Users → Country`  
**Y:** `Sale Price (SUM)`  
**Filter:** By Region (Parent control)  
**Add PoP Comparison:** Revenue vs Previous Year

---

#### 4️⃣ **Age vs Average Spending**

**Type:** Scatter / Bubble  
**X:** `Users → Age`  
**Y:** `Sale Price (AVG)`  
**Bubble Size:** `Order Count`  
**Feature:** Add _Tooltip_ = City, Gender, Revenue  
**Add Regression Line (Trendline)**

---

### 🧩 **Design & Enhancements**

- Dynamic Text Tile: “Top City: {{Top City}} | Avg Age: {{Avg Age}} yrs”
    
- Apply gradient color palette for demographics
    
- Use AI Summary block:
    
    > “AI Summary: Most orders come from young urban customers (25–34), dominated by Tier-1 cities.”
    
- Column Formatting: Age → “yrs”, Revenue → “₹ #,##0”
    

---

## 🚚 **PAGE 3 – OPERATIONS & FULFILLMENT**

### 🎯 KPIs

|KPI|Formula|Description|
|---|---|---|
|**Avg Shipping Time**|AVG(Order Transactions → Time to Ship)|Average days to ship|
|**On-Time Delivery Rate**|COUNT(Delivered before Delivery_At)/COUNT(Delivered Orders)*100|Timely delivery %|
|**Total Returns**|COUNT(Return At IS NOT NULL)|Returned orders|
|**Top Distribution Center**|MAX(Orders by Center)|Center with highest order volume|

**💡 Add Filters:** Distribution Center, Status, Month

---

### 📊 CHARTS (4)

#### 1️⃣ **Orders by Distribution Center**

**Type:** Bar  
**X:** `Distribution Centers → Name`  
**Y:** `Order ID (COUNT)`  
**Dynamic Top N:** Top Centers by Orders  
**Add Drill:** LOD → Region → City

---

#### 2️⃣ **Average Shipping Time Trend**

**Type:** Line  
**X:** `Created At` (Month)  
**Y:** `Time to Ship (AVG)`  
**Feature:** Add PoP comparison → Current vs Previous Month  
**Dynamic Text Tile:** “Avg Time to Ship: {{AvgShipDays}} days”

---

#### 3️⃣ **Order Status Breakdown**

**Type:** Donut / Pie  
**Slice:** `Order Transactions → Status`  
**Value:** `Order ID (COUNT)`  
**Color by:** Status  
**Filter:** Date Range (default current month)

---

#### 4️⃣ **Distribution Center Map**

**Type:** Geo Map  
**Latitude:** `Distribution Centers → latitude`  
**Longitude:** `Distribution Centers → longitude`  
**Value:** `Order ID (COUNT)`  
**Tooltip:** Center Name, Total Orders, Avg Delivery Time  
**Dynamic Color Scale:** Based on On-Time Rate

---

### 🧩 **Interactivity & Design**

- **Parent Control:** Region → filters centers dynamically
    
- **Field Control:** Choose metric for map (Orders / Revenue / Delay Time)
    
- **HTML/CSS Header Tile:**

```
<div style="font-size:20px; font-weight:600; color:#0b5394; text-align:center;">
  Operations & Fulfillment — Performance Summary
</div>

```

**AI Context Tile:**

> “AI Insight: East Region centers show a 12% faster shipping time than last quarter.”

🧮 **ADVANCED CALCULATIONS SUMMARY**

| Type                       | Example                                                                   | Technique                  |
| -------------------------- | ------------------------------------------------------------------------- | -------------------------- |
| **Excel-based**            | `Profit Margin = (Retail Price - Cost)/Retail Price`                      | Simple formula             |
| **Interface-based (Omni)** | `Avg LTV = Total Revenue / Total Customers`                               | Omni function              |
| **XLOOKUP**                | Lookup user’s city → region mapping                                       | Data enrichment            |
| **LOD Calculation**        | `AVG(Sale Price)` per `User ID`                                           | LOD for per-customer view  |
| **PoP**                    | `(Current Month Revenue - Last Month Revenue) / Last Month Revenue * 100` | Time comparison            |
| **Dynamic Top N**          | User slider to pick Top N categories                                      | Field control              |
| **AI Function**            | `AI_SUMMARY([Customer Segment])`                                          | AI auto-insight generation |

🎨 **DESIGN, FORMATTING & AI INTEGRATION**

| Area                  | Enhancement                                     | Implementation          |
| --------------------- | ----------------------------------------------- | ----------------------- |
| **Theming**           | Gradient Blue-Green for visuals                 | Consistent color coding |
| **Layout**            | 2 rows per page (1 for KPIs, 1 for Charts)      | Visual balance          |
| **Formatting**        | ₹ for currency, comma separators                | Omni formatting         |
| **Dynamic Tiles**     | “{{Top Category}} leads with {{Revenue}} sales” | Text binding            |
| **AI Excel Function** | Auto-generate summary lines                     | Use `AI_SUMMARY`        |
| **AI Context**        | Inline AI block for page summary                | Contextual insight      |