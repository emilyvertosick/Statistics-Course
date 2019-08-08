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

# Load data necessary to run Week 7 examples
example7a <- readRDS(here::here("Data", "Week 7", "example7a.rds"))

# Create the survival object
# "t" is time in months
# "d" is survival status (0 = alive, 1 = dead)
example7a_surv <- Surv(example7a$t, example7a$d)

# Calculate descriptive statistics on time to event data
# The "~ 1" indicates that we want survival estimates for the entire group
survfit(example7a_surv ~ 1)

# Calculate median followup for survivors only
example7a %>%
  filter(d == 0) %>% # Keep only the surviving patients
  skim(t) # Remember, "p50" indicates the median

# Plot survival curve
plot(survfit(example7a_surv ~ 1))

# Plot survival curve by group (drug vs no drug)
# "~ drug" indicates to plot by "drug", vs "~ 1" which plots for all patients
plot(survfit(example7a_surv ~ drug, data = example7a))

# Compare survival between drug groups
survdiff(example7a_surv ~ drug, data = example7a)

# Create Cox regression model
coxph(example7a_surv ~ drug, data = example7a)

# You can use the tbl_regression function with Cox models to see the hazard ratios
example7a_cox <- coxph(example7a_surv ~ drug, data = example7a)
tbl_regression(example7a_cox, exponentiate = TRUE)

# Create multivariable Cox regression model
coxph(example7a_surv ~ drug + age + sex + marker, data = example7a)

# Survival probabilities for the entire cohort
summary(survfit(example7a_surv ~ 1, data = example7a))

# You can also summarize the survival by group:
summary(survfit(example7a_surv ~ drug, data = example7a))

# Get survival probabilities for specific time points in full dataset
# "~ 1" indicates all patients
# "t" variable is in months, so 12, 24 and 60 months used for 1, 2 and 5 years
summary(survfit(example7a_surv ~ 1, data = example7a), times = c(12, 24, 60))

# Create your survival object, which indicates this is a time to event outcome
example7a_surv <- Surv(example7a$t, example7a$d)

# Get median survival and number of events for group
survfit(example7a_surv ~ 1)

# Get median followup for survivors
example7a %>%
  filter(d == 0) %>%
  skim(t)

# Show a graph
plot(survfit(example7a_surv ~ 1))

# Look at predictors of survival
coxph(example7a_surv ~ drug + age + sex + marker, data = example7a)

# Copy and paste this code to load the data for week 7 assignments
lesson7a <- readRDS(here::here("Data", "Week 7", "lesson7a.rds"))
lesson7b <- readRDS(here::here("Data", "Week 7", "lesson7b.rds"))
lesson7c <- readRDS(here::here("Data", "Week 7", "lesson7c.rds"))
lesson7d <- readRDS(here::here("Data", "Week 7", "lesson7d.rds"))

