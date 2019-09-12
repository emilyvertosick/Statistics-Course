library(tidyverse)
library(haven)

# Remove format labels from data, these are not useful in R
# Keep variable labels however

# Load data
all_data <-
  list.files(here::here("Data"), pattern = ".rds", recursive = TRUE) %>%
  purrr::map(~ glue::glue("Data/{..1}") %>% as.character())

all_data_names <-
  map(all_data,
      ~ str_split(..1, "/") %>%
        unlist() %>%
        pluck(3) %>%
        str_replace(".rds", "")
  )
names(all_data) <- all_data_names

list2env(map(all_data, readRDS), envir = .GlobalEnv)

# "filter(TRUE)" fixes issues where blue "expand" arrow no longer shows in 
# environment window

# Remove labels
example4a <- zap_formats(example4a)
saveRDS(example4a, here::here("Data", "Week 4", "example4a.rds"))

example5b <- zap_formats(example5b)
example5b <- example5b %>% filter(TRUE)
saveRDS(example5b, here::here("Data", "Week 5", "example5b.rds"))

lesson1a <- zap_formats(lesson1a)
lesson1a <- lesson1a %>% filter(TRUE)
saveRDS(lesson1a, here::here("Data", "Week 1", "lesson1a.rds"))

lesson2a <- zap_formats(lesson2a)
lesson2a <- lesson2a %>% filter(TRUE)
saveRDS(lesson2a, here::here("Data", "Week 2", "lesson2a.rds"))

lesson2b <- zap_formats(lesson2b)
lesson2b <- lesson2b %>% filter(TRUE)
saveRDS(lesson2b, here::here("Data", "Week 2", "lesson2b.rds"))

lesson2c <- zap_formats(lesson2c)
lesson2c <- lesson2c %>% filter(TRUE)
saveRDS(lesson2c, here::here("Data", "Week 2", "lesson2c.rds"))

lesson2d <- zap_formats(lesson2d)
lesson2d <- lesson2d %>% filter(TRUE)
saveRDS(lesson2d, here::here("Data", "Week 2", "lesson2d.rds"))

lesson2e <- zap_formats(lesson2e)
lesson2e <- lesson2e %>% filter(TRUE)
saveRDS(lesson2e, here::here("Data", "Week 2", "lesson2e.rds"))

lesson3a <- zap_formats(lesson3a)
lesson3a <- lesson3a %>% filter(TRUE)
saveRDS(lesson3a, here::here("Data", "Week 3", "lesson3a.rds"))

lesson3b <- zap_formats(lesson3b)
saveRDS(lesson3b, here::here("Data", "Week 3", "lesson3b.rds"))

lesson3c <- zap_formats(lesson3c)
saveRDS(lesson3c, here::here("Data", "Week 3", "lesson3c.rds"))

lesson3d <- zap_formats(lesson3d)
saveRDS(lesson3d, here::here("Data", "Week 3", "lesson3d.rds"))

lesson3e <- zap_formats(lesson3e)
lesson3e <-
  lesson3e %>%
  mutate(
    hospital =
      case_when(
        hospital == 1 ~ "a",
        hospital == 2 ~ "b"
      )
  )
saveRDS(lesson3e, here::here("Data", "Week 3", "lesson3e.rds"))

lesson3f <- zap_formats(lesson3f)
lesson3f <- lesson3f %>% filter(TRUE)
saveRDS(lesson3f, here::here("Data", "Week 3", "lesson3f.rds"))

lesson4a <- zap_formats(lesson4a)
saveRDS(lesson4a, here::here("Data", "Week 4", "lesson4a.rds"))

lesson4b <- zap_formats(lesson4b)
lesson4b <- lesson4b %>% filter(TRUE)
saveRDS(lesson4b, here::here("Data", "Week 4", "lesson4b.rds"))

lesson4b_changed <- zap_formats(lesson4b_changed)
saveRDS(lesson4b_changed, here::here("Data", "Week 4", "lesson4b_changed.rds"))

lesson4c <- zap_formats(lesson4c)
lesson4c <- lesson4c %>% filter(TRUE)
saveRDS(lesson4c, here::here("Data", "Week 4", "lesson4c.rds"))

lesson4d <- zap_formats(lesson4d)
lesson4d <- lesson4d %>% filter(TRUE)
saveRDS(lesson4d, here::here("Data", "Week 4", "lesson4d.rds"))

lesson4e <- zap_formats(lesson4e)
saveRDS(lesson4e, here::here("Data", "Week 4", "lesson4e.rds"))

lesson5a <- zap_formats(lesson5a)
lesson5a <- lesson5a %>% filter(TRUE)
saveRDS(lesson5a, here::here("Data", "Week 5", "lesson5a.rds"))

lesson5c <- zap_formats(lesson5c)
saveRDS(lesson5c, here::here("Data", "Week 5", "lesson5c.rds"))

lesson5d <- zap_formats(lesson5d)
saveRDS(lesson5d, here::here("Data", "Week 5", "lesson5d.rds"))

lesson5e <- zap_formats(lesson5e)
lesson5e <- lesson5e %>% filter(TRUE)
saveRDS(lesson5e, here::here("Data", "Week 5", "lesson5e.rds"))

lesson5f <- zap_formats(lesson5f)
saveRDS(lesson5f, here::here("Data", "Week 5", "lesson5f.rds"))

lesson5g <- zap_formats(lesson5g)
lesson5g <- lesson5g %>% filter(TRUE)
saveRDS(lesson5g, here::here("Data", "Week 5", "lesson5g.rds"))

lesson5h <- zap_formats(lesson5h)
lesson5h <- lesson5h %>% filter(TRUE)
saveRDS(lesson5h, here::here("Data", "Week 5", "lesson5h.rds"))

lesson5i <- zap_formats(lesson5i)
saveRDS(lesson5i, here::here("Data", "Week 5", "lesson5i.rds"))

lesson6a <- zap_formats(lesson6a)
lesson6a <- lesson6a %>% filter(TRUE)
saveRDS(lesson6a, here::here("Data", "Week 6", "lesson6a.rds"))

lesson6b <- zap_formats(lesson6b)
lesson6b <- lesson6b %>% filter(TRUE)
saveRDS(lesson6b, here::here("Data", "Week 6", "lesson6b.rds"))

lesson6c <- zap_formats(lesson6c)
lesson6c <- lesson6c %>% filter(TRUE)
saveRDS(lesson6c, here::here("Data", "Week 6", "lesson6c.rds"))

lesson6d <- zap_formats(lesson6d)
lesson6d <- lesson6d %>% filter(TRUE)
saveRDS(lesson6d, here::here("Data", "Week 6", "lesson6d.rds"))

lesson7a <- zap_formats(lesson7a)
lesson7a <- lesson7a %>% filter(TRUE)
saveRDS(lesson7a, here::here("Data", "Week 7", "lesson7a.rds"))

lesson7b <- zap_formats(lesson7b)
lesson7b <- zap_labels(lesson7b)
saveRDS(lesson7b, here::here("Data", "Week 7", "lesson7b.rds"))

lesson7c <- zap_formats(lesson7c)
lesson7c <- lesson7c %>% filter(TRUE)
saveRDS(lesson7c, here::here("Data", "Week 7", "lesson7c.rds"))

lesson7d <- zap_formats(lesson7d)
saveRDS(lesson7d, here::here("Data", "Week 7", "lesson7d.rds"))









