# Installing packages
install.packages("tidyverse")
install.packages("gt")
install.packages("here")
install.packages("skimr")
install.packages("epiR")
install.packages("broom")
install.packages("pROC")
install.packages("survival")
install.packages("survminer")
install.packages("remotes")

remotes::install_github("ddsjoberg/gtsummary")

# You can copy and paste this code into the console window and press "enter"
# to load the data needed for the week 1 examples
lesson1a <- readRDS(here::here("Data", "Week 1", "lesson1a.rds"))

# This will give an error - the "skimr" package isn't loaded yet
skim(lesson1a$age)

# You can use the function "skim" by specifying package "skimr"
skimr::skim(lesson1a$age)

# Here is the code to load all necessary packages
library(skimr)
library(gt)
library(gtsummary)
library(epiR)
library(broom)
library(pROC)
library(gmodels)
library(survival)
library(survminer)
library(tidyverse)

# View the data as a spreadsheet
View(lesson1a)

# View a summary of the dataset
skim(lesson1a)

# View a summary of the "age" variable only
skim(lesson1a$age)

# You can put the dataset into the function
skim(lesson1a)

# You can also use the "pipe" operator
lesson1a %>% skim()

# These two pieces of code will also give the same results
skim(lesson1a$age)
lesson1a %>% skim(age)

# Look at the first few rows of your data
lesson1a %>% head()

# Note: the "trial" dataset is automatically loaded when you load your packages
# and does not have to be manually loaded like the "lesson1a" dataset

# Create two-way table for response and death
table(trial$response, trial$death)

# Print response variable values
trial$response

# Create a formatted table for the "sex" variable
tbl_summary(
  lesson1a %>% select(sex) 
)

# Create a formatted table for the "sex" variable, showing both "0" and "1" values
tbl_summary(
  lesson1a %>% select(sex),
  type = list("sex" ~ "categorical")
)

# Create two-way table for response and death using "table" function
table(trial$response, trial$death)

# Create two-way table for response and death using "tbl_summary" function
tbl_summary(
  trial %>% select(response, death),
  by = death,
  type = list("response" ~ "categorical")
)

# Show summary statistics for "age"
skim(lesson1a$age)

# Save the data out as "lesson1a"
lesson1a <-
  lesson1a %>% # Take the current "lesson1a" dataset
  mutate(a = 1) # And add a variable called "a" with a value of "1"

# Replace the value of "a" with "2" for all observations
lesson1a <-
  lesson1a %>%
  mutate(a = 2)

# Replace the value of "a" with the value of "p1" for all observations
lesson1a <-
  lesson1a %>%
  mutate(a = p1)

# Replace "a" with the average of "p1", "p2", "p3" and "p4"
lesson1a <-
  lesson1a %>%
  mutate(a = (p1 + p2 + p3 + p4)/4)

# Replace the value of "a" with "p1" if the value of "p1" is greater than 4
lesson1a <-
  lesson1a %>%
  mutate(a = if_else(p1 > 4, p1, a))

# Replace the value of "a" with "p1" if "sex" equals 1 (female)
lesson1a <-
  lesson1a %>%
  mutate(a = if_else(sex == 1, p1, a))

# Replace the value of "a" with "1" if "y" is equal to either "campus" or "peds"
lesson1a <-
  lesson1a %>%
  mutate(a = if_else(y == "campus" | y == "peds", 1, a))

# Replace the value of "a" with 1 if sex equals 1 (female) and age > 50
# For all other observations, replace "a" with 0
lesson1a <-
  lesson1a %>%
  mutate(a = if_else(sex == 1 & age > 50, 1, 0))

# Copy and paste this code to load the data for week 1 assignments
lesson1a <- readRDS(here::here("Data", "Week 1", "lesson1a.rds"))

