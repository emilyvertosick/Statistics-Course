

# Week 5

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

## Correlation

Correlating two or more variables is very easy: just use the `cor` function and then the dataset and selected variables.

For example, if you use the "lesson2b.rds" dataset and correlate the first four pain scores, you get the following table:


```r
cor(lesson2b %>% select(l01, l02, l03, l04))
```

```
##           l01       l02       l03       l04
## l01 1.0000000 0.7900984 0.6270860 0.5395075
## l02 0.7900984 1.0000000 0.8145025 0.7148299
## l03 0.6270860 0.8145025 1.0000000 0.8383224
## l04 0.5395075 0.7148299 0.8383224 1.0000000
```

```r
# The "select" function allows you to keep specific columns from your dataset
```



This shows, for example, that the correlation between l01 and l02 is 0.79 and the correlation between l02 and l04 is 0.71. From the table you can easily see that pain scores taken on consecutive days are more strongly correlated than those taken two or three days apart.

If the data are skewed, you can try a regression based on ranks, what is known as Spearman's rank correlation. What you'd type is the same as above, but adding the option `method = "spearman"`.


```r
cor(lesson2b %>% select(l01, l02, l03, l04), method = "spearman")
```

```
##           l01       l02       l03       l04
## l01 1.0000000 0.7799856 0.6220233 0.5443327
## l02 0.7799856 1.0000000 0.8126008 0.7220277
## l03 0.6220233 0.8126008 1.0000000 0.8324906
## l04 0.5443327 0.7220277 0.8324906 1.0000000
```

## Linear regression

Linear regression is when you try to predict a continuous variable. The function to use is `lm`.

The first variable is the dependent variable (e.g. blood pressure) and must be continuous. The other variables are the predictor variables and can be binary or continuous: in some cases you can use ordinal variables but you have to be careful. We’ll deal with categorical variables later in the course. The dependent and predictor variables are separated by a "~", and multiple predictor variables are separated by "+".

Let's use the data from "lesson3d.rds" as an example dataset. We want to see if we can predict a patient's range of motion after treatment (variable a) in terms of their age, sex and pre-treatment range of motion (variable b).


```r
lm(a ~ sex + age + b, data = lesson3d)
```

```
## 
## Call:
## lm(formula = a ~ sex + age + b, data = lesson3d)
## 
## Coefficients:
## (Intercept)          sex          age            b  
##    138.7336       2.8524      -0.4359       0.6692
```

This gives you the very basic information from the regression, but you can get more information using the `summary` function:


```r
rom_model <- lm(a ~ sex + age + b, data = lesson3d)
summary(rom_model)
```

```
## 
## Call:
## lm(formula = a ~ sex + age + b, data = lesson3d)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -60.135 -11.943   3.238  14.523  47.732 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 138.73363   29.50514   4.702 5.40e-05 ***
## sex           2.85241   10.25817   0.278    0.783    
## age          -0.43589    0.27770  -1.570    0.127    
## b             0.66924    0.07816   8.563 1.49e-09 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 25.29 on 30 degrees of freedom
## Multiple R-squared:  0.7475,	Adjusted R-squared:  0.7222 
## F-statistic:  29.6 on 3 and 30 DF,  p-value: 4.241e-09
```

The first column of numbers listed under "Coefficients" are the coefficients. You can interpret this as follows: start with 138.7 degrees of range of motion (the intercept or constant). Then add 2.85 if the patient is a woman, and take away 0.436 degrees for every year of age. Find, add 0.669 degrees for every degree of range of motion the patient had before the trial.

Let's take a single patient: a 54 year old woman with a range of motion of 301 before treatment. Her predicted range of motion afterwards is 138.7 + 2.85 - 0.436\*54 + 0.669\*301 = 319.5. Her actual figure was 325, so we predicted quite well for this patient. You can get R to do this automatically using the `augment` function from the `broom` package.


```r
# The "augment" function creates a dataset of all patients included in the model
# and all variables included in the model, as well as the predictions
# The ".fitted" column is your prediction

lesson3d_pred <-
  augment(rom_model,
          newdata = lesson3d)
```

To get the number of observations, coefficients, 95% confidence interval and p-values printed in a table for all covariates, you can use the `tbl_regression` function from the `gtsummary` package:


```r
tbl_regression(rom_model)
```

\captionsetup[table]{labelformat=empty,skip=1pt}
\begin{longtable}{lccc}
\toprule
\textbf{N = 34} & \textbf{Coefficient} & \textbf{95\% CI}\textsuperscript{1} & \textbf{p-value} \\ 
\midrule
1=female & 2.9 & -18, 24 & 0.8 \\ 
age & -0.44 & -1.0, 0.13 & 0.13 \\ 
range of motion before acupuncture & 0.67 & 0.51, 0.83 & <0.001 \\ 
\bottomrule
\end{longtable}
\vspace{-5mm}
\begin{minipage}{\linewidth}
\textsuperscript{1}CI = Confidence Interval \\ 
\end{minipage}



For example, for sex, the 95% CI is -18 to 24, meaning that women might plausibly have a range of motion anywhere from 18 degrees less than men to 24 degrees more. In short, we don't have any strong evidence that sex has an effect on range of motion at all and we can see this reflected in the p value, p=0.8. There are 34 patients included in this model.


```r
summary(rom_model)
```

```
## 
## Call:
## lm(formula = a ~ sex + age + b, data = lesson3d)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -60.135 -11.943   3.238  14.523  47.732 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 138.73363   29.50514   4.702 5.40e-05 ***
## sex           2.85241   10.25817   0.278    0.783    
## age          -0.43589    0.27770  -1.570    0.127    
## b             0.66924    0.07816   8.563 1.49e-09 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 25.29 on 30 degrees of freedom
## Multiple R-squared:  0.7475,	Adjusted R-squared:  0.7222 
## F-statistic:  29.6 on 3 and 30 DF,  p-value: 4.241e-09
```

At the bottom of the `summary` readout there are a few miscellaneous tidbits:

- The "p-value" next to the "F-statistic" on the last line tells you whether, as a whole, your model, including the constant and three variables, is a statistically significant predictor.

- The "Multiple R-squared" value (often referred to as just "r squared") tells you how good a predictor it is on a scale from 0 to 1. We’ll discuss the meaning of r squared in more detail, but it is defined as the proportion of variation that you can explain using your model. 

## Graphing the data

Graphing the data is done using the `ggplot` function from the `ggplot2` package. In short, the main inputs for the `ggplot` function are your dataset, the x variable and the y variable. You can then create a number of different plots using this data.

To create a scatterplot, the `geom_point` function is added to the `ggplot` function:


```r
ggplot(data = lesson5a,
       aes(x = age, y = rt)) +
  geom_point()
```

![](05-week5_files/figure-latex/section5j-1.pdf)<!-- --> 

This scatterplot from the "lesson5a.rds" data shows race time and age for every runner in the study. This is a useful way of getting a feel for the data before you start.

## Logistic regression

Logistic regression is used when the variable you wish to predict is binary (e.g. relapsed or not). The function to use is `glm`, with the option `family = "binomial"` to indicate that our outcome variable is binary.

Again, the first variable is the dependent variable (e.g. hypertension) and must be binary. The other variables are the predictor variables and can be binary or continuous: again, in some cases you can use ordinal variables but you have to be careful. The variables are entered into the `glm` function the same way as the `lm` function (dependent ~ predictor1 + predictor2 + ...).

We'll use the dataset "lesson4d.rds" as an example.


```r
response_model <- glm(response ~ age + sex + group, data = lesson4d, family = "binomial")
summary(response_model)
```

```
## 
## Call:
## glm(formula = response ~ age + sex + group, family = "binomial", 
##     data = lesson4d)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -1.3760  -1.0954  -0.9119   1.2366   1.5590  
## 
## Coefficients:
##              Estimate Std. Error z value Pr(>|z|)  
## (Intercept)  0.967546   0.447037   2.164   0.0304 *
## age         -0.023270   0.009807  -2.373   0.0177 *
## sex         -0.180196   0.234045  -0.770   0.4413  
## group       -0.318300   0.205037  -1.552   0.1206  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 546.87  on 397  degrees of freedom
## Residual deviance: 538.18  on 394  degrees of freedom
##   (2 observations deleted due to missingness)
## AIC: 546.18
## 
## Number of Fisher Scoring iterations: 4
```



By default, R gives the coefficients in logits. To easily see the coefficients and 95% confidence intervals for all covariates as odds ratio, we can again use the `tbl_regression` function. In this case, we use the option `exponentiate = TRUE`, which indicates that odds ratios (not logits) should be presented. (You can also use this function to see the formatted logit results by using the `exponentiate = FALSE` option.)


```r
glm(response ~ age + sex + group, data = lesson4d, family = "binomial") %>%
  tbl_regression(exponentiate = TRUE)
```

\captionsetup[table]{labelformat=empty,skip=1pt}
\begin{longtable}{lccc}
\toprule
\textbf{N = 398} & \textbf{OR}\textsuperscript{1} & \textbf{95\% CI}\textsuperscript{1} & \textbf{p-value} \\ 
\midrule
age & 0.98 & 0.96, 1.00 & 0.018 \\ 
1 if woman, 0 if man & 0.84 & 0.53, 1.32 & 0.4 \\ 
1 if b, 0 if a & 0.73 & 0.49, 1.09 & 0.12 \\ 
\bottomrule
\end{longtable}
\vspace{-5mm}
\begin{minipage}{\linewidth}
\textsuperscript{1}OR = Odds Ratio, CI = Confidence Interval \\ 
\end{minipage}

The key things here are the odds ratios: you can say that the odds of response is multiplied by 0.98 for a one year increase in age; that women have an odds of response 0.84 of that for the men, though this is not statistically significant, and that response is lower in group 1, with an odds of 0.73 (you would also cite the p value and 95% CIs).

The problem here is that you can’t use any of these data to work out an individual patient’s chance of response. Now you can get R to do this for you using the `augment` function. For a binary outcome, you need to specify `type.predict = "response"` as an option so that you will get predicted probabilities (not log odds).


```r
lesson4d_pred <-
  augment(response_model,
          newdata = lesson4d,
          type.predict = "response")
```

NOTE: The "lesson4d_pred" dataset only includes 398 patients. If you look at the table above, you will see at the top that only 398 patients were included in the model. Any patients who are missing data for the outcome or any predictors will be excluded from the model, and will not be included in the predicted dataset.

If you want to look at calculating predictions from logistic regression in more detail, you’ll need logit (see below). 

One thing to be careful about is categorical variables. Imagine that you had the patients age and cancer stage (1, 2, 3 or 4) and wanted to know whether they recurred. If you tried `glm(recurrence ~ age + stage, ...)`, then stage would be treated as if the increase in risk going from stage 1 to 2 was exactly the same as that going from 2 to 3 and 3 to 4. To tell R that it is a categorical variable, you need to use the `factor` function with the categorical variable:


```r
recurrence_model <-
  glm(recurrence ~ age + factor(stage), data = example5a, family = "binomial")

summary(recurrence_model)
```


```r
recurrence_model %>%
  tbl_regression(exponentiate = TRUE)
```

\captionsetup[table]{labelformat=empty,skip=1pt}
\begin{longtable}{lccc}
\toprule
\textbf{N = 1064} & \textbf{OR}\textsuperscript{1} & \textbf{95\% CI}\textsuperscript{1} & \textbf{p-value} \\ 
\midrule
age & 1.04 & 1.03, 1.05 & <0.001 \\ 
factor(stage) &  &  &  \\ 
1 & --- & --- &  \\ 
2 & 2.71 & 2.01, 3.66 & <0.001 \\ 
3 & 5.23 & 3.16, 8.79 & <0.001 \\ 
4 & 5.88 & 3.34, 10.6 & <0.001 \\ 
\bottomrule
\end{longtable}
\vspace{-5mm}
\begin{minipage}{\linewidth}
\textsuperscript{1}OR = Odds Ratio, CI = Confidence Interval \\ 
\end{minipage}



What you can see here is that stage is broken into categories. The odds ratio is given comparing each stage to stage 1 (the reference). So the odds of recurrence is 2.71 higher for stage 2 compared to stage 1, 5.23 for stage 3 compared to stage 1 and 5.88 for stage 4 compared to stage 1.

**For keen students only!**

Here we look at our "response" model on the logit scale.


```r
summary(response_model)
```

```
## 
## Call:
## glm(formula = response ~ age + sex + group, family = "binomial", 
##     data = lesson4d)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -1.3760  -1.0954  -0.9119   1.2366   1.5590  
## 
## Coefficients:
##              Estimate Std. Error z value Pr(>|z|)  
## (Intercept)  0.967546   0.447037   2.164   0.0304 *
## age         -0.023270   0.009807  -2.373   0.0177 *
## sex         -0.180196   0.234045  -0.770   0.4413  
## group       -0.318300   0.205037  -1.552   0.1206  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 546.87  on 397  degrees of freedom
## Residual deviance: 538.18  on 394  degrees of freedom
##   (2 observations deleted due to missingness)
## AIC: 546.18
## 
## Number of Fisher Scoring iterations: 4
```




Firstly, note that the p values are the same, what differs is the coefficients. Now if you are really smart, you’ll notice that the coefficient is the natural log of the odds ratios above. You can use the coefficients to work out an individual’s probability of response. We start with the constant, and subtract 0.0233 for each year of age and then subtract an additional 0.18 if a woman and 0.318 if in group 1. Call this number "l" for the log of the odds. The probability is e^l^ / (1 + e^l^). Take a 53 year old man on regimen b (group 1): l = 0.9675 + -0.0233\*53 + -0.318, gives -0.5841.

To convert, type ``exp(-0.5841) / (exp(-0.5841)+1)`` to get a probability of 35.8%.

## Getting the area-under-the-curve

Imagine that you wanted to know how well a blood marker predicted cancer. Note that the blood marker could be continuous (e.g. ng/ml) or binary (positive or negative such as in a test for circulating tumor cells), doesn’t matter for our purposes.


```r
# The "roc" function comes from the "pROC" package
roc(cancer ~ marker, data = example5b)
```

```
## 
## Call:
## roc.formula(formula = cancer ~ marker, data = example5b)
## 
## Data: marker in 1865 controls (cancer 0) < 635 cases (cancer 1).
## Area under the curve: 0.8143
```

So the marker has an area under the curve of 0.814. The `roc` function is particularly useful if you want to know the area-under-the-curve with and without a marker.

For instance, the code below could tell you how much the area-under-the-curve increases when you add a new marker to a model to predict cancer that already includes age.

First, get the AUC for the model with age only:


```r
# Original model with age
roc(cancer ~ age, data = example5b)
```

```
## 
## Call:
## roc.formula(formula = cancer ~ age, data = example5b)
## 
## Data: age in 1865 controls (cancer 0) < 635 cases (cancer 1).
## Area under the curve: 0.6354
```

Now, calculate the AUC for the model with age and the marker:


```r
# Model adding marker
roc(cancer ~ age + marker, data = example5b)
```

```
## $age
## 
## Call:
## roc.formula(formula = cancer ~ age, data = example5b)
## 
## Data: age in 1865 controls (cancer 0) < 635 cases (cancer 1).
## Area under the curve: 0.6354
## 
## $marker
## 
## Call:
## roc.formula(formula = cancer ~ marker, data = example5b)
## 
## Data: marker in 1865 controls (cancer 0) < 635 cases (cancer 1).
## Area under the curve: 0.8143
```

## Assignments

Regression is a very important part of statistics: I probably do more regressions that any other type of analysis, apart from than calculating basic summary data such as medians, means and proportions. So, I’ve given you lots of possibilities here. I’ve coded them: you really should try to do the bold ones, do those in italics if you can, and if you get to the rest, well, the more the merrier. The reason I have included all this is so I can go over it in class.

- __lesson5a.rds: These are data from marathon runners (again). Which of the following is associated with how fast runners complete the marathon: age, sex, training miles, weight?__

- __lesson5b.rds: These are data on patients with a disease that predisposes them to cancer. The disease causes precancerous lesions that can be surgically removed. A group of recently removed lesions are analyzed for a specific mutation. Does how long a patient has had the disease affect the chance that a new lesion will have a mutation?__

- lesson5c.rds: These are data from Canadian provinces giving population, unemployment rates and male and female life expectancy. Which of these variables are associated?

- _lesson5d.rds: These are data from mice inoculated with tumor cells and then treated with different doses of a drug. The growth rate of each animal’s tumor is then calculated. Is this drug effective?_

- lesson5e.rds: These are data from a study of the use of complementary medicine (e.g. massage) by UK breast cancer patients. There are data for the women’s age, time since diagnosis, presence of distant metastases, use of complementary medicine before diagnosis, whether they received a qualification after high school, the age they left education, whether usual employment is a manual trade, socioeconomic status. What predicts use of complementary medicine by women with breast cancer?

- _lesson5f.rds: These are the distance records for Frisbee for various ages in males. What is the relationship between age and how far a man can throw a Frisbee?_

- __lesson5g.rds: You’ve seen this data set before. Patients with lung cancer are randomized to receive either chemotherapy regime a or b and assessed for tumor response. We know there is no statistically significant difference between regimens (you can test this if you like).  However, do the treatments work differently depending on sex? Do they work differently by age?__

- __lesson5h.rds: PSA is used to screen for prostate cancer. In this data set, the researchers are looking at various forms of PSA (e.g. "nicked" PSA). What variables should be used to try to predict cancer? How accurate would this test be? (NOTE: these data were taken from a real data set, but I played around with them a bit, so please don’t draw any conclusions about PSA testing from this assignment).__

- lesson5i.rds: This is a randomized trial of behavioral therapy in cancer patients with depressed mood (note that higher score means better mood). Patients are randomized to no treatment (group 1), informal contact with a volunteer (group 2) or behavior therapy with a trained therapist (group 3). What would you conclude about the effectiveness of these treatments?
