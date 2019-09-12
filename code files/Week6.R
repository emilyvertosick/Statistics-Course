
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



# This is the same code for week 4 that reverses the order of columns and rows
tbl_example6a <-
  matrix(rev(table(example6a$test, example6a$disease)), nrow = 2)

# Calculate sensitivity and specificity from table above
epi.tests(tbl_example6a)



# Copy and paste this code to load the data for week 6 assignments
lesson6a <- readRDS(here::here("Data", "Week 6", "lesson6a.rds"))
lesson6b <- readRDS(here::here("Data", "Week 6", "lesson6b.rds"))
lesson6c <- readRDS(here::here("Data", "Week 6", "lesson6c.rds"))
lesson6d <- readRDS(here::here("Data", "Week 6", "lesson6d.rds"))

