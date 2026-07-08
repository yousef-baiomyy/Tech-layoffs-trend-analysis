# Tech Layoffs & Hiring Trends Analysis

## 📌 Project Overview
This repository contains an end-to-end exploratory data analysis (EDA) of global technology sector layoffs and hiring trends between **2024 and 2026**. Using a dataset of 12,000 corporate records, this project uncovers the underlying macroeconomic indicators, industry shifts, corporate structures, and AI-driven automation impacts driving workforce changes.

The goal of this project is to turn raw infrastructure and corporate labor market data into actionable visual insights, highlighting patterns in hiring freezes, market conditions, and evolving technical roles.

---

## 📊 Dataset Architecture
The analysis is performed on a comprehensive dataset containing **12,000 rows** and **23 features** with zero missing values or duplicate records. 

### Features Breakdown

| Feature Name | Data Type | Description |
| :--- | :--- | :--- |
| `record_id` | Object | Unique identifier for each tracking record |
| `company_name` | Object | Name of the tech organization (e.g., Microsoft, Databricks) |
| `industry` | Object | Market sector (e.g., AI, Cybersecurity, Gaming, Social Media) |
| `country` | Object | Country of operations |
| `company_size` | Object | Enterprise tier (e.g., Startup, Mid-size, Big Tech, Enterprise) |
| `layoffs_count` | Int64 | Total number of employees laid off in the cycle |
| `layoff_percentage` | Float64 | Percentage of total company workforce affected |
| `reason_for_layoffs`| Object | Core driver (e.g., AI Automation, Cost Cutting, Overhiring) |
| `hiring_trend` | Object | Current recruitment status (e.g., Hiring Freeze, Moderate Hiring) |
| `top_hiring_role` | Object | Specific job profiles actively being recruited |
| `market_condition` | Object | Macro environment (e.g., Bull Market, Stable, Recession) |
| `ai_adoption_level` | Float64 | Structural scale of AI integration within the firm (1.0 - 10.0) |
| `job_security_score`| Float64 | Normalized employee retention confidence index (1.0 - 10.0) |

---

## 🛠️ Tech Stack & Libraries
* **Language:** Python
* **Data Manipulation:** Pandas, NumPy
* **Data Visualization:** Seaborn, Matplotlib
* **Environment:** Jupyter Notebook / VS Code

---

## 🔍 Analytical Workflow & Key Findings

### 1. Data Integrity & Verification
* Confirmed structural shape (`12000` rows, `23` columns).
* Verified data types and resource memory allocation (~2.1 MB).
* Executed data cleanliness checks, confirming **0 null values** and **0 duplicate records**.

### 2. Statistical Baseline Highlights
* **Layoffs Intensity:** Average layoff count per event stands at **~5,009 employees**, with a mean workforce reduction rate of **12.78%**.
* **AI & Automation Drivers:** Structural metrics show a significant intersection between shifting corporate budgets, rising AI adoption levels (mean: **5.54/10**), and workforce recalibration.
* **Hiring Postures:** Despite aggressive trimming strategies across several industry verticals, organizations maintain specific technical expansion tracks, frequently listing specialized roles even amidst widespread *Hiring Freezes*.

---

## 🚀 How to Run the Analysis

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/yourusername/tech-layoffs-analysis.git](https://github.com/yourusername/tech-layoffs-analysis.git)
   cd tech-layoffs-analysis
