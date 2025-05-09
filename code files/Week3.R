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

# t-test for marker levels between treatment arms
t.test(marker ~ trt, data = trial, var.equal = TRUE)

# paired t-test for blood pressure between "before" and "after" groups
t.test(example3a$bp_after, example3a$bp_before, paired = TRUE, var.equal = TRUE)

# t-test assessing whether the rate of college education is different than 32%
t.test(midwest$percollege, mu = 32)

# t-test for difference in horsepower for manual vs automatic transmission
t.test(hp ~ am, data = mtcars, var.equal = TRUE)

# perform t-test and save out results as "hp_test"
hp_test <- t.test(hp ~ am, data = mtcars, var.equal = TRUE)

# show the group means from "hp_test"
hp_test$estimate

# You can save out the means for each group

# The first value is mean in group 0
# ("mean in group 0" is printed first in results)
mean_group0 <- hp_test$estimate[[1]]

# The second value is mean in group 1
mean_group1 <- hp_test$estimate[[2]]

# Subtract the mean in group 1 from the mean in group 0
mean_group0 - mean_group1

# Subtract the mean in group 0 from the mean in group 1
mean_group1 - mean_group0

# non-parametric test for difference in marker levels by treatment group
wilcox.test(marker ~ trt, data = trial, exact = FALSE)

# paired non-parametric test for difference in "before" and "after" blood pressure measurements
wilcox.test(example3a$bp_after, example3a$bp_before, paired = TRUE)

# non-parametric test - is rate of college education different from 32%?
wilcox.test(midwest$percollege, mu = 32)

# Compare a proportion to a hypothesized value "p"
binom.test(60, 100, p = 0.5)

# The "sum" function adds up the number of observations where sex == 1 (women)
nwomen <- sum(lesson1a$sex)
nwomen

# The "nrow" function (for "number of rows") counts the total number of observations
# The "filter" function is used to count only the number of observations where
# "sex" is not missing (NA)
ntotal <- nrow(lesson1a %>% filter(!is.na(sex)))
ntotal

# Compare a proportion of patients in a dataset to a hypothesized value "p"
binom.test(nwomen, ntotal, p = 0.5)

# Copy and paste this code to load the data for week 3 assignments
lesson3a <- readRDS(here::here("Data", "Week 3", "lesson3a.rds"))
lesson3b <- readRDS(here::here("Data", "Week 3", "lesson3b.rds"))
lesson3c <- readRDS(here::here("Data", "Week 3", "lesson3c.rds"))
lesson3d <- readRDS(here::here("Data", "Week 3", "lesson3d.rds"))
lesson3e <- readRDS(here::here("Data", "Week 3", "lesson3e.rds"))
lesson3f <- readRDS(here::here("Data", "Week 3", "lesson3f.rds"))

