

# Week 6

## R Instructions

For this lesson, make sure you have loaded the following packages.


```r
library(skimr)
library(gtsummary)
library(epiR)
library(broom)
library(pROC)
library(gmodels)
library(survival)
library(tidyverse)
```

### Diagnostic Tests

For this, we will use the `epi.tests` function from the `epiR` package.

Imagine you want to calculate the sensitivity. If you already know the counts for disease-positive and disease-negative, and test-positive and test-negative, you can easily create a table and use the `epi.tests` function.


```r
# Enter the data in the following order
  # Disease-positive, test-positive
  # Disease-negative, test-positive
  # Disease-positive, test-negative
  # Disease-negative, test-negative

# The matrix function allows you to enter in the numbers and convert to a table
# "nrow = 2" indicates that there should be 2 rows in the table (test-positive and test-negative)
# "byrow = TRUE" correctly assigns the columns as "disease-positive" first and "disease-negative" second

tbl_disease_test <-
  as.table(matrix(c(670, 202, 74, 640),
                  nrow = 2, byrow = TRUE))
```

Your result in this case is that sensitivity is 90%, with a 95% CI 88%, 92%. For reasons that I am not quite sure, most investigators do not cite 95% CI with sensitivity, specificity, etc. so stating just 90% is probably fine.

You can also use this function with a dataset that includes a binary variable indicating disease positive or negative, and a binary variable indicating test positive or negative. Similar to the `epi.2by2` function from week 4 (also from the `epiR` package), the table needs to be flipped so the columns and rows are correctly ordered. You can simply copy the code below and replace the inputs to the `table` function with your dataset, test variable, and disease (outcome) variable. 


```r
tbl_example6a <-
  matrix(rev(table(example6a$test, example6a$disease)), nrow = 2)
# This is the same code for week 4 that reverses the order of columns and rows

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

As you can see, `epi.tests` also provides other information, such as specificity, prevalence and positive and negative predictive value.

See instructions from lecture 5 on how to get an area-under-the-curve.

## Assignments

- lesson6a.rds and lesson6b.rds: These are data on a blood test (creatine kinase) to detect a recent myocardial infarct. The two data sets are from a coronary care unit population (lesson6a.rds) and a general hospital population (lesson6b.rds). What is the sensitivity, specificity, positive predictive value and negative predictive value?

- lesson6c.rds: Here are the data from a study of a marker to predict the results of biopsy for cancer. There are 2000 patients, half of whom had a suspicious imaging result and were biopsied. It is known that only about half of patients with abnormal imaging actually have cancer and that is what is found in this study. The marker was measured in patients undergoing biopsy. Might the new marker help decide which patients with abnormal scans should receive biopsy? 

- lesson6d.rds: This is a data set of cancer patients undergoing surgery with the endpoint of recurrence within 5 years. Since this cohort was established, adjuvant therapy has been shown to be of benefit. Current guidelines are that adjuvant therapy should be considered in patients with stage 3 or high-grade disease. Recently, two new variables have been added to the data set:  levels of a novel tumor marker were obtained from banked tissue samples and preoperative imaging scans were retrieved and scored from 0 (no evidence of local extension) to 4 (definite evidence of local extension). Here are some questions about these data:
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

\captionsetup[table]{labelformat=empty,skip=1pt}
\begin{longtable}{lll}
\toprule
Chemotherapy & Male & Female \\ 
\midrule
Regime a & ? of ? (?\%) responded & ? of ? (?\%) responded \\ 
Regime b & ? of ? (?\%) responded & ? of ? (?\%) responded \\ 
\bottomrule
\end{longtable}

<br>

So, I want you to give similar answers to the following research questions:

- lesson6e: Hospitalized neutropenic patients were randomized to receive drug a or placebo. Bloods were taken every day. The time until patients were no longer neutropenic was measured (all patients eventually did get better).

- lesson6f: A new lab machine sometimes fails to give a readout with the result that the sample is wasted. To try and get a handle on this problem, a researcher carefully documents the number of failures for the 516 samples that she analyzes in the month of September. 

- lesson6g: Drug a appears to be effective against cancer cells _in vitro._ Researchers create two new drugs, b and c, by making slight molecular rearrangements of drug a. The three drugs are then added to tumor cells in the test tube and the degree of cell growth measured. 
