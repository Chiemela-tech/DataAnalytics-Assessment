# Data Analytics Assessment

This repository contains SQL-based solutions to a data analytics assessment focused on customer behavior, transaction analysis, and performance metrics for a financial services platform - Cowrywise. The queries are designed to extract meaningful insights from transactional and user data.

---

## 📁 Repository Structure

chiemela-tech-dataanalytics-assessment/
└── DataAnalytics-Assessment/
├── Assessment_Q1.sql # High-Value Customers with Multiple Products
├── Assessment_Q2.sql # Transaction Frequency Analysis
├── Assessment_Q3.sql # Account Inactivity Alert
└── Assessment_Q4.sql # Customer Lifetime Value Estimation


---

## 🧠 Evaluation Criteria

Each SQL solution is crafted with the following in mind:

- **Accuracy**: Results match the business requirements.
- **Efficiency**: Queries use optimized filters, aggregations, and joins.
- **Completeness**: All tasks outlined in the prompt are addressed.
- **Readability**: Well-formatted code with clear aliasing, indentation, and logic grouping.

---

## ✅ SQL Assessment Questions and Solutions

### **1. High-Value Customers with Multiple Products**

**Objective**: Identify customers who hold both funded savings and investment plans and rank them by their total deposits.

**Tables Used**:  
- `users_customuser`  
- `plans_plan`  
- `savings_savingsaccount`  

**Key Logic**:
- Filter on `p.is_regular_savings = 1` for savings plans.
- Filter on `p.is_a_fund = 1` for investment plans.
- Use `s.confirmed_amount` (in kobo) for deposits.
- Customers must have at least one of each type of plan.


---

### **2. Transaction Frequency Analysis**

**Objective**: Segment customers based on their average monthly deposit frequency.

**Tables Used**:
- `users_customuser`
- `plans_plan`
- `savings_savingsaccount`

**Key Logic**:
- Average monthly transaction rate = (Total transactions) / (Months since first transaction).
- Categorize users:
  - `High Frequency`: ≥ 10 tx/month
  - `Medium Frequency`: 3–9 tx/month
  - `Low Frequency`: ≤ 2 tx/month


---

### **3. Account Inactivity Alert**

**Objective**: Identify accounts with no deposits in the last 365 days.

**Tables Used**:
- `plans_plan`
- `savings_savingsaccount`

**Key Logic**:
- Use `MAX(s.created_at)` to get the last transaction.
- Calculate inactivity days as `JULIANDAY(NOW) - JULIANDAY(MAX(s.created_at))`.
- Filter where inactivity is ≥ 365 days.


---

### **4. Customer Lifetime Value (CLV) Estimation**

**Objective**: Estimate each customer’s lifetime value using transaction history and tenure.

**Tables Used**:
- `users_customuser`
- `savings_savingsaccount`

**Formula**:
CLV = (total_transactions / tenure_months) * 12 * average_profit_per_transaction

pgsql
Copy
Edit
- Assume `profit_per_transaction = 0.1%` of each transaction amount.
- Tenure is calculated as months since the user's earliest transaction.


---

## 🛠 Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/chiemela-tech-dataanalytics-assessment.git
   cd chiemela-tech-dataanalytics-assessment
Import adashi_assessment.sql into your MySQL or compatible SQL environment to simulate the database schema and data structure.

Run each query individually from the corresponding SQL files under DataAnalytics-Assessment/.

📌 Notes & Assumptions
All monetary values in the database are stored in kobo, hence are divided by 100 for standard currency representation.

is_regular_savings = 1 flags a plan as a savings plan.

is_a_fund = 1 flags a plan as an investment plan.

The schema assumes a logical relational structure with foreign keys (owner_id, plan_id) linking users and plans to transactions.

🧾 License
This project is licensed under the MIT License.

📬 Contact
For inquiries or feedback, please reach out via [cchiemela2@gmail.com].
