# Create dataset for example5a

library(tidyverse)
library(epiDisplay)
data(Compaq)
set.seed(7908544)

example5a <-
  Compaq %>%
  # Create age from age group to make this easier
  mutate(
    age =
      case_when(
        # Count as age 30-40
        agegr == "<40" ~ sample.int(10, nrow(.), replace = TRUE) + 29,
        agegr == "40-49" ~ sample.int(10, nrow(.), replace = TRUE) + 39,
        agegr == "50-59" ~ sample.int(10, nrow(.), replace = TRUE) + 49,
        agegr == "60+" ~ sample.int(16, nrow(.), replace = TRUE) + 59
      ),
    # Convert stage to numeric
    stage = as.numeric(stage),
    # Convert year to something sensible
    year2 = round(2000 + year)
  ) %>%
  arrange(stage, desc(status)) %>%
  group_by(stage) %>%
  mutate(n = 1:n()) %>%
  # Reduce a few events in the "stage 3" group to make OR more reasonable
  mutate(
    recurrence =
      case_when(
        stage != 3 ~ status,
        stage == 3 & n <= 25 ~ 0L,
        stage == 3 & n > 25 ~ status
      )
  ) %>%
  # Keep selected variables
  dplyr::select(id, stage, age,
         year = year2, recurrence)

saveRDS(example5a, here::here("Data", "Week 5", "example5a.rds"))

# Example 5b - simulate random age
set.seed(7908544)
example5b <- readRDS(here::here("Data", "Week 5", "example5b.rds"))
# example5b <- read_dta(here::here("Stata", "Lecture 5", "example5b.dta"))

example5b <-
  example5b %>%
  mutate(
    age = sample.int(20, n(), replace = TRUE),
    age =
      case_when(
        marker > 1 ~ age + 55,
        marker <= 1 ~ age + 45
      )
  )

saveRDS(example5b, here::here("Data", "Week 5", "example5b.rds"))

# Lesson 5b data is meant to have an observation where a patient has 154 year duration of disease
# Fix this

lesson5b <- readRDS(here::here("Data", "Week 5", "lesson5b.rds"))

lesson5b <-
  lesson5b %>%
  group_by(c) %>%
  mutate(
    n = 1:n(),
    c2 =
      case_when(
        is.na(c) & n == 1 ~ 154,
        TRUE ~ c
      ),
    mutation =
      case_when(
        c2 == 154 ~ 0,
        TRUE ~ mutation
      )
  ) %>%
  ungroup() %>%
  select(-c, -n, c = c2, mutation)
  
saveRDS(lesson5b, here::here("Data", "Week 5", "lesson5b.rds"))


  