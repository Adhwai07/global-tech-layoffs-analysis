# Global Layoffs SQL Analysis (2020–2023)
This project focuses on analyzing employee layoffs globally between 2020 and 2023 using SQL. The dataset contains real-world information collected from publicly reported layoff events and includes details such as:

- Company name

- Industry

- Location and country

- Number and percentage of employees laid off

- Company funding stage

- Total funds raised

- Layoff date

Data Cleaning & Preprocessing

- Prior to analysis, the raw data underwent extensive cleaning using SQL, involving the following key steps:
- Standardizing Text Fields: Corrected inconsistencies in country, industry, and location entries (e.g., “United States” vs. “US”, “Crypto” vs. “crypto”).
- Typo Correction: Fixed misspellings such as “floria” to “Florianópolis” and “sseldorf” to “Dusseldorf.”
- Removing Duplicates: Employed the ROW_NUMBER() window function to identify and remove exact duplicate rows.
- Whitespace Trimming: Eliminated leading and trailing spaces in company names.
- Date Conversion: Converted string-formatted dates to proper DATE type using STR_TO_DATE.
- Null Value Handling: Replaced empty strings with NULL, removed rows missing both total_laid_off and percentage_laid_off, and used self-joins to impute missing industry values based on matching companies.
- Research-Based Imputation: Filled missing funds_raised_millions and total_laid_off values using trusted external sources such as Crunchbase, company reports, and tech media.

These cleaning steps ensured the KPIs used in the EDA were as accurate and meaningful as possible.

## Exploratory Data Analysis (EDA)
Using the cleaned dataset, the analysis addressed several key questions across multiple dimensions:

* High-Level Overview:

  - Which industries experienced the highest layoffs?
  - Which countries saw the most workforce reductions?
  - How do layoffs vary by company funding stage?
  
- Temporal Trends:
  - In which months and years were layoffs most frequent?
  - How have layoffs evolved over time, including rolling cumulative totals?
  
- Company Insights:
  - Which companies had the largest layoffs overall?
  - Which companies conducted multiple rounds of layoffs?

- Extreme Events:
  - Which companies laid off 100% of their staff?
  - Which fully laid-off companies had previously raised significant funding?
  - Are early-stage startup collapses concentrated in specific industries?

- Company Classification by Size:
  - How does layoff behavior differ when grouping companies into:
    - Startups (Seed to Series B)
    - Intermediate stage (Series C to Series F)
    - MNCs / Late-stage firms (Series G+, Post-IPO, Acquired, etc.)
    
- Yearly Industry Impact:
  - Which industries were most affected each year between 2020 and 2023?
  
- Annual Trends & Industry Shocks:
  - What were the dominant macroeconomic factors driving layoffs each year?
  - Which industries peaked in layoffs in specific years (e.g., Travel in 2020, EdTech in 2022, Sales and Hardware in 2023)?
  - How did major global events (COVID-19 pandemic, inflation, interest rate hikes) influence layoff patterns?
  - How did large-scale layoffs by major companies (e.g., Airbnb, Byju’s, Salesforce, Dell) impact overall totals?
  - What insights does the sequence of layoffs (2022 > 2023 > 2020 > 2021) provide regarding economic cycles and market corrections?

## Key Findings and Insights

### Industry-Level Layoff Insights

![Screenshot 2025-07-08 164532](https://github.com/user-attachments/assets/cf76b513-ecdd-44f1-86ab-c190449e052a)

The Consumer and Retail industries were the most affected by layoffs across the dataset, each recording over 40,000 job cuts. Other heavily impacted sectors included:

* Transportation and Other categories (30K–35K range), likely reflecting logistics and cross-functional tech roles.

* Finance, Healthcare, and Food also appeared among the top seven, each facing significant workforce reductions driven by pandemic disruptions, market volatility, and rising operational costs.

This indicates that while tech-centric industries were dominant in news coverage, the layoff impact extended across traditional sectors as well.

### Country-Level Layoff Insights

![Screenshot 2025-07-08 165637](https://github.com/user-attachments/assets/49d24324-91eb-41f3-a035-00214301de4c)

The United States accounted for the overwhelming majority of layoffs in the dataset, with over 263,000 job cuts—far surpassing all other countries. This is reflective of the country’s large concentration of global tech firms, startups, and venture-backed companies.

Other top countries by total layoffs included:

- India – 36,493
- Netherlands – 17,220
- Sweden – 11,264
- Brazil – 10,391
- Germany – 8,801
- United Kingdom – 7,198

These figures underscore that while the U.S. led in absolute numbers, significant layoff events also occurred across Europe, South America, and Asia—highlighting the global nature of workforce contractions, especially within tech and consumer-facing industries.

### Layoffs by Company Funding Stage

![Screenshot 2025-07-08 173957](https://github.com/user-attachments/assets/6e6f80f5-de5b-4678-ba96-5645ccfc85d7)

Layoff volume varied significantly by funding stage, with Post-IPO companies accounting for the vast majority of workforce cuts—over 207,000 layoffs, far exceeding all other categories.

Other notable stages included:

* Acquired companies (~30K layoffs)

* Series C and Series D (each ~20K layoffs)

* Series B, E, and F (ranging from 10K to 15K layoffs)

This trend highlights that late-stage and publicly listed companies, despite their size and maturity, were not insulated from economic downturns. In fact, their scale made them primary contributors to total layoff numbers—often due to overexpansion during prior boom periods and pressure to deliver profitability in public markets.

### Monthly Layoff Trends

![Screenshot 2025-07-09 003407](https://github.com/user-attachments/assets/4c812134-fd13-4309-a962-3d6abc994b3f)

Layoffs were most heavily concentrated in January, which alone saw over 96,000 job cuts, nearly double that of the next highest month. This sharp spike suggests a pattern of cost-cutting and restructuring decisions being implemented at the start of the calendar year, especially after annual performance reviews and budget resets.

Other months with high layoff volumes included:

- November – 56,118
- February – 41,292
- May – 38,689
- April – 31,111

In contrast, September recorded the lowest total layoffs, followed by December and August, indicating relatively calmer periods in terms of workforce reduction.

This distribution reflects both strategic timing (e.g., fiscal year planning) and reactive layoffs tied to market shocks, funding cycles, and macroeconomic events.

### Yearly Layoff Trends (2020–2023)

![Screenshot 2025-07-08 192728](https://github.com/user-attachments/assets/f39ae1c6-b219-4f87-b373-70434853ca6d)

Layoff counts from 2020 to 2023 revealed distinct economic cycles characterized by shock, recovery, and correction phases. The highest layoffs occurred in 2022, with 165,516 job cuts, followed by 2023 with 129,915 layoffs. The year 2020 saw 81,010 layoffs, mainly during the early pandemic months, while 2021 had the lowest count at just 15,823 layoffs. The timeline illustrates:

- 2020: Initial Pandemic Shock, marked by layoffs in sectors like travel and retail due to lockdowns, but mitigated by a tech-driven digital surge.
- 2021: Unprecedented Boom, where stimulus and high demand drove workforce expansion, minimizing layoffs.
- 2022: Economic Correction, with inflation and rising interest rates drying up capital, triggering widespread layoffs and crypto/fintech collapses.
- 2023: Continued Pressure and Strategic Restructuring, as fears of recession and profitability demands led to deep layoffs, with a pivot toward AI and automation.

### Cumulative Layoff Growth Over Time
The rolling cumulative trend highlights a sharp and prolonged acceleration in layoffs starting mid-2022, with the total jumping from ~110,000 in April 2022 to over 260,000 by the end of that year — a more than 2.3× increase in just 8 months.

Another major surge occurred in January 2023, which alone added nearly 89,000 layoffs, marking the largest single-month increase in the entire dataset. This spike significantly pushed the cumulative total beyond 350,000 by March 2023.

These compounding effects reveal the momentum of layoffs during economic corrections — once companies begin restructuring, the trend tends to accelerate rapidly and cluster within short periods, especially across consecutive quarters.

### Industry Level Trends and Disparities

#### Sales Industry Layoffs in 2023
In 2023, the Sales industry experienced one of the highest layoff volumes, with major contributions from companies such as Salesforce, which conducted multiple large-scale layoffs throughout the year. Two primary factors drove this trend:

* Post-Pandemic Overhiring and Profit Pressure: During the COVID-19 boom, Sales companies aggressively expanded their workforce to meet surging digital demand. However, as growth slowed in 2023, many organizations found themselves overstaffed. Investor demands for improved profitability led to significant cost-cutting measures, including layoffs.

* Shift Toward Automation and Strategic Restructuring: The increasing adoption of AI-driven sales tools reduced the need for large traditional sales teams. For example, Salesforce reallocated resources toward AI innovation, resulting in layoffs of staff in conventional roles while investing in future-focused areas.

These layoffs highlight a broader recalibration across tech and SaaS sectors, transitioning from “growth at all costs” toward more sustainable and streamlined operations.

#### Hardware Industry Layoffs in 2023
The Hardware industry experienced a significant wave of layoffs in 2023, with leading companies such as Dell and IBM reporting substantial workforce reductions. This trend was driven by two main factors:
* Falling Demand and Inventory Corrections: Following a pandemic-driven surge in hardware demand, 2023 saw a marked decline in PC and device sales as both consumers and businesses reduced spending. Dell, for instance, faced a 20% drop in shipments caused by weaker commercial demand and excess inventory, prompting operational scale-backs and staffing cuts.
* Strategic Shifts Toward AI and Efficiency: Major firms like IBM and Dell reallocated resources away from traditional hardware units toward high-growth sectors such as AI and cloud computing. Layoffs primarily affected legacy divisions, enabling companies to streamline teams, manage rising costs, and focus on next-generation technologies.
These layoffs reflect a broader industry transition from pandemic-era overproduction to leaner, future-focused business models centered on AI and digital transformation.
#### Education Industry Layoffs in 2022
The Education sector, especially EdTech companies like Byju’s, 2U, and Unacademy, experienced a significant wave of layoffs in 2022 due to:
* Post-Pandemic Demand Decline: The return to in-person schooling ended the pandemic-driven EdTech boom, causing sharp drops in user engagement and revenue for platforms that had rapidly expanded during lockdowns.
* Funding Drought and Cost Corrections: Cooling investor sentiment and heightened focus on profitability forced EdTech firms—many already strained by aggressive expansion and acquisitions—to restructure and reduce headcount.
These layoffs reflect a broader industry correction following unsustainable growth during the COVID-19 surge.

#### Travel Industry Layoffs in 2020
The Travel industry faced some of the most severe layoffs in 2020, with companies like Booking.com, Airbnb, and Agoda significantly reducing staff due to:

* Global Shutdown of Travel and Tourism: Lockdowns, border closures, and event cancellations caused travel demand to collapse by over 70%, devastating revenue streams for platforms reliant on high booking volumes.

* Urgent Cost Cutting Amid Unsustainable Expenses: With fixed costs mounting and recovery timelines uncertain, companies like Airbnb halted expansion and cut workforce to preserve cash and focus on core operations.

These layoffs highlight the travel sector’s acute vulnerability to global crises and the necessity for rapid adaptation in times of prolonged uncertainty.

### Top Layoff Contributors by Company

![Screenshot 2025-07-08 181826](https://github.com/user-attachments/assets/6e453318-1dca-47ae-b482-01dad3c7331c)

A small number of tech giants were responsible for a significant portion of global layoffs. Companies like Amazon (18,150), Google (12,000), and Meta (11,000) topped the list, followed closely by Salesforce, Microsoft, and Philips—each with around 10,000 layoffs.

### Companies with Multiple Layoff Rounds

![Screenshot 2025-07-08 183017](https://github.com/user-attachments/assets/facb0fdd-5ee6-4949-b0d8-af95ee753c3b)

Several companies conducted repeated layoffs between 2020 and 2023, showing phased workforce reductions. Leading in layoff frequency were:

- Loft (Brazil) with 6 layoff rounds totaling 1,289 employees laid off.
- Swiggy (India) with 5 rounds and 2,880 layoffs.

Other notable companies with 4 rounds include Salesforce, Gopuff, Ola, Shopify, Patreon, and Vedantu. This pattern highlights ongoing restructuring efforts in response to evolving market conditions.

### Companies That Shut Down Entirely

Some startups and scaleups fully collapsed, laying off 100% of their workforce. Notably:

- Britishvolt (UK), despite raising $2.4 billion, shut down in early 2023 as funding fell through before battery production could scale.
- Quibi (US), a short-form video streaming platform backed by $1.8 billion, ceased operations just months after launching due to low user engagement and strategic missteps.
- Deliveroo Australia, the local arm of the food delivery giant, exited the market and let go of all staff in 2022 after facing intense competition.

### Full Shutdowns Concentrated in Early Funding Stages

![Screenshot 2025-07-08 185637](https://github.com/user-attachments/assets/4df8af9a-72cb-45c2-990a-ba0a375442b5)

Among companies that fully shut down (100% layoffs), most were in early funding stages—Seed and Series B—with 23 and 19 shutdowns respectively. This suggests that younger startups, likely with limited runway or unproven business models, were more prone to complete collapse.

#### Early-Stage Collapse Most Common in Food and Retail Startups

![Screenshot 2025-07-08 190414](https://github.com/user-attachments/assets/a54d7f2f-9b88-46b4-a2d7-a31291d76bd7)

Among startups that shut down completely during early funding stages (Seed to Series B), the Food and Retail industries saw the highest number of collapses — with 9 and 7 companies respectively. This may reflect thinner margins and higher burn rates common in these sectors.

### Company Maturity and Layoff Severity: A Stark Contrast

![Screenshot 2025-07-08 191257](https://github.com/user-attachments/assets/54c833c6-9f70-412c-9a81-275e2b4f6925)

Startups were the most vulnerable to complete shutdowns, with 54 companies laying off 100% of their staff — far more than Intermediate-stage (11) and large MNC-type firms (16). This highlights the higher risk of collapse in early-stage ventures.

## Summary

### High-Level Overview

#### Which industries were most affected?
The Consumer and Retail industries were the most affected, each with over 40,000 layoffs. Other significantly impacted sectors included Transportation, Finance, Healthcare, and Food, indicating that both tech and traditional sectors experienced widespread workforce reductions.
#### Which countries saw the highest layoffs?
The United States had the highest layoffs (263,000+), far surpassing other countries. Notable figures include India (~36.5K), Netherlands (~17.2K), and Sweden, Brazil, Germany, and the UK, each with significant layoffs.
#### How do layoffs differ by company funding stage?
Late-stage companies (Post-IPO) saw the highest number of layoffs (~207K). However, early-stage companies (Seed to Series B) had the highest collapse rates (100% layoffs), indicating high vulnerability. Intermediate-stage firms (Series C–F) were impacted less in comparison.

### Temporal Trends

#### In which months and years were layoffs highest?

- Month: January had the highest layoffs (96K+), followed by November, February, and May.
- Year: 2022 recorded the most layoffs (165.5K), followed by 2023 (129.9K), then 2020 (81K). The lowest was in 2021 (15.8K).

#### How have layoffs evolved over time?
There was a sharp surge starting mid-2022, with cumulative layoffs doubling within 8 months. A second major spike occurred in January 2023, showing clustered layoffs in short windows—often tied to market corrections.

### Company Insights

#### Which companies laid off the most employees overall?
Top contributors included Amazon (18,150), Google (12,000), Meta, Salesforce, Microsoft, and Philips (all ~10K).
#### Which companies had multiple rounds of layoffs?
- Loft (Brazil): 6 rounds, 1,289 employees.
- Swiggy (India): 5 rounds, 2,880 employees.
* Others with 4 rounds: Salesforce, Gopuff, Ola, Shopify, Patreon, and Vedantu.

### Extreme Events

#### Which companies laid off 100% of their staff?
- Britishvolt (UK): Raised $2.4B, shut down in 2023.
- Quibi (US): Raised $1.8B, failed shortly after launch.
- Deliveroo Australia: Exited market in 2022, fully shut down.

#### Which fully laid-off companies had previously raised significant funds?
The three companies above were the top in terms of funding. Many others also raised over $100M but failed due to market exits, poor product-market fit, or funding breakdowns.

#### Are there industries where early-stage startups collapsed more frequently?
Yes. Food and Retail sectors had the highest number of early-stage startup shutdowns (9 and 7 respectively), indicating higher burn rates and operational challenges in these industries.

### Company Classification by Size

#### What does layoff behavior look like when companies are grouped into:
- Startups (Seed to Series B): 54 companies fully collapsed — the highest among all categories.
- Intermediate (Series C to F): 11 companies collapsed.
- MNCs / Late-stage (Post-IPO, Acquired, etc.): 16 companies shut down completely.
This confirms that startups are far more vulnerable to complete failure under economic pressure.

### Yearly Industry Impact (2020–2023)

#### Which industries were hit hardest each year?
- 2020: Travel (e.g., Airbnb, Booking.com, Agoda)
- 2021: Few layoffs overall — the "boom year."
- 2022: Education/EdTech (e.g., Byju’s, 2U, Unacademy)
- 2023: Sales and Hardware (e.g., Salesforce, Dell, IBM)

#### Annual Trends & Industry Shocks
- 2020: Pandemic Shock – Layoffs concentrated in travel and offline services.
- 2021: Stimulus-Driven Growth – Minimal layoffs as digital expansion surged.
- 2022: Economic Correction – High inflation and rate hikes triggered the highest layoffs.
- 2023: Strategic Restructuring – Tech pivoted to AI, investors demanded profitability.

#### Impact of Major Layoff Events:
- Airbnb and Booking.com led early pandemic cuts.
- Byju’s and Unacademy marked the EdTech crash.
- Salesforce and Dell drove major 2023 restructuring cuts.

#### Sequence of layoffs (2022 > 2023 > 2020 > 2021)
The observed layoff pattern reflects a classic economic cycle:
- 2020: Economic shock due to the COVID-19 pandemic.
- 2021: Recovery and growth fueled by stimulus and digital expansion.
- 2022: Market correction triggered by inflation, rising interest rates, and collapsing valuations.
- 2023: Strategic realignment with companies focusing on profitability, AI adoption, and restructuring.
This sequence highlights how hiring behavior and layoffs follow broader economic phases, from shock to recovery, correction, and strategic adjustment.

This analysis provides a comprehensive, multi-dimensional understanding of global layoff patterns across industries, countries, funding stages, and company maturity levels. It reveals how macroeconomic shifts, strategic missteps, and evolving investor expectations have shaped workforce trends between 2020 and 2023. By identifying systemic vulnerabilities—particularly among early-stage startups—and pinpointing sectors most impacted in each year, the findings offer valuable insights into business resilience, economic cycles, and the consequences of overexpansion during times of rapid growth.




