

# Week 3

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

For this week's assignment, you will need to learn the following functions:

- `t.test`
- `wilcox.test`
- `binom.test`

**1. t-test**

This is used to compare a continuous outcome (such as hemoglobin) in two groups (e.g. vegetarians and carnivores, or patients in a randomized trial receiving an anemia treatment or placebo). Now statistician normally say that the t-test makes two assumptions: (1) data are normally distributed and (2) variances are equal. Don’t worry about assumption (2) for now. Also, assumption (1) has an odd feature: it doesn’t matter once sample sizes get large (for those of you who want to boast that you know a "theorem", this is called the "central limit theorem"). Just how large is "large" is a matter of judgment, but generally speaking, it is said that you can feel okay using a t-test on non-normal data once the sample size is above 30 a group. As it turns out, the t-test is "robust" to non-normal data, even if sample sizes are low. "Robust" means that it gives similar results regardless of whether the data are normally distributed or not. So many people feel comfortable using the t-test for just about any situation. 

**Different forms of the t-test**

In a simple unpaired case, for example, testing marker levels between a drug and placebo group:


```r
t.test(marker ~ trt, data = trial, var.equal = TRUE)
```

```
## 
## 	Two Sample t-test
## 
## data:  marker by trt
## t = -0.51222, df = 189, p-value = 0.6091
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.3092384  0.1817462
## sample estimates:
##    mean in group Drug mean in group Placebo 
##             0.8981078             0.9618539
```

A paired test, for example, comparing blood pressure taken before and after an intervention.

<!-- Note: Don't need to specify "var.equal = TRUE" for paired tests, as this is the default, but I thought it might be easier to be consistent across all. -->


```r
t.test(bp ~ when, data = example3a, var.equal = TRUE, paired = TRUE)
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

A single sample test comparing the mean of a group of observations with some hypothetical value, for example, is the average rate of college-educated adults in the midwest different than the national average of 32%?


```r
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
t.test(hp ~ am, data = mtcars, var.equal = TRUE)
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

The `t.test` function reports the data and variables you are testing, following by the t statistic (t), degrees of freedom (df) and p-value. Below that, it states the alternative hypothesis you are testing, prints the mean in each group, and gives the 95% confidence interval around the difference in group means.

While for an unpaired test, the `t.test` command prints the group means in each group, you may want to report the difference between means. (For a paired test, the difference in means is reported.) The group means are stored in the `estimate` attribute of the `t.test` results.


```r
hp_test <- t.test(hp ~ am, data = mtcars, var.equal = TRUE)
hp_test$estimate
```

```
## mean in group 0 mean in group 1 
##        160.2632        126.8462
```

To calculate the difference in means between group 0 and group 1, you can use the `estimate` data to calculate this. The square brackets indicate which number (first mean or second mean) to take. This works to calculate the difference between group 0 and group 1, as well as between group 1 and group 0.


```r
hp_test$estimate[[1]] - hp_test$estimate[[2]]
```

```
## [1] 33.417
```

```r
hp_test$estimate[[2]] - hp_test$estimate[[1]]
```

```
## [1] -33.417
```

You don't need to worry about the t statistic or degrees of freedom (df). The numbers you are most interested in are the p-value, the group means, and the 95% confidence interval.

Now we haven’t discussed the 95% confidence interval yet, but think of it in simple terms as a plausible range of true values of the difference between means. In this data, the average horsepower is 33.4 higher in cars with an automatic transmission, but it could be that, in fact, the true horsepower is between 16.3 lower or 83.1 higher in the automatic group vs the manual group.

**2. Non-parametric methods**

These are used to compare continuous outcomes in two groups. There are no assumptions about normality or variance. 

Unpaired case, for example, do marker levels differ between the drug and placebo groups?


```r
wilcox.test(marker ~ trt, data = trial, correct = FALSE, paired = FALSE)
```

```
## 
## 	Wilcoxon rank sum test
## 
## data:  marker by trt
## W = 4242.5, p-value = 0.4366
## alternative hypothesis: true location shift is not equal to 0
```

Paired case, for example, does an intervention cause a change in a patient's blood pressure?


```r
wilcox.test(bp ~ when, data = example3a, correct = FALSE, exact = FALSE, paired = FALSE)
```

```
## 
## 	Wilcoxon rank sum test
## 
## data:  bp by when
## W = 5551, p-value = 0.002159
## alternative hypothesis: true location shift is not equal to 0
```

Single sample, for example, is the rate of college education in the midwest different than the national average (32%)?


```r
wilcox.test(midwest$percollege, mu = 32, correct = FALSE)
```

```
## 
## 	Wilcoxon signed rank test
## 
## data:  midwest$percollege
## V = 924, p-value < 2.2e-16
## alternative hypothesis: true location is not equal to 32
```

Note here that you don’t get any parameters for the groups such as means, medians or standard deviations. You also don’t get an estimate for the difference between groups.

**3. The binomial test**

The binomial test compares a proportion to a hypothesized value. For example, what is the probability that an unbiased coin thrown 100 times would give a result as or more extreme than 60 heads? (This probability is equivalent to the p value). 

The first argument of `binom.test` is the number of successes, then the number of total tests (total observations). The hypothesized probability is specified by the `p =` option - the default is 0.5 (50%).


```r
binom.test(60, 100, p = 0.5)
```

```
## 
## 	Exact binomial test
## 
## data:  60 and 100
## number of successes = 60, number of trials = 100, p-value =
## 0.05689
## alternative hypothesis: true probability of success is not equal to 0.5
## 95 percent confidence interval:
##  0.4972092 0.6967052
## sample estimates:
## probability of success 
##                    0.6
```

The following tests whether the proportion of women (sex = 1) in the dataset is different than 50%. `sum(lesson2a$sex)` counts the number of observations where sex is 1. `nrow(lesson2a)` gives the total number of observations in the `lesson2a` dataset.


```r
binom.test(sum(lesson1a$sex), nrow(lesson1a), p = 0.5)
```

```
## 
## 	Exact binomial test
## 
## data:  sum(lesson1a$sex) and nrow(lesson1a)
## number of successes = 205, number of trials = 386, p-value =
## 0.2417
## alternative hypothesis: true probability of success is not equal to 0.5
## 95 percent confidence interval:
##  0.4799345 0.5817614
## sample estimates:
## probability of success 
##              0.5310881
```



This tells you that you had 386 observations, and there were 205 where sex was coded as 1, an observation proportion of 0.53. Now the "assumed" proportion was 0.5, giving an expected number of 193 women. These two values are quite close and the p value is 0.2. 

## Assignments

Again, more questions than you need to do, unless you’re keen (also, most won’t take long). Try to do at least the first three. 

- lesson3a.rds: These are data from over 1000 patients undergoing chemotherapy reporting a nausea and vomiting score from 0 to 10 on the day of treatment.  Does previous chemotherapy increase nausea scores? What about sex? 
- lesson3b.rds: Patients with wrist osteoarthritis are randomized to a new drug or placebo. Pain is measured before and two hours after taking a dose of the drug. Is the drug effective?
- lesson3c.rds: Some postoperative pain data again. Is pain on day 2 different than pain on day 1? Is pain on day 3 different from pain on day 2? 
- lesson3d.rds: This is a single-arm, uncontrolled study of acupuncture for patients with neck pain. Does acupuncture increase range of motion?  Just as many men as women get neck pain. Can we say anything about the sample chosen for this trial with respect to gender? The mean age of patients with neck pain is 58.2 years. Is the trial population representative with respect to age?
- lesson3e.rds: These data are length of stay from two different hospitals. One of the hospitals uses a new chemotherapy regime that is said to reduce adverse events and therefore length of stay. Does the new regime decrease length of stay? 
- lesson3f.rds: These data are from a randomized trial on the effects of physiotherapy treatment on physical function in pediatric patients recovering from cancer surgery. Function is measured on a 100 point scale. Does physiotherapy help improve physical functioning?
