> Fact is not fact table

# Types of Fact tables
### **1. Transaction Fact Table**
- Stores **detailed transactional data** at the most granular level.
- One row = one transaction/event.
- High volume, used for **detailed analysis**.

> 2 facts can store in same table when 2 rules are in play.
> 1. facts available at same level (Example - tuition bill and tuition payment).
> 2. facts occurs simultaneously. 

### **2. Periodic Snapshot Fact Table**
- Captures **data at a fixed interval** (daily, weekly, monthly, etc.).
- Shows **status at a point in time**, not individual transactions.
- Used for **trend analysis**.

### **3. Accumulating Snapshot Fact Table**
- Tracks the **lifecycle of a process** by capturing milestones/events.
- A row is **updated as events occur**.
- Good for processes with a **clear start and end**.

### **4. Fact-less Fact Table**

- Contains **no numeric measures**, only keys.
- Used to **capture events** (something happened) or **conditions** (something did not happen).
- Two types:
    - **Event-tracking factless fact** → e.g., Student attended a course (yes/no).
    - **Coverage factless fact** → e.g., Which students were _eligible_ for a scholarship, even if they didn’t apply.

