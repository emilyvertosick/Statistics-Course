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

# Load data necessary to run Week 5 examples
lesson2b <- readRDS(here::here("Data", "Week 2", "lesson2b.rds"))
lesson3d <- readRDS(here::here("Data", "Week 3", "lesson3d.rds"))
lesson4d <- readRDS(here::here("Data", "Week 4", "lesson4d.rds"))
lesson5a <- readRDS(here::here("Data", "Week 5", "lesson5a.rds"))
example5a <- readRDS(here::here("Data", "Week 5", "example5a.rds"))
example5b <- readRDS(here::here("Data", "Week 5", "example5b.rds"))

# Display the correlation between variables l01, l02, l03 and l04
cor(lesson2b %>% select(l01, l02, l03, l04))

# Calculate the Spearman correlation for skewed data
cor(lesson2b %>% select(l01, l02, l03, l04), method = "spearman")

# Linear regression model for a, predictors are sex, age and b
lm(a ~ sex + age + b, data = lesson3d)

# Save out linear regression model
rom_model <- lm(a ~ sex + age + b, data = lesson3d)

# Show additional model results
summary(rom_model)

# The "augment" function creates a dataset of all patients included in the model
# and all variables included in the model, as well as the predictions
lesson3d_pred <- augment(rom_model)

# Print out new dataset to show output from "augment"
# The ".fitted" column is your prediction
# You can ignore all columns to the right of ".fitted"
lesson3d_pred

# Print formatted table of regression results
tbl_regression(rom_model)

# Summary of linear regression results
summary(rom_model)

# Create a scatterplot of race time by age
ggplot(data = lesson5a,
       aes(x = age, y = rt)) +
  geom_point()

# Create a logistic regression model for response, predictors are age, sex and group
response_model <- glm(response ~ age + sex + group, data = lesson4d, family = "binomial")

# Look at additional model results
summary(response_model)

# Create logistic regression model
glm(response ~ age + sex + group, data = lesson4d, family = "binomial") %>%
  # Pass to tbl_regression to show formatted table with odds ratios
  tbl_regression(exponentiate = TRUE)

# Get predictions from logistic regression model
# type.predict = "response" gives predicted probabilities
lesson4d_pred <-
  augment(response_model, type.predict = "response")

# Look at the dataset containing predicted probabilities (.fitted variable)
# You can ignore all columns to the right of ".fitted"
lesson4d_pred

# Create a model for recurrence using the categorical variable "stage"
recurrence_model <-
  glm(recurrence ~ age + factor(stage), data = example5a, family = "binomial")

# Show the results of this model
summary(recurrence_model)

# Formatted to show odds ratios
recurrence_model %>%
  tbl_regression(exponentiate = TRUE)

# Look at details of "response" logistic regression model
summary(response_model)

# Calculate the AUC using the "roc" function
roc(cancer ~ marker, data = example5b)

# Calculate AUC of original model with age
roc(cancer ~ age, data = example5b)

# Create the multivariable model
marker_model <- glm(cancer ~ age + marker, data = example5b, family = "binomial")

# Use "augment" to get predicted probability
marker_pred <- augment(marker_model, type.predict = "response")

# Calculate AUC of model with age and marker
roc(cancer ~ .fitted, data = marker_pred)

# Copy and paste this code to load the data for week 5 assignments
lesson5a <- readRDS(here::here("Data", "Week 5", "lesson5a.rds"))
lesson5b <- readRDS(here::here("Data", "Week 5", "lesson5b.rds"))
lesson5c <- readRDS(here::here("Data", "Week 5", "lesson5c.rds"))
lesson5d <- readRDS(here::here("Data", "Week 5", "lesson5d.rds"))
lesson5e <- readRDS(here::here("Data", "Week 5", "lesson5e.rds"))
lesson5f <- readRDS(here::here("Data", "Week 5", "lesson5f.rds"))
lesson5g <- readRDS(here::here("Data", "Week 5", "lesson5g.rds"))
lesson5h <- readRDS(here::here("Data", "Week 5", "lesson5h.rds"))
lesson5i <- readRDS(here::here("Data", "Week 5", "lesson5i.rds"))
