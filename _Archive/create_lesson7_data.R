library(tidyverse)
library(survival)
set.seed(9798385)

# Create example data for lesson 7 instructions
example7a <-
  aml %>%
  rename(
    t = time, 
    d = status
  ) %>%
  mutate(
    drug = if_else(x == "Maintained", 1, 0),
    age = sample.int(40, size = nrow(.), replace = TRUE) + 40,
    marker = round(runif(nrow(.)) * 3, 3),
    sex = as.numeric(runif(nrow(.)) <= 0.65)
  ) %>%
  select(t, d, drug, age, marker, sex)

# Save out
saveRDS(example7a, here::here("Data", "Week 7", "example7a.rds"))