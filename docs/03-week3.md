

# Week 3

## Setting up


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

# The "trial" and "midwest" datasets are available automatically 
# after you load the packages above

# Load other data necessary to run Week 3 examples
lesson1a <- readRDS(here::here("Data", "Week 1", "lesson1a.rds"))
example3a <- readRDS(here::here("Data", "Week 3", "example3a.rds"))
```

## R Instructions

### Example Datasets

Normally, to do an analysis in R, you will have to load in a dataset. However, R and some packages come with built-in example datasets. For example, there is a dataset called "trial" that comes built in with the `gtsummary` package. We will use the "trial" dataset for many examples, but you do not need to load it, as the "trial" dataset will automatically be loaded after you run `library(gtsummary)`.

### Hypothesis Testing

For this week's assignment, you will need to learn the following functions:

- `t.test`
- `wilcox.test`
- `binom.test`

#### **t-test**

This is used to compare a continuous outcome (such as hemoglobin) in two groups (e.g. vegetarians and carnivores, or patients in a randomized trial receiving an anemia treatment or placebo). Now statisticians normally say that the t-test makes two assumptions: (1) data are normally distributed and (2) variances are equal. Don’t worry about assumption (2) for now. Also, assumption (1) has an odd feature: it doesn’t matter once sample sizes get large (for those of you who want to boast that you know a "theorem", this is called the "central limit theorem"). Just how large is "large" is a matter of judgment, but generally speaking, it is said that you can feel okay using a t-test on non-normal data once the sample size is above 30 a group. As it turns out, the t-test is "robust" to non-normal data, even if sample sizes are low. "Robust" means that it gives similar results regardless of whether the data are normally distributed or not. So many people feel comfortable using the t-test for to compare a continuous outcome between two groups even if the data are pretty skewed.

**Different forms of the t-test**

The two main forms of the t-test are "paired" and "unpaired".

"Unpaired" is used when, for example, testing marker levels between two groups taking different drugs, as there are different patients in each group:


```r
# t-test for marker levels between treatment arms
t.test(marker ~ trt, data = trial, paired = FALSE, var.equal = TRUE)
```

```
## 
## 	Two Sample t-test
## 
## data:  marker by trt
## t = 1.5816, df = 188, p-value = 0.1154
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.04858916  0.44161134
## sample estimates:
## mean in group Drug A mean in group Drug B 
##            1.0173478            0.8208367
```

The first variable, "marker", is the continuous endpoint that you are comparing by the two groups of the second variable, "trt" (Drug A vs Drug B). Next, you are telling R to get the data from the dataset called "trial". `paired = FALSE` indicates that you want to perform an "unpaired" test. The last option (`var.equal = TRUE`) tells the `t.test` function to treat the two variances as being equal. For this course, you will need to include this option in two-group `t.test` commands but you do not need to know specific details about this concept.

A "paired" test would be used for comparing blood pressure taken before and after an intervention, for example, because you are looking at two observations on the same patient.

<!-- Note: Don't need to specify "var.equal = TRUE" for paired tests, as this is the default, but I thought it might be easier to be consistent across all. -->


```r
# paired t-test for blood pressure between "before" and "after" groups
t.test(bp ~ when, data = example3a, paired = TRUE, var.equal = TRUE)
```

```
## 
## 	Paired t-test
## 
## data:  bp by when
## t = -3.3372, df = 119, p-value = 0.00113
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -8.112776 -2.070557
## sample estimates:
## mean of the differences 
##               -5.091667
```

Here, the code is the same as the last example, with "bp" as the continuous outcome, and "when" indicating the two groups. Since these are two measurements taken on the same patient, a paired t-test is necessary, so the option `paired = TRUE` must be included.

A single sample test compares the mean of a group of observations with some hypothetical value, for example, is the average rate of college-educated adults in the midwest different than the national average of 32%?


```r
# t-test assessing whether the rate of college education is different than 32%
t.test(midwest$percollege, mu = 32)
```

```
## 
## 	One Sample t-test
## 
## data:  midwest$percollege
## t = -45.827, df = 436, p-value < 2.2e-16
## alternative hypothesis: true mean is not equal to 32
## 95 percent confidence interval:
##  17.68400 18.86147
## sample estimates:
## mean of x 
##  18.27274
```

Let’s look at the print out from a t-test in more detail:


```r
# t-test for difference in horsepower for manual vs automatic transmission
t.test(hp ~ am, data = mtcars, paired = FALSE, var.equal = TRUE)
```

```
## 
## 	Two Sample t-test
## 
## data:  hp by am
## t = 1.3733, df = 30, p-value = 0.1798
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -16.27768  83.11169
## sample estimates:
## mean in group 0 mean in group 1 
##        160.2632        126.8462
```

This example is testing whether there is a difference in horsepower (hp) between cars with an automatic transmission (am == 0) vs manual transmission (am == 1).

The `t.test` function reports the data and variables you are testing, followed by the t statistic (t), degrees of freedom (df) and p-value. Below that, it states the alternative hypothesis you are testing, prints the mean in each group, and gives the 95% confidence interval around the difference in group means.

While for an unpaired test, the `t.test` command prints the group means in each group, you may want to report the difference between means. The group means are stored in the `t.test` results under `estimate`.


```r
# perform t-test and save out results as "hp_test"
hp_test <- t.test(hp ~ am, data = mtcars, paired = FALSE, var.equal = TRUE)

# show the group means from "hp_test"
hp_test$estimate
```

```
## mean in group 0 mean in group 1 
##        160.2632        126.8462
```

To calculate the difference in means between group 0 and group 1, you can use the `estimate` data to calculate this. The square brackets indicate which number (first mean or second mean) to take. This works to calculate the difference between group 0 and group 1, as well as between group 1 and group 0.


```r
# You can save out the means for each group

# The first value is mean in group 0
# ("mean in group 0" is printed first in results)
mean_group0 <- hp_test$estimate[[1]]

# The second value is mean in group 1
mean_group1 <- hp_test$estimate[[2]]

# Subtract the mean in group 1 from the mean in group 0
mean_group0 - mean_group1
```

```
## [1] 33.417
```

```r
# Subtract the mean in group 0 from the mean in group 1
mean_group1 - mean_group0
```

```
## [1] -33.417
```

You don't need to worry about the t statistic or degrees of freedom (df). The numbers you are most interested in are the p-value, the group means, and the 95% confidence interval.

Now we haven’t discussed the 95% confidence interval yet, but think of it in simple terms as a plausible range of true values of the difference between means. In this data, the average horsepower is 33.4 higher in cars with an automatic transmission, but it could be that, in fact, the true horsepower is between 16.3 lower or 83.1 higher in the automatic group vs the manual group.

#### **Non-parametric methods**

These are used to compare continuous outcomes in two groups. There are no assumptions about normality or variance. 

Unpaired case, for example, do marker levels differ between the drug and placebo groups?


```r
# non-parametric test for difference in marker levels by treatment group
wilcox.test(marker ~ trt, data = trial, paired = FALSE, exact = FALSE)
```

```
## 
## 	Wilcoxon rank sum test with continuity correction
## 
## data:  marker by trt
## W = 5161.5, p-value = 0.08475
## alternative hypothesis: true location shift is not equal to 0
```

The inputs for the `wilcox.test` function are very similar to the inputs for the `t.test` function. You will see here we are using the same example - comparing marker levels by treatment group, so the outcome variable ("marker"), the group variable ("trt") and the dataset ("trial") are all the same. This is still an unpaired test (`paired = FALSE`).

Paired case, for example, does an intervention cause a change in a patient's blood pressure?


```r
# paired non-parametric test for difference in "before" and "after" blood pressure measurements
wilcox.test(bp ~ when, data = example3a, paired = FALSE)
```

```
## 
## 	Wilcoxon rank sum test with continuity correction
## 
## data:  bp by when
## W = 5551, p-value = 0.002166
## alternative hypothesis: true location shift is not equal to 0
```

Single sample, for example, is the rate of college education in the midwest different than the national average (32%)?


```r
# non-parametric test - is rate of college education different from 32%?
wilcox.test(midwest$percollege, mu = 32)
```

```
## 
## 	Wilcoxon signed rank test with continuity correction
## 
## data:  midwest$percollege
## V = 924, p-value < 2.2e-16
## alternative hypothesis: true location is not equal to 32
```

Note here that you don’t get any parameters for the groups such as means, medians or standard deviations. You also don’t get an estimate for the difference between groups.

#### **The binomial test**

The binomial test compares a proportion to a hypothesized value. For example, what is the probability that an unbiased coin thrown 100 times would give a result as or more extreme than 60 heads? (This probability is equivalent to the p-value). 

The first argument of `binom.test` is the number of successes, then the number of total tests (total observations). The hypothesized probability is specified by the `p =` option - the default is 0.5 (50%).


```r
# Compare a proportion to a hypothesized value "p"
binom.test(60, 100, p = 0.5)
```

```
## 
## 	Exact binomial test
## 
## data:  60 and 100
## number of successes = 60, number of trials = 100, p-value = 0.05689
## alternative hypothesis: true probability of success is not equal to 0.5
## 95 percent confidence interval:
##  0.4972092 0.6967052
## sample estimates:
## probability of success 
##                    0.6
```

You can also use `binom.test` on data from a dataset. For example, if we want to test whether the proportion of women (sex = 1) is different from 50%:


```r
# The "sum" function adds up the number of observations where sex == 1 (women)
nwomen <- sum(lesson1a$sex)
nwomen
```

```
## [1] 205
```

```r
# The "nrow" function (for "number of rows") counts the total number of observations
# The "filter" function is used to count only the number of observations where
# "sex" is not missing (NA)
ntotal <- nrow(lesson1a %>% filter(!is.na(sex)))
ntotal
```

```
## [1] 386
```

```r
# Compare a proportion of patients in a dataset to a hypothesized value "p"
binom.test(nwomen, ntotal, p = 0.5)
```

```
## 
## 	Exact binomial test
## 
## data:  nwomen and ntotal
## number of successes = 205, number of trials = 386, p-value = 0.2417
## alternative hypothesis: true probability of success is not equal to 0.5
## 95 percent confidence interval:
##  0.4799345 0.5817614
## sample estimates:
## probability of success 
##              0.5310881
```

Note that above, we used the `filter` function to only count those observations where "sex" was not missing (NA). The function `is.na` gives a value of TRUE if the data is missing (NA) and FALSE if the data is non-missing. The `!` means "is not" in R, so that the statement `!is.na(sex)` is indicating that we want to keep the data where sex **is not** missing.

In this dataset, there are no missing values for "sex", but it is a good habit to include this condition so you are using the correct denominator if your dataset does have missing values.



This tells you that you had 386 observations, and there were 205 where sex was coded as 1, an observation proportion of 0.53. Now the "assumed" proportion was 0.5, giving an expected number of 193 women. These two values are quite close and the p-value is 0.2. 

## Assignments


```r
# Copy and paste this code to load the data for week 3 assignments
lesson3a <- readRDS(here::here("Data", "Week 3", "lesson3a.rds"))
lesson3b <- readRDS(here::here("Data", "Week 3", "lesson3b.rds"))
lesson3c <- readRDS(here::here("Data", "Week 3", "lesson3c.rds"))
lesson3d <- readRDS(here::here("Data", "Week 3", "lesson3d.rds"))
lesson3e <- readRDS(here::here("Data", "Week 3", "lesson3e.rds"))
lesson3f <- readRDS(here::here("Data", "Week 3", "lesson3f.rds"))
```

Again, more questions than you need to do, unless you’re keen (also, most won’t take long). Try to do at least the first three. 

- lesson3a.rds: These are data from over 1000 patients undergoing chemotherapy reporting a nausea and vomiting score from 0 to 10 on the day of treatment.  Does previous chemotherapy increase nausea scores? What about sex? 
- lesson3b.rds: Patients with wrist osteoarthritis are randomized to a new drug or placebo. Pain is measured before and two hours after taking a dose of the drug. Is the drug effective?
- lesson3c.rds: Some postoperative pain data again. Is pain on day 2 different than pain on day 1? Is pain on day 3 different from pain on day 2? 
- lesson3d.rds: This is a single-arm, uncontrolled study of acupuncture for patients with neck pain. Does acupuncture increase range of motion?  Just as many men as women get neck pain. Can we say anything about the sample chosen for this trial with respect to gender? The mean age of patients with neck pain is 58.2 years. Is the trial population representative with respect to age?
- lesson3e.rds: These data are length of stay from two different hospitals. One of the hospitals uses a new chemotherapy regimen that is said to reduce adverse events and therefore length of stay. Does the new regimen decrease length of stay? 
- lesson3f.rds: These data are from a randomized trial on the effects of physiotherapy treatment on physical function in pediatric patients recovering from cancer surgery. Function is measured on a 100 point scale. Does physiotherapy help improve physical functioning?
