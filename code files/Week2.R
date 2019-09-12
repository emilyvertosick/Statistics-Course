
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

# Load data necessary to run Week 2 examples
lesson1a <- readRDS(here::here("Data", "Week 1", "lesson1a.rds"))



str(lesson1a)



# Summary of "age" variable from "lesson1a" dataset
lesson1a %>% skim(age)



# Summary of "age" within men and women separately
lesson1a %>%
  group_by(sex) %>%
  skim(age)



# Get centiles for "age" variable
quantile(lesson1a$age, na.rm = TRUE)



# Get specific centiles (11th, 45th, 78th, 91.5th) for "age" variable
quantile(lesson1a$age, probs = c(0.11, 0.45, 0.78, 0.915), na.rm = TRUE)



# Get formatted one-way frequency table
tbl_summary(
  lesson1a %>% select(sex), # Specify data to use and variables to include
  type = list("sex" ~ "categorical") # Show all levels of binary variables
)





# Create a formatted two-way summary table
tbl_summary(
  lesson1a %>% select(sex, y), # Select both variables
  by = y, # The "by" option specifies which will be the column variable
  type = list("sex" ~ "categorical")
)



# Create a formatted two-way summary table and add column for all patients
tbl_summary(
  lesson1a %>% select(sex, y),
  by = y,
  type = list("sex" ~ "categorical")
) %>%
  # Add a column with totals across all locations
  # "last = TRUE" puts the column on the right side of the table
  add_overall(last = TRUE)



# The two-way summary table can give you row percent instead of column percent
tbl_summary(
  lesson1a %>% select(sex, y),
  by = y,
  type = list("sex" ~ "categorical"),
  percent = "row" # get the row percent instead of column percent
)



# Count all patients in the dataset
lesson1a %>% count()



# Count the number of women
lesson1a %>%
  filter(sex == 1) %>%
  count()

# Count the number of women treated at the main campus
lesson1a %>%
  filter(sex == 1 & y == "campus") %>%
  count()



# This code creates a histogram of the "age" variable
ggplot(data = lesson1a,
       aes(x = age)) +
  geom_histogram()



# Here is the same histogram, setting the number of bins to 20
ggplot(data = lesson1a,
       aes(x = age)) +
  geom_histogram(bins = 20)



# Here is the histogram with 20 bins and density curve overlay
ggplot(data = lesson1a,
       aes(x = age)) +
  geom_histogram(aes(y = ..density..), bins = 20) +
  geom_density()



# The "ci" function is from the "gmodels" package
# This gives the mean of age and 90% confidence interval
ci(lesson1a$age, confidence = 0.90, na.rm = TRUE)



# The "ci.binom" function gives the same information as "ci" but is used for binary variables
ci.binom(lesson1a$sex, na.rm = TRUE)



# Multiplication
7*7



# Natural logarithm
log(2.71828)



# Inverse natural logarithm
exp(1)



# Base 10 logarithm
log10(100)



# Cosine
cos(45)



# Probability that an observation will be less than mean + 1 standard deviations
pnorm(1)

# Probability that an observation will be less than mean - 0.5 standard deviations
pnorm(-0.5)



# Probability that an observation will be less than mean + 1.96
pnorm(1.96)

# Probability that an observation will be less than mean - 1.96
pnorm(-1.96)



# Copy and paste this code to load the data for week 2 assignments
lesson2a <- readRDS(here::here("Data", "Week 2", "lesson2a.rds"))
lesson2b <- readRDS(here::here("Data", "Week 2", "lesson2b.rds"))
lesson2c <- readRDS(here::here("Data", "Week 2", "lesson2c.rds"))
lesson2d <- readRDS(here::here("Data", "Week 2", "lesson2d.rds"))
lesson2e <- readRDS(here::here("Data", "Week 2", "lesson2e.rds"))

