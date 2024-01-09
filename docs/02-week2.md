---
output: html_document
editor_options: 
  chunk_output_type: console
---


# Week 2

## Setting Up


```r
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
```

## R Instructions

### Looking at your data

There are several ways to see the variables in your dataset.

Click on the blue circle with an arrow next to the name of your dataset in the "environment" tab (top right). You will see the number of observations and the number of variables in your dataset next to the name of your dataset.

Underneath, you can see the variable name, the variable type, the values from the first several observations, and variable labels (if they exist). In some datasets, variables are labeled with information on what data is stored in the variable and/or what the variable values mean.

For example, look below at the variable "sex" under **lesson1a**. To the right of the variable name, it shows that this is a numeric variable ("num") and displays the first ten values. What we would expect to find in the "sex" variable is self-explanatory, based on the variable name. However, we don't know how to interpret the values. Luckily, this information is included in the variable label on the following line.

Other variables have names that are not self-explanatory, for example, "p1". This variable has a label that indicates that this is "pain at time 1 postop". You will also notice that sometimes there are variables that are not labeled. In this dataset, "age" does not have a label - the variable name is self-explanatory, and by looking at the values we can see that this is age in years.

![ ](images\environment_window_data.jpg)

If you would like to print out this information in the console window, you can also use the `str` function:


```r
# Shows a list of variables and labels
str(lesson1a)
```

```
## tibble [386 × 11] (S3: tbl_df/tbl/data.frame)
##  $ id : num [1:386] 541836 285383 332777 566828 193254 ...
##  $ sex: num [1:386] 0 1 0 1 1 1 0 0 1 0 ...
##   ..- attr(*, "label")= chr "1 if woman, 0 if man"
##  $ age: num [1:386] 33 55 52 53 57 31 54 26 52 66 ...
##  $ p1 : num [1:386] 0 0 0 0 0 0 0 0 0 0 ...
##   ..- attr(*, "label")= chr "pain at time 1 postop"
##  $ p2 : num [1:386] 0 1 0 0 1 0 1 0 0 1 ...
##   ..- attr(*, "label")= chr "pain at time 2 postop"
##  $ p3 : num [1:386] 0 1 3 0 2 2 4 1 0 1 ...
##   ..- attr(*, "label")= chr "pain at time 3 postop"
##  $ p4 : num [1:386] 0 1 3 1 3 2 1 0 0 1 ...
##   ..- attr(*, "label")= chr "pain at time 4 postop"
##  $ t  : num [1:386] 0 3 6 1 6 4 6 1 0 3 ...
##   ..- attr(*, "label")= chr "total pain score times 1 - 4"
##  $ x  : num [1:386] 2 2 1 2 2 1 1 1 2 1 ...
##  $ y  : chr [1:386] "campus" "campus" "campus" "campus" ...
##  $ z  : num [1:386] 1 1 NA NA 1 3 1 1 3 1 ...
```

The "environment" tab and the `str` function are useful for getting an overview of the variables available in your dataset, they are not as useful for getting an overview of the data values available.

The commands you might think about using for the datasets sent after lecture 2 are given below. I give examples from `lesson1a.rds`, the data I sent after lecture 1.

### Summarizing continuous variables

The function `skim` will give summary statistics for specified variables.


```r
# Summary of "age" variable from "lesson1a" dataset
lesson1a %>% skim(age)
```


Table: (\#tab:section2b)Data summary

|                         |           |
|:------------------------|:----------|
|Name                     |Piped data |
|Number of rows           |386        |
|Number of columns        |11         |
|_______________________  |           |
|Column type frequency:   |           |
|numeric                  |1          |
|________________________ |           |
|Group variables          |None       |


**Variable type: numeric**

|skim_variable | n_missing| complete_rate|  mean|    sd| p0| p25| p50| p75| p100|hist  |
|:-------------|---------:|-------------:|-----:|-----:|--:|---:|---:|---:|----:|:-----|
|age           |         0|             1| 49.48| 13.75| 19|  40|  49|  59|   86|▃▇▇▅▁ |

So you can tell you have data on age for 386 patients ("number of rows" is the number of observations and "n_missing" = 0 indicates no missing values for age), the mean age was about 49 years, and the standard deviation of the mean was about 13.8.

The numbers below "p0", "p25", "p50", "p75" and "p100" are the centiles. "p0" indicates the minimum value, and "p100" indicates the maximum value, so you can tell that the youngest patient was 19 and the oldest was 86. "p50" is the median (49 years), and the interquartile range is reported under "p25" and "p75" (40, 59).


```r
# Summary of "age" within men and women separately
lesson1a %>%
  group_by(sex) %>%
  skim(age)
```


Table: (\#tab:section2c)Data summary

|                         |           |
|:------------------------|:----------|
|Name                     |Piped data |
|Number of rows           |386        |
|Number of columns        |11         |
|_______________________  |           |
|Column type frequency:   |           |
|numeric                  |1          |
|________________________ |           |
|Group variables          |sex        |


**Variable type: numeric**

|skim_variable | sex| n_missing| complete_rate|  mean|    sd| p0| p25| p50| p75| p100|hist  |
|:-------------|---:|---------:|-------------:|-----:|-----:|--:|---:|---:|---:|----:|:-----|
|age           |   0|         0|             1| 49.07| 13.61| 19|  40|  49|  58|   82|▂▇▇▅▂ |
|age           |   1|         0|             1| 49.85| 13.90| 21|  40|  49|  60|   86|▃▇▇▅▁ |

The `group_by` function allows you to group your data and perform analyses separately by group. For example, the above code groups by sex, so the mean, standard deviation and other summary statistics are presented separately among men and among women.

### Centiles

You can get R to give you centiles directly by using the `quantile` function. The option `na.rm = TRUE` tells R to ignore any missing (NA) values when calculating the centiles.


```r
# Get centiles for "age" variable
quantile(lesson1a$age, na.rm = TRUE)
```

```
##   0%  25%  50%  75% 100% 
##   19   40   49   59   86
```

The first row of the results says that you are looking at the 0, 25, 50, 75, and 100 centiles, i.e. the minimum and maximum, and the median and quartiles. The second row gives you the actual values. So you could report this as “Median age was 49 (quartiles 40, 59)."

You aren't restricted to quartiles with the `quantile` function. For example, you can use the code below to give you the 11th, 45th and 78th centile, as well as 91.5 centile, which would be the 915th highest value in a dataset of 1000 observations. 


```r
# Get specific centiles (11th, 45th, 78th, 91.5th) for "age" variable
quantile(lesson1a$age, probs = c(0.11, 0.45, 0.78, 0.915), na.rm = TRUE)
```

```
##   11%   45%   78% 91.5% 
##  32.0  47.0  60.3  69.0
```

### One-way tables

As mentioned in the first lesson, the `tbl_summary` function (from the {gtsummary} package) can be used to create a frequency table, in this case, the number of men and women.


```r
# Get formatted one-way frequency table
tbl_summary(
  lesson1a %>% select(sex), # Specify data to use and variables to include
  type = list(sex = "categorical") # Show all levels of binary variables
)
```

```{=html}
<div id="iwrgxmosvm" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#iwrgxmosvm table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#iwrgxmosvm thead, #iwrgxmosvm tbody, #iwrgxmosvm tfoot, #iwrgxmosvm tr, #iwrgxmosvm td, #iwrgxmosvm th {
  border-style: none;
}

#iwrgxmosvm p {
  margin: 0;
  padding: 0;
}

#iwrgxmosvm .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#iwrgxmosvm .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#iwrgxmosvm .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#iwrgxmosvm .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#iwrgxmosvm .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#iwrgxmosvm .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#iwrgxmosvm .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#iwrgxmosvm .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#iwrgxmosvm .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#iwrgxmosvm .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#iwrgxmosvm .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#iwrgxmosvm .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#iwrgxmosvm .gt_spanner_row {
  border-bottom-style: hidden;
}

#iwrgxmosvm .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#iwrgxmosvm .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#iwrgxmosvm .gt_from_md > :first-child {
  margin-top: 0;
}

#iwrgxmosvm .gt_from_md > :last-child {
  margin-bottom: 0;
}

#iwrgxmosvm .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#iwrgxmosvm .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#iwrgxmosvm .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#iwrgxmosvm .gt_row_group_first td {
  border-top-width: 2px;
}

#iwrgxmosvm .gt_row_group_first th {
  border-top-width: 2px;
}

#iwrgxmosvm .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#iwrgxmosvm .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#iwrgxmosvm .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#iwrgxmosvm .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#iwrgxmosvm .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#iwrgxmosvm .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#iwrgxmosvm .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#iwrgxmosvm .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#iwrgxmosvm .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#iwrgxmosvm .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#iwrgxmosvm .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#iwrgxmosvm .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#iwrgxmosvm .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#iwrgxmosvm .gt_left {
  text-align: left;
}

#iwrgxmosvm .gt_center {
  text-align: center;
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

#iwrgxmosvm .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#iwrgxmosvm .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#iwrgxmosvm .gt_indent_1 {
  text-indent: 5px;
}

#iwrgxmosvm .gt_indent_2 {
  text-indent: 10px;
}

#iwrgxmosvm .gt_indent_3 {
  text-indent: 15px;
}

#iwrgxmosvm .gt_indent_4 {
  text-indent: 20px;
}

#iwrgxmosvm .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;Characteristic&lt;/strong&gt;"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;N = 386&lt;/strong&gt;&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>N = 386</strong><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">1 if woman, 0 if man</td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_0" class="gt_row gt_center">181 (47%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_0" class="gt_row gt_center">205 (53%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="2"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span> n (%)</td>
    </tr>
  </tfoot>
</table>
</div>
```



<br>

So there are 205 (53%) women and 181 (47%) men.

### Two-way tables

The `tbl_summary` function can also give a two-way table, for example, a table that shows where operations were done (remember that the variable "y" gives the part of the hospital) in men and women separately. In the last lesson, a 2-by-2 table was created, but `tbl_summary` can also create a two-way table with more than 2 rows or more than 2 columns.


```r
# Create a formatted two-way summary table
tbl_summary(
  lesson1a %>% select(sex, y), # Select both variables
  by = y, # The "by" option specifies which will be the column variable
  type = list(sex = "categorical")
)
```

```{=html}
<div id="epqsnuprvj" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#epqsnuprvj table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#epqsnuprvj thead, #epqsnuprvj tbody, #epqsnuprvj tfoot, #epqsnuprvj tr, #epqsnuprvj td, #epqsnuprvj th {
  border-style: none;
}

#epqsnuprvj p {
  margin: 0;
  padding: 0;
}

#epqsnuprvj .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#epqsnuprvj .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#epqsnuprvj .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#epqsnuprvj .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#epqsnuprvj .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#epqsnuprvj .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#epqsnuprvj .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#epqsnuprvj .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#epqsnuprvj .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#epqsnuprvj .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#epqsnuprvj .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#epqsnuprvj .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#epqsnuprvj .gt_spanner_row {
  border-bottom-style: hidden;
}

#epqsnuprvj .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#epqsnuprvj .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#epqsnuprvj .gt_from_md > :first-child {
  margin-top: 0;
}

#epqsnuprvj .gt_from_md > :last-child {
  margin-bottom: 0;
}

#epqsnuprvj .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#epqsnuprvj .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#epqsnuprvj .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#epqsnuprvj .gt_row_group_first td {
  border-top-width: 2px;
}

#epqsnuprvj .gt_row_group_first th {
  border-top-width: 2px;
}

#epqsnuprvj .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#epqsnuprvj .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#epqsnuprvj .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#epqsnuprvj .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#epqsnuprvj .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#epqsnuprvj .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#epqsnuprvj .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#epqsnuprvj .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#epqsnuprvj .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#epqsnuprvj .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#epqsnuprvj .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#epqsnuprvj .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#epqsnuprvj .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#epqsnuprvj .gt_left {
  text-align: left;
}

#epqsnuprvj .gt_center {
  text-align: center;
}

#epqsnuprvj .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#epqsnuprvj .gt_font_normal {
  font-weight: normal;
}

#epqsnuprvj .gt_font_bold {
  font-weight: bold;
}

#epqsnuprvj .gt_font_italic {
  font-style: italic;
}

#epqsnuprvj .gt_super {
  font-size: 65%;
}

#epqsnuprvj .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#epqsnuprvj .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#epqsnuprvj .gt_indent_1 {
  text-indent: 5px;
}

#epqsnuprvj .gt_indent_2 {
  text-indent: 10px;
}

#epqsnuprvj .gt_indent_3 {
  text-indent: 15px;
}

#epqsnuprvj .gt_indent_4 {
  text-indent: 20px;
}

#epqsnuprvj .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;Characteristic&lt;/strong&gt;"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;campus&lt;/strong&gt;, N = 240&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>campus</strong>, N = 240<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;harding&lt;/strong&gt;, N = 39&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>harding</strong>, N = 39<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;peds&lt;/strong&gt;, N = 40&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>peds</strong>, N = 40<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;satellite&lt;/strong&gt;, N = 67&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>satellite</strong>, N = 67<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">1 if woman, 0 if man</td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="stat_3" class="gt_row gt_center"><br /></td>
<td headers="stat_4" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_1" class="gt_row gt_center">115 (48%)</td>
<td headers="stat_2" class="gt_row gt_center">15 (38%)</td>
<td headers="stat_3" class="gt_row gt_center">19 (48%)</td>
<td headers="stat_4" class="gt_row gt_center">32 (48%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_1" class="gt_row gt_center">125 (52%)</td>
<td headers="stat_2" class="gt_row gt_center">24 (62%)</td>
<td headers="stat_3" class="gt_row gt_center">21 (53%)</td>
<td headers="stat_4" class="gt_row gt_center">35 (52%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span> n (%)</td>
    </tr>
  </tfoot>
</table>
</div>
```

<br>

This shows that, for example, there were 240 operations done at the main campus, 115 of these were done on men and 125 on women. This shows that 48% of the operations at the satellite were on men and 52% on women.

You can use the `add_overall` function to add a column which shows the total across all sites. This is not generally advised - for instance, if the median age in the drug group is 65 and in the placebo group is 67, you don't need to be told that the median age in the cohort is somewhere near 66 - but there are sometimes reasons to report on the whole cohort as well.


```r
# Create a formatted two-way summary table and add column for all patients
tbl_summary(
  lesson1a %>% select(sex, y),
  by = y,
  type = list(sex = "categorical")
) %>%
  # Add a column with totals across all locations
  # "last = TRUE" puts the column on the right side of the table
  add_overall(last = TRUE)
```

```{=html}
<div id="mkgngwavns" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#mkgngwavns table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#mkgngwavns thead, #mkgngwavns tbody, #mkgngwavns tfoot, #mkgngwavns tr, #mkgngwavns td, #mkgngwavns th {
  border-style: none;
}

#mkgngwavns p {
  margin: 0;
  padding: 0;
}

#mkgngwavns .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#mkgngwavns .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#mkgngwavns .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#mkgngwavns .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#mkgngwavns .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#mkgngwavns .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mkgngwavns .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#mkgngwavns .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#mkgngwavns .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#mkgngwavns .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#mkgngwavns .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#mkgngwavns .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#mkgngwavns .gt_spanner_row {
  border-bottom-style: hidden;
}

#mkgngwavns .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#mkgngwavns .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#mkgngwavns .gt_from_md > :first-child {
  margin-top: 0;
}

#mkgngwavns .gt_from_md > :last-child {
  margin-bottom: 0;
}

#mkgngwavns .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#mkgngwavns .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#mkgngwavns .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#mkgngwavns .gt_row_group_first td {
  border-top-width: 2px;
}

#mkgngwavns .gt_row_group_first th {
  border-top-width: 2px;
}

#mkgngwavns .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mkgngwavns .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#mkgngwavns .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#mkgngwavns .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mkgngwavns .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mkgngwavns .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#mkgngwavns .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#mkgngwavns .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#mkgngwavns .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mkgngwavns .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#mkgngwavns .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#mkgngwavns .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#mkgngwavns .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#mkgngwavns .gt_left {
  text-align: left;
}

#mkgngwavns .gt_center {
  text-align: center;
}

#mkgngwavns .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#mkgngwavns .gt_font_normal {
  font-weight: normal;
}

#mkgngwavns .gt_font_bold {
  font-weight: bold;
}

#mkgngwavns .gt_font_italic {
  font-style: italic;
}

#mkgngwavns .gt_super {
  font-size: 65%;
}

#mkgngwavns .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#mkgngwavns .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#mkgngwavns .gt_indent_1 {
  text-indent: 5px;
}

#mkgngwavns .gt_indent_2 {
  text-indent: 10px;
}

#mkgngwavns .gt_indent_3 {
  text-indent: 15px;
}

#mkgngwavns .gt_indent_4 {
  text-indent: 20px;
}

#mkgngwavns .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;Characteristic&lt;/strong&gt;"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;campus&lt;/strong&gt;, N = 240&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>campus</strong>, N = 240<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;harding&lt;/strong&gt;, N = 39&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>harding</strong>, N = 39<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;peds&lt;/strong&gt;, N = 40&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>peds</strong>, N = 40<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;satellite&lt;/strong&gt;, N = 67&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>satellite</strong>, N = 67<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;Overall&lt;/strong&gt;, N = 386&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>Overall</strong>, N = 386<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">1 if woman, 0 if man</td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="stat_3" class="gt_row gt_center"><br /></td>
<td headers="stat_4" class="gt_row gt_center"><br /></td>
<td headers="stat_0" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_1" class="gt_row gt_center">115 (48%)</td>
<td headers="stat_2" class="gt_row gt_center">15 (38%)</td>
<td headers="stat_3" class="gt_row gt_center">19 (48%)</td>
<td headers="stat_4" class="gt_row gt_center">32 (48%)</td>
<td headers="stat_0" class="gt_row gt_center">181 (47%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_1" class="gt_row gt_center">125 (52%)</td>
<td headers="stat_2" class="gt_row gt_center">24 (62%)</td>
<td headers="stat_3" class="gt_row gt_center">21 (53%)</td>
<td headers="stat_4" class="gt_row gt_center">35 (52%)</td>
<td headers="stat_0" class="gt_row gt_center">205 (53%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span> n (%)</td>
    </tr>
  </tfoot>
</table>
</div>
```

<br>

Overall, 47% of the patients treated in the hospital were men and 53% were women.

By default `tbl_summary` gives column percents (here, the percentage of patients who are men and women at each site). You can also get the row percents (for example, the percentage of women treated at each site) using the `percent` option and specifying "row".


```r
# The two-way summary table can give you row percent instead of column percent
tbl_summary(
  lesson1a %>% select(sex, y),
  by = y,
  type = list(sex = "categorical"),
  percent = "row" # get the row percent instead of column percent
)
```

```{=html}
<div id="bixqbsxufc" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#bixqbsxufc table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#bixqbsxufc thead, #bixqbsxufc tbody, #bixqbsxufc tfoot, #bixqbsxufc tr, #bixqbsxufc td, #bixqbsxufc th {
  border-style: none;
}

#bixqbsxufc p {
  margin: 0;
  padding: 0;
}

#bixqbsxufc .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#bixqbsxufc .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#bixqbsxufc .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#bixqbsxufc .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#bixqbsxufc .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#bixqbsxufc .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bixqbsxufc .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#bixqbsxufc .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#bixqbsxufc .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#bixqbsxufc .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#bixqbsxufc .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#bixqbsxufc .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#bixqbsxufc .gt_spanner_row {
  border-bottom-style: hidden;
}

#bixqbsxufc .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#bixqbsxufc .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#bixqbsxufc .gt_from_md > :first-child {
  margin-top: 0;
}

#bixqbsxufc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#bixqbsxufc .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#bixqbsxufc .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#bixqbsxufc .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#bixqbsxufc .gt_row_group_first td {
  border-top-width: 2px;
}

#bixqbsxufc .gt_row_group_first th {
  border-top-width: 2px;
}

#bixqbsxufc .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bixqbsxufc .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#bixqbsxufc .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#bixqbsxufc .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bixqbsxufc .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bixqbsxufc .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#bixqbsxufc .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#bixqbsxufc .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#bixqbsxufc .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bixqbsxufc .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#bixqbsxufc .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#bixqbsxufc .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#bixqbsxufc .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#bixqbsxufc .gt_left {
  text-align: left;
}

#bixqbsxufc .gt_center {
  text-align: center;
}

#bixqbsxufc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#bixqbsxufc .gt_font_normal {
  font-weight: normal;
}

#bixqbsxufc .gt_font_bold {
  font-weight: bold;
}

#bixqbsxufc .gt_font_italic {
  font-style: italic;
}

#bixqbsxufc .gt_super {
  font-size: 65%;
}

#bixqbsxufc .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#bixqbsxufc .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#bixqbsxufc .gt_indent_1 {
  text-indent: 5px;
}

#bixqbsxufc .gt_indent_2 {
  text-indent: 10px;
}

#bixqbsxufc .gt_indent_3 {
  text-indent: 15px;
}

#bixqbsxufc .gt_indent_4 {
  text-indent: 20px;
}

#bixqbsxufc .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;Characteristic&lt;/strong&gt;"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;campus&lt;/strong&gt;, N = 240&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>campus</strong>, N = 240<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;harding&lt;/strong&gt;, N = 39&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>harding</strong>, N = 39<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;peds&lt;/strong&gt;, N = 40&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>peds</strong>, N = 40<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;satellite&lt;/strong&gt;, N = 67&lt;span class=&quot;gt_footnote_marks&quot; style=&quot;white-space:nowrap;font-style:italic;font-weight:normal;&quot;&gt;&lt;sup&gt;1&lt;/sup&gt;&lt;/span&gt;"><strong>satellite</strong>, N = 67<span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">1 if woman, 0 if man</td>
<td headers="stat_1" class="gt_row gt_center"><br /></td>
<td headers="stat_2" class="gt_row gt_center"><br /></td>
<td headers="stat_3" class="gt_row gt_center"><br /></td>
<td headers="stat_4" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    0</td>
<td headers="stat_1" class="gt_row gt_center">115 (64%)</td>
<td headers="stat_2" class="gt_row gt_center">15 (8.3%)</td>
<td headers="stat_3" class="gt_row gt_center">19 (10%)</td>
<td headers="stat_4" class="gt_row gt_center">32 (18%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    1</td>
<td headers="stat_1" class="gt_row gt_center">125 (61%)</td>
<td headers="stat_2" class="gt_row gt_center">24 (12%)</td>
<td headers="stat_3" class="gt_row gt_center">21 (10%)</td>
<td headers="stat_4" class="gt_row gt_center">35 (17%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="5"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;"><sup>1</sup></span> n (%)</td>
    </tr>
  </tfoot>
</table>
</div>
```

<br>

This shows that, for example, 8.3% of men and 12% of women had operations at the "Harding" site.

### Subsetting Data

Sometimes, you will want to subset your data - for instance, by keeping only the women from the full dataset. This can be done using the `filter` function. The `filter` function takes a condition, similar to an `if_else` statement. However, `filter` only keeps observations in the data that meet that condition.

To start, we will count the number of observations in the full dataset, so we will be able to confirm whether we have subset correctly. Passing a dataset to the `count` function will count the number of total observations.


```r
# Count all patients in the dataset
lesson1a %>% count()
```

```
## # A tibble: 1 × 1
##       n
##   <int>
## 1   386
```

In this example, we can use `filter` to count the number of women in the dataset, or the number of operations on women at the main campus. Don't forget that you need to use two equals signs here.


```r
# Count the number of women
lesson1a %>%
  filter(sex == 1) %>%
  count()
```

```
## # A tibble: 1 × 1
##       n
##   <int>
## 1   205
```

```r
# Count the number of women treated at the main campus
lesson1a %>%
  filter(sex == 1 & y == "campus") %>%
  count()
```

```
## # A tibble: 1 × 1
##       n
##   <int>
## 1   125
```

Note that because we did not use the assignment operator (`<-`) to save these datasets, we did not alter our original dataset. You can use the `count` function to confirm that **lesson1a** still contains all observations.

### Graphing

We won’t be doing much on the graphical presentation of data in this course (this has been called "graphicacy"). The only reason we are doing it here is to get a visual impression of whether data are normally presented (not something you’d want to publish).

The following might sound a little complicated, but just follow it through and everything will be fine.

First, run the following code.


```r
# This code creates a histogram of the "age" variable
ggplot(data = lesson1a,
       aes(x = age)) +
  geom_histogram()
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

<img src="02-week2_files/figure-html/section2m-1.png" width="672" />

`ggplot` indicates that you want to create a graph. The dataset **lesson1a** is specified in the `data` option, and `aes(x = age)` means that the variable on the x-axis should be age. `geom_histogram` takes this data and graphs it as a histogram.

One of the things that R does is to choose the number of bars for you. Notice how the graph looks "lumpy". The output also displays a message that tells you that the default number of bars (also called "bins") is 30 and suggests to "pick a better value". This is because you are breaking the data up into too many small pieces.

You can pick the number of bars yourself by using the `bins` option. Try setting the number of bins to 20, which will break the data into fewer pieces.


```r
# Here is the same histogram, setting the number of bins to 20
ggplot(data = lesson1a,
       aes(x = age)) +
  geom_histogram(bins = 20)
```

<img src="02-week2_files/figure-html/section2n-1.png" width="672" />

The following code will superimpose a curve for the normal distribution.


```r
# Here is the histogram with 20 bins and density curve overlay
ggplot(data = lesson1a,
       aes(x = age)) +
  geom_histogram(aes(y = after_stat(density)), bins = 20) +
  geom_density()
```

<img src="02-week2_files/figure-html/section2o-1.png" width="672" />

### Further Reading

Only read this if you are feeling really keen...


```r
# The "ci" function is from the "gmodels" package
# This gives the mean of age and 90% confidence interval
ci(lesson1a$age, confidence = 0.90, na.rm = TRUE)
```

```
##   Estimate   CI lower   CI upper Std. Error 
## 49.4844560 48.3301266 50.6387853  0.7000938
```

This gives the mean of age, its standard error and its 90% confidence interval (I’ll explain confidence intervals next week: one thing you might want to think about is to compare the two numbers given for the confidence interval with the 5% and 95% centile using `quantile(lesson1a$age, na.rm = TRUE)`).


```r
# The "ci.binom" function gives the same information as "ci" but is used for binary variables
ci.binom(lesson1a$sex, na.rm = TRUE)
```

```
##       Estimate  CI lower  CI upper Std. Error
## [1,] 0.5310881 0.4799345 0.5817614 0.02540009
```

For a binary variable, the function `ci.binom` from the {gmodels} package is used. This gives the proportion of women along with 95% confidence intervals (95% is the default, meaning if you don’t specify a level, it assumes you want the 95% confidence interval.)

### Using R as a calculator

R can be used as a calculator:


```r
# Multiplication
7*7
```

```
## [1] 49
```

`log()` is the natural logarithm (to base e)


```r
# Natural logarithm
log(2.71828)
```

```
## [1] 0.9999993
```

`exp()` is the inverse natural logarithm, that is, if exp(x)=y, e^y^=x


```r
# Inverse natural logarithm
exp(1)
```

```
## [1] 2.718282
```

`log10()` gives the log to base 10


```r
# Base 10 logarithm
log10(100)
```

```
## [1] 2
```

`cos(45)` gives the cosine of 45


```r
# Cosine
cos(45)
```

```
## [1] 0.525322
```

Some of the functions give useful statistical constants.

`pnorm(x)` gives the probability that an observation will be less than mean + x standard deviations.


```r
# Probability that an observation will be less than mean + 1 standard deviations
pnorm(1)
```

```
## [1] 0.8413447
```

```r
# Probability that an observation will be less than mean - 0.5 standard deviations
pnorm(-0.5)
```

```
## [1] 0.3085375
```

`pnorm(1)` gives 0.84 - this means that 84% of a normally distributed set of data will be less than one standard deviation above the mean.

`pnorm(-0.5)` gives 0.31, meaning that 31% of a normally distributed set of data will be less than half a standard deviation below the mean.

Therefore, if you had a data set where the pain score had a mean of 5 and a standard deviation of 2, you could predict that only 16% of patients would have pain scores of 7 or more (i.e. more than one standard deviation higher than the mean) and that 69% would have pain scores of 4 or more (i.e. more than half a standard deviation below the mean: 31% of observations are half a standard deviation or more less than the mean).


```r
# Probability that an observation will be less than mean + 1.96
pnorm(1.96)
```

```
## [1] 0.9750021
```

```r
# Probability that an observation will be less than mean - 1.96
pnorm(-1.96)
```

```
## [1] 0.0249979
```

`pnorm(1.96)` gives 0.975 and `pnorm(-1.96)` gives 0.025. So 97.5% of observations are less than 1.96 standard deviations greater than the mean, and 2.5% are less than 1.96 standard deviations lower than the mean. In other words, 95% of observations are within 1.96 standard deviations of the mean.

`pnorm(0.675)` gives 0.75 and `pnorm(-0.675)` gives 0.25, meaning that 50% of observations fall within approximately 2/3 of a standard deviation on either side of the mean.

Almost all observations fall within 3 standard deviations of the mean, as shown by `pnorm(3)` and `pnorm(-3)`, which give 0.9987 and 0.0013, respectively. This means that 99.7% of all observations fall into this range.

## Assignments


```r
# Copy and paste this code to load the data for week 2 assignments
lesson2a <- readRDS(here::here("Data", "Week 2", "lesson2a.rds"))
lesson2b <- readRDS(here::here("Data", "Week 2", "lesson2b.rds"))
lesson2c <- readRDS(here::here("Data", "Week 2", "lesson2c.rds"))
lesson2d <- readRDS(here::here("Data", "Week 2", "lesson2d.rds"))
lesson2e <- readRDS(here::here("Data", "Week 2", "lesson2e.rds"))
```

It seems like a lot of them, but the task shouldn’t take you very long. However, a general rule in this class is: you don't have to do all the questions in the assignment. Try to do at least some (say, at least 2a and 2b), so that you know what we are talking about next week in class. Also, the more you do the more you'll learn. However, don't drive yourself crazy trying to get them all done.

I am phrasing the questions in ordinary English, pretty much as you would do if you were an investigator. For example, I ask you to summarize the data on race time in marathon runners, rather than say: "provide the mean of the variable "rt" by typing `skim(lesson2a$rt)`". But this means you are going to have to work out what the various variable codes are and what commands to use.

All of these questions ask you to "summarize" data. In other words, how would you describe the data in a journal article (say, your table 1)? One quick clue here: I don't ever want the standard error, we'll talk more about that next week.

- **lesson2a**: This is data from marathon runners: summarize age, sex, race time in minutes (i.e. how long it took them to complete the race) and favorite running shoe.
- **lesson2b**: Postoperative pain (this is a similar dataset as you had before for the assignment for the first class). Summarize average pain after the operation.  Imagine you had to draw a graph of "time course of pain after surgery". What numbers would you use for pain at time 1, time 2, time 3 etc.?
- **lesson2c**: This is data on 241 patients undergoing radical prostatectomy. Summarize age, stage, grade and PSA.
- **lesson2d**: Cost of a minor medical procedure. Summarize cost.
- **lesson2e**: Total cancer pain in one month in a group with chronic cancer pain. Summarize pain scores and number of days with pain.



