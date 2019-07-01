library(tidyverse)

# Create example6a data

df_6a <-
  tribble(
    ~disease, ~test, ~ntimes,
    1, 1, 20,
    1, 0, 10,
    0, 1, 180,
    0, 0, 1820
  )

example6a <-
  as.data.frame(lapply(df_6a, rep, df_6a$ntimes)) %>%
  select(-ntimes)

# Save out
saveRDS(example6a, here::here("Data", "Week 6", "example6a.rds"))