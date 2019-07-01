

# Week 7

## R Instructions

For this lesson, make sure you have the following packages downloaded and loaded.


```r
library(skimr)
library(gtsummary)
library(epiR)
library(broom)
library(pROC)
library(gmodels)
library(survival)
library(survminer)
library(tidyverse)
```

### Time to event data

You need at least two variables to describe a time to event data set: how long the patients were followed (the time variable), and whether they had the event (e.g. were alive or dead) at last observation (the failure variable). The failure variable is coded 1 if the patient had the event (e.g. died, had a recurrence) and 0 otherwise. You can have any other variables (patient codes, stage of cancer, treatment, hair color etc) but these are not essential.

You first have to tell R that you are dealing with a survival data set. The function used is the `Surv` function from the `survival` package. The function is of the form `Surv(t, d)` where "t" is the time variable and "d" is the "failure" variable (e.g. died if 1, alive at last follow-up if 0). You can save out this survival object, but note that if you go and change any data, you have to re-run the `Surv` function so it utilizes the new data.


```r
# Create the survival object
# "t" is time in months
# "d" is survival status (0 = alive, 1 = dead)

example7a_surv <- Surv(example7a$t, example7a$d)
```

The `survfit` function (also from the `survival`) package describes the survival data. It is common to report the median survival.


```r
survfit(example7a_surv ~ 1)
```

```
## Call: survfit(formula = example7a_surv ~ 1)
## 
##       n  events  median 0.95LCL 0.95UCL 
##      23      18      27      18      45
```

```r
# The "~ 1" indicates that we want survival estimates for the entire group
# More information on this below
```

You often also report the median time of follow-up for survivors, which can easily be calculated manually.


```r
example7a %>%
  filter(d == 0) %>% # Keep only the surviving patients
  skim(t) # Rembmber, "p50" indicates the median
```

```
## Skim summary statistics
##  n obs: 5 
##  n variables: 6 
## 
## -- Variable type:numeric ---------------------------------------------------------------
##  variable missing complete n mean    sd p0 p25 p50 p75 p100     hist
##         t       0        5 5 52.6 61.89 13  16  28  45  161 ▇▂▁▁▁▁▁▂
```

You can also plot the survival curve by adding the `plot` function around your `survfit` function:


```r
plot(survfit(example7a_surv ~ 1))
```

![](07-week7_files/figure-latex/week7d-1.pdf)<!-- --> 

Use "~ covariate" instead of "~ 1" to plot survival curves by group:


```r
plot(survfit(example7a_surv ~ drug, data = example7a))
```

![](07-week7_files/figure-latex/week7e-1.pdf)<!-- --> 

Graphs can be saved out by using the "Export" option at the top of the "Plots" tab.

The `survdiff` function compares survival for different groups. For example, the following code compares survival for each value of the variable "drug" (generally 0 and 1).


```r
survdiff(example7a_surv ~ drug, data = example7a)
```

```
## Call:
## survdiff(formula = example7a_surv ~ drug, data = example7a)
## 
##         N Observed Expected (O-E)^2/E (O-E)^2/V
## drug=0 12       11     7.31      1.86       3.4
## drug=1 11        7    10.69      1.27       3.4
## 
##  Chisq= 3.4  on 1 degrees of freedom, p= 0.07
```

The `coxph` function (from `survival`) is for regression analyses. For example, a unvariate regression for the effects of "drug" on survival:


```r
coxph(example7a_surv ~ drug, data = example7a)
```

```
## Call:
## coxph(formula = example7a_surv ~ drug, data = example7a)
## 
##         coef exp(coef) se(coef)      z      p
## drug -0.9155    0.4003   0.5119 -1.788 0.0737
## 
## Likelihood ratio test=3.38  on 1 df, p=0.06581
## n= 23, number of events= 18
```

```r
#You can use the tbl_regression function with Cox models to see the hazard ratios
example7a_cox <- coxph(example7a_surv ~ drug, data = example7a)
tbl_regression(example7a_cox, exponentiate = TRUE)
```

\captionsetup[table]{labelformat=empty,skip=1pt}
\begin{longtable}{lccc}
\toprule
\textbf{N = 23} & \textbf{HR}\textsuperscript{1} & \textbf{95\% CI}\textsuperscript{1} & \textbf{p-value} \\ 
\midrule
drug & 0.40 & 0.15, 1.09 & 0.074 \\ 
\bottomrule
\end{longtable}
\vspace{-5mm}
\begin{minipage}{\linewidth}
\textsuperscript{1}HR = Hazard Ratio, CI = Confidence Interval \\ 
\end{minipage}

The following multivariable model also includes some demographic and medical characteristics:


```r
coxph(example7a_surv ~ drug + age + sex + marker, data = example7a)
```

```
## Call:
## coxph(formula = example7a_surv ~ drug + age + sex + marker, data = example7a)
## 
##            coef exp(coef) se(coef)      z       p
## drug   -1.76118   0.17184  0.68158 -2.584 0.00977
## age     0.01378   1.01388  0.02377  0.580 0.56199
## sex     1.01668   2.76401  0.58228  1.746 0.08080
## marker -0.80492   0.44712  0.42618 -1.889 0.05893
## 
## Likelihood ratio test=8.79  on 4 df, p=0.06668
## n= 23, number of events= 18
```

Using the `summary` function with `survfit` lists all available followup times along with survival probabilities (you get a 95% C.I. as well):


```r
# For the entire cohort
summary(survfit(example7a_surv ~ 1, data = example7a))
```

```
## Call: survfit(formula = example7a_surv ~ 1, data = example7a)
## 
##  time n.risk n.event survival std.err lower 95% CI upper 95% CI
##     5     23       2   0.9130  0.0588       0.8049        1.000
##     8     21       2   0.8261  0.0790       0.6848        0.996
##     9     19       1   0.7826  0.0860       0.6310        0.971
##    12     18       1   0.7391  0.0916       0.5798        0.942
##    13     17       1   0.6957  0.0959       0.5309        0.912
##    18     14       1   0.6460  0.1011       0.4753        0.878
##    23     13       2   0.5466  0.1073       0.3721        0.803
##    27     11       1   0.4969  0.1084       0.3240        0.762
##    30      9       1   0.4417  0.1095       0.2717        0.718
##    31      8       1   0.3865  0.1089       0.2225        0.671
##    33      7       1   0.3313  0.1064       0.1765        0.622
##    34      6       1   0.2761  0.1020       0.1338        0.569
##    43      5       1   0.2208  0.0954       0.0947        0.515
##    45      4       1   0.1656  0.0860       0.0598        0.458
##    48      2       1   0.0828  0.0727       0.0148        0.462
```

```r
# You can also summarize the survival by group:
summary(survfit(example7a_surv ~ drug, data = example7a))
```

```
## Call: survfit(formula = example7a_surv ~ drug, data = example7a)
## 
##                 drug=0 
##  time n.risk n.event survival std.err lower 95% CI upper 95% CI
##     5     12       2   0.8333  0.1076       0.6470        1.000
##     8     10       2   0.6667  0.1361       0.4468        0.995
##    12      8       1   0.5833  0.1423       0.3616        0.941
##    23      6       1   0.4861  0.1481       0.2675        0.883
##    27      5       1   0.3889  0.1470       0.1854        0.816
##    30      4       1   0.2917  0.1387       0.1148        0.741
##    33      3       1   0.1944  0.1219       0.0569        0.664
##    43      2       1   0.0972  0.0919       0.0153        0.620
##    45      1       1   0.0000     NaN           NA           NA
## 
##                 drug=1 
##  time n.risk n.event survival std.err lower 95% CI upper 95% CI
##     9     11       1    0.909  0.0867       0.7541        1.000
##    13     10       1    0.818  0.1163       0.6192        1.000
##    18      8       1    0.716  0.1397       0.4884        1.000
##    23      7       1    0.614  0.1526       0.3769        0.999
##    31      5       1    0.491  0.1642       0.2549        0.946
##    34      4       1    0.368  0.1627       0.1549        0.875
##    48      2       1    0.184  0.1535       0.0359        0.944
```

The `times` option allows you to get survival probabilities for specific timepoints. For example, at 1 year, 2 years and 5 years:


```r
summary(survfit(example7a_surv ~ 1, data = example7a), times = c(12, 24, 60))
```

```
## Call: survfit(formula = example7a_surv ~ 1, data = example7a)
## 
##  time n.risk n.event survival std.err lower 95% CI upper 95% CI
##    12     18       6   0.7391  0.0916       0.5798        0.942
##    24     11       4   0.5466  0.1073       0.3721        0.803
##    60      1       8   0.0828  0.0727       0.0148        0.462
```

```r
# "t" is in months
```

So, some typical code to analyze a data set:


```r
# Create your survival object, which indicates this is a time to event outcome
example7a_surv <- Surv(example7a$t, example7a$d)

# Get median survival and number of events for group
survfit(example7a_surv ~ 1)
```

```
## Call: survfit(formula = example7a_surv ~ 1)
## 
##       n  events  median 0.95LCL 0.95UCL 
##      23      18      27      18      45
```

```r
# Get median followup for survivors
example7a %>%
  filter(d == 0) %>%
  skim(t)
```

```
## Skim summary statistics
##  n obs: 5 
##  n variables: 6 
## 
## -- Variable type:numeric ---------------------------------------------------------------
##  variable missing complete n mean    sd p0 p25 p50 p75 p100     hist
##         t       0        5 5 52.6 61.89 13  16  28  45  161 ▇▂▁▁▁▁▁▂
```

```r
# Show a graph
plot(survfit(example7a_surv ~ 1))
```

![](07-week7_files/figure-latex/week7k-1.pdf)<!-- --> 

```r
# Look at predictors of survival
coxph(example7a_surv ~ drug + age + sex + marker, data = example7a)
```

```
## Call:
## coxph(formula = example7a_surv ~ drug + age + sex + marker, data = example7a)
## 
##            coef exp(coef) se(coef)      z       p
## drug   -1.76118   0.17184  0.68158 -2.584 0.00977
## age     0.01378   1.01388  0.02377  0.580 0.56199
## sex     1.01668   2.76401  0.58228  1.746 0.08080
## marker -0.80492   0.44712  0.42618 -1.889 0.05893
## 
## Likelihood ratio test=8.79  on 4 df, p=0.06668
## n= 23, number of events= 18
```

## Assignments

Try to do at least lesson7a and lesson7b

- lesson7a.rds: This is a large set of data on patients receiving adjuvant therapy after surgery for colon cancer. Describe this data set and determine which, if any, variables are prognostic in this patient group.

- lesson7b.rds: These are time to recurrence data on forty patients with biliary cancer treated at one of two hospitals, one of which treats a large number of cancer patients and one of which does not. Do patients treated at a “high volume” hospital have a longer time to recurrence?

- lesson7c.rds: These are data from a randomized trial comparing no treatment, levamisole (an immune stimulant) and levamisole combined with 5FU (a chemotherapy agent) and in the adjuvant treatment of colon cancer. Describe the data set. What conclusions would you draw about the effectiveness of the different treatments?

- lesson7d.rds: More data on time to recurrence by hospital volume. Given this data set, determine whether patients treated at a “high volume” hospital have a longer time to recurrence.
