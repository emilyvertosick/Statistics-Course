---
output: html_document
editor_options: 
  chunk_output_type: console
---



# Getting Started

## R Instructions

### Using RStudio

There are normally four panes in the window.

1. The "console" window at the bottom left is where results will be shown if running R code from a .R file or interactively. The console window is also where you types in instructions for R.

2. The "source" window in the top left is where you will write out R code for your final .R analysis file.

3. The top right panel includes several tabs. The most important tabs here are "environment", which shows your current datasets and objects, and "history", which shows previous commands that have been run from either the "console" or the "source" window.

4. The bottom right panel also includes several tabs. The "files" tab shows all files in your current directory. The "plots" tab is where plots will be shown if a plot is created. The "packages" tab shows all R packages that are available on your machine. The "help" tab will show help files, and help files can be searched from this tab. The "viewer" tab will show any other files that are created, for example, HTML files.

### Setting Up RStudio

To access this course, download the "Statistics Course.zip" file and unzip it to your desired folder. Navigate to the main folder and click to open the R project file called "Statistics Course.Rproj". Opening the R project will allow you to easily access all files, as the "files" tab in the bottom right will automatically open to folder in which the R project file is located.

For this course, we will be using a set of packages called the "tidyverse". There are also several other packages that you should install. Running the line of code below will install the necessary packages for you.


```r
install.packages(c("tidyverse", "here", "skimr", "epiR", "broom", "pROC", "survival", "survminer", "remotes"))
remotes::install_github("ddsjoberg/gtsummary")
```

When you open RStudio, you must either run the following code in the "console" window, or include this line of code at the top of your code file in the "source" window, so that the package is loaded to your current session. By loading the package, you will be able to use all functions without specifying the package name each time.


```r
library(skimr)
library(gtsummary)
library(epiR)
library(broom)
library(pROC)
library(gmodels)
library(survival)
library(tidyverse)
```

### Opening a data file created by someone else

This is mainly what you will be doing during this course. You will be loading data from files with a ".rds" extension, which is a type of file that can be exported from R. In the "files" tab in the bottom right panel, navigate to the folder where the data is stored. Click on the desired data ".rds" file. A "Load R Object" popup will appear, which allows you to change the name that the dataset will be stored under. It is fine for this course to leave the dataset names as is. Clicking "OK" will load this file to your environment, which you can confirm by looking for the dataset in the top right "environment" tab.

To note, you can also load data using the following code, changing the folder names (e.g. "Week 1") and dataset names (e.g. "lesson1a.rds") as necessary:


```r
lesson1a <- readRDS(here::here("Data", "Week 1", "lesson1a.rds"))
```

## Looking at the data
R stores the data in the form of a spreadsheet. The rows are individual observations, normally a patient. The columns are variables giving data for that observation. View the dataset "lesson1a" by typing the following into the console window:


```r
View(lesson1a)
```

This is data from 386 patients undergoing surgery. You can see the patient’s hospital code number as the variable "id" and then their age and sex. There are then lists of other variables with names such as "p1", "t", "x" and so on. You can see that you can have both numbers and text as a variable. You may also notice that some variables have a value of "NA" for a particular observation. In R, "NA" indicates missing data. 

### Typing a command

A typical command is of the form: `packagename::function(options)`. If a package has already been loaded using the `library()` function (for example, as we did with the `skimr` package above), you can omit `packagename::` when running the code.

Since you can have multiple datasets in R at the same time, your command must indicate which dataset you are referring to. Commonly this is done by including the dataset name as an option in the function call.

For example, this will summarize the data for the full `lesson1a` dataset.


```r
skimr::skim(lesson1a)
```

```
## Skim summary statistics
##  n obs: 386 
##  n variables: 11 
## 
## -- Variable type:character -------------------------------------------------------------
##  variable missing complete   n min max empty n_unique
##         y       0      386 386   4   9     0        4
## 
## -- Variable type:numeric ---------------------------------------------------------------
##  variable missing complete   n      mean        sd    p0      p25    p50
##       age       0      386 386     49.48     13.75    19     40       49
##        id       0      386 386 559159.34 257028.45 1e+05 337803.5 564405
##        p1       0      386 386      3.24      1.66     0      2        3
##        p2       0      386 386      3.29      1.59     0      2        3
##        p3       0      386 386      3.09      1.63     0      2        3
##        p4       0      386 386      2.62      1.63     0      1        3
##       sex       0      386 386      0.53      0.5      0      0        1
##         t       0      386 386     12.24      5.75     0      8       12
##         x       2      384 386      1.54      0.5      1      1        2
##         z       2      384 386      1.59      0.84     1      1        1
##        p75  p100     hist
##      59       86 ▂▅▇▇▆▅▂▁
##  778010.75 1e+06 ▆▆▆▇▆▇▇▆
##       5        6 ▂▅▂▇▁▆▇▁
##       5        6 ▂▅▂▇▁▆▇▁
##       4        6 ▂▅▃▇▁▆▆▁
##       4        6 ▃▆▂▇▁▅▃▁
##       1        1 ▇▁▁▁▁▁▁▇
##      17       24 ▃▅▅▇▇▆▆▁
##       2        2 ▇▁▁▁▁▁▁▇
##       2        3 ▇▁▁▂▁▁▁▃
```

### Some Useful Commands

#### Extracting a variable by name ($)

To refer to one variable in your dataset, you can use the notation `dataset$variable` to indicate which dataset you are referencing, and which variable within that dataset.

For example, this will summarize just the variable `age` from the `lesson1a` dataset.


```r
skim(lesson1a$age)
```

```
## 
## Skim summary statistics
## 
## -- Variable type:numeric ---------------------------------------------------------------
##      variable missing complete   n  mean    sd p0 p25 p50 p75 p100
##  lesson1a$age       0      386 386 49.48 13.75 19  40  49  59   86
##      hist
##  ▂▅▇▇▆▅▂▁
```

#### Pipe operator (%>%)

One of the most useful commands is known as the pipe operator (%>%). The pipe operator can be read as "and then". Pipes allow a dataset or object to be passed from the left side of the pipe to the command on the right side. The dataset you are using will be referenced on the left side of the pipe, rather than included as an option in the next function.

For example, these two pieces of code give the same results:


```r
skim(lesson1a)

lesson1a %>% skim()

# These also give the same results

skim(lesson1a$age)

lesson1a %>% skim(age)
```

#### `head` function

The `head` function allows you to see the first few rows of your dataset in the console window, including the variable names and variable types at the top of the table.


```r
lesson1a %>% head()
```

```
## # A tibble: 6 x 11
##       id   sex   age    p1    p2    p3    p4     t     x y             z
##    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <chr>     <dbl>
## 1 541836     0    33     0     0     0     0     0     2 campus        1
## 2 285383     1    55     0     1     1     1     3     2 campus        1
## 3 332777     0    52     0     0     3     3     6     1 campus       NA
## 4 566828     1    53     0     0     0     1     1     2 campus       NA
## 5 193254     1    57     0     1     2     3     6     2 satellite     1
## 6 530508     1    31     0     0     2     2     4     1 campus        3
```

#### `str` function

The `str` function allows you to see the variable name, variable type, and any variable attributes such as labels, for all variables in your dataset. For example, this tells you the description of the "sex" variable and its label - "1 if woman, 0 if man".


```r
lesson1a %>% str()
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	386 obs. of  11 variables:
##  $ id : num  541836 285383 332777 566828 193254 ...
##   ..- attr(*, "format.stata")= chr "%9.0g"
##  $ sex: num  0 1 0 1 1 1 0 0 1 0 ...
##   ..- attr(*, "label")= chr "1 if woman, 0 if man"
##   ..- attr(*, "format.stata")= chr "%9.0g"
##  $ age: num  33 55 52 53 57 31 54 26 52 66 ...
##   ..- attr(*, "format.stata")= chr "%9.0g"
##  $ p1 : num  0 0 0 0 0 0 0 0 0 0 ...
##   ..- attr(*, "label")= chr "pain at time 1 postop"
##   ..- attr(*, "format.stata")= chr "%9.0g"
##  $ p2 : num  0 1 0 0 1 0 1 0 0 1 ...
##   ..- attr(*, "label")= chr "pain at time 2 postop"
##   ..- attr(*, "format.stata")= chr "%9.0g"
##  $ p3 : num  0 1 3 0 2 2 4 1 0 1 ...
##   ..- attr(*, "label")= chr "pain at time 3 postop"
##   ..- attr(*, "format.stata")= chr "%9.0g"
##  $ p4 : num  0 1 3 1 3 2 1 0 0 1 ...
##   ..- attr(*, "label")= chr "pain at time 4 postop"
##   ..- attr(*, "format.stata")= chr "%9.0g"
##  $ t  : num  0 3 6 1 6 4 6 1 0 3 ...
##   ..- attr(*, "label")= chr "total pain score times 1 - 4"
##   ..- attr(*, "format.stata")= chr "%9.0g"
##  $ x  : num  2 2 1 2 2 1 1 1 2 1 ...
##   ..- attr(*, "format.stata")= chr "%9.0g"
##  $ y  : chr  "campus" "campus" "campus" "campus" ...
##   ..- attr(*, "format.stata")= chr "%9s"
##  $ z  : num  1 1 NA NA 1 3 1 1 3 1 ...
##   ..- attr(*, "format.stata")= chr "%9.0g"
```

#### `tbl_summary` function

The `tbl_summary` function (from the `gtsummary` package) provides a formatted table of the values and frequencies for binary or categorical variables, and summary statistics (by default, median and quartiles) for continuous variables.


```r
# "select" takes one or more variable names that you would like to include in your table
tbl_summary(
  lesson1a %>% select(sex) 
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#iwrgxmosvm .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #000000;
  font-size: 16px;
  background-color: #FFFFFF;
  /* table.background.color */
  width: auto;
  /* table.width */
  border-top-style: solid;
  /* table.border.top.style */
  border-top-width: 2px;
  /* table.border.top.width */
  border-top-color: #A8A8A8;
  /* table.border.top.color */
  border-bottom-style: solid;
  /* table.border.bottom.style */
  border-bottom-width: 2px;
  /* table.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* table.border.bottom.color */
}

#iwrgxmosvm .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#iwrgxmosvm .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#iwrgxmosvm .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#iwrgxmosvm .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#iwrgxmosvm .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#iwrgxmosvm .gt_col_heading {
  color: #000000;
  background-color: #FFFFFF;
  /* column_labels.background.color */
  font-size: 16px;
  /* column_labels.font.size */
  font-weight: initial;
  /* column_labels.font.weight */
  vertical-align: middle;
  padding: 10px;
  margin: 10px;
}

#iwrgxmosvm .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#iwrgxmosvm .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#iwrgxmosvm .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#iwrgxmosvm .gt_group_heading {
  padding: 8px;
  color: #000000;
  background-color: #FFFFFF;
  /* row_group.background.color */
  font-size: 16px;
  /* row_group.font.size */
  font-weight: initial;
  /* row_group.font.weight */
  border-top-style: solid;
  /* row_group.border.top.style */
  border-top-width: 2px;
  /* row_group.border.top.width */
  border-top-color: #A8A8A8;
  /* row_group.border.top.color */
  border-bottom-style: solid;
  /* row_group.border.bottom.style */
  border-bottom-width: 2px;
  /* row_group.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* row_group.border.bottom.color */
  vertical-align: middle;
}

#iwrgxmosvm .gt_empty_group_heading {
  padding: 0.5px;
  color: #000000;
  background-color: #FFFFFF;
  /* row_group.background.color */
  font-size: 16px;
  /* row_group.font.size */
  font-weight: initial;
  /* row_group.font.weight */
  border-top-style: solid;
  /* row_group.border.top.style */
  border-top-width: 2px;
  /* row_group.border.top.width */
  border-top-color: #A8A8A8;
  /* row_group.border.top.color */
  border-bottom-style: solid;
  /* row_group.border.bottom.style */
  border-bottom-width: 2px;
  /* row_group.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* row_group.border.bottom.color */
  vertical-align: middle;
}

#iwrgxmosvm .gt_striped {
  background-color: #f2f2f2;
}

#iwrgxmosvm .gt_from_md > :first-child {
  margin-top: 0;
}

#iwrgxmosvm .gt_from_md > :last-child {
  margin-bottom: 0;
}

#iwrgxmosvm .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
}

#iwrgxmosvm .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#iwrgxmosvm .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#iwrgxmosvm .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#iwrgxmosvm .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#iwrgxmosvm .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#iwrgxmosvm .gt_table_body {
  border-top-style: solid;
  /* table_body.border.top.style */
  border-top-width: 2px;
  /* table_body.border.top.width */
  border-top-color: #A8A8A8;
  /* table_body.border.top.color */
  border-bottom-style: solid;
  /* table_body.border.bottom.style */
  border-bottom-width: 2px;
  /* table_body.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* table_body.border.bottom.color */
}

#iwrgxmosvm .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#iwrgxmosvm .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#iwrgxmosvm .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#iwrgxmosvm .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#iwrgxmosvm .gt_center {
  text-align: center;
}

#iwrgxmosvm .gt_left {
  text-align: left;
}

#iwrgxmosvm .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#iwrgxmosvm .gt_font_normal {
  font-weight: normal;
}

#iwrgxmosvm .gt_font_bold {
  font-weight: bold;
}

#iwrgxmosvm .gt_font_italic {
  font-style: italic;
}

#iwrgxmosvm .gt_super {
  font-size: 65%;
}

#iwrgxmosvm .gt_footnote_glyph {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="iwrgxmosvm" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_glyph">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>N = 386</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">1 if woman, 0 if man</td>
      <td class="gt_row gt_center">205 (53%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="2">
        <p class="gt_footnote">
          <sup class="gt_footnote_glyph">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

```r
# If you would like to see percentages for both male and female, you can use the "type" option and specify that the variable is categorical
tbl_summary(
  lesson1a %>% select(sex),
  type = list(vars(sex) ~ "categorical")
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#hlleqxdave .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #000000;
  font-size: 16px;
  background-color: #FFFFFF;
  /* table.background.color */
  width: auto;
  /* table.width */
  border-top-style: solid;
  /* table.border.top.style */
  border-top-width: 2px;
  /* table.border.top.width */
  border-top-color: #A8A8A8;
  /* table.border.top.color */
  border-bottom-style: solid;
  /* table.border.bottom.style */
  border-bottom-width: 2px;
  /* table.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* table.border.bottom.color */
}

#hlleqxdave .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#hlleqxdave .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#hlleqxdave .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#hlleqxdave .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#hlleqxdave .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#hlleqxdave .gt_col_heading {
  color: #000000;
  background-color: #FFFFFF;
  /* column_labels.background.color */
  font-size: 16px;
  /* column_labels.font.size */
  font-weight: initial;
  /* column_labels.font.weight */
  vertical-align: middle;
  padding: 10px;
  margin: 10px;
}

#hlleqxdave .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#hlleqxdave .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#hlleqxdave .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#hlleqxdave .gt_group_heading {
  padding: 8px;
  color: #000000;
  background-color: #FFFFFF;
  /* row_group.background.color */
  font-size: 16px;
  /* row_group.font.size */
  font-weight: initial;
  /* row_group.font.weight */
  border-top-style: solid;
  /* row_group.border.top.style */
  border-top-width: 2px;
  /* row_group.border.top.width */
  border-top-color: #A8A8A8;
  /* row_group.border.top.color */
  border-bottom-style: solid;
  /* row_group.border.bottom.style */
  border-bottom-width: 2px;
  /* row_group.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* row_group.border.bottom.color */
  vertical-align: middle;
}

#hlleqxdave .gt_empty_group_heading {
  padding: 0.5px;
  color: #000000;
  background-color: #FFFFFF;
  /* row_group.background.color */
  font-size: 16px;
  /* row_group.font.size */
  font-weight: initial;
  /* row_group.font.weight */
  border-top-style: solid;
  /* row_group.border.top.style */
  border-top-width: 2px;
  /* row_group.border.top.width */
  border-top-color: #A8A8A8;
  /* row_group.border.top.color */
  border-bottom-style: solid;
  /* row_group.border.bottom.style */
  border-bottom-width: 2px;
  /* row_group.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* row_group.border.bottom.color */
  vertical-align: middle;
}

#hlleqxdave .gt_striped {
  background-color: #f2f2f2;
}

#hlleqxdave .gt_from_md > :first-child {
  margin-top: 0;
}

#hlleqxdave .gt_from_md > :last-child {
  margin-bottom: 0;
}

#hlleqxdave .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
}

#hlleqxdave .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#hlleqxdave .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#hlleqxdave .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#hlleqxdave .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#hlleqxdave .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#hlleqxdave .gt_table_body {
  border-top-style: solid;
  /* table_body.border.top.style */
  border-top-width: 2px;
  /* table_body.border.top.width */
  border-top-color: #A8A8A8;
  /* table_body.border.top.color */
  border-bottom-style: solid;
  /* table_body.border.bottom.style */
  border-bottom-width: 2px;
  /* table_body.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* table_body.border.bottom.color */
}

#hlleqxdave .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#hlleqxdave .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#hlleqxdave .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#hlleqxdave .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#hlleqxdave .gt_center {
  text-align: center;
}

#hlleqxdave .gt_left {
  text-align: left;
}

#hlleqxdave .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#hlleqxdave .gt_font_normal {
  font-weight: normal;
}

#hlleqxdave .gt_font_bold {
  font-weight: bold;
}

#hlleqxdave .gt_font_italic {
  font-style: italic;
}

#hlleqxdave .gt_super {
  font-size: 65%;
}

#hlleqxdave .gt_footnote_glyph {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="hlleqxdave" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_glyph">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>N = 386</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">1 if woman, 0 if man</td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">181 (47%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">205 (53%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="2">
        <p class="gt_footnote">
          <sup class="gt_footnote_glyph">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

<br>

This tells you that the "sex" variable has no missing data (no "NA" values), and that there only 2 different values, all of which are integers (i.e. whole numbers). Now this is useful because if you had been sent a set of data for sex and the `tbl_summary` function told you that there were 4 unique values, some of which were not integers, you would want to check the data further before doing any analysis.

Since 0 = man and 1 = woman (you can use `str(lesson1a$sex)` to confirm), this means that there were 181 men in the 386 patients and that they constituted 47% of the population.

#### `skim` function

The `skim` function (from the `skimr`) package gives basic summary data.


```r
skim(lesson1a$age)
```

```
## 
## Skim summary statistics
## 
## -- Variable type:numeric ---------------------------------------------------------------
##      variable missing complete   n  mean    sd p0 p25 p50 p75 p100
##  lesson1a$age       0      386 386 49.48 13.75 19  40  49  59   86
##      hist
##  ▂▅▇▇▆▅▂▁
```

So of the 386 patients, the mean age (a type of average, I’ll explain next week), 49.484456, the standard deviation (again, I’ll explain next week) is 13.7546598. The youngest patient was 19 and the oldest is 86. 

This simple command gives us our first lesson about the dangers of statistical software: it gives the age to within a few minutes. So if you were reporting results for a journal, you would never say that mean age was 49.484456, you’d probably just say 49.

"p0" here represents the minimum age in the dataset - 19. "p100" represents the maximum age of 86. "p25", "p50" and "p75" are the centiles. We'll talk more about this later, but briefly, "p25 = 40" means that 25% of the patients were aged 40 and younger. The number by "p50" (i.e. 49) is the median.

#### `mutate` function

The `mutate` function is used to create new variables, or replace variable values.

The code below means "create a new variable called "a" and set it equal to 1 in all observations." The "<-" indicator means to then save out this new dataset including the "a" variable as "lesson1a".


```r
lesson1a <-
  lesson1a %>%
  mutate(a = 1)
```

Since we have already created the variable "a" above, the code below means "replace the variable "a" with the value of 2 in all observations."


```r
lesson1a <-
  lesson1a %>%
  mutate(a = 2)
```

You can also replace one variable with the value of another variable. The code below means "replace the variable "a" with whatever the value of "p1" is in each observation."


```r
lesson1a <-
  lesson1a %>%
  mutate(a = p1)
```

You can also calculate values inside a `mutate` statement. For example, you can create an average of the four variables "p1" - "p4".


```r
lesson1a <-
  lesson1a %>%
  mutate(a = p1 + p2 + p3 + p4 / 4)
```

#### `if_else` function

The `if_else` function can be used with the `mutate` function to assign values to a variable based on a specific condition.

The first argument in the `if_else` function is the "if" condition. The second argument is the value of the variable for observations that meet the "if" condition. The third argument is the value of the variable for observations that do not meet the "if" condition.

For example, here we are replacing the value of "a" with the value of "p1" (argument 2), but only in cases where "p1 > 4" (argument 1) is true. If "p1 > 4" is not true, we will keep the original value "a" (argument 3).


```r
lesson1a <-
  lesson1a %>%
  mutate(a = if_else(p1 > 4, p1, a))
```

In this case, we are only replacing for females. Note that when you use equals sign after an "if" you have to use two of them in a row to signify "is equal to" rather than "make equal to".


```r
lesson1a <-
  lesson1a %>%
  mutate(a = if_else(sex == 1, p1, a))
```

The `|` sign means "or", such that the code below means "set "a" equal to 1 if "y" is equal to either "campus" or "peds". Otherwise, keep the original value of "a"."


```r
lesson1a <-
  lesson1a %>%
  mutate(a = if_else(y == "campus" | y == "peds", 1, a))
```

This code creates a subgroup of older women: "a" is 1 for older women and 0 for everybody else.


```r
lesson1a <-
  lesson1a %>%
  mutate(a = if_else(sex == 1 & age > 50, 1, 0))
```

### Using Help

<!-- TODO: Discuss with Andrew re: taking this section out -->

There is a good help feature where you can learn more about functions (though not about statistics...). You can access the help files by typing `?packagename::functionname` or `?functionname` into the console, for example `?mutate`. However, BE CAREFUL. It is very easy to get lost in the multitude of different functions. I strongly suggest you don't start using the help function until the end of the course. There is absolutely no reason to use help during the course because there will be examples including all commands you need.

## Assignments

The data for you to look at are in the attached file lesson1a.rds.

This is data for 386 patients undergoing surgery. What type of data (e.g. continuous, binary, ordinal, nonsense) are each of the variables?
