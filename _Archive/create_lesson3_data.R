# Create dataset for example3a
library(tidyverse)

# 12/2/2024: due to changes in syntax for using "paired" option with formula syntax in t.test and wilcox.test, want to reshape data here to match
# Copied long format to "_Archive", "Lecture 3" folder
example3a_long <- readRDS(here::here("_Archive", "Lecture 3", "example3a_long.rds"))

# Reshape to wide
example3a_wide <-
  example3a_long %>%
  pivot_wider(
    names_from = "when",
    values_from = "bp"
  ) %>%
  rename(bp_before = Before, bp_after = After)

saveRDS(example3a_wide, here::here("Data", "Week 3", "example3a.rds"))
