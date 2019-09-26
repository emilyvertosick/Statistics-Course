

# Week 6

## Setting Up


```r
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

For this, we will use the `epi.tests` function from the `epiR` package.

Imagine you want to calculate the sensitivity. If you already know the counts for disease-positive and disease-negative, and test-positive and test-negative, you can easily create a table and use the `epi.tests` function.


```r
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
## Point estimates and 95 % CIs:
## ---------------------------------------------------------
## Apparent prevalence                    0.55 (0.52, 0.57)
## True prevalence                        0.47 (0.44, 0.49)
## Sensitivity                            0.90 (0.88, 0.92)
## Specificity                            0.76 (0.73, 0.79)
## Positive predictive value              0.77 (0.74, 0.80)
## Negative predictive value              0.90 (0.87, 0.92)
## Positive likelihood ratio              3.75 (3.32, 4.24)
## Negative likelihood ratio              0.13 (0.11, 0.16)
## ---------------------------------------------------------
```

Your result in this case is that sensitivity is 90%, with a 95% CI 88%, 92%. For reasons that I am not quite sure, most investigators do not cite 95% CI with sensitivity, specificity, etc. so stating just 90% is probably fine.

You can also use this function with a dataset that includes a binary variable indicating disease positive or negative, and a binary variable indicating test positive or negative. Similar to the `epi.2by2` function from week 4 (also from the `epiR` package), the table needs to be flipped so the columns and rows are correctly ordered. You can simply copy the code below and replace the inputs to the `table` function with your dataset, test variable, and disease (outcome) variable. 


```r
# This is the same code for week 4 that reverses the order of columns and rows
tbl_example6a <-
  matrix(rev(table(example6a$test, example6a$disease)), nrow = 2)

# Calculate sensitivity and specificity from table above
epi.tests(tbl_example6a)
```

```
##           Outcome +    Outcome -      Total
## Test +           20          180        200
## Test -           10         1820       1830
## Total            30         2000       2030
## 
## Point estimates and 95 % CIs:
## ---------------------------------------------------------
## Apparent prevalence                    0.10 (0.09, 0.11)
## True prevalence                        0.01 (0.01, 0.02)
## Sensitivity                            0.67 (0.47, 0.83)
## Specificity                            0.91 (0.90, 0.92)
## Positive predictive value              0.10 (0.06, 0.15)
## Negative predictive value              0.99 (0.99, 1.00)
## Positive likelihood ratio              7.41 (5.55, 9.89)
## Negative likelihood ratio              0.37 (0.22, 0.61)
## ---------------------------------------------------------
```

As you can see, `epi.tests` also provides other information. Specificity and positive and negative predictive value you should know (remember that sensitivity is the probability of a positive result if you have the disease; specificity is the probability of a negative result if you don't have the disease; positive predictive value is the probability you have the disease if you test positive; negative predictive value is the probability that you don't have the disease if you test negative). True prevalence is the proportion of patients with disease in the data set. Apparent prevalence is a pretty misleading term and is the proportion of patients who test positive. You can generally ignore that, it isn't a commonly used statistic. Positive and negative likelihood ratios are used in Bayesian approaches to diagnostic tests and aren't taught on this course, so don't worry about those for now. 

See instructions from lecture 5 on how to get an area-under-the-curve.

## Assignments


```r
# Copy and paste this code to load the data for week 6 assignments
lesson6a <- readRDS(here::here("Data", "Week 6", "lesson6a.rds"))
lesson6b <- readRDS(here::here("Data", "Week 6", "lesson6b.rds"))
lesson6c <- readRDS(here::here("Data", "Week 6", "lesson6c.rds"))
lesson6d <- readRDS(here::here("Data", "Week 6", "lesson6d.rds"))
```

- lesson6a.rds and lesson6b.rds: These are data on a blood test (creatine kinase) to detect a recent myocardial infarct. The two datasets are from a coronary care unit population (lesson6a.rds) and a general hospital population (lesson6b.rds). What is the sensitivity, specificity, positive predictive value and negative predictive value?

- lesson6c.rds: Here are the data from a study of a marker to predict the results of biopsy for cancer. There are 2000 patients, half of whom had a suspicious imaging result and were biopsied. It is known that only about half of patients with abnormal imaging actually have cancer and that is what is found in this study. The marker was measured in patients undergoing biopsy. Might the new marker help decide which patients with abnormal scans should receive biopsy? 

- lesson6d.rds: This is a dataset of cancer patients undergoing surgery with the endpoint of recurrence within 5 years. Since this cohort was established, adjuvant therapy has been shown to be of benefit. Current guidelines are that adjuvant therapy should be considered in patients with stage 3 or high-grade disease. Recently, two new variables have been added to the dataset:  levels of a novel tumor marker were obtained from banked tissue samples and preoperative imaging scans were retrieved and scored from 0 (no evidence of local extension) to 4 (definite evidence of local extension). Here are some questions about these data:
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

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#iwrgxmosvm .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  background-color: #FFFFFF;
  /* table.background.color */
  width: auto;
  /* table.width */
  border-top-style: solid;
  /* table.border.top.style */
  border-top-width: 2px;
  /* table.border.top.width */
  border-top-color: #A8A8A8;
  /* table.border.top.color */
  border-bottom-style: solid;
  /* table.border.bottom.style */
  border-bottom-width: 2px;
  /* table.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* table.border.bottom.color */
}

#iwrgxmosvm .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#iwrgxmosvm .gt_title {
  color: #333333;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding - not yet used */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#iwrgxmosvm .gt_subtitle {
  color: #333333;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 0;
  padding-bottom: 4px;
  /* heading.bottom.padding - not yet used */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#iwrgxmosvm .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #D3D3D3;
  /* heading.border.bottom.color */
}

#iwrgxmosvm .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  padding-top: 4px;
  padding-bottom: 4px;
}

#iwrgxmosvm .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  /* column_labels.background.color */
  font-size: 16px;
  /* column_labels.font.size */
  font-weight: initial;
  /* column_labels.font.weight */
  vertical-align: middle;
  padding: 5px;
  margin: 10px;
  overflow-x: hidden;
}

#iwrgxmosvm .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#iwrgxmosvm .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#iwrgxmosvm .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#iwrgxmosvm .gt_group_heading {
  padding: 8px;
  /* row_group.padding */
  color: #333333;
  background-color: #FFFFFF;
  /* row_group.background.color */
  font-size: 16px;
  /* row_group.font.size */
  font-weight: initial;
  /* row_group.font.weight */
  border-top-style: solid;
  /* row_group.border.top.style */
  border-top-width: 2px;
  /* row_group.border.top.width */
  border-top-color: #D3D3D3;
  /* row_group.border.top.color */
  border-bottom-style: solid;
  /* row_group.border.bottom.style */
  border-bottom-width: 2px;
  /* row_group.border.bottom.width */
  border-bottom-color: #D3D3D3;
  /* row_group.border.bottom.color */
  vertical-align: middle;
}

#iwrgxmosvm .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  /* row_group.background.color */
  font-size: 16px;
  /* row_group.font.size */
  font-weight: initial;
  /* row_group.font.weight */
  border-top-style: solid;
  /* row_group.border.top.style */
  border-top-width: 2px;
  /* row_group.border.top.width */
  border-top-color: #D3D3D3;
  /* row_group.border.top.color */
  border-bottom-style: solid;
  /* row_group.border.bottom.style */
  border-bottom-width: 2px;
  /* row_group.border.bottom.width */
  border-bottom-color: #D3D3D3;
  /* row_group.border.bottom.color */
  vertical-align: middle;
}

#iwrgxmosvm .gt_striped {
  background-color: #8080800D;
}

#iwrgxmosvm .gt_from_md > :first-child {
  margin-top: 0;
}

#iwrgxmosvm .gt_from_md > :last-child {
  margin-bottom: 0;
}

#iwrgxmosvm .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#iwrgxmosvm .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#iwrgxmosvm .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#iwrgxmosvm .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#iwrgxmosvm .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#iwrgxmosvm .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#iwrgxmosvm .gt_table_body {
  border-top-style: solid;
  /* table_body.border.top.style */
  border-top-width: 2px;
  /* table_body.border.top.width */
  border-top-color: #D3D3D3;
  /* table_body.border.top.color */
  border-bottom-style: solid;
  /* table_body.border.bottom.style */
  border-bottom-width: 2px;
  /* table_body.border.bottom.width */
  border-bottom-color: #D3D3D3;
  /* table_body.border.bottom.color */
}

#iwrgxmosvm .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #D3D3D3;
  /* footnotes.border.top.color */
}

#iwrgxmosvm .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#iwrgxmosvm .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #D3D3D3;
  /* sourcenotes.border.top.color */
}

#iwrgxmosvm .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#iwrgxmosvm .gt_center {
  text-align: center;
}

#iwrgxmosvm .gt_left {
  text-align: left;
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
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="iwrgxmosvm" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1">Chemotherapy</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1">Male</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1">Female</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Regime a</td>
      <td class="gt_row gt_left">? of ? (?%) responded</td>
      <td class="gt_row gt_left">? of ? (?%) responded</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Regime b</td>
      <td class="gt_row gt_left gt_striped">? of ? (?%) responded</td>
      <td class="gt_row gt_left gt_striped">? of ? (?%) responded</td>
    </tr>
  </body>
  
  
</table></div><!--/html_preserve-->

So, I want you to give similar answers to the following research questions:

- lesson6e: Hospitalized neutropenic patients were randomized to receive drug a or placebo. Bloods were taken every day. The time until patients were no longer neutropenic was measured (all patients eventually did get better).

- lesson6f: A new lab machine sometimes fails to give a readout with the result that the sample is wasted. To try and get a handle on this problem, a researcher carefully documents the number of failures for the 516 samples that she analyzes in the month of September. 

- lesson6g: Drug a appears to be effective against cancer cells _in vitro._ Researchers create two new drugs, b and c, by making slight molecular rearrangements of drug a. The three drugs are then added to tumor cells in the test tube and the degree of cell growth measured. 
