

# Assignment Answers

## Week 1


```r
# Week 1: load packages
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

# Week 1: load data
lesson1a <- readRDS(here::here("Data", "Week 1", "lesson1a.rds"))
```

### lesson1a.rds

**This is data for 386 patients undergoing surgery. What type of data (e.g. continuous, binary, ordinal, nonsense) are each of the variables?**

The dataset has 11 variables:

- "id" is clearly a hospital record number. It doesn’t matter what type of variable it is, because you only want to know the type of variable in order to summarize or analyze data, and you’d never want to analyze or summarize patient id.
- "sex" is a binary variable
- "age" is continuous
- "p1", "p2", "p3", "p4" are the pain scores after surgery. They only take integer values between 0 and 6. They would therefore typically regarded as categorical, and because they are clearly ordered (i.e. pain score of 6 is higher than one of 4) these variables can be described are ordinal. However, many statisticians, myself included, would think it perfectly reasonable to treat these variables as continuous. 
- "t": total pain score takes on values between 0 and 24 and can thus be considered continuous
- "x", "y" and "z": should you attempt to summarize a variable if you don’t know what it is? It is obvious for y, this is some kind of hospital location, and is a categorical variable. But what about x and z? As it happens, z looks ordinal but isn’t: it is blood group coded 1=o, 2=a, 3=b, 4=ab.

## Week 2


```r
# Week 2: load packages
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

# Week 2: load data
lesson2a <- readRDS(here::here("Data", "Week 2", "lesson2a.rds"))
lesson2b <- readRDS(here::here("Data", "Week 2", "lesson2b.rds"))
lesson2c <- readRDS(here::here("Data", "Week 2", "lesson2c.rds"))
lesson2d <- readRDS(here::here("Data", "Week 2", "lesson2d.rds"))
lesson2e <- readRDS(here::here("Data", "Week 2", "lesson2e.rds"))
```

### lesson2a.rds

**This is data from marathon runners: summarize age, sex, race time in minutes (i.e. how long it took them to complete the race) and favorite running shoe.**

Age is continuous and normally distributed (look at a graph or look at the centiles) and so it wouldn’t be unreasonable to describe age in terms of mean and standard deviation (SD) by using `lesson2a %>% skim(age)`: mean (42 years), SD of 10.2. By the way, don’t just copy the readout from R: this would give mean age as 42.43 and implies we are interested in age within a few days. 

Sex is binary: use `tbl_summary(lesson2a %>% select(sex))` to get percentages. But note that the person who prepared the data didn’t state how the variable was coded (someone with sex=1 is a woman or a man?). Now what you should do in this situation is ask, but here is another alternative:


```r
# Summary statistics for race time, separately by sex
lesson2a %>%
  group_by(sex) %>%
  skim(rt)
```

```
## Skim summary statistics
##  n obs: 98 
##  n variables: 6 
##  group variables: sex 
## 
## -- Variable type:numeric --------------------------------------------------------------------------
##  sex variable missing complete  n   mean    sd  p0    p25   p50    p75
##    0       rt       0       66 66 243.23 49.85 158 214.25 236   268.75
##    1       rt       0       32 32 264.84 37.45 222 237    251.5 283.25
##  p100     hist
##   414 ▅▇▇▆▃▂▁▁
##   362 ▇▅▅▂▁▂▂▁
```

So sex==0 are running faster than the sex==1 and it would not be unreasonable to assume that sex==1 means women. 

Race time is continuous and looks pretty normal. Yes the data are skewed by a single outlier (a race time of 414 minutes) but the mean and median are pretty similar (250 v. 242 minutes) and the 5th and 95th centile are very close to the values expected by adding or subtracting 1.64 times the SD from the mean (5th centile is 176, expected value using means and SD is 173; 95th centile actual and expected values are 328 and 328). I would probably feel comfortable reporting a mean and SD if you wanted.

Favorite running shoe: `lesson2a %>% skim(shoe)` gives a mean of 3.08 and a median of 3. If you reported these, you need therapy: shoe is a categorical variable and you should report the percentage of runners that favor each shoe.

AN ADDITIONAL IMPORTANT POINT: you should give the number of observations and the number of missing observations. n is 98 for all observations except for favorite running shoe, where there are 95 observations and 3 missing observations.

So here is a model answer, suitable for publication (assuming that sex==1 is coded as female.)

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
  overflow-x: hidden;
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
  overflow-x: hidden;
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

#iwrgxmosvm .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="iwrgxmosvm" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>N = 98</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Age</td>
      <td class="gt_row gt_center">42 (10)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Women</td>
      <td class="gt_row gt_center gt_striped">32 (33%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Race time in minutes</td>
      <td class="gt_row gt_center">250 (47)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Favorite Running Shoe</td>
      <td class="gt_row gt_center gt_striped"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Asics</td>
      <td class="gt_row gt_center">14 (15%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">New Balance</td>
      <td class="gt_row gt_center gt_striped">7 (7.4%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Nike</td>
      <td class="gt_row gt_center">31 (33%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">Saucony</td>
      <td class="gt_row gt_center gt_striped">43 (45%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Unknown</td>
      <td class="gt_row gt_center">3</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="2">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: mean (SD); n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

However, look at this.

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
  overflow-x: hidden;
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
  overflow-x: hidden;
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

#hlleqxdave .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="hlleqxdave" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>N = 98</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Age</td>
      <td class="gt_row gt_center">43 (34, 48)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Women</td>
      <td class="gt_row gt_center gt_striped">32 (33%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Race time in minutes</td>
      <td class="gt_row gt_center">242 (222, 273)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Favorite Running Shoe</td>
      <td class="gt_row gt_center gt_striped"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Asics</td>
      <td class="gt_row gt_center">14 (15%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">New Balance</td>
      <td class="gt_row gt_center gt_striped">7 (7.4%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Nike</td>
      <td class="gt_row gt_center">31 (33%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">Saucony</td>
      <td class="gt_row gt_center gt_striped">43 (45%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Unknown</td>
      <td class="gt_row gt_center">3</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="2">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: median (IQR); n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

This really isn't much to distinguish between these tables. On the one hand using the mean and SD gives you more information (e.g. what proportion of patients are aged over 70?). On the other hand, I can't see anyone using a table 1 to do these types of calculation and the median and interquartile range give you some more immediately usable information (no multiplying by 1.64!).

### lesson2b.rds

**Summarize average pain after the operation. Imagine you had to draw a graph of "time course of pain after surgery". What numbers would you use for pain at time 1, time 2, time 3, etc.?**

This is data on postoperative pain. You were asked to summarize average pain after the operation. This is continuous, so by looking at the histogram, you can see that the data look skewed. I would be tempted to use the median (1.8) and quartiles (1.1, 2.6).


```r
# Create histogram to assess whether data look skewed
ggplot(data = lesson2b,
       aes(x = t)) +
  geom_histogram()
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

<img src="09-answers_files/figure-html/week2d-1.png" width="672" />

However, using the mean and standard deviation doesn’t get you far off. For normal data, 50% of the observations are within two-thirds of a standard deviations of the mean. So the interquartile range predicted from the mean and SD would be 1.9 - 1.1\*0.67 and 1.9 + 1.1\*0.67 which gives you 1.2 and 2.7. This is an interesting point: the data can look skewed (and if you are interested, a statistical test can tell you that the data are definitely non-normal) but it doesn’t make much of a difference in practice. 

You were then asked to imagine that you had to draw a graph of "time course of pain after surgery". What numbers would you use for time 1, time 2 etc? The first thing to note is that to draw the graph, which seems like a useful thing to do, you have to treat the data as continuous: you can’t really graph a table very easily. This is another illustration of how something that seems technically incorrect gives you useful approximations. Now that we have continuous data we have to decide whether to use medians or means. As it turns out, normality of the data isn’t even an issue. Here is what happens if you graph the median pain score at each time point.

<img src="09-answers_files/figure-html/week2e-1.png" width="672" />

This makes it seem that postoperative pain doesn’t change for four time points, then drops dramatically. 

A graph using means seems more illustrative of what is really going on.

<img src="09-answers_files/figure-html/week2f-1.png" width="672" />

### lesson2c.rds

**This is data on 242 patients undergoing radical prostatectomy. Summarize age, stage, grade and PSA.**

One of the first things to look for here is missing data. If you type `lesson2c %>% skim()`, you’ll see that there is no missing data for age, 9 missing observations for PSA and 41 for grade. You will notice that the "stage" variable is not included here, because it is a character variable, not a numeric variable.

If you type `tbl_summary(lesson2c %>% select(stage))`, you'll see that all patients have a stage assigned (no "NA" values).

A second issue is how to characterize the categorical variables. There are 8 different stages represented, many with very small numbers (like 2 for T4 and T1B, 4 for T3). It generally isn’t very helpful to slice and dice data into very small categories, so I would consider grouping. For instance, we could group the T1s and T3 and 4 to get something like:

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#kqtxbhydst .gt_table {
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

#kqtxbhydst .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#kqtxbhydst .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#kqtxbhydst .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#kqtxbhydst .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#kqtxbhydst .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#kqtxbhydst .gt_col_heading {
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
  overflow-x: hidden;
}

#kqtxbhydst .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#kqtxbhydst .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#kqtxbhydst .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#kqtxbhydst .gt_group_heading {
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

#kqtxbhydst .gt_empty_group_heading {
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

#kqtxbhydst .gt_striped {
  background-color: #f2f2f2;
}

#kqtxbhydst .gt_from_md > :first-child {
  margin-top: 0;
}

#kqtxbhydst .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kqtxbhydst .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#kqtxbhydst .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#kqtxbhydst .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#kqtxbhydst .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#kqtxbhydst .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#kqtxbhydst .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#kqtxbhydst .gt_table_body {
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

#kqtxbhydst .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#kqtxbhydst .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#kqtxbhydst .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#kqtxbhydst .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#kqtxbhydst .gt_center {
  text-align: center;
}

#kqtxbhydst .gt_left {
  text-align: left;
}

#kqtxbhydst .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#kqtxbhydst .gt_font_normal {
  font-weight: normal;
}

#kqtxbhydst .gt_font_bold {
  font-weight: bold;
}

#kqtxbhydst .gt_font_italic {
  font-style: italic;
}

#kqtxbhydst .gt_super {
  font-size: 65%;
}

#kqtxbhydst .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="kqtxbhydst" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>N = 241</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Stage</td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">T1</td>
      <td class="gt_row gt_center gt_striped">169 (70%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">T2A</td>
      <td class="gt_row gt_center">36 (15%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">T2B</td>
      <td class="gt_row gt_center gt_striped">22 (9.1%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">T2C</td>
      <td class="gt_row gt_center">8 (3.3%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">T3/4</td>
      <td class="gt_row gt_center gt_striped">6 (2.5%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="2">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

To get the table, I created a new variable as follows:


```r
# Create new variable for stage and save into "lesson2c" dataset
lesson2c <-
  lesson2c %>%
  mutate(
    stage_category =
      case_when(
        stage %in% c("T1A", "T1B", "T1C") ~ "T1",
        stage %in% c("T3", "T4") ~ "T3/4",
        TRUE ~ stage
      )
  )
```

The `case_when` function is similar to the `if_else` function, but it allows for more than the 2 options of TRUE/FALSE. "TRUE" in the last line indicates all values that were not included in the prior categories.

There is a similar issue for grade, with few patients having grades 4, 5, 8 or 9. Now a key point is that what you decide to do in situations like this will often need to take into account your medical understanding. It might seems sensible to categorize grade as ≤6 or ≥7, or perhaps 4/5, 6, 7, 8/9. But as it turns out in prostate cancer, pathologists can’t reliably grade a cancer as 4 or 5 and these cancers should really be grouped with grade 6. Grade 8, on the other hand, signifies very aggressive disease and really needs to be reported separately even if there are only a few patients with grade 8. So grade would probably be summarized as per the following table:

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#qzjvxzfwte .gt_table {
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

#qzjvxzfwte .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#qzjvxzfwte .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#qzjvxzfwte .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#qzjvxzfwte .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#qzjvxzfwte .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#qzjvxzfwte .gt_col_heading {
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
  overflow-x: hidden;
}

#qzjvxzfwte .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#qzjvxzfwte .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#qzjvxzfwte .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#qzjvxzfwte .gt_group_heading {
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

#qzjvxzfwte .gt_empty_group_heading {
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

#qzjvxzfwte .gt_striped {
  background-color: #f2f2f2;
}

#qzjvxzfwte .gt_from_md > :first-child {
  margin-top: 0;
}

#qzjvxzfwte .gt_from_md > :last-child {
  margin-bottom: 0;
}

#qzjvxzfwte .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#qzjvxzfwte .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#qzjvxzfwte .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#qzjvxzfwte .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#qzjvxzfwte .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#qzjvxzfwte .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#qzjvxzfwte .gt_table_body {
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

#qzjvxzfwte .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#qzjvxzfwte .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#qzjvxzfwte .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#qzjvxzfwte .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#qzjvxzfwte .gt_center {
  text-align: center;
}

#qzjvxzfwte .gt_left {
  text-align: left;
}

#qzjvxzfwte .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#qzjvxzfwte .gt_font_normal {
  font-weight: normal;
}

#qzjvxzfwte .gt_font_bold {
  font-weight: bold;
}

#qzjvxzfwte .gt_font_italic {
  font-style: italic;
}

#qzjvxzfwte .gt_super {
  font-size: 65%;
}

#qzjvxzfwte .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="qzjvxzfwte" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>N = 241</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Stage</td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">T1</td>
      <td class="gt_row gt_center gt_striped">169 (70%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">T2A</td>
      <td class="gt_row gt_center">36 (15%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">T2B</td>
      <td class="gt_row gt_center gt_striped">22 (9.1%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">T2C</td>
      <td class="gt_row gt_center">8 (3.3%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">T3/4</td>
      <td class="gt_row gt_center gt_striped">6 (2.5%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Grade</td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">6</td>
      <td class="gt_row gt_center gt_striped">79 (40%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">7</td>
      <td class="gt_row gt_center">112 (56%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">8</td>
      <td class="gt_row gt_center gt_striped">9 (4.5%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Unknown</td>
      <td class="gt_row gt_center">41</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Age</td>
      <td class="gt_row gt_center gt_striped">60 (56, 65)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">PSA</td>
      <td class="gt_row gt_center">5.3 (4.0, 8.0)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">Unknown</td>
      <td class="gt_row gt_center gt_striped">9</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="2">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%); median (IQR)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

### lesson2d.rds

**Summarize cost.**

I asked you to summarize the cost. You can see from a graph that the data are not normally distributed. If we were to follow the rule book slavishly, we would report a median and interquartile range. But what use is a median for cost data? We want to know "average" cost so that we can predict, for example, how much we should budget for next year. This requires a mean.

### lesson2e.rds

**Summarize total cancer pain in one month in a group of chronic cancer patients.**

The data are grossly non-normal and you could use the median pain score with interquartile range. 

As for summarizing the number of days in pain, almost everyone has 31 days of pain. So I would give proportions of patients who had pain for 31 days and then the number who, say, had pain at least 3 out of every 4 days and 2 out of 4 days. There are two ways of doing this. You could use `tbl_summary(lesson2e %>% select(f), type = list("f" ~ "categorical"))` and then combine some of the results. Or, and this is a little more complicated, you could create a new variable.



```r
# Create variable to categorize number of days in pain
lesson2e <-
  lesson2e %>%
  mutate(
    days =
      case_when(
        f <= 15 ~ 0,
        f > 15 & f < 23 ~ 1,
        f > 23 & f < 31 ~ 2,
        f == 31 ~ 3
      )
  )
```

In other words, create a new variable called "days", and set it to 0 for anyone with 15 or less days of pain. Call anyone who has pain more than half the time (i.e. more than 15 days) a 1. Call anyone who has pain more than three quarter of the time (i.e. more than 23 days) a 2. Call anyone who has pain all the time a 3.


```r
# Print formatted table summarizing number of days in pain
tbl_summary(
  lesson2e %>% select(days)
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#pqsnuprvju .gt_table {
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

#pqsnuprvju .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#pqsnuprvju .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#pqsnuprvju .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#pqsnuprvju .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#pqsnuprvju .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#pqsnuprvju .gt_col_heading {
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
  overflow-x: hidden;
}

#pqsnuprvju .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#pqsnuprvju .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#pqsnuprvju .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#pqsnuprvju .gt_group_heading {
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

#pqsnuprvju .gt_empty_group_heading {
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

#pqsnuprvju .gt_striped {
  background-color: #f2f2f2;
}

#pqsnuprvju .gt_from_md > :first-child {
  margin-top: 0;
}

#pqsnuprvju .gt_from_md > :last-child {
  margin-bottom: 0;
}

#pqsnuprvju .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#pqsnuprvju .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#pqsnuprvju .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#pqsnuprvju .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#pqsnuprvju .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#pqsnuprvju .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#pqsnuprvju .gt_table_body {
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

#pqsnuprvju .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#pqsnuprvju .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#pqsnuprvju .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#pqsnuprvju .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#pqsnuprvju .gt_center {
  text-align: center;
}

#pqsnuprvju .gt_left {
  text-align: left;
}

#pqsnuprvju .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#pqsnuprvju .gt_font_normal {
  font-weight: normal;
}

#pqsnuprvju .gt_font_bold {
  font-weight: bold;
}

#pqsnuprvju .gt_font_italic {
  font-style: italic;
}

#pqsnuprvju .gt_super {
  font-size: 65%;
}

#pqsnuprvju .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="pqsnuprvju" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>N = 100</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">days</td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">16 (17%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">7 (7.4%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">2</td>
      <td class="gt_row gt_center gt_striped">23 (24%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">3</td>
      <td class="gt_row gt_center">48 (51%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">Unknown</td>
      <td class="gt_row gt_center gt_striped">6</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="2">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->



So you could report that, of the 94 patients with data on number of days with pain, 51% were in daily pain, 17% of patients had pain on less than half of days, 7.4% of patients had pain on more than half but less than 75% of days, 24% of patients had pain on more than 75% of days, but not every day.

_For keen students only!_

You could also try a log transformation of the pain scores. Create a new variable using `log(pain)`.


```r
# Create a variable for log of the pain score
lesson2e <-
  lesson2e %>%
  mutate(log = log(pain))
```

Analyze this variable and you’ll see it appears normally distributed.

The mean of log is 5.42. You can transform the log back by calculating e^5.42^ (the function is ``exp(5.42)``) to get 225, close to the median. Backtransforming the standard deviation is more complicated and can’t really be done directly. What you need to do is make any calculations you need on the log transformed scale and then backtransform the results. Imagine you wanted a 95% confidence interval. A 95% confidence interval is the mean ± 1.96 standard deviations. The standard deviation of the log data is close to one. So the confidence interval is 3.45 to 7.39. Transforming this ``exp(3.45)`` and ``exp(7.39)`` gives a confidence interval on the original scale of 31.44 and 1614.07. This is a reasonable approximation to the 5th (50) and 95th centile (1319).

## Week 3


```r
# Week 3: load packages
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

# Week 3: load data
lesson3a <- readRDS(here::here("Data", "Week 3", "lesson3a.rds"))
lesson3b <- readRDS(here::here("Data", "Week 3", "lesson3b.rds"))
lesson3c <- readRDS(here::here("Data", "Week 3", "lesson3c.rds"))
lesson3d <- readRDS(here::here("Data", "Week 3", "lesson3d.rds"))
lesson3e <- readRDS(here::here("Data", "Week 3", "lesson3e.rds"))
lesson3f <- readRDS(here::here("Data", "Week 3", "lesson3f.rds"))
```

### lesson3a.rds

**These are data from over 1000 patients undergoing chemotherapy reporting a nausea and vomiting score from 0 to 10.  Does previous chemotherapy increase nausea scores? What about sex?**



Hands up, who typed in `t.test(nv ~ pc, data = lesson3a, var.equal = TRUE)` without looking at the data? There are lots of missing data. There is a question as to whether you would actually analyze these data at all: could data be missing because patients were too ill to complete questionnaires?  Could there have been bias in ascertaining who had prior chemotherapy?  If you do decide to analyze, a t-test would be appropriate (`t.test(nv ~ pc, data = lesson3a, var.equal = TRUE)` and `t.test(nv ~ sex, data = lesson3a, var.equal = TRUE)`). A model answer might be:

<div class="quote-container">

> Details of prior chemotherapy were available for 512 of the 1098 patients with nausea scores. Mean nausea scores were approximately 20% higher in the 255 patients with prior experience of chemotherapy (5.3; SD 2.03) than in the 257 chemotherapy-naive patients  (4.5; SD 1.99). The difference between groups was small (0.8, 95% C.I. 0.5, 1.2 but highly statistically significant (p<0.001 by t-test), suggesting that prior chemotherapy increases nausea scores. Nausea scores were slightly lower in women (n=444; mean 4.7; SD 1.98) than men (n=434; mean 4.8; SD 2.1) but there were no statistically significant differences between the sexes (difference between means 0.1, 95% C.I. -0.2, 0.3); p=0.7 by t-test). However, far more women (131 / 575, 60%) than men (89 / 523, 40%) failed provide a nausea score (p=0.017 by chi squared), perhaps suggesting bias in reporting.

</div>

Now, I'll explain what I did. First, I did the two t-tests:


```r
# t-test for nausea/vomiting by prior chemotherapy
t.test(nv ~ pc, data = lesson3a, var.equal = TRUE)
```

```
## 
## 	Two Sample t-test
## 
## data:  nv by pc
## t = -4.6275, df = 510, p-value = 4.7e-06
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -1.1699123 -0.4725841
## sample estimates:
## mean in group 0 mean in group 1 
##        4.459144        5.280392
```

```r
# t-test for nausea/vomiting by sex
t.test(nv ~ sex, data = lesson3a, var.equal = TRUE)
```

```
## 
## 	Two Sample t-test
## 
## data:  nv by sex
## t = 0.43835, df = 876, p-value = 0.6612
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.2100764  0.3308988
## sample estimates:
## mean in group 0 mean in group 1 
##        4.782258        4.721847
```

Then I created a new variable for missing data on nausea and vomiting:


```r
# Create new variable to indicate whether "nv" variable is missing
lesson3a <-
  lesson3a %>%
  mutate(
    missing =
      if_else(is.na(nv), 1, 0)
  )
```

And then the table:


```r
# Formatted table to look at rates of missingness in "nv" variable by sex
tbl_summary(
  lesson3a %>% select(missing, sex),
  by = sex,
  type = list("missing" ~ "categorical")
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#opulaeyvxv .gt_table {
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

#opulaeyvxv .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#opulaeyvxv .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#opulaeyvxv .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#opulaeyvxv .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#opulaeyvxv .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#opulaeyvxv .gt_col_heading {
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
  overflow-x: hidden;
}

#opulaeyvxv .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#opulaeyvxv .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#opulaeyvxv .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#opulaeyvxv .gt_group_heading {
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

#opulaeyvxv .gt_empty_group_heading {
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

#opulaeyvxv .gt_striped {
  background-color: #f2f2f2;
}

#opulaeyvxv .gt_from_md > :first-child {
  margin-top: 0;
}

#opulaeyvxv .gt_from_md > :last-child {
  margin-bottom: 0;
}

#opulaeyvxv .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#opulaeyvxv .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#opulaeyvxv .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#opulaeyvxv .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#opulaeyvxv .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#opulaeyvxv .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#opulaeyvxv .gt_table_body {
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

#opulaeyvxv .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#opulaeyvxv .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#opulaeyvxv .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#opulaeyvxv .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#opulaeyvxv .gt_center {
  text-align: center;
}

#opulaeyvxv .gt_left {
  text-align: left;
}

#opulaeyvxv .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#opulaeyvxv .gt_font_normal {
  font-weight: normal;
}

#opulaeyvxv .gt_font_bold {
  font-weight: bold;
}

#opulaeyvxv .gt_font_italic {
  font-style: italic;
}

#opulaeyvxv .gt_super {
  font-size: 65%;
}

#opulaeyvxv .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="opulaeyvxv" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 523</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 575</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">missing</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">434 (83%)</td>
      <td class="gt_row gt_center gt_striped">444 (77%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">89 (17%)</td>
      <td class="gt_row gt_center">131 (23%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

If you got that far: wow! (also, forget the course, you don’t need it). If you didn’t get that far, don’t feel bad about it, but try to get a handle on the thought process.

One other issue: the p value for the first t-test (previous chemotherapy) is given as "p-value = 4.709e-06". While this number is very close to 0, we cannot round to 0 - there is no such thing as a p value of 0 for any hypothesis worth testing (there is a small but finite chance of every possible result, even throwing 100,000 tails in a row on an unbiased coin.) So do not report "p=0.0000"! You can round p values for reporting - for example, "4.709e-06" can be rounded to "<0.0005".

_For more advanced students:_

The other thing you can do is to find out the precise p value from the t value (which is given above the p value: -4.6275). The function you need is `pt(t value, degrees of freedom)`. This will give you the p value for a one-sided test, so you must multiply by 2 to get the two-sided test p value.


```r
# Find out p value from t value
pt(-4.6275, 510)*2
```

```
## [1] 4.699746e-06
```

This p-value can also be read as 4.7 x 10^-6^. An interesting question though: is it important whether p is <0.0005 or 4.7 x 10^-6^?

What is "degrees of freedom" and how come it is 510? Think about it this way: You have a line of ten people outside your door. You know the mean age of this group. Each person comes in one-by-one, you try to guess their age and they tell you how old they actually are. As each person comes in, your guesses will get better and better (for example, if the first three people have ages less than the mean, you will guess the age of the fourth person as something above the mean). However, only when you have the ages of the first nine people will you be able to guess for sure the age of the next (and last) person. In other words, the ages of the first nine people are "free", the age of the last person is "constrained". So "degrees of freedom" is the sample size minus one. Little catch though: for an unpaired test (such a straight drug v. placebo trial), you have two different groups and two different means. You would therefore be able to predict the scores of two observations (the last patient in each group). Degrees of freedom in an unpaired test is therefore the total sample size minus two (or, put another way, the sample size in group a minus one plus the sample size in group b minus one.)

### lesson3b.rds

**Patients with wrist osteoarthritis are randomized to a new drug or placebo. Pain is measured before and after treatment. Is the drug effective?**

The data look relatively normal and the most obvious thing to do would be to do:


```r
# t-test for pain after treatment, by group
t.test(p ~ g, data = lesson3b, var.equal = TRUE)
```

```
## 
## 	Two Sample t-test
## 
## data:  p by g
## t = 1.9731, df = 34, p-value = 0.05665
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.01930642  1.30819531
## sample estimates:
## mean in group 0 mean in group 1 
##      0.55555555     -0.08888889
```

This gives a p value of 0.057 and you might conclude that there is a "trend" towards statistical significance suggesting that the drug works. However, the t-test assumes that the data are independent. In the present case, this assumption does not hold: each patient contributes data from two wrists, and the pain scores from each wrist are correlated. There are several ways around the problem. The most obvious is to say: "These data are not independent, I am not going to analyze them. Call in a statistician."

However, if you are really keen, you could try the following:

You could analyze the data from each wrist separately by creating new variables as shown below (lines with # are comments).


```r
# Analyze data separately by wrist
lesson3b <-
  lesson3b %>%
  # Create a new variable called "pright" equivalent to "p"
  # (the pain score for the right wrist (site 2) only)
  mutate(
    pright = case_when(site == 2 ~ p)
    # By default, any observations that do not fall into the specified conditions
    # in the "case_when" statement will be set to missing (NA)
  ) %>%
  # Create a new variable called "pleft" for pain scores for the left wrist
  mutate(
    pleft = case_when(site == 1 ~ p)
  )

# t-test for pain in right and left wrists separately
t.test(pright ~ g, data = lesson3b, var.equal = TRUE)
```

```
## 
## 	Two Sample t-test
## 
## data:  pright by g
## t = 1.6818, df = 16, p-value = 0.112
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.2055046  1.7832823
## sample estimates:
## mean in group 0 mean in group 1 
##       0.6555555      -0.1333333
```

```r
t.test(pleft ~ g, data = lesson3b, var.equal = TRUE)
```

```
## 
## 	Two Sample t-test
## 
## data:  pleft by g
## t = 1.0418, df = 16, p-value = 0.313
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.5174209  1.5174209
## sample estimates:
## mean in group 0 mean in group 1 
##      0.45555555     -0.04444445
```

### lesson3c.rds

**Some postoperative pain data again. Is pain on day 2 different than pain on day 1? Is pain on day 3 different from pain on day 2?**

The most obvious issue here is that you are measuring the same patients on two occasions, so you are going to want a paired test. Should you do a paired t-test? Many statisticians would prefer a non-parametric method given that the data take only five different values and that the number of observations is small. The following command gives you the "Wilcoxon signed rank test":


```r
# Non-parametric test comparing day 1 and day 2 pain
wilcox.test(lesson3c$t1, lesson3c$t2, correct = FALSE, exact = FALSE, paired = TRUE)
```

```
## 
## 	Wilcoxon signed rank test
## 
## data:  lesson3c$t1 and lesson3c$t2
## V = 41.5, p-value = 0.1303
## alternative hypothesis: true location shift is not equal to 0
```

(By the way: I know this because that is what it says on the read out: if you had asked me yesterday, I doubt I would have remembered the name of a non-parametric paired test, another reason to think in concepts rather than remembering statistical techniques). The p value you get is p=0.13. We cannot conclude that pain scores are different. But is that all we want to say? The number of patients is small, maybe we failed to spot a difference. So let’s try a t-test:


```r
# paired t-test comparing day 1 and day 2 pain
t.test(lesson3c$t1, lesson3c$t2, var.equal = TRUE, paired = TRUE)
```

```
## 
## 	Paired t-test
## 
## data:  lesson3c$t1 and lesson3c$t2
## t = 1.5467, df = 21, p-value = 0.1369
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.09395838  0.63941292
## sample estimates:
## mean of the differences 
##               0.2727273
```

The p value you get (p=0.14) is very similar to the non-parametric method and you get a confidence interval for the difference between means of -0.09, 0.64. What I would conclude from this is that pain is unlikely to be worse on day 2 than day 1 but any decrease in pain is probably not important. 

What about normality of the data? Doesn’t that figure into whether you assess by t-test or non-parametric? Well if you type look at the distribution of t1 and t2, you find that neither are normally distributed. But a paired t-test does not depend on the assumption that each set of data in a pair is distributed but that the differences between pairs are normally distributed. So you would have to create a new variable and look at that:


```r
# Create a variable containing the difference in pain scores between days 1 and 2
lesson3c <-
  lesson3c %>%
  mutate(delta12 = t2 - t1)

# Summarize change in pain scores
skim(lesson3c$delta12)
```

```
## 
## Skim summary statistics
## 
## -- Variable type:numeric --------------------------------------------------------------------------
##          variable missing complete  n  mean   sd p0 p25 p50 p75 p100
##  lesson3c$delta12       0       22 22 -0.27 0.83 -2  -1   0   0    1
##      hist
##  ▁▁▃▁▁▇▁▂
```

As it turns out, the distribution of differences between pain scores are normally distributed even though pain at time 2 does not have a normal distribution. In fact, this is almost always the case. 

Now let's compare t2 and t3. Again, no significant difference. Does this mean that pain does not decrease after an operation? Of course, we know that pain does indeed get better. This illustrates two points: first, don't ask questions you know the answer to; second, asking lots of questions (is pain on day 2 better than on day 1?; is pain on day 3 better on day 2?) is not as good as just asking one question: does pain decrease over time? We'll discuss how to answer this question later on in the course.

### lesson3d.rds

**This is a single-arm, uncontrolled study of acupuncture for patients with neck pain. Does acupuncture increase range of motion?  Just as many men as women get neck pain. Can we say anything about the sample chosen for this trial with respect to gender? The mean age of patients with neck pain is 58.2 years. Is the trial population representative with respect to age?**

This is before and after data, so again you’ll want a paired test. The data are continuous, so a paired t-test is an option (if you are worried about normality, do both the parametric and non-parametric test and compare the results.)

There are two ways of doing the t-test:

1) Test whether the baseline scores are different from the post-treatment scores:


```r
# paired t-test for before and after pain scores
t.test(lesson3d$b, lesson3d$a, var.equal = TRUE, paired = TRUE)
```

```
## 
## 	Paired t-test
## 
## data:  lesson3d$b and lesson3d$a
## t = -4.4912, df = 33, p-value = 8.19e-05
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -35.17110 -13.24067
## sample estimates:
## mean of the differences 
##               -24.20588
```

2) Test whether the difference between scores is different from zero:


```r
# t-test for whether difference between before and after scores is different than zero
t.test(lesson3d$d, mu = 0)
```

```
## 
## 	One Sample t-test
## 
## data:  lesson3d$d
## t = 4.4912, df = 33, p-value = 8.19e-05
## alternative hypothesis: true mean is not equal to 0
## 95 percent confidence interval:
##  13.24067 35.17110
## sample estimates:
## mean of x 
##  24.20588
```

Both methods give you an identical p value of <0.001. But note, I didn’t ask for the p value. I asked "Does acupuncture increase range of motion?" Given that this is an uncontrolled trial, it may be that range of motion has improved naturally over time. So in fact you can’t answer the question about whether acupuncture increases range of motion from these data!

BTW: for those who are interested, acupuncture has been shown to improve neck pain and range of motion in a controlled trial, see: [Irnich, Behrens et al., Immediate effects of dry needling and acupuncture at distant points in chronic neck pain: results of a randomized, double-blind, sham-controlled crossover trial.](https://www.ncbi.nlm.nih.gov/pubmed/12237186)


```r
# Test whether proportion of women is different from 50%
binom.test(sum(lesson3d$sex), nrow(lesson3d), p = 0.5)
```

```
## 
## 	Exact binomial test
## 
## data:  sum(lesson3d$sex) and nrow(lesson3d)
## number of successes = 9, number of trials = 34, p-value = 0.009041
## alternative hypothesis: true probability of success is not equal to 0.5
## 95 percent confidence interval:
##  0.1288174 0.4436154
## sample estimates:
## probability of success 
##              0.2647059
```

Only about a quarter of the patients are women, and the binomial test gives a p value of 0.009, suggesting that men are over-represented in this trial. But is this important?


```r
# t-test for whether age is significantly different from 58.2
t.test(lesson3d$age, mu = 58.2)
```

```
## 
## 	One Sample t-test
## 
## data:  lesson3d$age
## t = -2.261, df = 33, p-value = 0.03048
## alternative hypothesis: true mean is not equal to 58.2
## 95 percent confidence interval:
##  46.30921 57.57315
## sample estimates:
## mean of x 
##  51.94118
```

Similarly, this t-test for age gives a p value of 0.030, but I doubt anyone would call a mean age of 52 much different from a mean age of 58, so you’d probably want to say that, ok, the trial patients are younger than we might expect, but not by much.

### lesson3e.rds

**These data are length of stay from two different hospitals. One of the hospitals uses a new chemotherapy regime that is said to reduce adverse events and therefore length of stay. Does the new regime decrease length of stay?**

Well, before running off and doing t-tests, let’s have a look at the data: 


```r
# Summarize data by hospital
lesson3e %>%
  group_by(hospital) %>%
  skim()
```

```
## Skim summary statistics
##  n obs: 57 
##  n variables: 2 
##  group variables: hospital 
## 
## -- Variable type:numeric --------------------------------------------------------------------------
##  hospital variable missing complete  n  mean    sd p0   p25 p50  p75 p100
##         1      los       0       29 29 44.86 13.57 30 34     41 55     79
##         2      los       0       28 28 45.14 10.85 28 39.25  45 50.5   70
##      hist
##  ▇▃▃▁▃▂▁▂
##  ▃▅▇▇▂▂▂▂
```

This shows us the mean, median etc. for length of stay by hospital. The two sets of data look very similar. Regardless of whether we do a t-test or non-parametric test, we do not see a difference between groups, p is >0.9 or 0.6. Interesting question: should you report a 95% confidence interval for the difference between groups? This shows, for example, that the new regimen could reduce length of stay by up to six days, surely important in cost terms. On the other hand, this is not a randomized trial. There might be all sorts of differences between the hospitals other than the different chemotherapy regime, such as the mix of patients, discharge policies etc. So you would have to be careful in stating that the chemotherapy regime "could reduce hospital stay by as much as six days" or some such. 

For advanced students only:

The data are non-normally distributed so you could try a log transform: 


```r
# Create variable for log of length of stay
lesson3e <-
  lesson3e %>%
  mutate(loglos = log(los))
```

The distribution of this new variable for both groups combined is normal, therefore data in each group will be normal. Try a t-test:


```r
# paired t-test using log of length of stay as outcome
t.test(loglos ~ hospital, data = lesson3e, var.equal = TRUE, paired = FALSE)
```

```
## 
## 	Two Sample t-test
## 
## data:  loglos by hospital
## t = -0.29426, df = 55, p-value = 0.7697
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.1594693  0.1186343
## sample estimates:
## mean in group 1 mean in group 2 
##        3.762733        3.783150
```



The p value is similar to the untransformed analyses. Now, look at the difference between means -0.02 and confidence interval (-0.16, 0.12).

To backtransform these values, you have to remember that addition on a log scale is the same as multiplication on an untransformed scale. Backtransform -0.02 using ``exp(-0.02)`` and you get 0.98. In other words, length of stay in hospital a is 98% more (or 2.0% less) compared to hospital b. Do the same things with the upper and lower bounds of the confidence interval and you might conclude that the difference in length of stay is between 15% less in hospital a to 13% less in hospital b. If you wanted to convert these numbers to actual days, just multiply by the mean hospital stay in group b by 0.98, 0.85 and 1.13.

### lesson3f.rds

**These data are from a randomized trial on the effects of physiotherapy treatment on function in pediatric patients recovering from cancer surgery. Function is measured on a 100 point scale. Does physiotherapy help improve function?**

You will want to do an unpaired t-test or non-parametric test on these data. 


```r
# unpaired t-test for change in pain by physiotherapy group
t.test(delta ~ physio, data = lesson3f, var.equal = TRUE, paired = FALSE)
```

```
## 
## 	Two Sample t-test
## 
## data:  delta by physio
## t = -1.4868, df = 110, p-value = 0.1399
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -16.668572   2.378662
## sample estimates:
## mean in group 0 mean in group 1 
##        11.70690        18.85185
```



This gives a p value of 0.14 (incidentally, don't say "p > 0.05" or "p=0.1399", which are under- and over-precise, respectively). Given a p value greater than 5%, we would say that we found no evidence that the treatment was effective. But is this really the case? Look at the read out from the t-test again, particularly the means for each group and the difference. The improvements in the treatment group was about 50% greater than in controls. The 95% confidence interval for the difference includes a possible 17 point improvement on physiotherapy, more than twice that of controls. So physiotherapy might well be a clinically important treatment in this population, even if we failed to prove it was better than control in this trial. Whatever your conclusion, don’t just report the p value: report the means and standard deviations in each group separately plus the difference between means and a 95% confidence interval. If I was writing this up for a journal, I might say:

<div class="quote-container">

>Mean improvement in function was greater in the 54 physiotherapy group patients (18.9 points, SD 24.6) than in the 58 controls (11.7, SD 26.1). Although by t-test the difference between groups (7.1) was not statistically significant (p=0.14), the 95% confidence interval (-2.4, 33.3) includes clinically relevant effects. This suggests that the trial may have been underpowered to detect meaningful differences between groups.

</div>

An alternative conclusion, which I think I actually prefer, would be to focus on the difference between groups of 7.1, deciding whether this is clinically significant.

## Week 4


```r
# Week 4: load packages
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

# Week 4: load data
lesson4a <- readRDS(here::here("Data", "Week 4", "lesson4a.rds"))
lesson4b <- readRDS(here::here("Data", "Week 4", "lesson4b.rds"))
lesson4c <- readRDS(here::here("Data", "Week 4", "lesson4c.rds"))
lesson4d <- readRDS(here::here("Data", "Week 4", "lesson4d.rds"))
lesson4e <- readRDS(here::here("Data", "Week 4", "lesson4e.rds"))
```

### lesson4a.rds

**This is a dataset on fifteen patients recording whether they had problematic nausea or vomiting after chemotherapy (defined as grade 2 or higher for either nausea or vomiting) and whether they reported being prone to travel sickness. Does travel sickness predict chemotherapy nausea and vomiting?**

To have a quick look at the data, create a two-by-two table:


```r
# Create formatted table of nausea/vomiting by car sickness history
tbl_summary(
  lesson4a %>% select(nv, cs),
  by = cs,
  type = list("nv" ~ "categorical")
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#zlxeaoptgx .gt_table {
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

#zlxeaoptgx .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#zlxeaoptgx .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#zlxeaoptgx .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#zlxeaoptgx .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#zlxeaoptgx .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#zlxeaoptgx .gt_col_heading {
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
  overflow-x: hidden;
}

#zlxeaoptgx .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#zlxeaoptgx .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#zlxeaoptgx .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#zlxeaoptgx .gt_group_heading {
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

#zlxeaoptgx .gt_empty_group_heading {
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

#zlxeaoptgx .gt_striped {
  background-color: #f2f2f2;
}

#zlxeaoptgx .gt_from_md > :first-child {
  margin-top: 0;
}

#zlxeaoptgx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#zlxeaoptgx .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#zlxeaoptgx .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#zlxeaoptgx .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#zlxeaoptgx .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#zlxeaoptgx .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#zlxeaoptgx .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#zlxeaoptgx .gt_table_body {
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

#zlxeaoptgx .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#zlxeaoptgx .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#zlxeaoptgx .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#zlxeaoptgx .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#zlxeaoptgx .gt_center {
  text-align: center;
}

#zlxeaoptgx .gt_left {
  text-align: left;
}

#zlxeaoptgx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#zlxeaoptgx .gt_font_normal {
  font-weight: normal;
}

#zlxeaoptgx .gt_font_bold {
  font-weight: bold;
}

#zlxeaoptgx .gt_font_italic {
  font-style: italic;
}

#zlxeaoptgx .gt_super {
  font-size: 65%;
}

#zlxeaoptgx .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="zlxeaoptgx" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 6</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 9</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">grade 2 or above nausea 1 =yes</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">4 (67%)</td>
      <td class="gt_row gt_center gt_striped">4 (44%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">2 (33%)</td>
      <td class="gt_row gt_center">5 (56%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->



This shows, for example, 5 (56%) of those who get car sick reported problematic nausea compared to only 2 (33%) of those who aren't prone to car sickness. To find out whether this is statistically significant (it certainly seems clinically significant), you can use the `chisq.test` or the `fisher.test` function.


```r
# Chi squared test
chisq.test(table(lesson4a$nv, lesson4a$cs), correct = FALSE)
```

```
## 
## 	Pearson's Chi-squared test
## 
## data:  table(lesson4a$nv, lesson4a$cs)
## X-squared = 0.71429, df = 1, p-value = 0.398
```

```r
# Fisher's exact test
fisher.test(table(lesson4a$nv, lesson4a$cs))
```

```
## 
## 	Fisher's Exact Test for Count Data
## 
## data:  table(lesson4a$nv, lesson4a$cs)
## p-value = 0.6084
## alternative hypothesis: true odds ratio is not equal to 1
## 95 percent confidence interval:
##   0.1989474 39.4980687
## sample estimates:
## odds ratio 
##   2.348722
```

`chisq.test` gives the p value from a chi-squared test, `fisher.test` is a special form of this test when any of the numbers in the table are small, say 10 or below). The p-value is about 0.6. You now have 3 options:

1. Declare the result non-statistically significant, and conclude that you have failed to reject the null hypothesis of no difference between groups.
2.	Say that, though differences between groups were not statistically significant, sample size was too small.
3.	Say that differences between groups were not statistically significant, and that the study was too small, but try to quantify a plausible range of possible differences between groups.

For point 3, you need the confidence interval. You get this by using the `epi.2by2` command.


```r
# Confidence interval for difference between groups
epi.2by2(matrix(rev(table(lesson4a$cs, lesson4a$nv)), nrow = 2))
```

```
##              Outcome +    Outcome -      Total        Inc risk *
## Exposed +            5            4          9              55.6
## Exposed -            2            4          6              33.3
## Total                7            8         15              46.7
##                  Odds
## Exposed +       1.250
## Exposed -       0.500
## Total           0.875
## 
## Point estimates and 95% CIs:
## -------------------------------------------------------------------
## Inc risk ratio                               1.67 (0.47, 5.96)
## Odds ratio                                   2.50 (0.29, 21.40)
## Attrib risk *                                22.22 (-27.54, 71.99)
## Attrib risk in population *                  13.33 (-32.06, 58.72)
## Attrib fraction in exposed (%)               40.00 (-114.41, 83.21)
## Attrib fraction in population (%)            28.57 (-78.75, 71.46)
## -------------------------------------------------------------------
##  Test that odds ratio = 1: chi2(1) = 0.714 Pr>chi2 = 0.398
##  Wald confidence limits
##  CI: confidence interval
##  * Outcomes per 100 population units
```



This gives a "risk ratio" (same as relative risk) of 1.67 with a 95% CI 0.47, 5.96. A model answer might be:

<div class="quote-container">

>Five of the nine patients (56%) who reported prior car sickness had grade 2 or higher nausea and vomiting compared to two of the six (33%) who reported no prior car sickness. Though differences between groups were not statistically significant (p=0.6 by Fisher's exact test), the sample size was small and the 95% confidence interval for the difference between groups includes differences of clinical relevance (relative risk 1.67; 95% CI 0.47, 5.96). It may be, for example, that problematic nausea and vomiting is up to six times more common in patients reporting prior car sickness than in those who do not.

</div>

### lesson4b.rds

**An epidemiological study of meat consumption and hypertension. Meat consumption was defined as low, medium or high depending on whether subjects ate less than 3, 3 to 7 or 7 + meals with meat in per week. Does meat consumption lead to hypertension?**



There are three levels of meat consumption. The outcome (hypertension) is binary either 1 or 0. So we will have a 3 by 2 table. Let’s start with a quick look:


```r
# Formatted table of meat consumption by hypertension status
tbl_summary(
  lesson4b %>% select(meat, hbp),
  by = hbp
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#hgemkgngwa .gt_table {
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

#hgemkgngwa .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#hgemkgngwa .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#hgemkgngwa .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#hgemkgngwa .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#hgemkgngwa .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#hgemkgngwa .gt_col_heading {
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
  overflow-x: hidden;
}

#hgemkgngwa .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#hgemkgngwa .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#hgemkgngwa .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#hgemkgngwa .gt_group_heading {
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

#hgemkgngwa .gt_empty_group_heading {
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

#hgemkgngwa .gt_striped {
  background-color: #f2f2f2;
}

#hgemkgngwa .gt_from_md > :first-child {
  margin-top: 0;
}

#hgemkgngwa .gt_from_md > :last-child {
  margin-bottom: 0;
}

#hgemkgngwa .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#hgemkgngwa .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#hgemkgngwa .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#hgemkgngwa .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#hgemkgngwa .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#hgemkgngwa .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#hgemkgngwa .gt_table_body {
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

#hgemkgngwa .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#hgemkgngwa .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#hgemkgngwa .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#hgemkgngwa .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#hgemkgngwa .gt_center {
  text-align: center;
}

#hgemkgngwa .gt_left {
  text-align: left;
}

#hgemkgngwa .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#hgemkgngwa .gt_font_normal {
  font-weight: normal;
}

#hgemkgngwa .gt_font_bold {
  font-weight: bold;
}

#hgemkgngwa .gt_font_italic {
  font-style: italic;
}

#hgemkgngwa .gt_super {
  font-size: 65%;
}

#hgemkgngwa .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="hgemkgngwa" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 35</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 71</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">consumption 1=lo, 2=med, 3=hi</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center gt_striped">16 (46%)</td>
      <td class="gt_row gt_center gt_striped">16 (23%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">2</td>
      <td class="gt_row gt_center">10 (29%)</td>
      <td class="gt_row gt_center">13 (18%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">3</td>
      <td class="gt_row gt_center gt_striped">9 (26%)</td>
      <td class="gt_row gt_center gt_striped">42 (59%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

This would tell you, for example, that of the patients with hypertension, 59% ate a lot of meat and only 23% ate a little. I find this a less helpful statistic than presenting the data in terms of rates of hypertension for level of meat consumption. One other thing to notice is that the rates of hypertension are high, suggesting this is a selected population.

You also could have created this table:


```r
# Formatted table of meat consumption by hypertension status (row percents)
tbl_summary(
  lesson4b %>% select(meat, hbp),
  by = hbp,
  percent = "row"
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#vnsfmmrbvs .gt_table {
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

#vnsfmmrbvs .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#vnsfmmrbvs .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#vnsfmmrbvs .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#vnsfmmrbvs .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#vnsfmmrbvs .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#vnsfmmrbvs .gt_col_heading {
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
  overflow-x: hidden;
}

#vnsfmmrbvs .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#vnsfmmrbvs .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#vnsfmmrbvs .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#vnsfmmrbvs .gt_group_heading {
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

#vnsfmmrbvs .gt_empty_group_heading {
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

#vnsfmmrbvs .gt_striped {
  background-color: #f2f2f2;
}

#vnsfmmrbvs .gt_from_md > :first-child {
  margin-top: 0;
}

#vnsfmmrbvs .gt_from_md > :last-child {
  margin-bottom: 0;
}

#vnsfmmrbvs .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#vnsfmmrbvs .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#vnsfmmrbvs .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#vnsfmmrbvs .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#vnsfmmrbvs .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#vnsfmmrbvs .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#vnsfmmrbvs .gt_table_body {
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

#vnsfmmrbvs .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#vnsfmmrbvs .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#vnsfmmrbvs .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#vnsfmmrbvs .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#vnsfmmrbvs .gt_center {
  text-align: center;
}

#vnsfmmrbvs .gt_left {
  text-align: left;
}

#vnsfmmrbvs .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#vnsfmmrbvs .gt_font_normal {
  font-weight: normal;
}

#vnsfmmrbvs .gt_font_bold {
  font-weight: bold;
}

#vnsfmmrbvs .gt_font_italic {
  font-style: italic;
}

#vnsfmmrbvs .gt_super {
  font-size: 65%;
}

#vnsfmmrbvs .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="vnsfmmrbvs" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 35</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 71</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">consumption 1=lo, 2=med, 3=hi</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center gt_striped">16 (50%)</td>
      <td class="gt_row gt_center gt_striped">16 (50%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">2</td>
      <td class="gt_row gt_center">10 (43%)</td>
      <td class="gt_row gt_center">13 (57%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">3</td>
      <td class="gt_row gt_center gt_striped">9 (18%)</td>
      <td class="gt_row gt_center gt_striped">42 (82%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

These tables show the number and percentages of patients with hypertension in each category of meat eating. Rates of hypertension are 50%, 57% and 82% in the low, medium and high meat consumption groups, respectively.

To assess statistical significance, use the `chisq.test` function with the hypertension by meat consumption table as the input.


```r
# Chi squared test for association between meat consumption and hypertension
chisq.test(table(lesson4b$hbp, lesson4b$meat), correct = FALSE)
```

```
## 
## 	Pearson's Chi-squared test
## 
## data:  table(lesson4b$hbp, lesson4b$meat)
## X-squared = 10.759, df = 2, p-value = 0.004611
```

The p value is p=0.005. How to interpret this? The formal statistical interpretation is that we can reject the null hypothesis that rates of hypertension are the same in each group. To demonstrate this, try renumbering the labels for the variable meat:


```r
# Change values of meat consumption variable
lesson4b_changed <-
  lesson4b %>%
  mutate(
    meat =
      case_when(
        meat == 3 ~ 0.98573,
        meat == 2 ~ 60,
        meat == 1 ~ 643
      )
  )

# Re-run chi squared test
chisq.test(table(lesson4b_changed$hbp, lesson4b_changed$meat), correct = FALSE)
```

```
## 
## 	Pearson's Chi-squared test
## 
## data:  table(lesson4b_changed$hbp, lesson4b_changed$meat)
## X-squared = 10.759, df = 2, p-value = 0.004611
```

You get exactly the same result. This demonstrates that: a) the numbers you use for meat consumption act only as labels; b) the order is unimportant: you get the same p value if you arrange the columns "low med hi" as "hi low med".

So it might be useful to do what are called "pairwise" comparisons: what difference is there in the rate of hypertension between low and medium meat eaters? What about high and low? Though there are three possible comparisons (hi v. lo; hi v. med; med v. lo), it is more usual to chose either the highest or lowest category and compare everything to that. The way to do these analyses is to create new variables. The code is given below (the #s are comments that are ignored by R).


```r
# Create a new variable "c1" which is "1" if meat consumption is high and "0" if it is medium
# "c1" is missing for low meat consumption: these patients are left out of the analysis
lesson4b <-
  lesson4b %>%
  mutate(
    c1 =
      case_when(
        meat == 2 ~ 0,
        meat == 3 ~ 1
      )
  )

# Test for difference between medium and high meat consumption
epi.2by2(matrix(rev(table(lesson4b$c1, lesson4b$hbp)), nrow = 2))
```

```
##              Outcome +    Outcome -      Total        Inc risk *
## Exposed +           42            9         51              82.4
## Exposed -           13           10         23              56.5
## Total               55           19         74              74.3
##                  Odds
## Exposed +        4.67
## Exposed -        1.30
## Total            2.89
## 
## Point estimates and 95% CIs:
## -------------------------------------------------------------------
## Inc risk ratio                               1.46 (1.00, 2.13)
## Odds ratio                                   3.59 (1.20, 10.73)
## Attrib risk *                                25.83 (3.03, 48.63)
## Attrib risk in population *                  17.80 (-4.77, 40.37)
## Attrib fraction in exposed (%)               31.37 (-0.39, 53.08)
## Attrib fraction in population (%)            23.95 (-1.91, 43.25)
## -------------------------------------------------------------------
##  Test that odds ratio = 1: chi2(1) = 5.542 Pr>chi2 = 0.019
##  Wald confidence limits
##  CI: confidence interval
##  * Outcomes per 100 population units
```




```r
# Compare high vs low consumption
# "c2" is "1" if meat consumption is high and "0" if it is low
# "c2" is missing for medium meat consumption: these patients are left out of the analysis
lesson4b <-
  lesson4b %>%
  mutate(
    c2 =
      case_when(
        meat == 1 ~ 0,
        meat == 3 ~ 1
      )
  )

# Test for difference between low and high meat consumption
epi.2by2(matrix(rev(table(lesson4b$c2, lesson4b$hbp)), nrow = 2))
```

```
##              Outcome +    Outcome -      Total        Inc risk *
## Exposed +           42            9         51              82.4
## Exposed -           16           16         32              50.0
## Total               58           25         83              69.9
##                  Odds
## Exposed +        4.67
## Exposed -        1.00
## Total            2.32
## 
## Point estimates and 95% CIs:
## -------------------------------------------------------------------
## Inc risk ratio                               1.65 (1.14, 2.38)
## Odds ratio                                   4.67 (1.72, 12.68)
## Attrib risk *                                32.35 (12.11, 52.59)
## Attrib risk in population *                  19.88 (-0.06, 39.82)
## Attrib fraction in exposed (%)               39.29 (12.19, 58.02)
## Attrib fraction in population (%)            28.45 (6.12, 45.47)
## -------------------------------------------------------------------
##  Test that odds ratio = 1: chi2(1) = 9.778 Pr>chi2 = 0.002
##  Wald confidence limits
##  CI: confidence interval
##  * Outcomes per 100 population units
```



What these commands do is to create new variables (c1 and c2) that are used instead of the variable "meat" in analyses. These are set to 1 or 0 or missing depending on the pairwise comparison that you want to do. A model answer might be as follows: 

<div class="quote-container">

>The results of the study are shown in the table. Differences in rates of hypertension between categories of meat consumption are statistically significant (p=0.005). Rates of hypertension rise with increasing meat consumption: patients with the highest meat consumption had a risk of hypertension 1.5 times greater than those with intermediate meat consumption (95% CI 1.00, 2.1, p=0.019) and 1.6 times greater than those with the lowest levels of meat consumption (95% CI 1.1, 2.4, p=0.002). Rates of hypertension were similar between medium and low meat consumption (relative risk 1.1; 95% CI 0.69, 1.9, p=0.6).

</div>

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#gfhbrxnasc .gt_table {
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

#gfhbrxnasc .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#gfhbrxnasc .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#gfhbrxnasc .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#gfhbrxnasc .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#gfhbrxnasc .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#gfhbrxnasc .gt_col_heading {
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
  overflow-x: hidden;
}

#gfhbrxnasc .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#gfhbrxnasc .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#gfhbrxnasc .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#gfhbrxnasc .gt_group_heading {
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

#gfhbrxnasc .gt_empty_group_heading {
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

#gfhbrxnasc .gt_striped {
  background-color: #f2f2f2;
}

#gfhbrxnasc .gt_from_md > :first-child {
  margin-top: 0;
}

#gfhbrxnasc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#gfhbrxnasc .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#gfhbrxnasc .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#gfhbrxnasc .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#gfhbrxnasc .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#gfhbrxnasc .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#gfhbrxnasc .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#gfhbrxnasc .gt_table_body {
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

#gfhbrxnasc .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#gfhbrxnasc .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#gfhbrxnasc .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#gfhbrxnasc .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#gfhbrxnasc .gt_center {
  text-align: center;
}

#gfhbrxnasc .gt_left {
  text-align: left;
}

#gfhbrxnasc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#gfhbrxnasc .gt_font_normal {
  font-weight: normal;
}

#gfhbrxnasc .gt_font_bold {
  font-weight: bold;
}

#gfhbrxnasc .gt_font_italic {
  font-style: italic;
}

#gfhbrxnasc .gt_super {
  font-size: 65%;
}

#gfhbrxnasc .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="gfhbrxnasc" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>No Hypertension</strong>, N = 35</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>Hypertension</strong>, N = 71</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>Overall</strong>, N = 106</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Meat Consumption</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">Low</td>
      <td class="gt_row gt_center gt_striped">16 (50%)</td>
      <td class="gt_row gt_center gt_striped">16 (50%)</td>
      <td class="gt_row gt_center gt_striped">32 (100%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Medium</td>
      <td class="gt_row gt_center">10 (43%)</td>
      <td class="gt_row gt_center">13 (57%)</td>
      <td class="gt_row gt_center">23 (100%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">High</td>
      <td class="gt_row gt_center gt_striped">9 (18%)</td>
      <td class="gt_row gt_center gt_striped">42 (82%)</td>
      <td class="gt_row gt_center gt_striped">51 (100%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

You might note that I chose to compare low and medium meat consumption, that is, give all three pairwise comparisons rather than just high v. low and high v. medium. This is probably the exception rather than the rule: in this particular case, it seems worth reporting because the low and medium groups seem very comparable compared to high meat consumption.  

And now, the key point...

You may have noticed that my model answer did not actually answer the question. The question was "does meat consumption lead to hypertension?". I only answered in terms of rates of hypertension rising with increased meat consumption and the like. This is because you cannot use statistics to prove causality without thinking about the research design. If you go out and ask how much meat people eat and then measure their blood pressure, you cannot assume that any associations are causal. It may be, for example, that meat eaters tend to smoke more and it is smoking, not meat, that causes hypertension.

### lesson4c.rds

**This is a dataset from a chemotherapy study. The researchers think that a mutation of a certain gene may be associated with chemotherapy toxicity. Should clinicians test for the gene during pre-chemotherapy work up?**

It is immediately obvious from this table that there are very few patients who are homozygous wild type.


```r
# Formatted two-way table of genes by toxicity outcome
tbl_summary(
  lesson4c %>% select(gene, toxicity),
  by = toxicity
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#tlnsbgwbeq .gt_table {
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

#tlnsbgwbeq .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#tlnsbgwbeq .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#tlnsbgwbeq .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#tlnsbgwbeq .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#tlnsbgwbeq .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#tlnsbgwbeq .gt_col_heading {
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
  overflow-x: hidden;
}

#tlnsbgwbeq .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#tlnsbgwbeq .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#tlnsbgwbeq .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#tlnsbgwbeq .gt_group_heading {
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

#tlnsbgwbeq .gt_empty_group_heading {
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

#tlnsbgwbeq .gt_striped {
  background-color: #f2f2f2;
}

#tlnsbgwbeq .gt_from_md > :first-child {
  margin-top: 0;
}

#tlnsbgwbeq .gt_from_md > :last-child {
  margin-bottom: 0;
}

#tlnsbgwbeq .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#tlnsbgwbeq .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#tlnsbgwbeq .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#tlnsbgwbeq .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#tlnsbgwbeq .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#tlnsbgwbeq .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#tlnsbgwbeq .gt_table_body {
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

#tlnsbgwbeq .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#tlnsbgwbeq .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#tlnsbgwbeq .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#tlnsbgwbeq .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#tlnsbgwbeq .gt_center {
  text-align: center;
}

#tlnsbgwbeq .gt_left {
  text-align: left;
}

#tlnsbgwbeq .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#tlnsbgwbeq .gt_font_normal {
  font-weight: normal;
}

#tlnsbgwbeq .gt_font_bold {
  font-weight: bold;
}

#tlnsbgwbeq .gt_font_italic {
  font-style: italic;
}

#tlnsbgwbeq .gt_super {
  font-size: 65%;
}

#tlnsbgwbeq .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="tlnsbgwbeq" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 204</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 100</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">0=homozygous wild type; 1=heterozygous; 2 = homozygous mutant</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">134 (66%)</td>
      <td class="gt_row gt_center gt_striped">80 (80%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">65 (32%)</td>
      <td class="gt_row gt_center">19 (19%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">2</td>
      <td class="gt_row gt_center gt_striped">5 (2.5%)</td>
      <td class="gt_row gt_center gt_striped">1 (1.0%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

It would seem appropriate to combine heterozygotes and homozygous wild type into a single category. You might be tempted to type `lesson4c %>% mutate(gene = if_else(gene == 2, 1, gene))`. But you should avoid changing raw data in this way: it would be preferable to create a new variable as follows:


```r
# Create binary variable grouping the values of "1" and "2" for gene
lesson4c <-
  lesson4c %>%
  mutate(
    mutant =
      case_when(
        gene == 1 | gene == 2 ~ 1,
        gene == 0 ~ 0
      )
  )
```

Moreover, it would be worth reporting the results of an analysis using all three groups, to investigate whether the conclusions change. This is sometimes called a "sensitivity analysis".



The results of the study are shown in the table. Very few participants (6 (2.0%)) were homozygous mutant. For the purposes of analysis therefore, data for these participants was combined with those heterozygous for the gene. Patients with any mutant allele (i.e. heterozygous or homozygous mutant) had lower rates of toxicity (20% vs 80%, p=0.010 by chi squared). The relative risk of toxicity is 0.59 compared to patients with the wild-type (95% CI 0.39, 0.91). This conclusion is not sensitive to the method of analysis: analysis of the table keeping participants in three groups gives p=0.033 by an exact test. These findings should be confirmed in a larger series. In particular, it would be interesting to know whether patients who are homozygous mutant are at particularly increased risk.

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#bixqbsxufc .gt_table {
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

#bixqbsxufc .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#bixqbsxufc .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#bixqbsxufc .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#bixqbsxufc .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#bixqbsxufc .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#bixqbsxufc .gt_col_heading {
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
  overflow-x: hidden;
}

#bixqbsxufc .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#bixqbsxufc .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#bixqbsxufc .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#bixqbsxufc .gt_group_heading {
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

#bixqbsxufc .gt_empty_group_heading {
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

#bixqbsxufc .gt_striped {
  background-color: #f2f2f2;
}

#bixqbsxufc .gt_from_md > :first-child {
  margin-top: 0;
}

#bixqbsxufc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#bixqbsxufc .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#bixqbsxufc .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#bixqbsxufc .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#bixqbsxufc .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#bixqbsxufc .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#bixqbsxufc .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#bixqbsxufc .gt_table_body {
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

#bixqbsxufc .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#bixqbsxufc .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#bixqbsxufc .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#bixqbsxufc .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#bixqbsxufc .gt_center {
  text-align: center;
}

#bixqbsxufc .gt_left {
  text-align: left;
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
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="bixqbsxufc" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>No Grade III/IV Toxicity</strong>, N = 204</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>Grade III/IV Toxicity</strong>, N = 100</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>Overall</strong>, N = 304</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Gene</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">Homozygous wild type</td>
      <td class="gt_row gt_center gt_striped">134 (63%)</td>
      <td class="gt_row gt_center gt_striped">80 (37%)</td>
      <td class="gt_row gt_center gt_striped">214 (100%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Heterozygous</td>
      <td class="gt_row gt_center">65 (77%)</td>
      <td class="gt_row gt_center">19 (23%)</td>
      <td class="gt_row gt_center">84 (100%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">Homozygous mutant</td>
      <td class="gt_row gt_center gt_striped">5 (83%)</td>
      <td class="gt_row gt_center gt_striped">1 (17%)</td>
      <td class="gt_row gt_center gt_striped">6 (100%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

Genetics type people: note that this gene is in Hardy Weinberg equilibrium!

One thing to note is my conclusion, the answer to the question. It would be a little premature to start changing clinical practice on the basis of a single study with a moderate number of patients and a less than overwhelming strength of evidence. Also, it is questionable whether you should start using a test just because it is predictive: you should use a test if it improves clinical outcome.

### lesson4d.rds

**Patients are given chemotherapy regimen a or b and assessed for tumor response. Which regimen would you recommend to a patient? Do the treatments work differently depending on age or sex?**

The first thing we want to do is compare response by group. But using `epi.2by2` with "response" and "chemo" doesn't work. This is because the exposure variable has to be numeric (for example, 0 and 1), not "a" or "b". So you need to use the "group" variable instead of the "chemo" variable.



This gives response rates of 54% on regimen "a" and 46% on regimen "b", a relative risk of 0.84 and a p value of 0.11. Should we conclude that there is no difference between groups and that you should feel free to use either regimen? Imagine you are a patient. You are told that you have a 50:50 chance of response on one regimen but only a 40% chance on the other. Unless there are good reasons to choose between the regimes (e.g. toxicity), which would you choose? The point here is that statistical significance does not really inform choices between similar alternatives. Assuming that toxicity, cost and inconvenience are similar between the regimes, I would recommend regimen a, even though the difference is not statistically significant. The confidence interval here is absolutely critical: the 95% C.I. for the risk difference is -18%, 1.7%. In other words, the response rate could be 18% higher on regimen a (e.g. 55% vs. 37%) or 2% lower (e.g. 50% vs. 52%). So you might do a lot better with regimen a, you are unlikely to do much worse. 

**The sub-group analyses**

A common mistake would be to use `epi.2by2` with `response` and `sex`. However, this would examine whether, regardless of chemotherapy regimen used, men and women had different tumor outcome. What we want to see if the difference between treatment a and b changes depending on whether male or female patients are being treated. As a start, try:


```r
# You can use the "group_split" function to split your dataset into two groups
lesson4d_sex <-
  lesson4d %>%
  group_split(sex)

# The first dataset, indicated by lesson4d_sex[[1]], is males
lesson4d_males <- lesson4d_sex[[1]]

# To confirm:
table(lesson4d_males$sex)
```

```
## 
##   0 
## 294
```

```r
# The second dataset, indicated by lesson4d_sex[[2]], is females
lesson4d_females <- lesson4d_sex[[2]]

# To confirm:
table(lesson4d_females$sex)
```

```
## 
##   1 
## 106
```

```r
# Males (sex == 0)
epi.2by2(matrix(rev(table(lesson4d_males$group, lesson4d_males$response)), nrow = 2))
```

```
##              Outcome +    Outcome -      Total        Inc risk *
## Exposed +           54           84        138              39.1
## Exposed -           80           76        156              51.3
## Total              134          160        294              45.6
##                  Odds
## Exposed +       0.643
## Exposed -       1.053
## Total           0.838
## 
## Point estimates and 95% CIs:
## -------------------------------------------------------------------
## Inc risk ratio                               0.76 (0.59, 0.99)
## Odds ratio                                   0.61 (0.38, 0.97)
## Attrib risk *                                -12.15 (-23.46, -0.85)
## Attrib risk in population *                  -5.70 (-15.40, 3.99)
## Attrib fraction in exposed (%)               -31.05 (-69.67, -1.23)
## Attrib fraction in population (%)            -12.51 (-24.99, -1.28)
## -------------------------------------------------------------------
##  Test that odds ratio = 1: chi2(1) = 4.359 Pr>chi2 = 0.037
##  Wald confidence limits
##  CI: confidence interval
##  * Outcomes per 100 population units
```

```r
# Females (sex == 1)
epi.2by2(matrix(rev(table(lesson4d_females$group, lesson4d_females$response)), nrow = 2))
```

```
##              Outcome +    Outcome -      Total        Inc risk *
## Exposed +           27           35         62              43.5
## Exposed -           17           27         44              38.6
## Total               44           62        106              41.5
##                  Odds
## Exposed +       0.771
## Exposed -       0.630
## Total           0.710
## 
## Point estimates and 95% CIs:
## -------------------------------------------------------------------
## Inc risk ratio                               1.13 (0.71, 1.80)
## Odds ratio                                   1.23 (0.56, 2.69)
## Attrib risk *                                4.91 (-14.04, 23.87)
## Attrib risk in population *                  2.87 (-14.30, 20.05)
## Attrib fraction in exposed (%)               11.28 (-41.66, 44.44)
## Attrib fraction in population (%)            6.92 (-24.07, 30.17)
## -------------------------------------------------------------------
##  Test that odds ratio = 1: chi2(1) = 0.256 Pr>chi2 = 0.613
##  Wald confidence limits
##  CI: confidence interval
##  * Outcomes per 100 population units
```

What you get is a statistically significant difference between treatment groups for men (many more respond on regimen a) but not women (actually a few more respond on regimen b). How to interpret this? In the literature, this might well be trumpeted as showing that though either regimen could be used for women, regimen a is better for men. My own view is that sub-group analyses are hypothesis generating not hypothesis testing. In particular, is there any reason to believe that response to chemotherapy might depend on sex? I don't think there are any cases of this. 

Testing age is a little more difficult as it is a continuous variable. One typical approach might be to create two sub-groups depending on the median. First, `quantile(lesson4d$age, c(0.5), na.rm = TRUE)` gives a median age of 42. So:


```r
# Use "group_split" again
lesson4d_age <-
  lesson4d %>%
  # Create variable to indicate how to split data
  mutate(hiage = if_else(age > 42, 1, 0)) %>%
  group_split(hiage)

# Younger patients (lesson4d_age[[1]])
lesson4d_younger <- lesson4d_age[[1]]
epi.2by2(matrix(rev(table(lesson4d_younger$group, lesson4d_younger$response)), nrow = 2))
```

```
##              Outcome +    Outcome -      Total        Inc risk *
## Exposed +           44           52         96              45.8
## Exposed -           56           47        103              54.4
## Total              100           99        199              50.3
##                  Odds
## Exposed +       0.846
## Exposed -       1.191
## Total           1.010
## 
## Point estimates and 95% CIs:
## -------------------------------------------------------------------
## Inc risk ratio                               0.84 (0.64, 1.12)
## Odds ratio                                   0.71 (0.41, 1.24)
## Attrib risk *                                -8.54 (-22.39, 5.32)
## Attrib risk in population *                  -4.12 (-15.98, 7.75)
## Attrib fraction in exposed (%)               -18.62 (-57.01, 10.38)
## Attrib fraction in population (%)            -8.19 (-22.47, 4.42)
## -------------------------------------------------------------------
##  Test that odds ratio = 1: chi2(1) = 1.448 Pr>chi2 = 0.229
##  Wald confidence limits
##  CI: confidence interval
##  * Outcomes per 100 population units
```

```r
# Older patients (lesson4d_age[[2]])
lesson4d_older <- lesson4d_age[[2]]
epi.2by2(matrix(rev(table(lesson4d_older$group, lesson4d_older$response)), nrow = 2))
```

```
##              Outcome +    Outcome -      Total        Inc risk *
## Exposed +           36           66        102              35.3
## Exposed -           41           56         97              42.3
## Total               77          122        199              38.7
##                  Odds
## Exposed +       0.545
## Exposed -       0.732
## Total           0.631
## 
## Point estimates and 95% CIs:
## -------------------------------------------------------------------
## Inc risk ratio                               0.84 (0.59, 1.19)
## Odds ratio                                   0.75 (0.42, 1.32)
## Attrib risk *                                -6.97 (-20.49, 6.54)
## Attrib risk in population *                  -3.57 (-15.51, 8.36)
## Attrib fraction in exposed (%)               -19.76 (-70.10, 15.68)
## Attrib fraction in population (%)            -9.24 (-28.78, 7.33)
## -------------------------------------------------------------------
##  Test that odds ratio = 1: chi2(1) = 1.019 Pr>chi2 = 0.313
##  Wald confidence limits
##  CI: confidence interval
##  * Outcomes per 100 population units
```

You get no difference between groups for either older or younger patients. As it turns out, this is not a very efficient method of testing for age differences. A better technique will be discussed in the class on regression.

**Interaction or sub-group analysis?**

There is a further problem here: we have one question ("do effects differ between men and women?") and two p values (one for men and one for women). What you really want is one p value to answer one question. The correct statistical technique for looking at whether the effects of treatment differ between sub-groups is called interaction. We will look at this later in the course. In the meantime, if you are interested, you can read some brief articles at: 

[Statistics Notes: Interaction 1: heterogeneity of effects](http://bmj.bmjjournals.com/cgi/content/full/313/7055/486?ijkey=f0d0304067151ab3c6490b209ca3e954acb60a29&keytype2=tf_ipsecsha)

[Statistics Notes: Interaction 2: compare effect sizes not P values](http://bmj.bmjjournals.com/cgi/content/full/313/7060/808?ijkey=7172a78ea07bf92702ec4a33c6804b3ea439c46c&keytype2=tf_ipsecsha)

[Statistics Notes: Interaction 3: How to examine heterogeneity](http://bmj.bmjjournals.com/cgi/content/full/313/7061/862?ijkey=c1181f258aa1146139604ac7d463ec93caa4d623&keytype2=tf_ipsecsha)

### lesson4e.rds

**This is a lab study of two candidate tumor-suppressor genes (gene1 and gene2). Wild-type mice are compared with mice that have gene1 knocked-out, gene2 knocked-out or both. The presence of tumors is measured after 30 days. Do the genes suppress cancer?**

The obvious thing to do would be to use `epi.2by2` with "cancer" and "gene1", and then with "cancer" and "gene2". Superficially this would suggest that gene1 is a tumor suppressor gene and gene2 is not. However, that might be to get too fixed on p-values. The proportion of cancer in mice with gene2 knocked out is over twice that of controls. Remember that animal experiments tend to use a very small number of observations (a typical clinical trial has hundreds of patients, a typical lab study has maybe a dozen mice). So you might want to say that there is good evidence that gene1 is a tumor suppressor gene but that whilst evidence is suggestive for gene2, more research is needed.

A BIG HOWEVER - have a look at the data or this table:


```r
# Formatted table of gene1 by gene2
tbl_summary(
  lesson4e %>% select(gene1, gene2),
  by = gene2,
  type = list("gene1" ~ "categorical")
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#jrfpnysbvm .gt_table {
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

#jrfpnysbvm .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#jrfpnysbvm .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#jrfpnysbvm .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#jrfpnysbvm .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#jrfpnysbvm .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#jrfpnysbvm .gt_col_heading {
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
  overflow-x: hidden;
}

#jrfpnysbvm .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#jrfpnysbvm .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#jrfpnysbvm .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#jrfpnysbvm .gt_group_heading {
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

#jrfpnysbvm .gt_empty_group_heading {
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

#jrfpnysbvm .gt_striped {
  background-color: #f2f2f2;
}

#jrfpnysbvm .gt_from_md > :first-child {
  margin-top: 0;
}

#jrfpnysbvm .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jrfpnysbvm .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#jrfpnysbvm .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#jrfpnysbvm .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#jrfpnysbvm .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#jrfpnysbvm .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#jrfpnysbvm .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#jrfpnysbvm .gt_table_body {
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

#jrfpnysbvm .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#jrfpnysbvm .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#jrfpnysbvm .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#jrfpnysbvm .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#jrfpnysbvm .gt_center {
  text-align: center;
}

#jrfpnysbvm .gt_left {
  text-align: left;
}

#jrfpnysbvm .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jrfpnysbvm .gt_font_normal {
  font-weight: normal;
}

#jrfpnysbvm .gt_font_bold {
  font-weight: bold;
}

#jrfpnysbvm .gt_font_italic {
  font-style: italic;
}

#jrfpnysbvm .gt_super {
  font-size: 65%;
}

#jrfpnysbvm .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="jrfpnysbvm" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 12</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 12</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">gene1</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">6 (50%)</td>
      <td class="gt_row gt_center gt_striped">6 (50%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">6 (50%)</td>
      <td class="gt_row gt_center">6 (50%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->



The experimental design was to knockout no genes in some animals, gene1 in some animals, gene2 in other animals and both genes in a final set of animals. This is known as a factorial or Latin-square design. Analyzing rates of cancer for mice without gene1 or gene2, as suggested above, ignores this experimental design. Presumably the design was implemented because the researchers wanted to know if the effects of gene1 differed depending on whether gene2 had been knocked-out and vice versa. Now you could start doing separate sub-groups (e.g. using `epi.2by2` for "cancer" and "gene1", filtering by "gene2==0" and "gene2==1" separately) but this produces somewhat unhelpful results. For example, it suggests that gene1 has an effect for wild-type gene2 (p=0.046) but maybe not for knocked out gene2 (p=0.079). This has all the look and feel of a spurious sub-group analysis, however. We will discuss some regression approaches to this problem later in the lecture series.

## Week 5


```r
# Week 5: load packages
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

# Week 5: load data
lesson5a <- readRDS(here::here("Data", "Week 5", "lesson5a.rds"))
lesson5b <- readRDS(here::here("Data", "Week 5", "lesson5b.rds"))
lesson5c <- readRDS(here::here("Data", "Week 5", "lesson5c.rds"))
lesson5d <- readRDS(here::here("Data", "Week 5", "lesson5d.rds"))
lesson5e <- readRDS(here::here("Data", "Week 5", "lesson5e.rds"))
lesson5f <- readRDS(here::here("Data", "Week 5", "lesson5f.rds"))
lesson5g <- readRDS(here::here("Data", "Week 5", "lesson5g.rds"))
lesson5h <- readRDS(here::here("Data", "Week 5", "lesson5h.rds"))
lesson5i <- readRDS(here::here("Data", "Week 5", "lesson5i.rds"))
```

### lesson5a.rds

**These are data from marathon runners (again). Which of the following is associated with how fast runners complete the marathon: age, sex, training miles, weight?**

My guess here is that we are going to want to do a regression analysis. This would allow us to quantify the association between the various predictor variables and race time. For example, it would be interesting to know not only that number of weekly training miles is correlated with race time, but by how much you can reduce your race time if you increased your training by a certain amount. Our dependent variable is "rt" (race time in minutes), so we could type:


```r
# Create linear regression model for race time
rt_model <- lm(rt ~ age + sex + tr + wt, data = lesson5a)

# Results of linear regression model
summary(rt_model)
```

```
## 
## Call:
## lm(formula = rt ~ age + sex + tr + wt, data = lesson5a)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -100.066  -26.311   -3.977   20.682  165.336 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 256.48412   18.29679  14.018  < 2e-16 ***
## age           0.80819    0.25451   3.175 0.001719 ** 
## sex          23.16076    6.02247   3.846 0.000159 ***
## tr           -1.48529    0.20717  -7.169 1.23e-11 ***
## wt            0.04766    0.17133   0.278 0.781145    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 39.36 on 212 degrees of freedom
##   (45 observations deleted due to missingness)
## Multiple R-squared:  0.2605,	Adjusted R-squared:  0.2465 
## F-statistic: 18.67 on 4 and 212 DF,  p-value: 3.677e-13
```



The p values for all the predictor variables apart from weight are very low. A model answer might be:

<div class="quote-container">

>There were 262 runners in the dataset; full data were available for 217. Summary data for these 217 are given in table 1. Predictors of race time are shown in table 2. Age, sex and number of training miles were all statistically significant predictors of race time; weight is unlikely to have an important effect.

</div>

<center> **Table 1** </center>

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#jgoecrbkrg .gt_table {
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

#jgoecrbkrg .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#jgoecrbkrg .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#jgoecrbkrg .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#jgoecrbkrg .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#jgoecrbkrg .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#jgoecrbkrg .gt_col_heading {
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
  overflow-x: hidden;
}

#jgoecrbkrg .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#jgoecrbkrg .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#jgoecrbkrg .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#jgoecrbkrg .gt_group_heading {
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

#jgoecrbkrg .gt_empty_group_heading {
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

#jgoecrbkrg .gt_striped {
  background-color: #f2f2f2;
}

#jgoecrbkrg .gt_from_md > :first-child {
  margin-top: 0;
}

#jgoecrbkrg .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jgoecrbkrg .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#jgoecrbkrg .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#jgoecrbkrg .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#jgoecrbkrg .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#jgoecrbkrg .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#jgoecrbkrg .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#jgoecrbkrg .gt_table_body {
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

#jgoecrbkrg .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#jgoecrbkrg .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#jgoecrbkrg .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#jgoecrbkrg .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#jgoecrbkrg .gt_center {
  text-align: center;
}

#jgoecrbkrg .gt_left {
  text-align: left;
}

#jgoecrbkrg .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jgoecrbkrg .gt_font_normal {
  font-weight: normal;
}

#jgoecrbkrg .gt_font_bold {
  font-weight: bold;
}

#jgoecrbkrg .gt_font_italic {
  font-style: italic;
}

#jgoecrbkrg .gt_super {
  font-size: 65%;
}

#jgoecrbkrg .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="jgoecrbkrg" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>N = 219</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Age (years)</td>
      <td class="gt_row gt_center">42 (11)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">Unknown</td>
      <td class="gt_row gt_center gt_striped">1</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Female</td>
      <td class="gt_row gt_center">61 (28%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Training miles per week</td>
      <td class="gt_row gt_center gt_striped">36 (13)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Race time (minutes)</td>
      <td class="gt_row gt_center">246 (45)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">Unknown</td>
      <td class="gt_row gt_center gt_striped">1</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Weight (kg)</td>
      <td class="gt_row gt_center">76 (16)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="2">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: mean (SD); n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

<center> **Table 2** </center>

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#mafemqyuoy .gt_table {
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

#mafemqyuoy .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#mafemqyuoy .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#mafemqyuoy .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#mafemqyuoy .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#mafemqyuoy .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#mafemqyuoy .gt_col_heading {
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
  overflow-x: hidden;
}

#mafemqyuoy .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#mafemqyuoy .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#mafemqyuoy .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#mafemqyuoy .gt_group_heading {
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

#mafemqyuoy .gt_empty_group_heading {
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

#mafemqyuoy .gt_striped {
  background-color: #f2f2f2;
}

#mafemqyuoy .gt_from_md > :first-child {
  margin-top: 0;
}

#mafemqyuoy .gt_from_md > :last-child {
  margin-bottom: 0;
}

#mafemqyuoy .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#mafemqyuoy .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#mafemqyuoy .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#mafemqyuoy .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#mafemqyuoy .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#mafemqyuoy .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#mafemqyuoy .gt_table_body {
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

#mafemqyuoy .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#mafemqyuoy .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#mafemqyuoy .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#mafemqyuoy .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#mafemqyuoy .gt_center {
  text-align: center;
}

#mafemqyuoy .gt_left {
  text-align: left;
}

#mafemqyuoy .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#mafemqyuoy .gt_font_normal {
  font-weight: normal;
}

#mafemqyuoy .gt_font_bold {
  font-weight: bold;
}

#mafemqyuoy .gt_font_italic {
  font-style: italic;
}

#mafemqyuoy .gt_super {
  font-size: 65%;
}

#mafemqyuoy .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="mafemqyuoy" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 217</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>Coefficient</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Age (years)</td>
      <td class="gt_row gt_center">0.81</td>
      <td class="gt_row gt_center">0.31, 1.3</td>
      <td class="gt_row gt_center">0.002</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Female</td>
      <td class="gt_row gt_center gt_striped">23</td>
      <td class="gt_row gt_center gt_striped">11, 35</td>
      <td class="gt_row gt_center gt_striped"><0.001</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Training miles per week</td>
      <td class="gt_row gt_center">-1.5</td>
      <td class="gt_row gt_center">-1.9, -1.1</td>
      <td class="gt_row gt_center"><0.001</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Weight (kg)</td>
      <td class="gt_row gt_center gt_striped">0.05</td>
      <td class="gt_row gt_center gt_striped">-0.29, 0.39</td>
      <td class="gt_row gt_center gt_striped">0.8</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

A real-life decision you could take away from this is that every additional mile you run in training would be predicted to cut about 1.5 minutes from your marathon time: add a couple of extra five mile runs per week and you’ll shave a quarter of an hour off your time. 

A couple of thoughts. First, you will note that I didn’t remove weight from the model (that is, use a step wise approach) then report the coefficients and p values for the new model (by typing `lm(rt ~ age + sex + tr, data = lesson5a)`).

Second, race time is not normally distributed and the textbooks would have us believe that this invalidates a regression analysis. Let’s try:


```r
# Create variable for log of race time
lesson5a <-
  lesson5a %>%
  mutate(
    lt = log(rt)
  )

# Create linear regression model for log of race time
rtlog_model <- lm(lt ~ age + sex + tr + wt, data = lesson5a)

# Results of linear regression model
summary(rtlog_model)
```

```
## 
## Call:
## lm(formula = lt ~ age + sex + tr + wt, data = lesson5a)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.44858 -0.10750 -0.00080  0.09165  0.58183 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  5.5305274  0.0729321  75.831  < 2e-16 ***
## age          0.0033135  0.0010145   3.266  0.00127 ** 
## sex          0.0980829  0.0240060   4.086 6.23e-05 ***
## tr          -0.0063758  0.0008258  -7.721 4.51e-13 ***
## wt           0.0003336  0.0006829   0.488  0.62570    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.1569 on 212 degrees of freedom
##   (45 observations deleted due to missingness)
## Multiple R-squared:  0.2893,	Adjusted R-squared:  0.2759 
## F-statistic: 21.58 on 4 and 212 DF,  p-value: 5.978e-15
```

This creates a new variable called "lt" that is the log of race time. The Shapiro-Wilk test confirms that this is normally distributed. Now let’s look at the results of the regression analysis: the p values are almost exactly the same. This suggests that the non-normality of race time is not important in this setting.

_For advanced students only_

It might be interesting to compare the coefficients from the untransformed and log transformed models. For example, women are predicted to run about 23 minutes slower on the untransformed model; the coefficient in the log model is 0.098. Backtransform by typing ``exp(0.098)`` and you get 1.10. Remember that backtransforming gives you a proportion. So to work out the difference between men and women in race time, first work out the average men’s time:


```r
# Get the average time for men
lesson5a %>%
  filter(sex == 0) %>% # Select only males
  skim(rt)
```

```
## Skim summary statistics
##  n obs: 190 
##  n variables: 6 
## 
## -- Variable type:numeric --------------------------------------------------------------------------
##  variable missing complete   n   mean    sd  p0 p25 p50 p75 p100     hist
##        rt       1      189 190 238.57 46.63 155 205 235 268  414 ▃▇▇▆▃▂▁▁
```

Then multiply the men's average (238.6) by 1.10 to get the women's time, which gives 263.2.

Subtract one from the other to get 24.6 minutes difference in race time between the sexes. This is very close to the value from the untransformed model.

### lesson5b.rds

**These are data on patients with a disease that predisposes them to cancer. The disease causes precancerous lesions that can be surgically removed. A group of recently removed lesions are analyzed for a specific mutation. Does how long a patient has had the disease affect the chance that a new lesion will have a mutation?**

What you are trying to predict here is binary (mutation / no mutation). You are predicting with a continuous variable (length of disease). So a logistic regression would work nicely. Try:


```r
# Create logistic regression model
mutate_model <- glm(mutation ~ c, data = lesson5b, family = "binomial")

# Formatted results with odds ratios
tbl_regression(mutate_model, exponentiate = TRUE)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#rbpbdnnbet .gt_table {
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

#rbpbdnnbet .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#rbpbdnnbet .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#rbpbdnnbet .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#rbpbdnnbet .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#rbpbdnnbet .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#rbpbdnnbet .gt_col_heading {
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
  overflow-x: hidden;
}

#rbpbdnnbet .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#rbpbdnnbet .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#rbpbdnnbet .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#rbpbdnnbet .gt_group_heading {
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

#rbpbdnnbet .gt_empty_group_heading {
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

#rbpbdnnbet .gt_striped {
  background-color: #f2f2f2;
}

#rbpbdnnbet .gt_from_md > :first-child {
  margin-top: 0;
}

#rbpbdnnbet .gt_from_md > :last-child {
  margin-bottom: 0;
}

#rbpbdnnbet .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#rbpbdnnbet .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#rbpbdnnbet .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#rbpbdnnbet .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#rbpbdnnbet .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#rbpbdnnbet .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#rbpbdnnbet .gt_table_body {
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

#rbpbdnnbet .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#rbpbdnnbet .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#rbpbdnnbet .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#rbpbdnnbet .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#rbpbdnnbet .gt_center {
  text-align: center;
}

#rbpbdnnbet .gt_left {
  text-align: left;
}

#rbpbdnnbet .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#rbpbdnnbet .gt_font_normal {
  font-weight: normal;
}

#rbpbdnnbet .gt_font_bold {
  font-weight: bold;
}

#rbpbdnnbet .gt_font_italic {
  font-style: italic;
}

#rbpbdnnbet .gt_super {
  font-size: 65%;
}

#rbpbdnnbet .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="rbpbdnnbet" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 125</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>OR</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">c</td>
      <td class="gt_row gt_center">0.99</td>
      <td class="gt_row gt_center">0.96, 1.02</td>
      <td class="gt_row gt_center">0.7</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          OR = Odds Ratio, CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

If you get a p-value of around 0.7, you haven't been inspecting your data. One patient has apparently had the disease for 154 years. Either this is a freak of nature or the study assistant meant to type 14 or 15. You need to delete this observation from the dataset and try the model again:


```r
# Use "filter" to exclude patients with outlying disease duration
lesson5b <-
  lesson5b %>%
  filter(c <= 50)

# Create logistic regression model
mutate_model <- glm(mutation ~ c, data = lesson5b, family = "binomial")

# Formatted results with odds ratios
tbl_regression(mutate_model, exponentiate = TRUE)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#jrdysgpclz .gt_table {
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

#jrdysgpclz .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#jrdysgpclz .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#jrdysgpclz .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#jrdysgpclz .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#jrdysgpclz .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#jrdysgpclz .gt_col_heading {
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
  overflow-x: hidden;
}

#jrdysgpclz .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#jrdysgpclz .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#jrdysgpclz .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#jrdysgpclz .gt_group_heading {
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

#jrdysgpclz .gt_empty_group_heading {
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

#jrdysgpclz .gt_striped {
  background-color: #f2f2f2;
}

#jrdysgpclz .gt_from_md > :first-child {
  margin-top: 0;
}

#jrdysgpclz .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jrdysgpclz .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#jrdysgpclz .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#jrdysgpclz .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#jrdysgpclz .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#jrdysgpclz .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#jrdysgpclz .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#jrdysgpclz .gt_table_body {
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

#jrdysgpclz .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#jrdysgpclz .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#jrdysgpclz .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#jrdysgpclz .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#jrdysgpclz .gt_center {
  text-align: center;
}

#jrdysgpclz .gt_left {
  text-align: left;
}

#jrdysgpclz .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jrdysgpclz .gt_font_normal {
  font-weight: normal;
}

#jrdysgpclz .gt_font_bold {
  font-weight: bold;
}

#jrdysgpclz .gt_font_italic {
  font-style: italic;
}

#jrdysgpclz .gt_super {
  font-size: 65%;
}

#jrdysgpclz .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="jrdysgpclz" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 124</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>OR</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">c</td>
      <td class="gt_row gt_center">1.14</td>
      <td class="gt_row gt_center">1.03, 1.27</td>
      <td class="gt_row gt_center">0.014</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          OR = Odds Ratio, CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->


```r
# Formatted results in logits
tbl_regression(mutate_model, exponentiate = FALSE)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#tusbkbxopk .gt_table {
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

#tusbkbxopk .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#tusbkbxopk .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#tusbkbxopk .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#tusbkbxopk .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#tusbkbxopk .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#tusbkbxopk .gt_col_heading {
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
  overflow-x: hidden;
}

#tusbkbxopk .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#tusbkbxopk .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#tusbkbxopk .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#tusbkbxopk .gt_group_heading {
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

#tusbkbxopk .gt_empty_group_heading {
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

#tusbkbxopk .gt_striped {
  background-color: #f2f2f2;
}

#tusbkbxopk .gt_from_md > :first-child {
  margin-top: 0;
}

#tusbkbxopk .gt_from_md > :last-child {
  margin-bottom: 0;
}

#tusbkbxopk .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#tusbkbxopk .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#tusbkbxopk .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#tusbkbxopk .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#tusbkbxopk .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#tusbkbxopk .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#tusbkbxopk .gt_table_body {
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

#tusbkbxopk .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#tusbkbxopk .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#tusbkbxopk .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#tusbkbxopk .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#tusbkbxopk .gt_center {
  text-align: center;
}

#tusbkbxopk .gt_left {
  text-align: left;
}

#tusbkbxopk .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#tusbkbxopk .gt_font_normal {
  font-weight: normal;
}

#tusbkbxopk .gt_font_bold {
  font-weight: bold;
}

#tusbkbxopk .gt_font_italic {
  font-style: italic;
}

#tusbkbxopk .gt_super {
  font-size: 65%;
}

#tusbkbxopk .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="tusbkbxopk" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 124</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>log(OR)</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">c</td>
      <td class="gt_row gt_center">0.13</td>
      <td class="gt_row gt_center">0.03, 0.24</td>
      <td class="gt_row gt_center">0.014</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          OR = Odds Ratio, CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->



After fixing the data, you will now find an association (p=0.014). Using the `tbl_regression` function, you get an odds ratio of 1.14, meaning that the odds of having a mutation increase by 1.14 each year.

You can get the coefficients in logits from the `tbl_regression` function by using the `exponentiate = FALSE` option.


```r
# Results in logits
# The "intercept = TRUE" option includes the constant in the table
tbl_regression(mutate_model,
               exponentiate = FALSE,
               intercept = TRUE)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#mbchtzpmbb .gt_table {
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

#mbchtzpmbb .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#mbchtzpmbb .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#mbchtzpmbb .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#mbchtzpmbb .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#mbchtzpmbb .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#mbchtzpmbb .gt_col_heading {
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
  overflow-x: hidden;
}

#mbchtzpmbb .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#mbchtzpmbb .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#mbchtzpmbb .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#mbchtzpmbb .gt_group_heading {
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

#mbchtzpmbb .gt_empty_group_heading {
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

#mbchtzpmbb .gt_striped {
  background-color: #f2f2f2;
}

#mbchtzpmbb .gt_from_md > :first-child {
  margin-top: 0;
}

#mbchtzpmbb .gt_from_md > :last-child {
  margin-bottom: 0;
}

#mbchtzpmbb .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#mbchtzpmbb .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#mbchtzpmbb .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#mbchtzpmbb .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#mbchtzpmbb .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#mbchtzpmbb .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#mbchtzpmbb .gt_table_body {
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

#mbchtzpmbb .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#mbchtzpmbb .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#mbchtzpmbb .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#mbchtzpmbb .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#mbchtzpmbb .gt_center {
  text-align: center;
}

#mbchtzpmbb .gt_left {
  text-align: left;
}

#mbchtzpmbb .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#mbchtzpmbb .gt_font_normal {
  font-weight: normal;
}

#mbchtzpmbb .gt_font_bold {
  font-weight: bold;
}

#mbchtzpmbb .gt_font_italic {
  font-style: italic;
}

#mbchtzpmbb .gt_super {
  font-size: 65%;
}

#mbchtzpmbb .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="mbchtzpmbb" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 124</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>log(OR)</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">(Intercept)</td>
      <td class="gt_row gt_center">-0.94</td>
      <td class="gt_row gt_center">-2.0, 0.08</td>
      <td class="gt_row gt_center">0.076</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">c</td>
      <td class="gt_row gt_center gt_striped">0.13</td>
      <td class="gt_row gt_center gt_striped">0.03, 0.24</td>
      <td class="gt_row gt_center gt_striped">0.014</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          OR = Odds Ratio, CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

This gives a coefficient of 0.13 and a constant of -0.94. This can be used to make a specific prediction using the equation below ("l" stands for the log odds).

$p = e^l / (e^l+1)$

Take someone who has had the disease for 10 years. Their logit is 10 times the coefficient of 0.13 minus the constant -0.94 to give 0.37. Plug 0.37 into the equation (``exp(0.37)/(exp(0.37)+1)``) and you get 59%. Someone who has had the disease for 3 years has a logit of -0.55 giving a risk (``exp(-0.55)/(exp(-0.55)+1)``) of 37%.

If you wanted to get flashy, you could work out the risk for each year between 2 and 18 and get a graph. But R can do this automatically for you: you can create a variable with the risk of mutation for each observation based on the duration of disease using the `augment` function. The column that contains the risk is called ".fitted". Since this is a logistic regression model, we also need to specify `type.predict = "response"` to get the predicted probabilities.


```r
# Create predictions
lesson5b_pred <-
  augment(mutate_model,
          type.predict = "response")

# Show resulting dataset
lesson5b_pred
```

```
## # A tibble: 124 x 9
##    mutation     c .fitted .se.fit .resid    .hat .sigma .cooksd .std.resid
##       <dbl> <dbl>   <dbl>   <dbl>  <dbl>   <dbl>  <dbl>   <dbl>      <dbl>
##  1        1    11   0.623  0.0488  0.973 0.0101    1.16 0.00313      0.978
##  2        0     6   0.462  0.0637 -1.11  0.0163    1.16 0.00723     -1.12 
##  3        1    12   0.653  0.0535  0.923 0.0126    1.16 0.00344      0.929
##  4        1     9   0.559  0.0461  1.08  0.00862   1.16 0.00345      1.08 
##  5        0    13   0.682  0.0590 -1.51  0.0161    1.15 0.0178      -1.53 
##  6        1     9   0.559  0.0461  1.08  0.00862   1.16 0.00345      1.08 
##  7        0     8   0.527  0.0495 -1.22  0.00984   1.15 0.00559     -1.23 
##  8        1     6   0.462  0.0637  1.24  0.0163    1.15 0.00984      1.25 
##  9        0    11   0.623  0.0488 -1.40  0.0101    1.15 0.00852     -1.40 
## 10        0     4   0.397  0.0811 -1.01  0.0275    1.16 0.00958     -1.02 
## # ... with 114 more rows
```

```r
# Graph over disease duration
# Tells the plot what data and variables to use
ggplot(data = lesson5b_pred, aes(x = c, y = .fitted)) +
  # Creates the line portion of the graph
  geom_line() +
  # Creates the points along the line
  geom_point() +
  # Labels the x and y axes
  labs(
    x = "Disease duration",
    y = "Risk of mutation"
  )
```

<img src="09-answers_files/figure-html/week5l-1.png" width="672" />

You can also use the `augment` function for linear regression and multivariable models. One other interesting thing you can do is to make "out of sample" predictions.

Try this:


```r
# Reopen lesson5b dataset
lesson5b <- readRDS(here::here("Data", "Week 5", "lesson5b.rds"))

# Use original logistic regression model
tbl_regression(mutate_model, exponentiate = TRUE)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#yzwkzlhjln .gt_table {
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

#yzwkzlhjln .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#yzwkzlhjln .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#yzwkzlhjln .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#yzwkzlhjln .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#yzwkzlhjln .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#yzwkzlhjln .gt_col_heading {
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
  overflow-x: hidden;
}

#yzwkzlhjln .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#yzwkzlhjln .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#yzwkzlhjln .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#yzwkzlhjln .gt_group_heading {
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

#yzwkzlhjln .gt_empty_group_heading {
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

#yzwkzlhjln .gt_striped {
  background-color: #f2f2f2;
}

#yzwkzlhjln .gt_from_md > :first-child {
  margin-top: 0;
}

#yzwkzlhjln .gt_from_md > :last-child {
  margin-bottom: 0;
}

#yzwkzlhjln .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#yzwkzlhjln .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#yzwkzlhjln .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#yzwkzlhjln .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#yzwkzlhjln .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#yzwkzlhjln .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#yzwkzlhjln .gt_table_body {
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

#yzwkzlhjln .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#yzwkzlhjln .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#yzwkzlhjln .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#yzwkzlhjln .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#yzwkzlhjln .gt_center {
  text-align: center;
}

#yzwkzlhjln .gt_left {
  text-align: left;
}

#yzwkzlhjln .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#yzwkzlhjln .gt_font_normal {
  font-weight: normal;
}

#yzwkzlhjln .gt_font_bold {
  font-weight: bold;
}

#yzwkzlhjln .gt_font_italic {
  font-style: italic;
}

#yzwkzlhjln .gt_super {
  font-size: 65%;
}

#yzwkzlhjln .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="yzwkzlhjln" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 124</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>OR</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">c</td>
      <td class="gt_row gt_center">1.14</td>
      <td class="gt_row gt_center">1.03, 1.27</td>
      <td class="gt_row gt_center">0.014</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          OR = Odds Ratio, CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->


```r
# Create new values for "c" (disease duration)
lesson5b_new <-
  lesson5b %>%
  mutate(c = 1:n()/3)
# "1:n()" gives the observation number for each observation
# Replace c with observation number / 3 gives a list of simulated
# disease durations between 0.33 and 42.33.

# Predict risk of mutation
# The "newdata" option allows you to get predictions for a dataset
# other than the dataset that was used to create the model
lesson5b_pred_new <-
  augment(mutate_model,
          newdata = lesson5b_new,
          type.predict = "response")

# Create graph
ggplot(data = lesson5b_pred_new,
       aes(x = c, y = .fitted)) +
  geom_line()
```

<img src="09-answers_files/figure-html/week5n-1.png" width="672" />

### lesson5c.rds

**These are data from Canadian provinces giving population, unemployment rates and male and female life expectancy. Which of these variables are associated?**

A key first question: what are we likely to be interested in? For example, total population and unemployment rate will have no illuminating relationship whatsoever and we wouldn’t want to analyze the association between these two. The link between unemployment and life expectancy seems more interesting. Before we start doing the analysis however, we need to look at the data.


```r
# Open up dataset to view observations
View(lesson5c)
```

It seems that there are not only data for each province separately but for Canada as a whole. Clearly we would have to delete this row as it is not an independent observation.


```r
# Remove the observation for all of Canada from dataset
lesson5c_fixed <-
  lesson5c %>%
  filter(place != "Canada")
```

Now, we could just correlate the three variables together: 


```r
# Calculate correlation between unemployment and male/female life expectancy
# There are missing values for unemployment,
# so we need to indicate that we only want to use "complete observations"
cor(lesson5c_fixed %>% select(unemp, mlife, flife),
    use = "complete.obs")
```

```
##            unemp      mlife      flife
## unemp  1.0000000 -0.7413079 -0.6152419
## mlife -0.7413079  1.0000000  0.7619491
## flife -0.6152419  0.7619491  1.0000000
```

This tells you that unemployment rates are negatively correlated with life expectancy (i.e. the higher the unemployment rate, the lower the life expectancy), that this effect seems stronger for men than for women and that male and female life expectancy are strongly correlated.

We might also want to go on and do some regressions. We probably wouldn’t ever want to predict the unemployment rate on the basis of life expectancy, but the opposite case is indeed of interest: we might want to know, for example, what effect a 1% drop in unemployment rate might have on life expectancy. 

Try these regression models:


```r
# Create linear regression model for male life expectancy
mlife_model <- lm(mlife ~ unemp, data = lesson5c_fixed)
tbl_regression(mlife_model)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#gnbvekovad .gt_table {
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

#gnbvekovad .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#gnbvekovad .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#gnbvekovad .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#gnbvekovad .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#gnbvekovad .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#gnbvekovad .gt_col_heading {
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
  overflow-x: hidden;
}

#gnbvekovad .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#gnbvekovad .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#gnbvekovad .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#gnbvekovad .gt_group_heading {
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

#gnbvekovad .gt_empty_group_heading {
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

#gnbvekovad .gt_striped {
  background-color: #f2f2f2;
}

#gnbvekovad .gt_from_md > :first-child {
  margin-top: 0;
}

#gnbvekovad .gt_from_md > :last-child {
  margin-bottom: 0;
}

#gnbvekovad .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#gnbvekovad .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#gnbvekovad .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#gnbvekovad .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#gnbvekovad .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#gnbvekovad .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#gnbvekovad .gt_table_body {
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

#gnbvekovad .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#gnbvekovad .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#gnbvekovad .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#gnbvekovad .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#gnbvekovad .gt_center {
  text-align: center;
}

#gnbvekovad .gt_left {
  text-align: left;
}

#gnbvekovad .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#gnbvekovad .gt_font_normal {
  font-weight: normal;
}

#gnbvekovad .gt_font_bold {
  font-weight: bold;
}

#gnbvekovad .gt_font_italic {
  font-style: italic;
}

#gnbvekovad .gt_super {
  font-size: 65%;
}

#gnbvekovad .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="gnbvekovad" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 10</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>Coefficient</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">% 15+ population unemployed, 1995</td>
      <td class="gt_row gt_center">-0.10</td>
      <td class="gt_row gt_center">-0.18, -0.03</td>
      <td class="gt_row gt_center">0.014</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->


```r
# Create linear regression model for female life expectancy
flife_model <- lm(flife ~ unemp, data = lesson5c_fixed)
tbl_regression(flife_model)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#kijudtsfwn .gt_table {
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

#kijudtsfwn .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#kijudtsfwn .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#kijudtsfwn .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#kijudtsfwn .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#kijudtsfwn .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#kijudtsfwn .gt_col_heading {
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
  overflow-x: hidden;
}

#kijudtsfwn .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#kijudtsfwn .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#kijudtsfwn .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#kijudtsfwn .gt_group_heading {
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

#kijudtsfwn .gt_empty_group_heading {
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

#kijudtsfwn .gt_striped {
  background-color: #f2f2f2;
}

#kijudtsfwn .gt_from_md > :first-child {
  margin-top: 0;
}

#kijudtsfwn .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kijudtsfwn .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#kijudtsfwn .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#kijudtsfwn .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#kijudtsfwn .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#kijudtsfwn .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#kijudtsfwn .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#kijudtsfwn .gt_table_body {
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

#kijudtsfwn .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#kijudtsfwn .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#kijudtsfwn .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#kijudtsfwn .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#kijudtsfwn .gt_center {
  text-align: center;
}

#kijudtsfwn .gt_left {
  text-align: left;
}

#kijudtsfwn .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#kijudtsfwn .gt_font_normal {
  font-weight: normal;
}

#kijudtsfwn .gt_font_bold {
  font-weight: bold;
}

#kijudtsfwn .gt_font_italic {
  font-style: italic;
}

#kijudtsfwn .gt_super {
  font-size: 65%;
}

#kijudtsfwn .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="kijudtsfwn" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 10</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>Coefficient</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">% 15+ population unemployed, 1995</td>
      <td class="gt_row gt_center">-0.08</td>
      <td class="gt_row gt_center">-0.17, 0.00</td>
      <td class="gt_row gt_center">0.058</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

The coefficients you get (-0.10 for men and -0.08 for women) suggest that a 5% drop in unemployment is associated with about a 6 month increase in life expectancy, in other words, a small effect.

Interesting question: should you also report a p value and 95% confidence interval for the coefficients? The answer is no. This is because Canadian provinces are not some random sample from a large theoretical population of Canadian provinces. You have all the data. So questions of inference (i.e. p values) and uncertainty (i.e. 95% confidence intervals) don’t come into it.

Even more interesting question: the conclusion of a 5% drop in unemployment being associated with a 6 month increase in life expectancy is based on a causal relationship, that is, we believe that changes in unemployment _cause_ changes in life expectancy. This is not implausible: unemployment leads to poverty and depression, both of which reduce life expectancy. However, a causal relationship cannot be assumed. For example, it may be that life expectancy is lower in certain areas of the country (due to eating patterns or ethnic differences) that also happen to suffer higher unemployment. 

### lesson5d.rds

**These are data from mice inoculated with tumor cells and then treated with different doses of a drug. The growth rate of each animal’s tumor is then calculated. Is this drug effective?**

This is a straightforward linear regression that shows a significant decrease in log tumor size with increasing dose.


```r
# Create linear regression model for tumor size
tumorsize_model <- lm(s ~ dose, data = lesson5d)
summary(tumorsize_model)
```

```
## 
## Call:
## lm(formula = s ~ dose, data = lesson5d)
## 
## Residuals:
##       Min        1Q    Median        3Q       Max 
## -0.026182 -0.010515 -0.005768  0.009948  0.050698 
## 
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  5.272e-02  5.376e-03   9.807 1.19e-07 ***
## dose        -7.986e-05  2.674e-05  -2.986  0.00982 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.01793 on 14 degrees of freedom
## Multiple R-squared:  0.3891,	Adjusted R-squared:  0.3454 
## F-statistic: 8.916 on 1 and 14 DF,  p-value: 0.00982
```

A couple of thoughts. Firstly, this rather obvious analysis is not often conducted in lab research. Typically, researchers present pairwise comparisons between each dose and control. For example, see the following typical diagram. Each of the p values compares the dose to control. The problem with such an approach is that you end up with multiple p values (instead of just one) and that each test takes place in a vacuum: the p value of a comparison between no treatment and, say, dose level 3, is the same regardless of whether there were 2 dose levels in the experiment, or 100, and whether all other dose levels showed an effect or did not. A regression analysis gives you a single p value and uses all data in one analysis.

<img src="09-answers_files/figure-html/week5u-1.png" width="384" />

A second thought: should you report the coefficient of -0.00008? This can be interpreted as "for each increase in dose of one unit, increase in log tumor size is less by -0.00008". I would argue that this coefficient might misleading because you only have a few doses and they are widely spaced. Also, dose-response is often non-linear: it generally takes a sigmoidal curve (see below). In short, you might have too few data to be confident about a linear prediction. Finally, it is rare that you really want to estimate the effects of a treatment on a mouse: generally, laboratory studies are about testing hypotheses.

<img src="09-answers_files/figure-html/week5v-1.png" width="384" />

My model answer would be:

<div class="quote-container">

>Mean increase in log tumor size per day by dose is given in the table. Higher doses were associated with lower growth rates (p=0.010 by linear regression).

</div>

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#bvxaujwtra .gt_table {
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

#bvxaujwtra .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#bvxaujwtra .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#bvxaujwtra .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#bvxaujwtra .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#bvxaujwtra .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#bvxaujwtra .gt_col_heading {
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
  overflow-x: hidden;
}

#bvxaujwtra .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#bvxaujwtra .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#bvxaujwtra .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#bvxaujwtra .gt_group_heading {
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

#bvxaujwtra .gt_empty_group_heading {
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

#bvxaujwtra .gt_striped {
  background-color: #f2f2f2;
}

#bvxaujwtra .gt_from_md > :first-child {
  margin-top: 0;
}

#bvxaujwtra .gt_from_md > :last-child {
  margin-bottom: 0;
}

#bvxaujwtra .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#bvxaujwtra .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#bvxaujwtra .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#bvxaujwtra .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#bvxaujwtra .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#bvxaujwtra .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#bvxaujwtra .gt_table_body {
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

#bvxaujwtra .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#bvxaujwtra .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#bvxaujwtra .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#bvxaujwtra .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#bvxaujwtra .gt_center {
  text-align: center;
}

#bvxaujwtra .gt_left {
  text-align: left;
}

#bvxaujwtra .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#bvxaujwtra .gt_font_normal {
  font-weight: normal;
}

#bvxaujwtra .gt_font_bold {
  font-weight: bold;
}

#bvxaujwtra .gt_font_italic {
  font-style: italic;
}

#bvxaujwtra .gt_super {
  font-size: 65%;
}

#bvxaujwtra .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="bvxaujwtra" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1">Dose</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1">Mean (SD)</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_right">0</td>
      <td class="gt_row gt_left">0.069 (0.025)</td>
    </tr>
    <tr>
      <td class="gt_row gt_right gt_striped">4</td>
      <td class="gt_row gt_left gt_striped">0.046 (0.016)</td>
    </tr>
    <tr>
      <td class="gt_row gt_right">40</td>
      <td class="gt_row gt_left">0.039 (0.001)</td>
    </tr>
    <tr>
      <td class="gt_row gt_right gt_striped">400</td>
      <td class="gt_row gt_left gt_striped">0.022 (0.009)</td>
    </tr>
  </body>
  
  
</table></div><!--/html_preserve-->

### lesson5e.rds

**These are data from a study of the use of complementary medicine (e.g. massage) by UK breast cancer patients. There are data for the women’s age, time since diagnosis, presence of distant metastases, use of complementary medicine before diagnosis, whether they received a qualification after high school, the age they left education, whether usual employment is a manual trade, socioeconomic status. What predicts use of complementary medicine by women with breast cancer?**

This is a fairly simple analysis: the outcome is binary and as we want to make predictions we are going to want a logistic regression. It would be tempting just to throw all the variables into the analysis:


```r
# Create multivariable logistic regression model for CAM
cam_model1 <- glm(CAM ~ age + t + mets + u + q18 + e + m + ses,
                  data = lesson5e,
                  family = "binomial")
tbl_regression(cam_model1, exponentiate = TRUE)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#oedswpdpir .gt_table {
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

#oedswpdpir .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#oedswpdpir .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#oedswpdpir .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#oedswpdpir .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#oedswpdpir .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#oedswpdpir .gt_col_heading {
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
  overflow-x: hidden;
}

#oedswpdpir .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#oedswpdpir .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#oedswpdpir .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#oedswpdpir .gt_group_heading {
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

#oedswpdpir .gt_empty_group_heading {
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

#oedswpdpir .gt_striped {
  background-color: #f2f2f2;
}

#oedswpdpir .gt_from_md > :first-child {
  margin-top: 0;
}

#oedswpdpir .gt_from_md > :last-child {
  margin-bottom: 0;
}

#oedswpdpir .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#oedswpdpir .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#oedswpdpir .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#oedswpdpir .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#oedswpdpir .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#oedswpdpir .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#oedswpdpir .gt_table_body {
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

#oedswpdpir .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#oedswpdpir .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#oedswpdpir .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#oedswpdpir .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#oedswpdpir .gt_center {
  text-align: center;
}

#oedswpdpir .gt_left {
  text-align: left;
}

#oedswpdpir .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#oedswpdpir .gt_font_normal {
  font-weight: normal;
}

#oedswpdpir .gt_font_bold {
  font-weight: bold;
}

#oedswpdpir .gt_font_italic {
  font-style: italic;
}

#oedswpdpir .gt_super {
  font-size: 65%;
}

#oedswpdpir .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="oedswpdpir" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 438</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>OR</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">age</td>
      <td class="gt_row gt_center">0.97</td>
      <td class="gt_row gt_center">0.95, 0.99</td>
      <td class="gt_row gt_center">0.004</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">time since diagnosis</td>
      <td class="gt_row gt_center gt_striped">1.02</td>
      <td class="gt_row gt_center gt_striped">0.91, 1.15</td>
      <td class="gt_row gt_center gt_striped">0.7</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">distant metastases?</td>
      <td class="gt_row gt_center">1.45</td>
      <td class="gt_row gt_center">0.12, 15.3</td>
      <td class="gt_row gt_center">0.8</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">used CAM before diagnosis?</td>
      <td class="gt_row gt_center gt_striped">7.40</td>
      <td class="gt_row gt_center gt_striped">4.23, 13.5</td>
      <td class="gt_row gt_center gt_striped"><0.001</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">qualifications after 18?</td>
      <td class="gt_row gt_center">2.07</td>
      <td class="gt_row gt_center">1.16, 3.73</td>
      <td class="gt_row gt_center">0.015</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">age left education</td>
      <td class="gt_row gt_center gt_striped">0.93</td>
      <td class="gt_row gt_center gt_striped">0.83, 1.02</td>
      <td class="gt_row gt_center gt_striped">0.2</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">manual trade?</td>
      <td class="gt_row gt_center">1.19</td>
      <td class="gt_row gt_center">0.39, 3.61</td>
      <td class="gt_row gt_center">0.8</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">socioeconomic status 1 - 5</td>
      <td class="gt_row gt_center gt_striped">0.81</td>
      <td class="gt_row gt_center gt_striped">0.54, 1.22</td>
      <td class="gt_row gt_center gt_striped">0.3</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          OR = Odds Ratio, CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

This would suggest that the strongest predictor is whether women used complementary medicine before diagnosis and that two other variables are predictive: women with a qualification after leaving high school are more likely to use complementary medicine, but use declines with age (older people are more conservative, or alternatively, wiser, depending on your point of view.)

However...

Should we just throw everything in the model? For example, only 6 patients have distant metastases. Secondly, many of the variables seem highly correlated. For example, age at which the patient left education and whether they received a qualification after the age of 18 are highly correlated as are socioeconomic status and whether the patient’s job is a manual trade. In clinical terms, you wouldn’t need to know the age that someone left education if you already knew whether they had a post-high school qualification. And as would be intuitive, regression does not deal well with correlated variables. To take an extreme example, take two variables "x" which is equal to height, and "y" which is equal to height plus 1 inch. These have a correlation of one. Regressing just variable x or y on shoe size you get:

$shoesize = 0.6*x - 30$

or

$shoesize = 0.6*y - 31$

What would you get for regressing x and y? Any of the following are possible:

$shoesize = 0.3*x + 0.3*y - 30.5$

$shoesize = 0.4*x + 0.2*y - 30.5$

$shoesize = 0.1*x + 0.5*y - 30.5$

There is no way of telling these apart in terms of regression. Bottom line: care is needed with correlated variables both in a clinical  / scientific sense (you don’t need both of two correlated variables in a model) and a statistical sense (regression results can be misleading).

So I would start with the full model and then remove the least predictive of socioeconomic status and manual trade, and the least predictive of qualification and age left education. You end up with:


```r
# Create logistic regression model for CAM removing "e" and "m"
cam_model2 <- glm(CAM ~ age + t + mets + u + q18 + ses,
                  data = lesson5e,
                  family = "binomial")
tbl_regression(cam_model2, exponentiate = TRUE)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#tnlmxmpshf .gt_table {
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

#tnlmxmpshf .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#tnlmxmpshf .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#tnlmxmpshf .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#tnlmxmpshf .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#tnlmxmpshf .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#tnlmxmpshf .gt_col_heading {
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
  overflow-x: hidden;
}

#tnlmxmpshf .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#tnlmxmpshf .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#tnlmxmpshf .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#tnlmxmpshf .gt_group_heading {
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

#tnlmxmpshf .gt_empty_group_heading {
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

#tnlmxmpshf .gt_striped {
  background-color: #f2f2f2;
}

#tnlmxmpshf .gt_from_md > :first-child {
  margin-top: 0;
}

#tnlmxmpshf .gt_from_md > :last-child {
  margin-bottom: 0;
}

#tnlmxmpshf .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#tnlmxmpshf .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#tnlmxmpshf .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#tnlmxmpshf .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#tnlmxmpshf .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#tnlmxmpshf .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#tnlmxmpshf .gt_table_body {
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

#tnlmxmpshf .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#tnlmxmpshf .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#tnlmxmpshf .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#tnlmxmpshf .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#tnlmxmpshf .gt_center {
  text-align: center;
}

#tnlmxmpshf .gt_left {
  text-align: left;
}

#tnlmxmpshf .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#tnlmxmpshf .gt_font_normal {
  font-weight: normal;
}

#tnlmxmpshf .gt_font_bold {
  font-weight: bold;
}

#tnlmxmpshf .gt_font_italic {
  font-style: italic;
}

#tnlmxmpshf .gt_super {
  font-size: 65%;
}

#tnlmxmpshf .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="tnlmxmpshf" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 445</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>OR</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">age</td>
      <td class="gt_row gt_center">0.97</td>
      <td class="gt_row gt_center">0.95, 0.99</td>
      <td class="gt_row gt_center">0.004</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">time since diagnosis</td>
      <td class="gt_row gt_center gt_striped">1.02</td>
      <td class="gt_row gt_center gt_striped">0.91, 1.15</td>
      <td class="gt_row gt_center gt_striped">0.7</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">distant metastases?</td>
      <td class="gt_row gt_center">1.36</td>
      <td class="gt_row gt_center">0.11, 14.8</td>
      <td class="gt_row gt_center">0.8</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">used CAM before diagnosis?</td>
      <td class="gt_row gt_center gt_striped">7.21</td>
      <td class="gt_row gt_center gt_striped">4.16, 12.9</td>
      <td class="gt_row gt_center gt_striped"><0.001</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">qualifications after 18?</td>
      <td class="gt_row gt_center">1.71</td>
      <td class="gt_row gt_center">1.04, 2.80</td>
      <td class="gt_row gt_center">0.033</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">socioeconomic status 1 - 5</td>
      <td class="gt_row gt_center gt_striped">0.88</td>
      <td class="gt_row gt_center gt_striped">0.73, 1.07</td>
      <td class="gt_row gt_center gt_striped">0.2</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          OR = Odds Ratio, CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

Now it appears that "q18" is predictive but not "ses". So try removing one of these from the model in turn:


```r
# Create logistic regression model for CAM removing "q18"
cam_model3 <- glm(CAM ~ age + t + mets + u + ses,
                  data = lesson5e,
                  family = "binomial")
tbl_regression(cam_model3, exponentiate = TRUE)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#sjkurdayvt .gt_table {
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

#sjkurdayvt .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#sjkurdayvt .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#sjkurdayvt .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#sjkurdayvt .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#sjkurdayvt .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#sjkurdayvt .gt_col_heading {
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
  overflow-x: hidden;
}

#sjkurdayvt .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#sjkurdayvt .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#sjkurdayvt .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#sjkurdayvt .gt_group_heading {
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

#sjkurdayvt .gt_empty_group_heading {
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

#sjkurdayvt .gt_striped {
  background-color: #f2f2f2;
}

#sjkurdayvt .gt_from_md > :first-child {
  margin-top: 0;
}

#sjkurdayvt .gt_from_md > :last-child {
  margin-bottom: 0;
}

#sjkurdayvt .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#sjkurdayvt .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#sjkurdayvt .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#sjkurdayvt .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#sjkurdayvt .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#sjkurdayvt .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#sjkurdayvt .gt_table_body {
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

#sjkurdayvt .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#sjkurdayvt .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#sjkurdayvt .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#sjkurdayvt .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#sjkurdayvt .gt_center {
  text-align: center;
}

#sjkurdayvt .gt_left {
  text-align: left;
}

#sjkurdayvt .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#sjkurdayvt .gt_font_normal {
  font-weight: normal;
}

#sjkurdayvt .gt_font_bold {
  font-weight: bold;
}

#sjkurdayvt .gt_font_italic {
  font-style: italic;
}

#sjkurdayvt .gt_super {
  font-size: 65%;
}

#sjkurdayvt .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="sjkurdayvt" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 459</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>OR</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">age</td>
      <td class="gt_row gt_center">0.97</td>
      <td class="gt_row gt_center">0.95, 0.99</td>
      <td class="gt_row gt_center">0.002</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">time since diagnosis</td>
      <td class="gt_row gt_center gt_striped">1.04</td>
      <td class="gt_row gt_center gt_striped">0.93, 1.17</td>
      <td class="gt_row gt_center gt_striped">0.5</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">distant metastases?</td>
      <td class="gt_row gt_center">1.23</td>
      <td class="gt_row gt_center">0.10, 13.4</td>
      <td class="gt_row gt_center">0.9</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">used CAM before diagnosis?</td>
      <td class="gt_row gt_center gt_striped">7.65</td>
      <td class="gt_row gt_center gt_striped">4.45, 13.6</td>
      <td class="gt_row gt_center gt_striped"><0.001</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">socioeconomic status 1 - 5</td>
      <td class="gt_row gt_center">0.78</td>
      <td class="gt_row gt_center">0.66, 0.93</td>
      <td class="gt_row gt_center">0.005</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          OR = Odds Ratio, CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->


```r
# Create logistic regression model for CAM removing "ses"
cam_model4 <- glm(CAM ~ age + t + mets + u + q18,
                  data = lesson5e,
                  family = "binomial")
tbl_regression(cam_model4, exponentiate = TRUE)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#ajfhjtutgr .gt_table {
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

#ajfhjtutgr .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#ajfhjtutgr .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#ajfhjtutgr .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ajfhjtutgr .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#ajfhjtutgr .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#ajfhjtutgr .gt_col_heading {
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
  overflow-x: hidden;
}

#ajfhjtutgr .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#ajfhjtutgr .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#ajfhjtutgr .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#ajfhjtutgr .gt_group_heading {
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

#ajfhjtutgr .gt_empty_group_heading {
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

#ajfhjtutgr .gt_striped {
  background-color: #f2f2f2;
}

#ajfhjtutgr .gt_from_md > :first-child {
  margin-top: 0;
}

#ajfhjtutgr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ajfhjtutgr .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#ajfhjtutgr .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#ajfhjtutgr .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#ajfhjtutgr .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#ajfhjtutgr .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#ajfhjtutgr .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#ajfhjtutgr .gt_table_body {
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

#ajfhjtutgr .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#ajfhjtutgr .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#ajfhjtutgr .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#ajfhjtutgr .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#ajfhjtutgr .gt_center {
  text-align: center;
}

#ajfhjtutgr .gt_left {
  text-align: left;
}

#ajfhjtutgr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ajfhjtutgr .gt_font_normal {
  font-weight: normal;
}

#ajfhjtutgr .gt_font_bold {
  font-weight: bold;
}

#ajfhjtutgr .gt_font_italic {
  font-style: italic;
}

#ajfhjtutgr .gt_super {
  font-size: 65%;
}

#ajfhjtutgr .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ajfhjtutgr" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 651</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>OR</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">age</td>
      <td class="gt_row gt_center">0.96</td>
      <td class="gt_row gt_center">0.94, 0.97</td>
      <td class="gt_row gt_center"><0.001</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">time since diagnosis</td>
      <td class="gt_row gt_center gt_striped">1.01</td>
      <td class="gt_row gt_center gt_striped">0.92, 1.12</td>
      <td class="gt_row gt_center gt_striped">0.8</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">distant metastases?</td>
      <td class="gt_row gt_center">0.85</td>
      <td class="gt_row gt_center">0.08, 6.83</td>
      <td class="gt_row gt_center">0.9</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">used CAM before diagnosis?</td>
      <td class="gt_row gt_center gt_striped">7.32</td>
      <td class="gt_row gt_center gt_striped">4.48, 12.3</td>
      <td class="gt_row gt_center gt_striped"><0.001</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">qualifications after 18?</td>
      <td class="gt_row gt_center">1.90</td>
      <td class="gt_row gt_center">1.28, 2.82</td>
      <td class="gt_row gt_center">0.002</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          OR = Odds Ratio, CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

It turns out that both are predictive independently, but not together. When you think about this, it is because socioeconomic status is correlated with education. The most sensible thing to do is to leave "q18" in the model as a) it is slightly more predictive and b) it is easier to ask about; c) there are fewer missing data. As such, my model answer might be:

<div class="quote-container">

>There were responses from 714 women, of whom  had data adequate for analysis. There were more missing data for socioeconomic status but this was not included in the final model. In a multivariable model, use of complementary medicine before diagnosis was the strongest predictor of complementary medicine use in women with breast cancer, odds ratio 7.32 (95% CI 4.48, 12.3; p<0.001). Complementary medicine use was related to education. The odds of a woman with a qualification received after the age of 18 using complementary medicine were 1.90 (95% CI 1.28, 2.82; p=0.002) those of women without a qualification after high school. In a univariate model, higher socioeconomic status predicted use of complementary medicine, but this was dropped from the multivariable model due to collinearity with educational achievement. Older women were less likely to use complementary medicine (odds ratio 0.96 for a one-year increase in age; 95% CI 0.94, 0.97, p<0.001). There was no statistically significant effect of time since diagnosis (odds ratio 1.01 per year; 95% CI 0.92, 1.12, p=0.8). This suggests that breast cancer patients who use complementary medicine are likely to start doing so shortly after diagnosis.

</div>

### lesson5f.rds

**These are the distance records for Frisbee for various ages in males. What is the relationship between age and how far a man can throw a Frisbee?**

Well the obvious thing to do would be a linear regression:


```r
# Create linear regression model for distance
frisbee_model <- lm(distance ~ age, data = lesson5f)
summary(frisbee_model)
```

```
## 
## Call:
## lm(formula = distance ~ age, data = lesson5f)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -90.772 -53.291   4.797  43.120 105.031 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)   88.165     20.447   4.312 0.000717 ***
## age            1.623      0.673   2.412 0.030187 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 56.94 on 14 degrees of freedom
## Multiple R-squared:  0.2935,	Adjusted R-squared:  0.243 
## F-statistic: 5.816 on 1 and 14 DF,  p-value: 0.03019
```

You get a coefficient of 1.62, meaning that the furthest a man can throw a Frisbee increases by 1.62 meters every year. But of course this is nonsense: you can’t throw further and further each year, athletic ability starts to decline with age. You can see this on a graph:


```r
# Scatterplot of distance by age
ggplot(data = lesson5f,
       aes(x = age, y = distance)) + 
  geom_point()
```

<img src="09-answers_files/figure-html/week53-1.png" width="672" />

In other words, there is not a linear relationship between your age and the distance you can throw a Frisbee. There are two options. You can either do two linear regressions, one for age up to 30 and one for age >30. But this is a little sloppy: better, you could try including non-linear terms (see below). In either case, remember not to report p values or 95% confidence intervals: these are meaningless because there is only one record per distance.

_For advanced students only:_

Often the relationship between an $x$ and a $y$ does not follow a straight line. You may remember from high school that one way to get a curve is to have a quadratic equation including both $x$ and $x^2$. So you have to create a new variable called age2 using `mutate(age2 = age^2)` and regress:


```r
# Create new variable for age squared
lesson5f <-
  lesson5f %>%
  mutate(
    age2 = age^2
  )

# Create linear regression model using age and age squared
frisbee_model2 <- lm(distance ~ age + age2, data = lesson5f)
summary(frisbee_model2)
```

```
## 
## Call:
## lm(formula = distance ~ age + age2, data = lesson5f)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -38.530 -18.159   1.256  19.124  37.573 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  8.13134   13.41881   0.606    0.555    
## age         11.60072    1.29513   8.957 6.36e-07 ***
## age2        -0.14906    0.01886  -7.905 2.55e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 24.52 on 13 degrees of freedom
## Multiple R-squared:  0.8783,	Adjusted R-squared:  0.8596 
## F-statistic: 46.92 on 2 and 13 DF,  p-value: 1.132e-06
```



This model (distance = 11.6\*age - 0.149\*age^2 + 8.13) fits extremely well (r^2^ of 0.88 vs 0.29 for the linear model). If you really remember your high school match, consider that for a regression equation $y = ax + bx^2 + c$ you can work out the maximum $y$ as $-a/2b$. We predict that the world record for distance will be held by a man who is -11.6/(2 * -0.149) = 38.9 years old.

### lesson5g.rds

**You’ve seen this dataset before. Patients with lung cancer are randomized to receive either chemotherapy regime a or b and assessed for tumor response. We know there is no difference between regimes (you can test this if you like).  However, do the treatments work differently depending on age or sex?**

The first thing to do here is to do the sub-group analysis, just to get a feel for the data. 

Try this:


```r
# For men
tbl_summary(
  lesson5g %>% filter(sex == 0) %>% select(response, chemo),
  by = chemo,
  type = list("response" ~ "categorical")
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#snrxyyasnx .gt_table {
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

#snrxyyasnx .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#snrxyyasnx .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#snrxyyasnx .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#snrxyyasnx .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#snrxyyasnx .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#snrxyyasnx .gt_col_heading {
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
  overflow-x: hidden;
}

#snrxyyasnx .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#snrxyyasnx .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#snrxyyasnx .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#snrxyyasnx .gt_group_heading {
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

#snrxyyasnx .gt_empty_group_heading {
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

#snrxyyasnx .gt_striped {
  background-color: #f2f2f2;
}

#snrxyyasnx .gt_from_md > :first-child {
  margin-top: 0;
}

#snrxyyasnx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#snrxyyasnx .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#snrxyyasnx .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#snrxyyasnx .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#snrxyyasnx .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#snrxyyasnx .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#snrxyyasnx .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#snrxyyasnx .gt_table_body {
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

#snrxyyasnx .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#snrxyyasnx .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#snrxyyasnx .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#snrxyyasnx .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#snrxyyasnx .gt_center {
  text-align: center;
}

#snrxyyasnx .gt_left {
  text-align: left;
}

#snrxyyasnx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#snrxyyasnx .gt_font_normal {
  font-weight: normal;
}

#snrxyyasnx .gt_font_bold {
  font-weight: bold;
}

#snrxyyasnx .gt_font_italic {
  font-style: italic;
}

#snrxyyasnx .gt_super {
  font-size: 65%;
}

#snrxyyasnx .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="snrxyyasnx" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 138</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 156</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">1 = response to treatment, 0 = failure</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">84 (61%)</td>
      <td class="gt_row gt_center gt_striped">76 (49%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">54 (39%)</td>
      <td class="gt_row gt_center">80 (51%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
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
# For women
tbl_summary(
  lesson5g %>% filter(sex == 1) %>% select(response, chemo),
  by = chemo,
  type = list("response" ~ "categorical")
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#ktgliozlwc .gt_table {
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

#ktgliozlwc .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#ktgliozlwc .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#ktgliozlwc .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ktgliozlwc .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#ktgliozlwc .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#ktgliozlwc .gt_col_heading {
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
  overflow-x: hidden;
}

#ktgliozlwc .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#ktgliozlwc .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#ktgliozlwc .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#ktgliozlwc .gt_group_heading {
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

#ktgliozlwc .gt_empty_group_heading {
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

#ktgliozlwc .gt_striped {
  background-color: #f2f2f2;
}

#ktgliozlwc .gt_from_md > :first-child {
  margin-top: 0;
}

#ktgliozlwc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ktgliozlwc .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#ktgliozlwc .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#ktgliozlwc .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#ktgliozlwc .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#ktgliozlwc .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#ktgliozlwc .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#ktgliozlwc .gt_table_body {
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

#ktgliozlwc .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#ktgliozlwc .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#ktgliozlwc .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#ktgliozlwc .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#ktgliozlwc .gt_center {
  text-align: center;
}

#ktgliozlwc .gt_left {
  text-align: left;
}

#ktgliozlwc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ktgliozlwc .gt_font_normal {
  font-weight: normal;
}

#ktgliozlwc .gt_font_bold {
  font-weight: bold;
}

#ktgliozlwc .gt_font_italic {
  font-style: italic;
}

#ktgliozlwc .gt_super {
  font-size: 65%;
}

#ktgliozlwc .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ktgliozlwc" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 62</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 44</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">1 = response to treatment, 0 = failure</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">35 (56%)</td>
      <td class="gt_row gt_center gt_striped">27 (61%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">27 (44%)</td>
      <td class="gt_row gt_center">17 (39%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
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
# Here, the "summarize" function stores out the p values for the chi-squared test by sex
lesson5g %>%
  group_by(sex) %>%
  summarize(p = chisq.test(response, chemo, correct = FALSE)$p.value)
```

```
## # A tibble: 2 x 2
##     sex      p
##   <dbl>  <dbl>
## 1     0 0.0368
## 2     1 0.613
```



This shows that regime b is better for men (51% vs 39% response rate, p=0.037). For women, there doesn't seem to be a difference between groups. The next thing to check is whether sex in general makes a difference to response:


```r
# Create two-way table of response by sex
tbl_summary(
  lesson5g %>% select(response, sex),
  by = sex,
  type = list("response" ~ "categorical")
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#zjxtfnqgfo .gt_table {
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

#zjxtfnqgfo .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#zjxtfnqgfo .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#zjxtfnqgfo .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#zjxtfnqgfo .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#zjxtfnqgfo .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#zjxtfnqgfo .gt_col_heading {
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
  overflow-x: hidden;
}

#zjxtfnqgfo .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#zjxtfnqgfo .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#zjxtfnqgfo .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#zjxtfnqgfo .gt_group_heading {
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

#zjxtfnqgfo .gt_empty_group_heading {
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

#zjxtfnqgfo .gt_striped {
  background-color: #f2f2f2;
}

#zjxtfnqgfo .gt_from_md > :first-child {
  margin-top: 0;
}

#zjxtfnqgfo .gt_from_md > :last-child {
  margin-bottom: 0;
}

#zjxtfnqgfo .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#zjxtfnqgfo .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#zjxtfnqgfo .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#zjxtfnqgfo .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#zjxtfnqgfo .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#zjxtfnqgfo .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#zjxtfnqgfo .gt_table_body {
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

#zjxtfnqgfo .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#zjxtfnqgfo .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#zjxtfnqgfo .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#zjxtfnqgfo .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#zjxtfnqgfo .gt_center {
  text-align: center;
}

#zjxtfnqgfo .gt_left {
  text-align: left;
}

#zjxtfnqgfo .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#zjxtfnqgfo .gt_font_normal {
  font-weight: normal;
}

#zjxtfnqgfo .gt_font_bold {
  font-weight: bold;
}

#zjxtfnqgfo .gt_font_italic {
  font-style: italic;
}

#zjxtfnqgfo .gt_super {
  font-size: 65%;
}

#zjxtfnqgfo .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="zjxtfnqgfo" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 294</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 106</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">1 = response to treatment, 0 = failure</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">160 (54%)</td>
      <td class="gt_row gt_center gt_striped">62 (58%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">134 (46%)</td>
      <td class="gt_row gt_center">44 (42%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
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
# Test for a difference in response by sex using chi-squared test
table(lesson5g$response, lesson5g$sex) %>%
  chisq.test(correct = FALSE)
```

```
## 
## 	Pearson's Chi-squared test
## 
## data:  .
## X-squared = 0.52224, df = 1, p-value = 0.4699
```

This shows similar response rates (around 40-45%) for men and women.

Now we want to test for interaction between chemo regime and sex in a multivariable regression. You can put the interaction directly into the multivariable model:


```r
# Create logistic regression model for response including interaction between sex and chemo
sex_int_model <- glm(response ~ sex + chemo + sex*chemo,
                     data = lesson5g,
                     family = "binomial")
tbl_regression(sex_int_model, exponentiate = TRUE)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#zlejpcnofh .gt_table {
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

#zlejpcnofh .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#zlejpcnofh .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#zlejpcnofh .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#zlejpcnofh .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#zlejpcnofh .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#zlejpcnofh .gt_col_heading {
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
  overflow-x: hidden;
}

#zlejpcnofh .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#zlejpcnofh .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#zlejpcnofh .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#zlejpcnofh .gt_group_heading {
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

#zlejpcnofh .gt_empty_group_heading {
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

#zlejpcnofh .gt_striped {
  background-color: #f2f2f2;
}

#zlejpcnofh .gt_from_md > :first-child {
  margin-top: 0;
}

#zlejpcnofh .gt_from_md > :last-child {
  margin-bottom: 0;
}

#zlejpcnofh .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#zlejpcnofh .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#zlejpcnofh .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#zlejpcnofh .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#zlejpcnofh .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#zlejpcnofh .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#zlejpcnofh .gt_table_body {
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

#zlejpcnofh .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#zlejpcnofh .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#zlejpcnofh .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#zlejpcnofh .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#zlejpcnofh .gt_center {
  text-align: center;
}

#zlejpcnofh .gt_left {
  text-align: left;
}

#zlejpcnofh .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#zlejpcnofh .gt_font_normal {
  font-weight: normal;
}

#zlejpcnofh .gt_font_bold {
  font-weight: bold;
}

#zlejpcnofh .gt_font_italic {
  font-style: italic;
}

#zlejpcnofh .gt_super {
  font-size: 65%;
}

#zlejpcnofh .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="zlejpcnofh" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 400</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>OR</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">1 if female</td>
      <td class="gt_row gt_center">1.20</td>
      <td class="gt_row gt_center">0.65, 2.20</td>
      <td class="gt_row gt_center">0.6</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">0 for regime a, 1 for regime b</td>
      <td class="gt_row gt_center gt_striped">1.64</td>
      <td class="gt_row gt_center gt_striped">1.03, 2.61</td>
      <td class="gt_row gt_center gt_striped">0.037</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">1 if female * 0 for regime a, 1 for regime b</td>
      <td class="gt_row gt_center">0.50</td>
      <td class="gt_row gt_center">0.20, 1.24</td>
      <td class="gt_row gt_center">0.14</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          OR = Odds Ratio, CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

By the way, don't try `glm(response ~ sex*chemo, ...)`, that is, including only the interaction term. This would involve a non-randomized comparison between men and women who received the same chemotherapy treatment.

You can repeat this for age by creating a new variable based on the median age:


```r
# First, get the median age
skim(lesson5g$age)
```

```
## 
## Skim summary statistics
## 
## -- Variable type:numeric --------------------------------------------------------------------------
##      variable missing complete   n  mean    sd p0   p25  p50 p75 p100
##  lesson5g$age       2      398 400 42.46 10.58 17 34.25 42.5  49   71
##      hist
##  ▁▃▇▇▆▃▂▁
```

```r
# Then, create a category variable based on median age
lesson5g <-
  lesson5g %>%
  mutate(
    hiage = if_else(age > 42.5, 1, 0)
  )
```

Then do the subgroup analysis as above:


```r
# For younger patients
tbl_summary(
  lesson5g %>% filter(hiage == 0) %>% select(response, chemo),
  by = chemo,
  type = list("response" ~ "categorical")
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#daegbisqwz .gt_table {
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

#daegbisqwz .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#daegbisqwz .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#daegbisqwz .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#daegbisqwz .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#daegbisqwz .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#daegbisqwz .gt_col_heading {
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
  overflow-x: hidden;
}

#daegbisqwz .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#daegbisqwz .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#daegbisqwz .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#daegbisqwz .gt_group_heading {
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

#daegbisqwz .gt_empty_group_heading {
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

#daegbisqwz .gt_striped {
  background-color: #f2f2f2;
}

#daegbisqwz .gt_from_md > :first-child {
  margin-top: 0;
}

#daegbisqwz .gt_from_md > :last-child {
  margin-bottom: 0;
}

#daegbisqwz .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#daegbisqwz .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#daegbisqwz .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#daegbisqwz .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#daegbisqwz .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#daegbisqwz .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#daegbisqwz .gt_table_body {
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

#daegbisqwz .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#daegbisqwz .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#daegbisqwz .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#daegbisqwz .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#daegbisqwz .gt_center {
  text-align: center;
}

#daegbisqwz .gt_left {
  text-align: left;
}

#daegbisqwz .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#daegbisqwz .gt_font_normal {
  font-weight: normal;
}

#daegbisqwz .gt_font_bold {
  font-weight: bold;
}

#daegbisqwz .gt_font_italic {
  font-style: italic;
}

#daegbisqwz .gt_super {
  font-size: 65%;
}

#daegbisqwz .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="daegbisqwz" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 96</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 103</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">1 = response to treatment, 0 = failure</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">52 (54%)</td>
      <td class="gt_row gt_center gt_striped">47 (46%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">44 (46%)</td>
      <td class="gt_row gt_center">56 (54%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
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
# For older patients
tbl_summary(
  lesson5g %>% filter(hiage == 1) %>% select(response, chemo),
  by = chemo,
  type = list("response" ~ "categorical")
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#tifwvoyvwi .gt_table {
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

#tifwvoyvwi .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#tifwvoyvwi .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#tifwvoyvwi .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#tifwvoyvwi .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#tifwvoyvwi .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#tifwvoyvwi .gt_col_heading {
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
  overflow-x: hidden;
}

#tifwvoyvwi .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#tifwvoyvwi .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#tifwvoyvwi .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#tifwvoyvwi .gt_group_heading {
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

#tifwvoyvwi .gt_empty_group_heading {
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

#tifwvoyvwi .gt_striped {
  background-color: #f2f2f2;
}

#tifwvoyvwi .gt_from_md > :first-child {
  margin-top: 0;
}

#tifwvoyvwi .gt_from_md > :last-child {
  margin-bottom: 0;
}

#tifwvoyvwi .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#tifwvoyvwi .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#tifwvoyvwi .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#tifwvoyvwi .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#tifwvoyvwi .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#tifwvoyvwi .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#tifwvoyvwi .gt_table_body {
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

#tifwvoyvwi .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#tifwvoyvwi .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#tifwvoyvwi .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#tifwvoyvwi .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#tifwvoyvwi .gt_center {
  text-align: center;
}

#tifwvoyvwi .gt_left {
  text-align: left;
}

#tifwvoyvwi .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#tifwvoyvwi .gt_font_normal {
  font-weight: normal;
}

#tifwvoyvwi .gt_font_bold {
  font-weight: bold;
}

#tifwvoyvwi .gt_font_italic {
  font-style: italic;
}

#tifwvoyvwi .gt_super {
  font-size: 65%;
}

#tifwvoyvwi .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="tifwvoyvwi" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 102</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 97</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">1 = response to treatment, 0 = failure</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">66 (65%)</td>
      <td class="gt_row gt_center gt_striped">56 (58%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">36 (35%)</td>
      <td class="gt_row gt_center">41 (42%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
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
# Calculate p value for each comparison
lesson5g %>%
  filter(!is.na(age)) %>% # Exclude 2 patients missing age
  group_by(hiage) %>%
  summarize(p = chisq.test(response, chemo, correct = FALSE)$p.value)
```

```
## # A tibble: 2 x 2
##   hiage     p
##   <dbl> <dbl>
## 1     0 0.229
## 2     1 0.313
```

There do not appear to be any differences between groups. Now to do the interaction analysis, you can create an interaction term in one of two ways ("chemo\*age" or "chemo\*hiage").


```r
# Logistic regression model with interaction between chemo and age (continuous)
age_int_model1 <-
  glm(response ~ chemo + age + chemo*age,
      data = lesson5g,
      family = "binomial")
tbl_regression(age_int_model1, exponentiate = TRUE)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#jkehecqzjk .gt_table {
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

#jkehecqzjk .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#jkehecqzjk .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#jkehecqzjk .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#jkehecqzjk .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#jkehecqzjk .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#jkehecqzjk .gt_col_heading {
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
  overflow-x: hidden;
}

#jkehecqzjk .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#jkehecqzjk .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#jkehecqzjk .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#jkehecqzjk .gt_group_heading {
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

#jkehecqzjk .gt_empty_group_heading {
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

#jkehecqzjk .gt_striped {
  background-color: #f2f2f2;
}

#jkehecqzjk .gt_from_md > :first-child {
  margin-top: 0;
}

#jkehecqzjk .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jkehecqzjk .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#jkehecqzjk .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#jkehecqzjk .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#jkehecqzjk .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#jkehecqzjk .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#jkehecqzjk .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#jkehecqzjk .gt_table_body {
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

#jkehecqzjk .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#jkehecqzjk .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#jkehecqzjk .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#jkehecqzjk .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#jkehecqzjk .gt_center {
  text-align: center;
}

#jkehecqzjk .gt_left {
  text-align: left;
}

#jkehecqzjk .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jkehecqzjk .gt_font_normal {
  font-weight: normal;
}

#jkehecqzjk .gt_font_bold {
  font-weight: bold;
}

#jkehecqzjk .gt_font_italic {
  font-style: italic;
}

#jkehecqzjk .gt_super {
  font-size: 65%;
}

#jkehecqzjk .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="jkehecqzjk" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 398</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>OR</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">0 for regime a, 1 for regime b</td>
      <td class="gt_row gt_center">2.24</td>
      <td class="gt_row gt_center">0.42, 12.1</td>
      <td class="gt_row gt_center">0.3</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">age</td>
      <td class="gt_row gt_center gt_striped">0.98</td>
      <td class="gt_row gt_center gt_striped">0.96, 1.01</td>
      <td class="gt_row gt_center gt_striped">0.3</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">0 for regime a, 1 for regime b * age</td>
      <td class="gt_row gt_center">0.99</td>
      <td class="gt_row gt_center">0.95, 1.03</td>
      <td class="gt_row gt_center">0.6</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          OR = Odds Ratio, CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->


```r
# Logistic regression model with interaction between chemo and hiage (binary)
age_int_model2 <-
  glm(response ~ chemo + hiage + chemo*hiage,
      data = lesson5g,
      family = "binomial")
tbl_regression(age_int_model2, exponentiate = TRUE)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#ofvubetlvn .gt_table {
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

#ofvubetlvn .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#ofvubetlvn .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#ofvubetlvn .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ofvubetlvn .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#ofvubetlvn .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#ofvubetlvn .gt_col_heading {
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
  overflow-x: hidden;
}

#ofvubetlvn .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#ofvubetlvn .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#ofvubetlvn .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#ofvubetlvn .gt_group_heading {
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

#ofvubetlvn .gt_empty_group_heading {
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

#ofvubetlvn .gt_striped {
  background-color: #f2f2f2;
}

#ofvubetlvn .gt_from_md > :first-child {
  margin-top: 0;
}

#ofvubetlvn .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ofvubetlvn .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#ofvubetlvn .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#ofvubetlvn .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#ofvubetlvn .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#ofvubetlvn .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#ofvubetlvn .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#ofvubetlvn .gt_table_body {
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

#ofvubetlvn .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#ofvubetlvn .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#ofvubetlvn .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#ofvubetlvn .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#ofvubetlvn .gt_center {
  text-align: center;
}

#ofvubetlvn .gt_left {
  text-align: left;
}

#ofvubetlvn .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ofvubetlvn .gt_font_normal {
  font-weight: normal;
}

#ofvubetlvn .gt_font_bold {
  font-weight: bold;
}

#ofvubetlvn .gt_font_italic {
  font-style: italic;
}

#ofvubetlvn .gt_super {
  font-size: 65%;
}

#ofvubetlvn .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ofvubetlvn" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 398</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>OR</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">0 for regime a, 1 for regime b</td>
      <td class="gt_row gt_center">1.41</td>
      <td class="gt_row gt_center">0.81, 2.47</td>
      <td class="gt_row gt_center">0.2</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">hiage</td>
      <td class="gt_row gt_center gt_striped">0.64</td>
      <td class="gt_row gt_center gt_striped">0.36, 1.14</td>
      <td class="gt_row gt_center gt_striped">0.13</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">0 for regime a, 1 for regime b * hiage</td>
      <td class="gt_row gt_center">0.95</td>
      <td class="gt_row gt_center">0.43, 2.12</td>
      <td class="gt_row gt_center">>0.9</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          OR = Odds Ratio, CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->



Whichever one you choose, the interaction is non-significant in a logistic regression with age and chemotherapy. Incidentally, you must put age in the model because, not surprisingly, it is statistically significant, with higher age being associated with a lower chance of response.

Incidentally, I have often emphasized the importance of including an estimate and a 95% confidence interval in any set of results rather than just saying "differences between groups were / were not significant". Interaction analyses are somewhat of an exception to this general rule. First, these tend to be secondary, exploratory analyses. Secondly, interaction is rather rare in medicine: treatments tend to work (or not work) regardless of a patients age, gender, race and so on. Thirdly, the coefficient for the interaction term can be quite difficult to interpret. So it is often appropriate just to say that you looked for an interaction and didn't find one. A model answer might be:

<div class="quote-container">

>[Describe main comparison between chemo regimens here. Describe age and sex here.] In a subgroup analysis, there appeared to a differential effect of the two regimens depending on sex. In men, response rates were higher for regimen B (51%) than regimen A (39%); response rates were more similar in women, though perhaps favoring regimen A (44% vs. 39%). Sex and sex by regimen interaction were entered into a logistic regression model of regimen and response, but the interaction term was non-significant (p=0.14). There were no apparent differences in response depending on age: response rates were 54% v. 46% in patients aged below the median compared to 42% v. 35% in patients aged above the median. The interaction between regimen and age as a continuous variable was non-significant (p=0.6).

</div>

### lesson5h.rds

**PSA is used to screen for prostate cancer. In this dataset, the researchers are looking at various forms of PSA (e.g. "nicked" PSA). What variables should be used to try to predict prostate cancer? How accurate would this test be?**



One approach to selecting which variables to include in a predictive model would be to do a regression. You could start with all the variables (i.e. `glm(cancer ~ psa + psan + psai + psant, ...)`). You might notice that psant is not a good predictor (p=0.3) and decide to take it out of the model. In a regression using the remaining three variables, psai is not statistically significant, and you might then want to remove that variable too. Both psa and psan are highly predictive, so you could leave them in the model and use the `roc` function (from the `pROC` package) to get the area-under-the-curve.

However, I would have my doubts about such an approach. What you are trying to do here is predict the presence of cancer as well as you can: the significance or otherwise of individual variables doesn’t really come into it. How I would lay about my analysis would be in terms of the area-under-the-curve of the model. So a model answer might be:

<div class="quote-container">

>The cohort consisted of 353 patients. Values for PSA and PSA subtypes are shown in the table. Entering all four PSA variables into a logistic model to predict the presence of prostate cancer gave an area-under-the-curve (AUC) of 0.736. Nicked-to-total ratio was not a strong predictor and removing it from the model did not decrease AUC (0.738). Removing intact PSA from the model had a small but noticeable impact on AUC (0.729). We therefore recommend that further research use total, nicked and intact PSA to predict prostate cancer.

</div>

<center> **Table 1. Marker distributions** </center>

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#mpvoaaoyfm .gt_table {
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

#mpvoaaoyfm .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#mpvoaaoyfm .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#mpvoaaoyfm .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#mpvoaaoyfm .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#mpvoaaoyfm .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#mpvoaaoyfm .gt_col_heading {
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
  overflow-x: hidden;
}

#mpvoaaoyfm .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#mpvoaaoyfm .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#mpvoaaoyfm .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#mpvoaaoyfm .gt_group_heading {
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

#mpvoaaoyfm .gt_empty_group_heading {
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

#mpvoaaoyfm .gt_striped {
  background-color: #f2f2f2;
}

#mpvoaaoyfm .gt_from_md > :first-child {
  margin-top: 0;
}

#mpvoaaoyfm .gt_from_md > :last-child {
  margin-bottom: 0;
}

#mpvoaaoyfm .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#mpvoaaoyfm .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#mpvoaaoyfm .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#mpvoaaoyfm .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#mpvoaaoyfm .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#mpvoaaoyfm .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#mpvoaaoyfm .gt_table_body {
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

#mpvoaaoyfm .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#mpvoaaoyfm .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#mpvoaaoyfm .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#mpvoaaoyfm .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#mpvoaaoyfm .gt_center {
  text-align: center;
}

#mpvoaaoyfm .gt_left {
  text-align: left;
}

#mpvoaaoyfm .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#mpvoaaoyfm .gt_font_normal {
  font-weight: normal;
}

#mpvoaaoyfm .gt_font_bold {
  font-weight: bold;
}

#mpvoaaoyfm .gt_font_italic {
  font-style: italic;
}

#mpvoaaoyfm .gt_super {
  font-size: 65%;
}

#mpvoaaoyfm .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="mpvoaaoyfm" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>N = 353</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Total PSA (ng/mL)</td>
      <td class="gt_row gt_center">6.8 (4.3, 10.2)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Nicked PSA (ng/mL)</td>
      <td class="gt_row gt_center gt_striped">0.47 (0.28, 0.71)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Intact PSA (ng/mL)</td>
      <td class="gt_row gt_center">0.48 (0.38, 0.57)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Nicked-to-total ratio</td>
      <td class="gt_row gt_center gt_striped">0.07 (0.05, 0.11)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="2">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: median (IQR)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

<center> **Table 2. Multivariable prediction model** </center>

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#phijstdxka .gt_table {
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

#phijstdxka .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#phijstdxka .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#phijstdxka .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#phijstdxka .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#phijstdxka .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#phijstdxka .gt_col_heading {
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
  overflow-x: hidden;
}

#phijstdxka .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#phijstdxka .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#phijstdxka .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#phijstdxka .gt_group_heading {
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

#phijstdxka .gt_empty_group_heading {
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

#phijstdxka .gt_striped {
  background-color: #f2f2f2;
}

#phijstdxka .gt_from_md > :first-child {
  margin-top: 0;
}

#phijstdxka .gt_from_md > :last-child {
  margin-bottom: 0;
}

#phijstdxka .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#phijstdxka .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#phijstdxka .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#phijstdxka .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#phijstdxka .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#phijstdxka .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#phijstdxka .gt_table_body {
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

#phijstdxka .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#phijstdxka .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#phijstdxka .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#phijstdxka .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#phijstdxka .gt_center {
  text-align: center;
}

#phijstdxka .gt_left {
  text-align: left;
}

#phijstdxka .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#phijstdxka .gt_font_normal {
  font-weight: normal;
}

#phijstdxka .gt_font_bold {
  font-weight: bold;
}

#phijstdxka .gt_font_italic {
  font-style: italic;
}

#phijstdxka .gt_super {
  font-size: 65%;
}

#phijstdxka .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="phijstdxka" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 353</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>OR</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Total PSA</td>
      <td class="gt_row gt_center">1.30</td>
      <td class="gt_row gt_center">1.20, 1.43</td>
      <td class="gt_row gt_center"><0.001</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Nicked PSA</td>
      <td class="gt_row gt_center gt_striped">0.22</td>
      <td class="gt_row gt_center gt_striped">0.10, 0.46</td>
      <td class="gt_row gt_center gt_striped"><0.001</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Intact PSA</td>
      <td class="gt_row gt_center">0.41</td>
      <td class="gt_row gt_center">0.13, 1.10</td>
      <td class="gt_row gt_center">0.081</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          OR = Odds Ratio, CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

### lesson5i.rds

**This is a randomized trial of behavioral therapy in cancer patients with depressed mood. Patients are randomized to no treatment (group 1), informal contact with a volunteer (group 2) or behavior therapy with a trained therapist (group 3). What would you conclude about the effectiveness of these treatments?**

One approach to these data is to use a test called ANOVA. This addresses the question of whether there is some overall difference between the three groups, or, more specifically, tests the null hypothesis that the three groups are equivalent. But this isn’t a very interesting hypothesis. The other thing to do would be to conduct t-tests on all possible pairs (i.e. no treatment vs. therapy; therapy vs. volunteer; volunteer vs. no treatment). But I am not sure that this is particularly interesting either.

What I would use is a regression analysis.


```r
# Create variables for treatment (yes/no) and therapy (yes/no)
lesson5i <-
  lesson5i %>%
  mutate(
    treat = if_else(group > 1, 1, 0),
    therapy = if_else(group == 3, 1, 0),
  )

# Create linear regression model for followup
treat_model <- lm(followup ~ baseline + treat + therapy,
                  data = lesson5i)
tbl_regression(treat_model)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#alcqlbdxer .gt_table {
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

#alcqlbdxer .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#alcqlbdxer .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#alcqlbdxer .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#alcqlbdxer .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#alcqlbdxer .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#alcqlbdxer .gt_col_heading {
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
  overflow-x: hidden;
}

#alcqlbdxer .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#alcqlbdxer .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#alcqlbdxer .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#alcqlbdxer .gt_group_heading {
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

#alcqlbdxer .gt_empty_group_heading {
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

#alcqlbdxer .gt_striped {
  background-color: #f2f2f2;
}

#alcqlbdxer .gt_from_md > :first-child {
  margin-top: 0;
}

#alcqlbdxer .gt_from_md > :last-child {
  margin-bottom: 0;
}

#alcqlbdxer .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#alcqlbdxer .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#alcqlbdxer .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#alcqlbdxer .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#alcqlbdxer .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#alcqlbdxer .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#alcqlbdxer .gt_table_body {
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

#alcqlbdxer .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#alcqlbdxer .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#alcqlbdxer .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#alcqlbdxer .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#alcqlbdxer .gt_center {
  text-align: center;
}

#alcqlbdxer .gt_left {
  text-align: left;
}

#alcqlbdxer .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#alcqlbdxer .gt_font_normal {
  font-weight: normal;
}

#alcqlbdxer .gt_font_bold {
  font-weight: bold;
}

#alcqlbdxer .gt_font_italic {
  font-style: italic;
}

#alcqlbdxer .gt_super {
  font-size: 65%;
}

#alcqlbdxer .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="alcqlbdxer" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 29</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>Coefficient</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">baseline mood score</td>
      <td class="gt_row gt_center">0.58</td>
      <td class="gt_row gt_center">0.52, 0.63</td>
      <td class="gt_row gt_center"><0.001</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">treat</td>
      <td class="gt_row gt_center gt_striped">0.83</td>
      <td class="gt_row gt_center gt_striped">0.54, 1.1</td>
      <td class="gt_row gt_center gt_striped"><0.001</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">therapy</td>
      <td class="gt_row gt_center">1.00</td>
      <td class="gt_row gt_center">0.73, 1.3</td>
      <td class="gt_row gt_center"><0.001</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

What this does is to create two dummy variables "treat" and "therapy". "treat" means that you had some kind of treatment, whether that was contact with the therapist or just with a volunteer. "therapy" means you say the trained therapist. So the groups are coded:

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#wimnizqbsk .gt_table {
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

#wimnizqbsk .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#wimnizqbsk .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#wimnizqbsk .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#wimnizqbsk .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#wimnizqbsk .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#wimnizqbsk .gt_col_heading {
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
  overflow-x: hidden;
}

#wimnizqbsk .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#wimnizqbsk .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#wimnizqbsk .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#wimnizqbsk .gt_group_heading {
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

#wimnizqbsk .gt_empty_group_heading {
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

#wimnizqbsk .gt_striped {
  background-color: #f2f2f2;
}

#wimnizqbsk .gt_from_md > :first-child {
  margin-top: 0;
}

#wimnizqbsk .gt_from_md > :last-child {
  margin-bottom: 0;
}

#wimnizqbsk .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#wimnizqbsk .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#wimnizqbsk .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#wimnizqbsk .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#wimnizqbsk .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#wimnizqbsk .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#wimnizqbsk .gt_table_body {
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

#wimnizqbsk .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#wimnizqbsk .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#wimnizqbsk .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#wimnizqbsk .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#wimnizqbsk .gt_center {
  text-align: center;
}

#wimnizqbsk .gt_left {
  text-align: left;
}

#wimnizqbsk .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#wimnizqbsk .gt_font_normal {
  font-weight: normal;
}

#wimnizqbsk .gt_font_bold {
  font-weight: bold;
}

#wimnizqbsk .gt_font_italic {
  font-style: italic;
}

#wimnizqbsk .gt_super {
  font-size: 65%;
}

#wimnizqbsk .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="wimnizqbsk" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1">Group</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1">treat</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1">therapy</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">No treatment</td>
      <td class="gt_row gt_right">0</td>
      <td class="gt_row gt_right">1</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Volunteer</td>
      <td class="gt_row gt_right gt_striped">1</td>
      <td class="gt_row gt_right gt_striped">0</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Trained therapy</td>
      <td class="gt_row gt_right">1</td>
      <td class="gt_row gt_right">1</td>
    </tr>
  </body>
  
  
</table></div><!--/html_preserve-->

Now when you regress the change score using the variables "treat" and "therapy" you get an estimate of the effect of just spending time with someone and the effect of seeing a trained professional. In my view, this fits in well with the original study design. A model answer might be:

<div class="quote-container">

> Mood scores improved in the therapist group (2.1 points, SD 0.88) and volunteer groups (1.0, SD 0.89) but not in the no treatment group (0.1 point worsening in score, 1.1). Interaction with a considerate individual appears to improve mood by 0.83 points (95% CI 0.54, 1.1, p<0.001) with active behavior therapy further improving scores an additional 1.00 points (95% CI 0.73, 1.3, p<0.001).

</div>

## Week 6


```r
# Week 6: load packages
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

# Week 6: load data
lesson6a <- readRDS(here::here("Data", "Week 6", "lesson6a.rds"))
lesson6b <- readRDS(here::here("Data", "Week 6", "lesson6b.rds"))
lesson6c <- readRDS(here::here("Data", "Week 6", "lesson6c.rds"))
lesson6d <- readRDS(here::here("Data", "Week 6", "lesson6d.rds"))
```

### lesson6a.rds and lesson6b.rds

**These are data on a blood test (creatine kinase) to detect a recent myocardial infarct. The two datasets are from a coronary care unit population (06b) and a general hospital population (06c). What is the sensitivity, specificity, positive predictive value and negative predictive value?**



The thing to take away from this is that sensitivity and specificity don’t change, but the positive and negative predictive value do. The prevalence of myocardial infarct is obviously much lower in the general hospital population compared to the coronary care population. So negative predictive value is higher in general patients (you are unlikely to have an MI anyway, so if the test says you’re negative, it is almost definite) and positive predictive value higher in coronary care patients (you at high risk of having an MI, so a positive test just about confirms it).

### lesson6c.rds

**Here are the data from a study of a marker to predict the results of biopsy for cancer. There are 2000 patients, half of whom had a suspicious imaging result and were biopsied. It is known that only about half of patients with abnormal imaging actually have cancer and that is what is found in this study. The marker was measured in patients undergoing biopsy. Might the new marker help decide which patients with abnormal scans should receive biopsy?**

You might be tempted just to try:


```r
# Calculate AUC for marker predicting cancer using marker
roc(cancer ~ marker, data = lesson6c)
```

```
## 
## Call:
## roc.formula(formula = cancer ~ marker, data = lesson6c)
## 
## Data: marker in 500 controls (cancer 0) < 500 cases (cancer 1).
## Area under the curve: 0.7
```

You'd get an AUC of 0.700, which is pretty good. But the question isn't "how good is the marker?" but "might the new marker help make a clinical decision about biopsy?" So we need to look at clinical consequences.

Let's try:


```r
# Here we will drop observations missing marker data from the table (filter function)
tbl_summary(
  lesson6c %>% filter(!is.na(marker)) %>% select(cancer, marker),
  by = marker,
  type = list("cancer" ~ "categorical")
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#xvkjrdadrg .gt_table {
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

#xvkjrdadrg .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#xvkjrdadrg .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#xvkjrdadrg .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#xvkjrdadrg .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#xvkjrdadrg .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#xvkjrdadrg .gt_col_heading {
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
  overflow-x: hidden;
}

#xvkjrdadrg .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#xvkjrdadrg .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#xvkjrdadrg .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#xvkjrdadrg .gt_group_heading {
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

#xvkjrdadrg .gt_empty_group_heading {
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

#xvkjrdadrg .gt_striped {
  background-color: #f2f2f2;
}

#xvkjrdadrg .gt_from_md > :first-child {
  margin-top: 0;
}

#xvkjrdadrg .gt_from_md > :last-child {
  margin-bottom: 0;
}

#xvkjrdadrg .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#xvkjrdadrg .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#xvkjrdadrg .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#xvkjrdadrg .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#xvkjrdadrg .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#xvkjrdadrg .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#xvkjrdadrg .gt_table_body {
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

#xvkjrdadrg .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#xvkjrdadrg .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#xvkjrdadrg .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#xvkjrdadrg .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#xvkjrdadrg .gt_center {
  text-align: center;
}

#xvkjrdadrg .gt_left {
  text-align: left;
}

#xvkjrdadrg .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#xvkjrdadrg .gt_font_normal {
  font-weight: normal;
}

#xvkjrdadrg .gt_font_bold {
  font-weight: bold;
}

#xvkjrdadrg .gt_font_italic {
  font-style: italic;
}

#xvkjrdadrg .gt_super {
  font-size: 65%;
}

#xvkjrdadrg .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="xvkjrdadrg" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 600</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 400</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">cancer</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">400 (67%)</td>
      <td class="gt_row gt_center gt_striped">100 (25%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">200 (33%)</td>
      <td class="gt_row gt_center">300 (75%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

So you can see that, if you only biopsied patients who were positive for the marker, you do 600 fewer biopsies per 1000, but you’d also miss 200 cancers. That is a lot of cancers to miss and so you might feel that using the marker to make biopsy decisions would do more harm than good. 

### lesson6d.rds

**This is a dataset of cancer patients undergoing surgery with the endpoint of recurrence within 5 years. Since this cohort was established, adjuvant therapy has been shown to be of benefit. Current guidelines are that adjuvant therapy should be considered in patients with stage 3 or high grade disease. Recently, two new variables have been added to the dataset:  levels of a novel tumor marker were obtained from banked tissue samples and preoperative imaging scans were retrieved and scored from 0 (no evidence of local extension) to 4 (definite evidence of local extension). Here are some questions about these data:**

- **How good is the current method for determining whether patients should be referred to adjuvant therapy?**
- **It has been suggested that a statistical model using stage and grade would be better than the current risk grouping. How good do you think this model would be?**
- **Does the marker add information to the model of stage and grade?**
- **Does imaging add information to the model including stage, grade and the marker?**

The first question concerns the value of the current method of determining referral for adjuvant therapy. There are two ways of thinking about this. The first is to show a simple table:


```r
# Two-way table of recurrence by hi_risk
tbl_summary(
  lesson6d %>% select(recurrence, hi_risk),
  by = hi_risk,
  type = list("recurrence" ~ "categorical")
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#oguvercsxm .gt_table {
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

#oguvercsxm .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#oguvercsxm .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#oguvercsxm .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#oguvercsxm .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#oguvercsxm .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#oguvercsxm .gt_col_heading {
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
  overflow-x: hidden;
}

#oguvercsxm .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#oguvercsxm .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#oguvercsxm .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#oguvercsxm .gt_group_heading {
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

#oguvercsxm .gt_empty_group_heading {
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

#oguvercsxm .gt_striped {
  background-color: #f2f2f2;
}

#oguvercsxm .gt_from_md > :first-child {
  margin-top: 0;
}

#oguvercsxm .gt_from_md > :last-child {
  margin-bottom: 0;
}

#oguvercsxm .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#oguvercsxm .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#oguvercsxm .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#oguvercsxm .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#oguvercsxm .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#oguvercsxm .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#oguvercsxm .gt_table_body {
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

#oguvercsxm .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#oguvercsxm .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#oguvercsxm .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#oguvercsxm .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#oguvercsxm .gt_center {
  text-align: center;
}

#oguvercsxm .gt_left {
  text-align: left;
}

#oguvercsxm .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#oguvercsxm .gt_font_normal {
  font-weight: normal;
}

#oguvercsxm .gt_font_bold {
  font-weight: bold;
}

#oguvercsxm .gt_font_italic {
  font-style: italic;
}

#oguvercsxm .gt_super {
  font-size: 65%;
}

#oguvercsxm .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="oguvercsxm" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 4375</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 2200</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">recurrence</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">4125 (94%)</td>
      <td class="gt_row gt_center gt_striped">1609 (73%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">250 (5.7%)</td>
      <td class="gt_row gt_center">591 (27%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->



You can see that 27% of patients who met high risk criteria recurred compared to only 5.7% of those who were not high stage or high grade. Another way to think about "how good" the criterion is would be to look at discriminative accuracy.


```r
# Calculate AUC for prediction of recurrence using hi_risk
roc(recurrence ~ hi_risk, data = lesson6d)
```

```
## 
## Call:
## roc.formula(formula = recurrence ~ hi_risk, data = lesson6d)
## 
## Data: hi_risk in 5734 controls (recurrence 0) < 841 cases (recurrence 1).
## Area under the curve: 0.7111
```

The area-under-the-curve (AUC) is 0.71. Because high risk is a binary variable, this AUC is equivalent to sensitivity plus specificity – 1 (you can check this if you like). 

So now let’s look at the statistical model of stage and grade. We'll first create this model and then use the model to give us the predicted probabilities for each patient.


```r
# Create the model
# "grade" is a categorical variable, so use "factor()"
recur_model <- glm(recurrence ~ stage + factor(grade_numeric),
                   data = lesson6d,
                   family = "binomial")

# Get the predicted probability for each patient
lesson6d_pred <-
  augment(
    recur_model,
    newdata = lesson6d,
    type.predict = "response"
  ) %>%
  # Renaming to identify each prediction separately
  rename(clinpred = .fitted, clinpred_se = .se.fit)

# Calculate the AUC for the clinical model
roc(recurrence ~ clinpred, data = lesson6d_pred)
```

```
## 
## Call:
## roc.formula(formula = recurrence ~ clinpred, data = lesson6d_pred)
## 
## Data: clinpred in 5734 controls (recurrence 0) < 841 cases (recurrence 1).
## Area under the curve: 0.7567
```

So the AUC is better for the model than for simple risk grouping. But would using a model make a clinical difference? The first thing to think about is the sort of risk that would make you consider the use of adjuvant therapy. Clearly a patient with a 1% risk of recurrence should not be referred for adjuvant; a risk of 90% would definitely be an indication for chemotherapy. Somewhere in between 1% and 90%, we’d think that the risk becomes high enough to warrant adjuvant therapy. Let’s imagine that we choose a risk threshold of 10%. We can now do this.


```r
# Create a new variable to define patients at high risk from the model
lesson6d_pred <-
  lesson6d_pred %>%
  mutate(
    clinmodel_hirisk = if_else(clinpred >= 0.1, 1, 0)
  )

# Compare who is defined as high risk from the model
# with those defined as high risk using clinical criteria
tbl_summary(
  lesson6d_pred %>% select(clinmodel_hirisk, hi_risk),
  by = hi_risk,
  type = list("clinmodel_hirisk" ~ "categorical")
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#kluxeipkeg .gt_table {
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

#kluxeipkeg .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#kluxeipkeg .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#kluxeipkeg .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#kluxeipkeg .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#kluxeipkeg .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#kluxeipkeg .gt_col_heading {
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
  overflow-x: hidden;
}

#kluxeipkeg .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#kluxeipkeg .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#kluxeipkeg .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#kluxeipkeg .gt_group_heading {
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

#kluxeipkeg .gt_empty_group_heading {
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

#kluxeipkeg .gt_striped {
  background-color: #f2f2f2;
}

#kluxeipkeg .gt_from_md > :first-child {
  margin-top: 0;
}

#kluxeipkeg .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kluxeipkeg .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#kluxeipkeg .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#kluxeipkeg .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#kluxeipkeg .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#kluxeipkeg .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#kluxeipkeg .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#kluxeipkeg .gt_table_body {
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

#kluxeipkeg .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#kluxeipkeg .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#kluxeipkeg .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#kluxeipkeg .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#kluxeipkeg .gt_center {
  text-align: center;
}

#kluxeipkeg .gt_left {
  text-align: left;
}

#kluxeipkeg .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#kluxeipkeg .gt_font_normal {
  font-weight: normal;
}

#kluxeipkeg .gt_font_bold {
  font-weight: bold;
}

#kluxeipkeg .gt_font_italic {
  font-style: italic;
}

#kluxeipkeg .gt_super {
  font-size: 65%;
}

#kluxeipkeg .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="kluxeipkeg" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 4375</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 2200</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">clinmodel_hirisk</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">4375 (100%)</td>
      <td class="gt_row gt_center gt_striped">0 (0%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">0 (0%)</td>
      <td class="gt_row gt_center">2200 (100%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

You can see that no patient is "reclassified" using the model. All 2200 patients defined as high risk by clinical criteria are also defined as high risk (risk ≥10%) by the model, similarly, all 4,375 patients defined as low risk by clinical criteria have risks <10% from the model.

How about adding in the marker?


```r
# Create the model
marker_recur_model <- glm(recurrence ~ stage + factor(grade_numeric) + marker,
                          data = lesson6d,
                          family = "binomial")
tbl_regression(marker_recur_model, exponentiate = TRUE)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#qcfdyzmmty .gt_table {
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

#qcfdyzmmty .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#qcfdyzmmty .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#qcfdyzmmty .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#qcfdyzmmty .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#qcfdyzmmty .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#qcfdyzmmty .gt_col_heading {
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
  overflow-x: hidden;
}

#qcfdyzmmty .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#qcfdyzmmty .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#qcfdyzmmty .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#qcfdyzmmty .gt_group_heading {
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

#qcfdyzmmty .gt_empty_group_heading {
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

#qcfdyzmmty .gt_striped {
  background-color: #f2f2f2;
}

#qcfdyzmmty .gt_from_md > :first-child {
  margin-top: 0;
}

#qcfdyzmmty .gt_from_md > :last-child {
  margin-bottom: 0;
}

#qcfdyzmmty .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#qcfdyzmmty .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#qcfdyzmmty .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#qcfdyzmmty .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#qcfdyzmmty .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#qcfdyzmmty .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#qcfdyzmmty .gt_table_body {
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

#qcfdyzmmty .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#qcfdyzmmty .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#qcfdyzmmty .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#qcfdyzmmty .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#qcfdyzmmty .gt_center {
  text-align: center;
}

#qcfdyzmmty .gt_left {
  text-align: left;
}

#qcfdyzmmty .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#qcfdyzmmty .gt_font_normal {
  font-weight: normal;
}

#qcfdyzmmty .gt_font_bold {
  font-weight: bold;
}

#qcfdyzmmty .gt_font_italic {
  font-style: italic;
}

#qcfdyzmmty .gt_super {
  font-size: 65%;
}

#qcfdyzmmty .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="qcfdyzmmty" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 6575</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>OR</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Stage II or III disease</td>
      <td class="gt_row gt_center">3.26</td>
      <td class="gt_row gt_center">2.75, 3.86</td>
      <td class="gt_row gt_center"><0.001</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">factor(grade_numeric)</td>
      <td class="gt_row gt_center gt_striped"></td>
      <td class="gt_row gt_center gt_striped"></td>
      <td class="gt_row gt_center gt_striped"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center">&mdash;</td>
      <td class="gt_row gt_center">&mdash;</td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center gt_striped">1.83</td>
      <td class="gt_row gt_center gt_striped">1.51, 2.22</td>
      <td class="gt_row gt_center gt_striped"><0.001</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">2</td>
      <td class="gt_row gt_center">6.77</td>
      <td class="gt_row gt_center">5.26, 8.73</td>
      <td class="gt_row gt_center"><0.001</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Marker level</td>
      <td class="gt_row gt_center gt_striped">1.09</td>
      <td class="gt_row gt_center gt_striped">1.07, 1.10</td>
      <td class="gt_row gt_center gt_striped"><0.001</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          OR = Odds Ratio, CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

```r
# Get the predicted probability for each patient
lesson6d_pred <-
  augment(
    marker_recur_model,
    newdata = lesson6d_pred,
    type.predict = "response"
  ) %>%
  rename(markerpred = .fitted, markerpred_se = .se.fit)

# Calculate the AUC from the marker for the marker model
roc(recurrence ~ markerpred, data = lesson6d_pred)
```

```
## 
## Call:
## roc.formula(formula = recurrence ~ markerpred, data = lesson6d_pred)
## 
## Data: markerpred in 5734 controls (recurrence 0) < 841 cases (recurrence 1).
## Area under the curve: 0.7982
```



A couple of things to note here. First, the marker is a statistically significant predictor in the model. Typical language is that the marker is "an independent predictor" or that "it is significant after adjusting for stage and grade". Second, it increases AUC quite a bit, from 0.757 for the clinical variables alone to 0.798 for the clinical variables plus the marker. But let's again look at clinical consequences.


```r
# Identify patients at >= 10% risk from clinical+marker model
lesson6d_pred <-
  lesson6d_pred %>%
  mutate(markermodel_hirisk = if_else(markerpred >= 0.1, 1, 0))

# Compare who is defined as high risk from the clinical+marker model
# with those defined as high risk using clinical criteria
tbl_summary(
  lesson6d_pred %>% select(markermodel_hirisk, hi_risk),
  by = hi_risk,
  type = list("markermodel_hirisk" ~ "categorical")
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#vjnfqcioza .gt_table {
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

#vjnfqcioza .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#vjnfqcioza .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#vjnfqcioza .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#vjnfqcioza .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#vjnfqcioza .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#vjnfqcioza .gt_col_heading {
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
  overflow-x: hidden;
}

#vjnfqcioza .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#vjnfqcioza .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#vjnfqcioza .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#vjnfqcioza .gt_group_heading {
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

#vjnfqcioza .gt_empty_group_heading {
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

#vjnfqcioza .gt_striped {
  background-color: #f2f2f2;
}

#vjnfqcioza .gt_from_md > :first-child {
  margin-top: 0;
}

#vjnfqcioza .gt_from_md > :last-child {
  margin-bottom: 0;
}

#vjnfqcioza .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#vjnfqcioza .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#vjnfqcioza .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#vjnfqcioza .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#vjnfqcioza .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#vjnfqcioza .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#vjnfqcioza .gt_table_body {
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

#vjnfqcioza .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#vjnfqcioza .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#vjnfqcioza .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#vjnfqcioza .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#vjnfqcioza .gt_center {
  text-align: center;
}

#vjnfqcioza .gt_left {
  text-align: left;
}

#vjnfqcioza .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#vjnfqcioza .gt_font_normal {
  font-weight: normal;
}

#vjnfqcioza .gt_font_bold {
  font-weight: bold;
}

#vjnfqcioza .gt_font_italic {
  font-style: italic;
}

#vjnfqcioza .gt_super {
  font-size: 65%;
}

#vjnfqcioza .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="vjnfqcioza" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 4375</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 2200</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">markermodel_hirisk</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">4030 (92%)</td>
      <td class="gt_row gt_center gt_striped">133 (6.0%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">345 (7.9%)</td>
      <td class="gt_row gt_center">2067 (94%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->



You can see now that 133 patients who would otherwise be referred to adjuvant chemotherapy would not using the model, and 345 of those defined at low risk by the clinical criteria are reclassified as high risk from the model (presumably because of a high level of the marker. You could also do this:


```r
# Table of recurrences for those at high risk from the marker model but not clinically
tbl_summary(
  lesson6d_pred %>% filter(markermodel_hirisk == 1 & hi_risk == 0) %>%
    select(recurrence),
  type = list("recurrence" ~ "categorical")
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#fssxgtwmsf .gt_table {
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

#fssxgtwmsf .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#fssxgtwmsf .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#fssxgtwmsf .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#fssxgtwmsf .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#fssxgtwmsf .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#fssxgtwmsf .gt_col_heading {
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
  overflow-x: hidden;
}

#fssxgtwmsf .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#fssxgtwmsf .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#fssxgtwmsf .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#fssxgtwmsf .gt_group_heading {
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

#fssxgtwmsf .gt_empty_group_heading {
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

#fssxgtwmsf .gt_striped {
  background-color: #f2f2f2;
}

#fssxgtwmsf .gt_from_md > :first-child {
  margin-top: 0;
}

#fssxgtwmsf .gt_from_md > :last-child {
  margin-bottom: 0;
}

#fssxgtwmsf .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#fssxgtwmsf .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#fssxgtwmsf .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#fssxgtwmsf .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#fssxgtwmsf .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#fssxgtwmsf .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#fssxgtwmsf .gt_table_body {
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

#fssxgtwmsf .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#fssxgtwmsf .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#fssxgtwmsf .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#fssxgtwmsf .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#fssxgtwmsf .gt_center {
  text-align: center;
}

#fssxgtwmsf .gt_left {
  text-align: left;
}

#fssxgtwmsf .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#fssxgtwmsf .gt_font_normal {
  font-weight: normal;
}

#fssxgtwmsf .gt_font_bold {
  font-weight: bold;
}

#fssxgtwmsf .gt_font_italic {
  font-style: italic;
}

#fssxgtwmsf .gt_super {
  font-size: 65%;
}

#fssxgtwmsf .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="fssxgtwmsf" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>N = 345</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">recurrence</td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">286 (83%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">59 (17%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="2">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
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
# Table of recurrences for those at low risk from the marker model but high risk clinically
tbl_summary(
  lesson6d_pred %>% filter(markermodel_hirisk == 0 & hi_risk == 1) %>%
    select(recurrence),
  type = list("recurrence" ~ "categorical")
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#njcjwgigkv .gt_table {
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

#njcjwgigkv .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#njcjwgigkv .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#njcjwgigkv .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#njcjwgigkv .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#njcjwgigkv .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#njcjwgigkv .gt_col_heading {
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
  overflow-x: hidden;
}

#njcjwgigkv .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#njcjwgigkv .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#njcjwgigkv .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#njcjwgigkv .gt_group_heading {
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

#njcjwgigkv .gt_empty_group_heading {
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

#njcjwgigkv .gt_striped {
  background-color: #f2f2f2;
}

#njcjwgigkv .gt_from_md > :first-child {
  margin-top: 0;
}

#njcjwgigkv .gt_from_md > :last-child {
  margin-bottom: 0;
}

#njcjwgigkv .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#njcjwgigkv .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#njcjwgigkv .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#njcjwgigkv .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#njcjwgigkv .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#njcjwgigkv .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#njcjwgigkv .gt_table_body {
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

#njcjwgigkv .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#njcjwgigkv .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#njcjwgigkv .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#njcjwgigkv .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#njcjwgigkv .gt_center {
  text-align: center;
}

#njcjwgigkv .gt_left {
  text-align: left;
}

#njcjwgigkv .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#njcjwgigkv .gt_font_normal {
  font-weight: normal;
}

#njcjwgigkv .gt_font_bold {
  font-weight: bold;
}

#njcjwgigkv .gt_font_italic {
  font-style: italic;
}

#njcjwgigkv .gt_super {
  font-size: 65%;
}

#njcjwgigkv .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="njcjwgigkv" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>N = 133</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">recurrence</td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">125 (94%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">8 (6.0%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="2">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

You can see that patients reclassified as low risk using the marker really are at low risk (only 6.0% of them recurred) whereas 17% of those defined as high risk from the model did indeed recur. As to whether you’d use this in practice, the question is whether it is worth measuring the marker on ~6500 to reclassify ~500. That all depends on how difficult, invasive and expensive it is to measure the marker. 

As for imaging, if you try:


```r
# Create model that includes imaging score
imaging_model <- glm(recurrence ~ stage + factor(grade_numeric) + marker + imaging_score,
                     data = lesson6d,
                     family = "binomial")

# Get predictions for imaging model
lesson6d_pred <-
  augment(
    imaging_model,
    newdata = lesson6d_pred,
    type.predict = "response"
  ) %>%
  rename(imagingpred = .fitted, imagingpred_se = .se.fit)

# Calculate AUC for imaging model
roc(recurrence ~ imagingpred, data = lesson6d_pred)
```

```
## 
## Call:
## roc.formula(formula = recurrence ~ imagingpred, data = lesson6d_pred)
## 
## Data: imagingpred in 5734 controls (recurrence 0) < 841 cases (recurrence 1).
## Area under the curve: 0.8004
```



You'll find that imaging is a statistically significant predictor of recurrence, even after adjusting for stage, grade and the marker, but it doesn’t improve AUC by very much (from 0.798 to 0.800). You could go on to see that it also doesn’t reclassify very well.


```r
# Create variable indicating whether patient is high risk from imaging model
lesson6d_pred <-
  lesson6d_pred %>%
  mutate(
    imagingmodel_hirisk = if_else(imagingpred >= 0.1, 1, 0)
  )

# Two-way table of high risk status, based on marker model and imaging model
tbl_summary(
  lesson6d_pred %>% select(imagingmodel_hirisk, markermodel_hirisk),
  by = markermodel_hirisk,
  type = list("imagingmodel_hirisk" ~ "categorical")
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#jzetravkvy .gt_table {
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

#jzetravkvy .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#jzetravkvy .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#jzetravkvy .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#jzetravkvy .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#jzetravkvy .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#jzetravkvy .gt_col_heading {
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
  overflow-x: hidden;
}

#jzetravkvy .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#jzetravkvy .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#jzetravkvy .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#jzetravkvy .gt_group_heading {
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

#jzetravkvy .gt_empty_group_heading {
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

#jzetravkvy .gt_striped {
  background-color: #f2f2f2;
}

#jzetravkvy .gt_from_md > :first-child {
  margin-top: 0;
}

#jzetravkvy .gt_from_md > :last-child {
  margin-bottom: 0;
}

#jzetravkvy .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#jzetravkvy .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#jzetravkvy .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#jzetravkvy .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#jzetravkvy .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#jzetravkvy .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#jzetravkvy .gt_table_body {
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

#jzetravkvy .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#jzetravkvy .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#jzetravkvy .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#jzetravkvy .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#jzetravkvy .gt_center {
  text-align: center;
}

#jzetravkvy .gt_left {
  text-align: left;
}

#jzetravkvy .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#jzetravkvy .gt_font_normal {
  font-weight: normal;
}

#jzetravkvy .gt_font_bold {
  font-weight: bold;
}

#jzetravkvy .gt_font_italic {
  font-style: italic;
}

#jzetravkvy .gt_super {
  font-size: 65%;
}

#jzetravkvy .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="jzetravkvy" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 4163</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 2412</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">imagingmodel_hirisk</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">4073 (98%)</td>
      <td class="gt_row gt_center gt_striped">82 (3.4%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">90 (2.2%)</td>
      <td class="gt_row gt_center">2330 (97%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->



You'll see that only 172 patients are reclassified. It is questionable whether we'd want to do scans on ~6600 patients to reclassify 172 of them.

And here are the answers to the questions without data!

### lesson6e

**Hospitalized neutropenic patients were randomized to receive drug a or placebo. Bloods were taken every day. The time until patients were no longer neutropenic was measured (all patients eventually did get better).**

A possible answer might be:

<div class="quote-container">

>Mean time to recovery was ?? (SD ??) in the ?? patients randomized to drug a, compared to ?? (SD ??) in the ?? patients receiving placebo. The difference between means of ?? fewer / more days with neutropenia (95% C.I. ??, ??) was / was not statistically significant (p=??).

</div>

If the data were very skewed, which wouldn’t be uncommon for data of this sort, we might try the following, although obtaining a 95% confidence interval for the difference between medians is not straightforward. 

<div class="quote-container">

>Median time to recovery was ?? (interquartile range ?? - ??) in the ?? patients randomized to drug a, compared to ?? (interquartile range ?? - ??) in the ?? patients receiving placebo. The difference between medians of ?? fewer / more days with neutropenia (95% C.I. ??, ??) was / was not statistically significant (p=??). 
</div>

### lesson6f

**A new lab machine sometimes fails to give a readout with the result that the sample is wasted. To try and get a handle on this problem, a researcher carefully documents the number of failures for the 516 samples that she analyzes in the month of September.**

This is a simple one:

<div class="quote-container">

>Of the 516 samples analyzed in September, ?? led to a failed readout (??%, 95% C.I. ??%, ??%).

</div>

### lesson6g

**Drug a appears to be effective against cancer cells in vitro. Researchers create two new drugs, b and c, by making slight molecular rearrangements of drug a. The three drugs are then added to tumor cells in the test tube and the degree of cell growth measured.**

The key thing to think about here is the comparisons you want to make. Drug a already is known to work, so what you want to know is whether drug b or c might be more effective. So you want the comparison between drug a and b and between drug a and c, not between drug b and c. Hence you might have something like:

<div class="quote-container">

>Mean cell growth was ?? (SD??), ?? (SD??) and ?? (SD??) in cells treated by drugs a, b and c respectively. Drug b was more / less effective than drug a (difference between mean cell growth ??; 95% C.I. ??, ??). Drug c was more / less effective than drug a (difference between mean cell growth ??; 95% C.I. ??, ??).

</div>

## Week 7


```r
# Week 7: load packages
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

# Week 7: load data
lesson7a <- readRDS(here::here("Data", "Week 7", "lesson7a.rds"))
lesson7b <- readRDS(here::here("Data", "Week 7", "lesson7b.rds"))
lesson7c <- readRDS(here::here("Data", "Week 7", "lesson7c.rds"))
lesson7d <- readRDS(here::here("Data", "Week 7", "lesson7d.rds"))
```

### lesson7a.rds

**This is a large set of data on patients receiving adjuvant therapy after surgery for colon cancer. Describe this dataset and determine which, if any, variables are prognostic in this patient group.**

The data list the number of days of follow-up (survival_time), whether the patient was dead or alive at last follow-up (died), sex, age and various characteristics of the colon tumor.

First, create a "Surv" object to indicate that our outcome is a survival outcome:


```r
# Create survival outcome for time to death
lesson7a_surv <- Surv(lesson7a$survival_time, lesson7a$died)
```

We can then use `survfit` and `skim` to get the median time for all patients and for survivors only:


```r
# Median followup for all patients
survfit(lesson7a_surv ~ 1)
```

```
## Call: survfit(formula = lesson7a_surv ~ 1)
## 
##       n  events  median 0.95LCL 0.95UCL 
##     614     284    2910    2482      NA
```

```r
# Median followup for survivors
lesson7a %>%
  filter(died == 0) %>%
  skim(survival_time)
```

```
## Skim summary statistics
##  n obs: 330 
##  n variables: 9 
## 
## -- Variable type:numeric --------------------------------------------------------------------------
##       variable missing complete   n    mean     sd   p0  p25  p50    p75
##  survival_time       0      330 330 2389.38 336.23 1279 2162 2352 2625.5
##  p100     hist
##  3329 ▁▁▃▇▇▅▂▁
```

To look at predictors of survival, we might conduct a multivariable regression:


```r
# Multivariable Cox model for time to death
coxph(lesson7a_surv ~ sex + age + obstruction + perforation + adhesions + nodes,
      data = lesson7a)
```

```
## Call:
## coxph(formula = lesson7a_surv ~ sex + age + obstruction + perforation + 
##     adhesions + nodes, data = lesson7a)
## 
##                  coef exp(coef)  se(coef)      z        p
## sex         -0.013287  0.986801  0.121653 -0.109  0.91303
## age          0.004931  1.004943  0.005311  0.928  0.35321
## obstruction  0.397503  1.488104  0.151813  2.618  0.00884
## perforation -0.270916  0.762681  0.367464 -0.737  0.46097
## adhesions    0.331229  1.392679  0.162403  2.040  0.04140
## nodes        0.088444  1.092473  0.011733  7.538 4.76e-14
## 
## Likelihood ratio test=48  on 6 df, p=1.181e-08
## n= 599, number of events= 274 
##    (15 observations deleted due to missingness)
```

This suggests that the presence of obstruction or adhesion influences survival, as well as the number of nodes. Neither age (surprisingly) nor sex are likely to have a large impact (the confidence interval does not include any large differences between groups). The p value for perforation is non-significant, but the confidence intervals are wide. Why is this? Try this:


```r
# Table of perforation rate
tbl_summary(
  lesson7a %>% select(perforation)
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#myzlhqiesj .gt_table {
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

#myzlhqiesj .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#myzlhqiesj .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#myzlhqiesj .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#myzlhqiesj .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#myzlhqiesj .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#myzlhqiesj .gt_col_heading {
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
  overflow-x: hidden;
}

#myzlhqiesj .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#myzlhqiesj .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#myzlhqiesj .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#myzlhqiesj .gt_group_heading {
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

#myzlhqiesj .gt_empty_group_heading {
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

#myzlhqiesj .gt_striped {
  background-color: #f2f2f2;
}

#myzlhqiesj .gt_from_md > :first-child {
  margin-top: 0;
}

#myzlhqiesj .gt_from_md > :last-child {
  margin-bottom: 0;
}

#myzlhqiesj .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#myzlhqiesj .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#myzlhqiesj .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#myzlhqiesj .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#myzlhqiesj .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#myzlhqiesj .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#myzlhqiesj .gt_table_body {
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

#myzlhqiesj .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#myzlhqiesj .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#myzlhqiesj .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#myzlhqiesj .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#myzlhqiesj .gt_center {
  text-align: center;
}

#myzlhqiesj .gt_left {
  text-align: left;
}

#myzlhqiesj .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#myzlhqiesj .gt_font_normal {
  font-weight: normal;
}

#myzlhqiesj .gt_font_bold {
  font-weight: bold;
}

#myzlhqiesj .gt_font_italic {
  font-style: italic;
}

#myzlhqiesj .gt_super {
  font-size: 65%;
}

#myzlhqiesj .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="myzlhqiesj" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>N = 614</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">perforation</td>
      <td class="gt_row gt_center">18 (2.9%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="2">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

You will see that less than 3% of patients had perforations, making it almost impossible to assess its predictive value. Another useful thing to do is to try:


```r
# Summarize number of nodes
lesson7a %>%
  skim(nodes)
```

```
## Skim summary statistics
##  n obs: 614 
##  n variables: 9 
## 
## -- Variable type:numeric --------------------------------------------------------------------------
##  variable missing complete   n mean   sd p0 p25 p50 p75 p100     hist
##     nodes      15      599 614 3.59 3.49  0   1   2 4.5   33 ▇▂▁▁▁▁▁▁
```

You can see that patients had up to 33 nodes affected, yet all but a handful had 10 or fewer nodes. This might make us somewhat suspicious of the coefficient for nodes (which is interpreted as increase in hazard ratio for each additional node). One possibility might be to:


```r
# Exclude patients with > 10 notes
lesson7a <-
  lesson7a %>%
  mutate(
    n2 = 
      case_when(nodes <= 10 ~ nodes)
    # This sets "n2" to missing for those with > 10 nodes
  )

# Re-run cox model using "n2" (excluding patients with > 10 nodes)
coxph(lesson7a_surv ~ sex + age + obstruction + perforation + adhesions + n2, data = lesson7a)
```

```
## Call:
## coxph(formula = lesson7a_surv ~ sex + age + obstruction + perforation + 
##     adhesions + n2, data = lesson7a)
## 
##                  coef exp(coef)  se(coef)      z        p
## sex         -0.023829  0.976453  0.126137 -0.189  0.85016
## age          0.006556  1.006578  0.005656  1.159  0.24639
## obstruction  0.401656  1.494298  0.155456  2.584  0.00977
## perforation -0.379466  0.684227  0.367198 -1.033  0.30141
## adhesions    0.460898  1.585497  0.166016  2.776  0.00550
## n2           0.176562  1.193108  0.023749  7.435 1.05e-13
## 
## Likelihood ratio test=56.7  on 6 df, p=2.106e-10
## n= 571, number of events= 253 
##    (43 observations deleted due to missingness)
```

This creates a new variable that excludes patients with large numbers of nodes from the analysis. However, it might be better to group patients. Here we create a new variable called "node4" that groups patients into four groups: 0 – 2 nodes, 3 – 5 nodes, 5 – 10 nodes, 11 or more nodes.


```r
# Categorize values of nodes removed
lesson7a <-
  lesson7a %>%
  mutate(
    node4 =
      case_when(
        nodes <= 2 ~ 1,
        nodes > 2 & nodes <= 5 ~ 2,
        nodes > 5 & nodes <= 10 ~ 3,
        nodes > 10 ~ 4
      )
  )
```

The "cut-points" are arbitrary but are not particularly important unless you think the effect of nodes radically changes at one particular cut point or another.

The regression code would then be:


```r
# Re-run Cox model using categorized variable for nodes
# Since "node4" is categorical, we must use "factor()" with this variable
coxph(lesson7a_surv ~ sex + age + obstruction + perforation + adhesions + factor(node4),
      data = lesson7a)
```

```
## Call:
## coxph(formula = lesson7a_surv ~ sex + age + obstruction + perforation + 
##     adhesions + factor(node4), data = lesson7a)
## 
##                     coef exp(coef)  se(coef)      z        p
## sex            -0.001937  0.998065  0.121949 -0.016 0.987326
## age             0.004899  1.004912  0.005364  0.913 0.361041
## obstruction     0.381416  1.464357  0.150828  2.529 0.011445
## perforation    -0.338675  0.712714  0.369481 -0.917 0.359341
## adhesions       0.373402  1.452668  0.163292  2.287 0.022212
## factor(node4)2  0.497687  1.644913  0.147630  3.371 0.000748
## factor(node4)3  1.078693  2.940832  0.161449  6.681 2.37e-11
## factor(node4)4  1.187162  3.277766  0.241102  4.924 8.48e-07
## 
## Likelihood ratio test=60.22  on 8 df, p=4.213e-10
## n= 599, number of events= 274 
##    (15 observations deleted due to missingness)
```



A model answer for this dataset might be:

<div class="quote-container">

>Median survival in the 614 patients in the cohort was 8.0 years, with a median duration of follow-up for survivors of 6.4. There were 284 deaths during follow-up. Although about 95% of patients had ten nodes or fewer, a small number of patients had a very large number of affected nodes, up to 33 in one case. Nodes were therefore categorized as 0-2, 3-5, 6-10, 11+. In a Cox regression of the 599 patients with complete data, obstruction, adhesion and number of nodes were predictive of survival. Neither sex, age or perforation appeared to influence survival. Fewer than 3% of patients experienced and this variable was therefore removed from the model. Patient characteristics and results for the final model are given in the table.

</div>

**Table 1.** Patient Characteristics

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#mexgygslyy .gt_table {
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

#mexgygslyy .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#mexgygslyy .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#mexgygslyy .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#mexgygslyy .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#mexgygslyy .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#mexgygslyy .gt_col_heading {
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
  overflow-x: hidden;
}

#mexgygslyy .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#mexgygslyy .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#mexgygslyy .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#mexgygslyy .gt_group_heading {
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

#mexgygslyy .gt_empty_group_heading {
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

#mexgygslyy .gt_striped {
  background-color: #f2f2f2;
}

#mexgygslyy .gt_from_md > :first-child {
  margin-top: 0;
}

#mexgygslyy .gt_from_md > :last-child {
  margin-bottom: 0;
}

#mexgygslyy .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#mexgygslyy .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#mexgygslyy .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#mexgygslyy .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#mexgygslyy .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#mexgygslyy .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#mexgygslyy .gt_table_body {
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

#mexgygslyy .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#mexgygslyy .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#mexgygslyy .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#mexgygslyy .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#mexgygslyy .gt_center {
  text-align: center;
}

#mexgygslyy .gt_left {
  text-align: left;
}

#mexgygslyy .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#mexgygslyy .gt_font_normal {
  font-weight: normal;
}

#mexgygslyy .gt_font_bold {
  font-weight: bold;
}

#mexgygslyy .gt_font_italic {
  font-style: italic;
}

#mexgygslyy .gt_super {
  font-size: 65%;
}

#mexgygslyy .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="mexgygslyy" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>N = 614</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Sex</td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">296 (48%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">318 (52%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Age</td>
      <td class="gt_row gt_center gt_striped">61 (53, 69)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Obstruction</td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center gt_striped">497 (81%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">117 (19%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Adhesions</td>
      <td class="gt_row gt_center gt_striped"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center">526 (86%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center gt_striped">88 (14%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">node4</td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center gt_striped">311 (52%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">2</td>
      <td class="gt_row gt_center">168 (28%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">3</td>
      <td class="gt_row gt_center gt_striped">92 (15%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">4</td>
      <td class="gt_row gt_center">28 (4.7%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">Unknown</td>
      <td class="gt_row gt_center gt_striped">15</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="2">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%); median (IQR)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

**Table 2.** Results of Cox proportional hazards model for time to death

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#zrfktzocbr .gt_table {
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

#zrfktzocbr .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#zrfktzocbr .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#zrfktzocbr .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#zrfktzocbr .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#zrfktzocbr .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#zrfktzocbr .gt_col_heading {
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
  overflow-x: hidden;
}

#zrfktzocbr .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#zrfktzocbr .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#zrfktzocbr .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#zrfktzocbr .gt_group_heading {
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

#zrfktzocbr .gt_empty_group_heading {
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

#zrfktzocbr .gt_striped {
  background-color: #f2f2f2;
}

#zrfktzocbr .gt_from_md > :first-child {
  margin-top: 0;
}

#zrfktzocbr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#zrfktzocbr .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#zrfktzocbr .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#zrfktzocbr .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#zrfktzocbr .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#zrfktzocbr .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#zrfktzocbr .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#zrfktzocbr .gt_table_body {
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

#zrfktzocbr .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#zrfktzocbr .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#zrfktzocbr .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#zrfktzocbr .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#zrfktzocbr .gt_center {
  text-align: center;
}

#zrfktzocbr .gt_left {
  text-align: left;
}

#zrfktzocbr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#zrfktzocbr .gt_font_normal {
  font-weight: normal;
}

#zrfktzocbr .gt_font_bold {
  font-weight: bold;
}

#zrfktzocbr .gt_font_italic {
  font-style: italic;
}

#zrfktzocbr .gt_super {
  font-size: 65%;
}

#zrfktzocbr .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="zrfktzocbr" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 599</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>HR</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Female</td>
      <td class="gt_row gt_center">0.99</td>
      <td class="gt_row gt_center">0.78, 1.26</td>
      <td class="gt_row gt_center">>0.9</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Age (per 1 year)</td>
      <td class="gt_row gt_center gt_striped">1.01</td>
      <td class="gt_row gt_center gt_striped">0.99, 1.02</td>
      <td class="gt_row gt_center gt_striped">0.3</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">Obstruction</td>
      <td class="gt_row gt_center">1.44</td>
      <td class="gt_row gt_center">1.07, 1.93</td>
      <td class="gt_row gt_center">0.015</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped">Adhesions</td>
      <td class="gt_row gt_center gt_striped">1.41</td>
      <td class="gt_row gt_center gt_striped">1.03, 1.93</td>
      <td class="gt_row gt_center gt_striped">0.032</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">factor(node4)</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center gt_striped">&mdash;</td>
      <td class="gt_row gt_center gt_striped">&mdash;</td>
      <td class="gt_row gt_center gt_striped"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">2</td>
      <td class="gt_row gt_center">1.62</td>
      <td class="gt_row gt_center">1.21, 2.16</td>
      <td class="gt_row gt_center">0.001</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">3</td>
      <td class="gt_row gt_center gt_striped">2.93</td>
      <td class="gt_row gt_center gt_striped">2.14, 4.02</td>
      <td class="gt_row gt_center gt_striped"><0.001</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">4</td>
      <td class="gt_row gt_center">3.30</td>
      <td class="gt_row gt_center">2.06, 5.29</td>
      <td class="gt_row gt_center"><0.001</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          HR = Hazard Ratio, CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

### lesson7b.rds

**These are time to recurrence data on forty patients with biliary cancer treated at one of two hospitals, one of which treats a large number of cancer patients and one of which does not. Do patients treated at a “high volume” hospital have a longer time to recurrence?**

We can test the difference between groups by using the `survdiff` function:


```r
# Test for difference in time to recurrence by hivolume
survdiff(Surv(lesson7b$time, lesson7b$recurrence) ~ lesson7b$hivolume)
```

```
## Call:
## survdiff(formula = Surv(lesson7b$time, lesson7b$recurrence) ~ 
##     lesson7b$hivolume)
## 
##                      N Observed Expected (O-E)^2/E (O-E)^2/V
## lesson7b$hivolume=0 20        7      4.5      1.39      2.53
## lesson7b$hivolume=1 20        3      5.5      1.14      2.53
## 
##  Chisq= 2.5  on 1 degrees of freedom, p= 0.1
```



We get a p-value of 0.11.

This is not sufficient evidence to conclude that high volume hospitals and more experienced surgeons lower recurrence rates. However, could there be a difference and the trial was not large enough to detect it? The key point here is not sample size, but the number of "events" (typically recurrences or deaths). Even if you had a trial of 100,000 patients, if only one or two people died you would not have any data on length of survival to test. In this dataset, though there were 40 patients, there were only ten events. You can see that if you use the `survfit` function:


```r
# Look at number of recurrence events in this dataset
survfit(Surv(lesson7b$time, lesson7b$recurrence) ~ 1)
```

```
## Call: survfit(formula = Surv(lesson7b$time, lesson7b$recurrence) ~ 
##     1)
## 
##       n  events  median 0.95LCL 0.95UCL 
##      40      10      NA      NA      NA
```

You can then look at a Cox model:


```r
# Cox model for time to recurrence
lesson7b_cox <-
  coxph(Surv(time, recurrence) ~ hivolume, data = lesson7b)
tbl_regression(lesson7b_cox, exponentiate = TRUE)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#qeykezvosr .gt_table {
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

#qeykezvosr .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#qeykezvosr .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#qeykezvosr .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#qeykezvosr .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#qeykezvosr .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#qeykezvosr .gt_col_heading {
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
  overflow-x: hidden;
}

#qeykezvosr .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#qeykezvosr .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#qeykezvosr .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#qeykezvosr .gt_group_heading {
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

#qeykezvosr .gt_empty_group_heading {
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

#qeykezvosr .gt_striped {
  background-color: #f2f2f2;
}

#qeykezvosr .gt_from_md > :first-child {
  margin-top: 0;
}

#qeykezvosr .gt_from_md > :last-child {
  margin-bottom: 0;
}

#qeykezvosr .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#qeykezvosr .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#qeykezvosr .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#qeykezvosr .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#qeykezvosr .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#qeykezvosr .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#qeykezvosr .gt_table_body {
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

#qeykezvosr .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#qeykezvosr .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#qeykezvosr .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#qeykezvosr .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#qeykezvosr .gt_center {
  text-align: center;
}

#qeykezvosr .gt_left {
  text-align: left;
}

#qeykezvosr .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#qeykezvosr .gt_font_normal {
  font-weight: normal;
}

#qeykezvosr .gt_font_bold {
  font-weight: bold;
}

#qeykezvosr .gt_font_italic {
  font-style: italic;
}

#qeykezvosr .gt_super {
  font-size: 65%;
}

#qeykezvosr .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="qeykezvosr" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>N = 40</strong></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>HR</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>95% CI</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong></th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">1 = high volume, 0 = low volume</td>
      <td class="gt_row gt_center">0.35</td>
      <td class="gt_row gt_center">0.09, 1.35</td>
      <td class="gt_row gt_center">0.13</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          HR = Hazard Ratio, CI = Confidence Interval
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

You find that the hazard ratio for survival is 0.35. The 95% CI is 0.09, 1.35. Clearly, high volume hospitals seem to do better, this dataset just isn’t large enough to see it. 



A model answer:

<div class="quote-container">

>At a median follow-up for survivors of 44 months, 3 patients in the high volume hospital had recurred compared to 7 in the low volume hospital (Figure 1, p=0.11 by log-rank test). Median has not been reached in either group. The hazard ratio of 0.35 (95% CI 0.09, 1.35) suggests that a large difference between groups may not have been detected at this stage of follow-up.

</div>

**Figure 1.** Kaplan-Meier curve for recurrence in low volume (blue) and high volume (red) centers

<img src="09-answers_files/figure-html/week7q-1.png" width="672" />

Another way of doing this would be to estimate survival at say, 6, 12 and 18 months in each hospital. The command would be:


```r
# Estimate survival at 6, 12 and 18 months
summary(survfit(Surv(lesson7b$time, lesson7b$recurrence) ~ lesson7b$hivolume),
        times = c(183, 365, 548))
```

```
## Call: survfit(formula = Surv(lesson7b$time, lesson7b$recurrence) ~ 
##     lesson7b$hivolume)
## 
##                 lesson7b$hivolume=0 
##  time n.risk n.event survival std.err lower 95% CI upper 95% CI
##   183     18       2    0.900  0.0671        0.778        1.000
##   365     15       3    0.750  0.0968        0.582        0.966
##   548      5       2    0.556  0.1404        0.339        0.912
## 
##                 lesson7b$hivolume=1 
##  time n.risk n.event survival std.err lower 95% CI upper 95% CI
##   183     20       0    1.000  0.0000        1.000            1
##   365     18       2    0.900  0.0671        0.778            1
##   548     10       1    0.847  0.0814        0.702            1
```

You could report survival of 100%, 90%, and 85% in the high volume hospital compared to 90%, 75% and 56% in the low volume hospital.

### lesson7c.rds

**These are data from a randomized trial comparing no treatment, 5FU (a chemotherapy agent) and 5FU plus levamisole in the adjuvant treatment of colon cancer. Describe the dataset. What conclusions would you draw about the effectiveness of the different treatments?**



Let's jump straight to the model answer.

<div class="quote-container">

The study consisted of 929 patients, of whom 452 died during the study. Median duration of follow-up for survivors was 6.4 years. Median survival in the control and 5FU groups was 5.7 and 5.9, respectively; median survival for the combination group has not been reached (see figure). The overall log-rank test was significant (p=0.003), suggesting that the survival is different between groups. In a multivariable Cox regression with group coded as two dummy variables (5FU and Levamisole), 5FU was found to have little effect on survival (HR 0.97 (95% CI 0.78, 1.21; p=0.8)). Levamisole, however, led to significantly increased survival (hazard ratio 0.69 (95% CI 0.55, 0.87; p=0.002)).

**Figure**

</div>

<img src="09-answers_files/figure-html/week7t-1.png" width="672" />

In case you are wondering how I did all this, one key is to see that in the dataset "group" and "treatment" are equivalent:


```r
# Two-way table of group by treatment
tbl_summary(
  lesson7c %>% select(group, treatment),
  by = treatment
)
```

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#vscgzddlst .gt_table {
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

#vscgzddlst .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#vscgzddlst .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#vscgzddlst .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 2px;
  padding-bottom: 2px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#vscgzddlst .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#vscgzddlst .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#vscgzddlst .gt_col_heading {
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
  overflow-x: hidden;
}

#vscgzddlst .gt_columns_top_border {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#vscgzddlst .gt_columns_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
}

#vscgzddlst .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#vscgzddlst .gt_group_heading {
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

#vscgzddlst .gt_empty_group_heading {
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

#vscgzddlst .gt_striped {
  background-color: #f2f2f2;
}

#vscgzddlst .gt_from_md > :first-child {
  margin-top: 0;
}

#vscgzddlst .gt_from_md > :last-child {
  margin-bottom: 0;
}

#vscgzddlst .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
  overflow-x: hidden;
}

#vscgzddlst .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#vscgzddlst .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#vscgzddlst .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#vscgzddlst .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#vscgzddlst .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#vscgzddlst .gt_table_body {
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

#vscgzddlst .gt_footnotes {
  border-top-style: solid;
  /* footnotes.border.top.style */
  border-top-width: 2px;
  /* footnotes.border.top.width */
  border-top-color: #A8A8A8;
  /* footnotes.border.top.color */
}

#vscgzddlst .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  margin: 0px;
  padding: 4px;
  /* footnote.padding */
}

#vscgzddlst .gt_sourcenotes {
  border-top-style: solid;
  /* sourcenotes.border.top.style */
  border-top-width: 2px;
  /* sourcenotes.border.top.width */
  border-top-color: #A8A8A8;
  /* sourcenotes.border.top.color */
}

#vscgzddlst .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#vscgzddlst .gt_center {
  text-align: center;
}

#vscgzddlst .gt_left {
  text-align: left;
}

#vscgzddlst .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#vscgzddlst .gt_font_normal {
  font-weight: normal;
}

#vscgzddlst .gt_font_bold {
  font-weight: bold;
}

#vscgzddlst .gt_font_italic {
  font-style: italic;
}

#vscgzddlst .gt_super {
  font-size: 65%;
}

#vscgzddlst .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="vscgzddlst" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <tr>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong><sup class="gt_footnote_marks">1</sup></th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>5FU</strong>, N = 310</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>5FU+Levamisole</strong>, N = 304</th>
    <th class="gt_col_heading gt_columns_bottom_border gt_columns_top_border gt_center" rowspan="1" colspan="1"><strong>control</strong>, N = 315</th>
  </tr>
  <body class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">group</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center gt_striped">0 (0%)</td>
      <td class="gt_row gt_center gt_striped">0 (0%)</td>
      <td class="gt_row gt_center gt_striped">315 (100%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">2</td>
      <td class="gt_row gt_center">310 (100%)</td>
      <td class="gt_row gt_center">0 (0%)</td>
      <td class="gt_row gt_center">0 (0%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left gt_striped" style="text-align: left; text-indent: 10px;">3</td>
      <td class="gt_row gt_center gt_striped">0 (0%)</td>
      <td class="gt_row gt_center gt_striped">304 (100%)</td>
      <td class="gt_row gt_center gt_striped">0 (0%)</td>
    </tr>
  </body>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          Statistics presented: n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div><!--/html_preserve-->

When I did the graph, I used the variable "treatment" to get the names of the treatments (rather than the group number). I also used a function called `ggsurvplot` (from the `survminer` package) rather than the standard `plot` option, because `ggsurvplot` allows more customization to the graph.


```r
# Create Kaplan-Meier plot by treatment group
survminer::ggsurvplot(survfit(Surv(survival_time/365.25, died) ~ treatment, data = lesson7c),
                      legend = "bottom")
```

<img src="09-answers_files/figure-html/week7v-1.png" width="672" />

When I did the Cox regression, I created dummy variables by typing:


```r
# Create dummy variable for treatment
lesson7c <-
  lesson7c %>%
  mutate(
    fu = if_else(group == 2, 1, 0),
    lev = if_else(group == 3, 1, 0)
  )
```

Then it was straightforward to create the cox model and get the overall p-value from the `survdiff` function.


```r
# Cox model with dummy variables
coxph(Surv(survival_time, died) ~ fu + lev, data = lesson7c)
```

```
## Call:
## coxph(formula = Surv(survival_time, died) ~ fu + lev, data = lesson7c)
## 
##         coef exp(coef) se(coef)      z       p
## fu  -0.02664   0.97371  0.11030 -0.241 0.80917
## lev -0.37171   0.68955  0.11875 -3.130 0.00175
## 
## Likelihood ratio test=12.15  on 2 df, p=0.002302
## n= 929, number of events= 452
```

```r
# Overall p-value for all 3 groups
survdiff(Surv(survival_time, died) ~ group, data = lesson7c)
```

```
## Call:
## survdiff(formula = Surv(survival_time, died) ~ group, data = lesson7c)
## 
##           N Observed Expected (O-E)^2/E (O-E)^2/V
## group=1 315      168      148      2.58      3.85
## group=2 310      161      146      1.52      2.25
## group=3 304      123      157      7.55     11.62
## 
##  Chisq= 11.7  on 2 degrees of freedom, p= 0.003
```

Any oncologists notice a problem here? It is this: Levamisole doesn’t work at all, but 5FU (obviously) does. It turns out that this whole dataset (which I downloaded from the internet) was miscoded: it should have been: control, levamisole alone, levamisole + 5FU. Which goes to show the importance of checking your data.

### lesson7d.rds

**More data on time to recurrence by hospital volume. Given this dataset, determine whether patients treated at a “high volume” hospital have a longer time to recurrence.**

These data are comparable to lesson7b.rds, except with a longer length of follow-up. There are more recurrences (events) because more time has elapsed. So though the hazard ratio is very similar, and the number of patients identical, the confidence interval is much narrower and the results statistically significant. However, do be careful about drawing causal inferences: just because recurrence rates are lower at the high volume hospital, it doesn't mean that treatment at a high volume hospital reduces risk of recurrence. There may be other differences between hospitals (e.g. case mix).

