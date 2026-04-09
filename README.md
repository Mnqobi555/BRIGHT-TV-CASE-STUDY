# BRIGHT-TV-CASE-STUDY
OUR GOAL: Provide BrightTV's CVM (Customer Value Management) team with data-driven insights to grow the company's subscription base for the current financial year.
Key Business Questions

What are the user and usage trends of BrightTV?
What type of factors influence consumption?
What content would you recommend to increase consumption on days with low consumption?
What type of initiatives would you recommend to grow BrightTV's user base further?

Project Steps
Step 1 — Plan & Architect: Designed the data flow and analytical framework; defined core KPIs around viewership, session duration, and user engagement.

Step 2 — Process & Clean Data Loaded raw Excel files into Databricks; converted UTC timestamps to South African time (Africa/Johannesburg / UTC+2); standardised Duration 2 from H:MM:SS format to seconds; joined user profile and viewership transaction tables using a LEFT JOIN on UserID.

Step 3 — Analyze in Databricks (SQL). Wrote SQL queries covering monthly active users, peak viewing hours, consumption by channel, demographic breakdowns (age group, gender, race, province), low consumption days, top channels per segment, user segmentation by engagement level, and churn analysis.

Step 4 — Present to Stakeholders: Delivered a 20-minute data story with visuals and actionable growth recommendations targeting user acquisition, retention, and content strategy.


Tools Used

-Data Processing: SQL and Databricks
-Visualization: Excel 
-Planning & Presentation: Miro and PowerPoint
-Project Tracking: Canva

Key Recommendations

-Promote high-performing channels to low-engagement user segments to boost session frequency.
-Schedule targeted push notifications or content drops on identified low-consumption days.
-Use demographic insights (age group, province, gender) to personalise content recommendations.
-Re-engage churned users (inactive 30+ days) with win-back campaigns featuring top-rated channels.

Notes
All times and dates in the dataset are supplied in UTC and have been converted to SA time (UTC+2).
Consumption is split per session — for every session a subscriber has, there is 1 record.
