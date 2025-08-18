# 🌟 What is SCD?

**SCD = Slowly Changing Dimension**

👉 In a data warehouse, **dimension tables** (like Student, Faculty, Product, Employee) usually contain attributes (name, address, department, salary, etc.).  
Sometimes, these values **change slowly over time** (not every day, but once in a while).

The question is:  
**When a dimension attribute changes, how do we store that change in the data warehouse?**  
That’s exactly what **Slowly Changing Dimensions (SCDs)** handle.

---
# 📌 Types of SCDs (the most common 3)

### **SCD Type 1 (Overwrite)**
- Old data is **replaced with new data**.
- History is **not kept**.
- ✅ Simple, saves space
- ❌ Lose old information

**Example:**
- Student Address changes from _“Delhi”_ → _“Mumbai”_.
- Table just updates to _“Mumbai”_ (Delhi is lost).

### **SCD Type 2 (History Tracking)**
- Keep **full history** by adding a **new row** when data changes.
- Use **effective dates** or **current flag** to know which record is active.
- ✅ Best for historical reporting.
- ❌ Table grows large.
    
**Example:**
- Faculty Department: _“Physics”_ → _“Computer Science”_.
- Table has 2 rows:
    - Row 1: Physics (active until change date)
    - Row 2: Computer Science (active now).

### **SCD Type 3 (Limited History)**

- Add a **new column** to store the “previous value”.
- Keeps only **current and one old value**.
- ✅ Less space, some history kept.
- ❌ Can’t track multiple changes.

**Example:**
- Employee Salary changes: 50,000 → 60,000.
- Table has columns: _Current_Salary = 60,000, Previous_Salary = 50,000_.
## 🎯 In Short
- **SCD1** → Replace (no history)
- **SCD2** → Add new row (full history)
- **SCD3** → Add new column (limited history)

---
