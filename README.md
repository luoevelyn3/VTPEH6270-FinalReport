# County-Level Health and Demographic Explorer

## Overview
This project explores associations between county-level demographic characteristics and health outcomes across the United States. The primary objective is to examine the relationship between obesity prevalence and self-rated poor health using publicly available county-level data.

In addition to statistical analysis, an interactive Shiny application was developed to support exploratory data analysis, allowing users to visualize relationships between variables and examine summary statistics.

---

## Author
Yuhui Luo

---

## Data Source
The dataset used in this project contains county-level demographic and health indicators across U.S. counties. Variables include population characteristics, socioeconomic indicators, and health outcomes such as obesity prevalence and self-rated health.

Relevant data sources include:
- CDC (Centers for Disease Control and Prevention)
- County-level public health datasets provided for course use

---

## Methods
The analysis examines the association between obesity prevalence and the percentage of individuals reporting fair or poor health using linear regression.

Key components:
- Scatter plot visualization
- Linear regression model
- Diagnostic plots (residuals, Q-Q plot)
- Summary statistics (mean, standard deviation, correlation)

Missing observations were excluded using complete-case analysis.

---

## Final Report
The full report for this project is available here:  
👉 👉 [Final Report](https://github.com/luoevelyn3/VTPEH6270-FinalReport/blob/main/Final%20Report/VTPEH6270-Final-Report.pdf)

---

## Shiny Application
An interactive Shiny application was developed to explore the dataset.

👉 Live App:  
[https://your-shiny-link-here](https://yl42.shinyapps.io/my_shiny_app/)

The application allows users to:
- Select variables for analysis  
- Visualize relationships using scatter plots  
- Examine distributions via histograms  
- View summary statistics  

---

## Code and Reproducibility

### Run the Shiny App locally:
```r
shiny::runApp("my_shiny_app")
