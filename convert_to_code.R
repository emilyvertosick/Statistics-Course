# Run to convert from Rmd to R script, keeping necessary code

knitr::purl(input = here::here("01-week1.Rmd"),
            output = here::here("code files", "Week1.R"), documentation = 0)

knitr::purl(input = here::here("02-week2.Rmd"),
            output = here::here("code files", "Week2.R"), documentation = 0)

knitr::purl(input = here::here("03-week3.Rmd"),
            output = here::here("code files", "Week3.R"), documentation = 0)

knitr::purl(input = here::here("04-week4.Rmd"),
            output = here::here("code files", "Week4.R"), documentation = 0)

knitr::purl(input = here::here("05-week5.Rmd"),
            output = here::here("code files", "Week5.R"), documentation = 0)

knitr::purl(input = here::here("06-week6.Rmd"),
            output = here::here("code files", "Week6.R"), documentation = 0)

knitr::purl(input = here::here("07-week7.Rmd"),
            output = here::here("code files", "Week7.R"), documentation = 0)

knitr::purl(input = here::here("09-answers.Rmd"),
            output = here::here("code files", "Answers.R"), documentation = 0)
