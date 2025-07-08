# Global Layoffs SQL Analysis (2020–2023)
This project focuses on analyzing employee layoffs globally between 2020 and 2023 using SQL. The dataset contains real-world information collected from publicly reported layoff events and includes details such as:

- Company name

- Industry

- Location and country

- Number and percentage of employees laid off

- Company funding stage

- Total funds raised

- Layoff date

## Data Cleaning & Preprocessing
Before performing any analysis, the raw data required extensive cleaning. This was accomplished using SQL and involved the following steps:

### Standardizing Text Fields: 
Fixed inconsistent values in country, industry, and location fields (e.g., “United States” vs “US”, “Crypto” vs “crypto”, etc.).

### Typo Correction: 
Cleaned entries such as floria ➝ Florianópolis, sseldorf ➝ Dusseldorf, and more.

### Removing Duplicates:
Used the ROW_NUMBER() window function to identify and eliminate exact duplicate rows.

### Whitespace Trimming:
Trimmed leading/trailing spaces in company names.

### Date Conversion: 
Converted string-formatted dates to proper DATE type using STR_TO_DATE.

### Null Value Handling:

Replaced empty strings with NULL.

Removed rows where both total_laid_off and percentage_laid_off were missing.

Used self-joins to fill missing industry values based on matching companies.

### Research-Based Imputation:

Carefully filled missing funds_raised_millions and total_laid_off values using trusted external sources (Crunchbase, company reports, tech media, etc.).

This ensured the KPIs used for EDA were as accurate and meaningful as possible.

## Exploratory Data Analysis (EDA)
The cleaned dataset was then used to answer several key questions:

🔹 High-Level Overview
- Which industries were most affected?

- Which countries saw the highest layoffs?

- How do layoffs differ by company funding stage?

🔹 Temporal Trends
- In which months and years were layoffs highest?

- How have layoffs evolved over time (rolling cumulative total)?

🔹 Company Insights
- Which companies laid off the most employees overall?

- Which companies had multiple rounds of layoffs?

- Who were the top 5 layoff contributors within each funding stage?

🔹 Country & Industry Deep Dives
- Who were the top layoff contributors in each country and industry?

🔹 Extreme Events
- Which companies laid off 100% of their staff?

- Which fully laid-off companies had previously raised significant funds?

- Are there industries where early-stage startups collapsed more frequently?

🔹 Company Classification by Size
- What does layoff behavior look like when companies are grouped into:

  - Startups (Seed to Series B)

  - Intermediate (Series C to Series F)

  - MNCs / Late-stage (Series G+, Post-IPO, Acquired, etc.)

🔹 Yearly Industry Impact
Which industries were hit hardest each year from 2020 to 2023?
