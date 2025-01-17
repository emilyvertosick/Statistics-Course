

# Week 6

## Setting Up


``` r
# Load packages
library(skimr)
library(gt)
library(gtsummary)
library(epiR)
library(broom)
library(pROC)
library(gmodels)
library(survival)
library(here)
library(tidyverse)

# Load data necessary to run Week 6 examples
example6a <- readRDS(here::here("Data", "Week 6", "example6a.rds"))
```

## R Instructions

### Diagnostic Tests

For this, we will use the `epi.tests` function from the {epiR} package.

Imagine you want to calculate the sensitivity. If you already know the counts for disease-positive and disease-negative, and test-positive and test-negative, you can easily create a table and use the `epi.tests` function.


``` r
# Enter the data in the following order to create the 2x2 table
# Disease-positive, test-positive
# Disease-negative, test-positive
# Disease-positive, test-negative
# Disease-negative, test-negative
tbl_disease_test <-
  as.table(matrix(c(670, 202, 74, 640),
                  nrow = 2, byrow = TRUE))
# The matrix function allows you to enter in the numbers and convert to a table
# "nrow = 2" indicates that there should be 2 rows in the table (test-positive and test-negative)
# "byrow = TRUE" correctly assigns the columns as "disease-positive" first and "disease-negative" second

# Use the "epi.tests" function with the new 2x2 table
epi.tests(tbl_disease_test)
```

```
##           Outcome +    Outcome -      Total
## Test +          670          202        872
## Test -           74          640        714
## Total           744          842       1586
## 
## Point estimates and 95% CIs:
## --------------------------------------------------------------
## Apparent prevalence *                  0.55 (0.52, 0.57)
## True prevalence *                      0.47 (0.44, 0.49)
## Sensitivity *                          0.90 (0.88, 0.92)
## Specificity *                          0.76 (0.73, 0.79)
## Positive predictive value *            0.77 (0.74, 0.80)
## Negative predictive value *            0.90 (0.87, 0.92)
## Positive likelihood ratio              3.75 (3.32, 4.24)
## Negative likelihood ratio              0.13 (0.11, 0.16)
## False T+ proportion for true D- *      0.24 (0.21, 0.27)
## False T- proportion for true D+ *      0.10 (0.08, 0.12)
## False T+ proportion for T+ *           0.23 (0.20, 0.26)
## False T- proportion for T- *           0.10 (0.08, 0.13)
## Correctly classified proportion *      0.83 (0.81, 0.84)
## --------------------------------------------------------------
## * Exact CIs
```



Your result in this case is that sensitivity is 90%, with a 95% CI 88%, 92%. For reasons that I am not quite sure, most investigators do not cite 95% CI with sensitivity, specificity, etc. so stating just 90% is probably fine.

You can also use this function with a dataset that includes a binary variable indicating disease positive or negative, and a binary variable indicating test positive or negative. Similar to the `epi.2by2` function from week 4 (also from the {epiR} package), the table needs to be flipped so the columns and rows are correctly ordered. As a reminder, you can do this by converting the variables to factors using the `factor` function and using the `levels` option to assign the sort order.


``` r
# This is the same code for week 4 that reverses the order of columns and rows
tbl_example6a <-
  table(
    factor(example6a$test, levels = c(1, 0)),
    factor(example6a$disease, levels = c(1, 0))
  )

# Calculate sensitivity and specificity from table above
epi.tests(tbl_example6a)
```

```
##           Outcome +    Outcome -      Total
## Test +           20          180        200
## Test -           10         1820       1830
## Total            30         2000       2030
## 
## Point estimates and 95% CIs:
## --------------------------------------------------------------
## Apparent prevalence *                  0.10 (0.09, 0.11)
## True prevalence *                      0.01 (0.01, 0.02)
## Sensitivity *                          0.67 (0.47, 0.83)
## Specificity *                          0.91 (0.90, 0.92)
## Positive predictive value *            0.10 (0.06, 0.15)
## Negative predictive value *            0.99 (0.99, 1.00)
## Positive likelihood ratio              7.41 (5.55, 9.89)
## Negative likelihood ratio              0.37 (0.22, 0.61)
## False T+ proportion for true D- *      0.09 (0.08, 0.10)
## False T- proportion for true D+ *      0.33 (0.17, 0.53)
## False T+ proportion for T+ *           0.90 (0.85, 0.94)
## False T- proportion for T- *           0.01 (0.00, 0.01)
## Correctly classified proportion *      0.91 (0.89, 0.92)
## --------------------------------------------------------------
## * Exact CIs
```

As you can see, `epi.tests` also provides other information. Specificity and positive and negative predictive value you should know (remember that sensitivity is the probability of a positive result if you have the disease; specificity is the probability of a negative result if you don't have the disease; positive predictive value is the probability you have the disease if you test positive; negative predictive value is the probability that you don't have the disease if you test negative). True prevalence is the proportion of patients with disease in the data set. Apparent prevalence is a pretty misleading term and is the proportion of patients who test positive. You can generally ignore that, it isn't a commonly used statistic. Positive and negative likelihood ratios are used in Bayesian approaches to diagnostic tests and aren't taught on this course, so don't worry about those for now. 

See instructions from lecture 5 on how to get an area-under-the-curve.

## Assignments


``` r
# Copy and paste this code to load the data for week 6 assignments
lesson6a <- readRDS(here::here("Data", "Week 6", "lesson6a.rds"))
lesson6b <- readRDS(here::here("Data", "Week 6", "lesson6b.rds"))
lesson6c <- readRDS(here::here("Data", "Week 6", "lesson6c.rds"))
lesson6d <- readRDS(here::here("Data", "Week 6", "lesson6d.rds"))
```

- **lesson6a** and **lesson6b**: These are data on a blood test (creatine kinase) to detect a recent myocardial infarct. The two datasets are from a coronary care unit population (lesson6a.rds) and a general hospital population (lesson6b.rds). What is the sensitivity, specificity, positive predictive value and negative predictive value?

- **lesson6c**: Here are the data from a study of a marker to predict the results of biopsy for cancer. There are 2000 patients, half of whom had a suspicious imaging result and were biopsied. It is known that only about half of patients with abnormal imaging actually have cancer and that is what is found in this study. The marker was measured in patients undergoing biopsy. Might the new marker help decide which patients with abnormal scans should receive biopsy? 

- **lesson6d**: This is a dataset of cancer patients undergoing surgery with the endpoint of recurrence within 5 years. Since this cohort was established, adjuvant therapy has been shown to be of benefit. Current guidelines are that adjuvant therapy should be considered in patients with stage 3 or high-grade disease. Recently, two new variables have been added to the dataset:  levels of a novel tumor marker were obtained from banked tissue samples and preoperative imaging scans were retrieved and scored from 0 (no evidence of local extension) to 4 (definite evidence of local extension). Here are some questions about these data:
  - How good is the current method for determining whether patients should be referred to adjuvant therapy?
  - It has been suggested that a statistical model using stage and grade would be better than the current risk grouping. How good do you think this model would be?
  - Does the marker add information to the model of stage and grade?
  - Does imaging add information to the model including stage, grade and the marker?

**And now, a complete different type of question...**

In this question, I give you an experimental set up _but no data._ What you have to do is give me an answer. Now obviously you can’t give me any numbers because I didn’t give you any. However, you can write an answer with some blanks.

For example, if you hadn't been given any data, an answer to lesson5b.rds might be:

<div class="quote-container">

>? of the ? (?%) patients on chemotherapy regime a responded compared to ? of the ? patients on regime b (?%). The difference between groups (?%, 95% CI ?, ?) was / was not statistically significant (p = ?). Response by sex and group is shown in the table. The interaction term for group and sex was / was not significant (p = ?).

</div>


```{=html}
<div id="iwrgxmosvm" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#iwrgxmosvm table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#iwrgxmosvm thead, #iwrgxmosvm tbody, #iwrgxmosvm tfoot, #iwrgxmosvm tr, #iwrgxmosvm td, #iwrgxmosvm th {
  border-style: none;
}

#iwrgxmosvm p {
  margin: 0;
  padding: 0;
}

#iwrgxmosvm .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#iwrgxmosvm .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#iwrgxmosvm .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#iwrgxmosvm .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#iwrgxmosvm .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#iwrgxmosvm .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#iwrgxmosvm .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#iwrgxmosvm .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#iwrgxmosvm .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#iwrgxmosvm .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#iwrgxmosvm .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#iwrgxmosvm .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#iwrgxmosvm .gt_spanner_row {
  border-bottom-style: hidden;
}

#iwrgxmosvm .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#iwrgxmosvm .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#iwrgxmosvm .gt_from_md > :first-child {
  margin-top: 0;
}

#iwrgxmosvm .gt_from_md > :last-child {
  margin-bottom: 0;
}

#iwrgxmosvm .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#iwrgxmosvm .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#iwrgxmosvm .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#iwrgxmosvm .gt_row_group_first td {
  border-top-width: 2px;
}

#iwrgxmosvm .gt_row_group_first th {
  border-top-width: 2px;
}

#iwrgxmosvm .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#iwrgxmosvm .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#iwrgxmosvm .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#iwrgxmosvm .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#iwrgxmosvm .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#iwrgxmosvm .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#iwrgxmosvm .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#iwrgxmosvm .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#iwrgxmosvm .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#iwrgxmosvm .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#iwrgxmosvm .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#iwrgxmosvm .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#iwrgxmosvm .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#iwrgxmosvm .gt_left {
  text-align: left;
}

#iwrgxmosvm .gt_center {
  text-align: center;
}

#iwrgxmosvm .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#iwrgxmosvm .gt_font_normal {
  font-weight: normal;
}

#iwrgxmosvm .gt_font_bold {
  font-weight: bold;
}

#iwrgxmosvm .gt_font_italic {
  font-style: italic;
}

#iwrgxmosvm .gt_super {
  font-size: 65%;
}

#iwrgxmosvm .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#iwrgxmosvm .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#iwrgxmosvm .gt_indent_1 {
  text-indent: 5px;
}

#iwrgxmosvm .gt_indent_2 {
  text-indent: 10px;
}

#iwrgxmosvm .gt_indent_3 {
  text-indent: 15px;
}

#iwrgxmosvm .gt_indent_4 {
  text-indent: 20px;
}

#iwrgxmosvm .gt_indent_5 {
  text-indent: 25px;
}

#iwrgxmosvm .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#iwrgxmosvm div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Chemotherapy">Chemotherapy</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Male">Male</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Female">Female</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="Chemotherapy" class="gt_row gt_left">Regime a</td>
<td headers="Male" class="gt_row gt_left">? of ? (?%) responded</td>
<td headers="Female" class="gt_row gt_left">? of ? (?%) responded</td></tr>
    <tr><td headers="Chemotherapy" class="gt_row gt_left">Regime b</td>
<td headers="Male" class="gt_row gt_left">? of ? (?%) responded</td>
<td headers="Female" class="gt_row gt_left">? of ? (?%) responded</td></tr>
  </tbody>
  
  
</table>
</div>
```

So, I want you to give similar answers to the following research questions:

- **lesson6e**: Hospitalized neutropenic patients were randomized to receive drug a or placebo. Bloods were taken every day. The time until patients were no longer neutropenic was measured (all patients eventually did get better).

- **lesson6f**: A new lab machine sometimes fails to give a readout with the result that the sample is wasted. To try and get a handle on this problem, a researcher carefully documents the number of failures for the 516 samples that she analyzes in the month of September. 

- **lesson6g**: Drug a appears to be effective against cancer cells _in vitro._ Researchers create two new drugs, b and c, by making slight molecular rearrangements of drug a. The three drugs are then added to tumor cells in the test tube and the degree of cell growth measured. 
