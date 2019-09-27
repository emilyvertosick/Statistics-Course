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

# Load data necessary to run Week 4 examples
lesson2a <- readRDS(here::here("Data", "Week 2", "lesson2a.rds"))
lesson3a <- readRDS(here::here("Data", "Week 3", "lesson3a.rds"))
example4a <- readRDS(here::here("Data", "Week 4", "example4a.rds"))

# Create twoway table of prior chemotherapy by sex
tbl_summary(
  lesson3a %>% select(pc, sex),
  by = sex,
  type = list("pc" ~ "categorical")
)

# Create twoway table with "overall" column and display row percents
tbl_summary(
  lesson3a %>% select(pc, sex),
  by = sex,
  type = list("pc" ~ "categorical"),
  percent = "row"
) %>%
  add_overall(last = TRUE)

# Create a new variable that indicates whether patients had marathon time <= 240 minutes
lesson2a <-
  lesson2a %>%
  mutate(subfourhour =
           if_else(rt <= 240, 1, 0))

# The first variable is the row variable
# The second variable is the column variable
table(lesson2a$subfourhour, lesson2a$sex)

# Create the table and then perform the chi-squared test
table(lesson2a$subfourhour, lesson2a$sex) %>%
  chisq.test()

# Create two-way table including chi-squared p value
tbl_summary(
  lesson2a %>% select(subfourhour, sex),
  by = sex,
  type = list("subfourhour" ~ "categorical")
) %>%
  add_p(test = list("subfourhour" ~ "chisq.test"))

# Create a two-way table
table(lesson2a$sex, lesson2a$subfourhour)

# This code creates the table with the correct format
matrix(rev(table(lesson2a$sex, lesson2a$subfourhour)), nrow = 2)

# For those who are curious, here is a description of the functions above:
# "table" - creates the two-way table above
# "rev" - reverses the order of the table
# "matrix(..., nrow = 2)" converts the reversed data back into a two-by-two table

# Apply the epi.2by2 function to the table in the correct format
epi.2by2(matrix(rev(table(lesson2a$sex, lesson2a$subfourhour)), nrow = 2))

# Another example using "epi.2by2" function
epi.2by2(matrix(rev(table(example4a$toxin, example4a$cancer)), nrow = 2))

# Calculate p value from fisher's exact test
fisher.test(table(example4a$toxin, example4a$cancer))

# Create formatted table with p value from fisher's exact test
tbl_summary(
  example4a %>% select(toxin, cancer),
  by = cancer,
  type = list("toxin" ~ "categorical")
) %>%
  add_p(test = list("toxin" ~ "fisher.test"))

# Perform a t-test only among patients with prior chemotherapy
t.test(nv ~ sex, data = lesson3a %>% filter(pc == 1))

# t-test for patients without prior chemotherapy
t.test(nv ~ sex, data = lesson3a %>% filter(pc == 0))

# Copy and paste this code to load the data for week 4 assignments
lesson4a <- readRDS(here::here("Data", "Week 4", "lesson4a.rds"))
lesson4b <- readRDS(here::here("Data", "Week 4", "lesson4b.rds"))
lesson4c <- readRDS(here::here("Data", "Week 4", "lesson4c.rds"))
lesson4d <- readRDS(here::here("Data", "Week 4", "lesson4d.rds"))
lesson4e <- readRDS(here::here("Data", "Week 4", "lesson4e.rds"))
