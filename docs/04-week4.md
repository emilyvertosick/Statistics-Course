

# Week 4

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

# Load data necessary to run Week 4 examples
lesson2a <- readRDS(here::here("Data", "Week 2", "lesson2a.rds"))
lesson3a <- readRDS(here::here("Data", "Week 3", "lesson3a.rds"))
example4a <- readRDS(here::here("Data", "Week 4", "example4a.rds"))
```

## R Instructions

Here are some of the commands you might use when analyzing epidemiological data or data that has a similar form. For example, if you had two variables "diet" (where 1 = high fat, 0 = low fat) and "hypertension", you could use the same forms of analysis regardless of whether you were investigating a randomized trial (dietary advice assigned randomly to patients) or an epidemiological study (patients interviewed about eating habits). You can also use these methods for lab data (e.g. proportion of mice with a knockout versus wild type who develop a tumor).

### Tables

The first command is the `tbl_summary` function from the `gtsummary` package which makes a table. This was introduced in the week 1 lesson. We are interested in "two-way" tables. In other words, we are not interested in just how many people had hypertension, but in the number of people who had hypertension in each different category of diet.

I’ll use the dataset for assignment 3a ("lesson3a.rds") to illustrate these points. This dataset includes patients who had prior chemotherapy, patient sex, and whether patients had postoperative nausea and vomiting.


```r
# Create twoway table of prior chemotherapy by sex
tbl_summary(
  lesson3a %>% select(pc, sex),
  by = sex,
  type = list("pc" ~ "categorical")
)
```

```{=html}
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#iwrgxmosvm .gt_table {
  display: table;
  border-collapse: collapse;
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

#iwrgxmosvm .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#iwrgxmosvm .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
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
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#iwrgxmosvm .gt_group_heading {
  padding: 8px;
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
  padding-left: 12px;
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
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
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
  padding: 4px;
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
  padding: 4px;
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
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="iwrgxmosvm" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 523<sup class="gt_footnote_marks">1</sup></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 575<sup class="gt_footnote_marks">1</sup></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">previous chemo:1 if yes</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center">160 (51%)</td>
      <td class="gt_row gt_center">161 (50%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">156 (49%)</td>
      <td class="gt_row gt_center">162 (50%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Unknown</td>
      <td class="gt_row gt_center">207</td>
      <td class="gt_row gt_center">252</td>
    </tr>
  </tbody>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="3">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div>
```



<br>

So, for example, we can see that there were 575 women, 162 had prior chemo and 161 had no prior chemo. You can see that 252 women were missing data on prior chemotherapy use. By default, the table shows the percent among all observations with non-missing data.

This table also tells us that among men with prior chemotherapy data available, 51% had no prior chemo, and 49% had prior chemo.

As mentioned in lesson 2, the `tbl_summary` command gives column percentages by default, but can also give row percents using the `percent = "row"` option:


```r
# Create twoway table with "overall" column and display row percents
tbl_summary(
  lesson3a %>% select(pc, sex),
  by = sex,
  type = list("pc" ~ "categorical"),
  percent = "row"
) %>%
  add_overall(last = TRUE)
```

```{=html}
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#hlleqxdave .gt_table {
  display: table;
  border-collapse: collapse;
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

#hlleqxdave .gt_heading {
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

#hlleqxdave .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#hlleqxdave .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#hlleqxdave .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hlleqxdave .gt_col_headings {
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

#hlleqxdave .gt_col_heading {
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

#hlleqxdave .gt_column_spanner_outer {
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

#hlleqxdave .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#hlleqxdave .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#hlleqxdave .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#hlleqxdave .gt_group_heading {
  padding: 8px;
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
}

#hlleqxdave .gt_empty_group_heading {
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

#hlleqxdave .gt_from_md > :first-child {
  margin-top: 0;
}

#hlleqxdave .gt_from_md > :last-child {
  margin-bottom: 0;
}

#hlleqxdave .gt_row {
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

#hlleqxdave .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#hlleqxdave .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hlleqxdave .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#hlleqxdave .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hlleqxdave .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#hlleqxdave .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#hlleqxdave .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hlleqxdave .gt_footnotes {
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

#hlleqxdave .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#hlleqxdave .gt_sourcenotes {
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

#hlleqxdave .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#hlleqxdave .gt_left {
  text-align: left;
}

#hlleqxdave .gt_center {
  text-align: center;
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
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 523<sup class="gt_footnote_marks">1</sup></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 575<sup class="gt_footnote_marks">1</sup></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>Overall</strong>, N = 1,098<sup class="gt_footnote_marks">1</sup></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">previous chemo:1 if yes</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center">160 (50%)</td>
      <td class="gt_row gt_center">161 (50%)</td>
      <td class="gt_row gt_center">321 (100%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">156 (49%)</td>
      <td class="gt_row gt_center">162 (51%)</td>
      <td class="gt_row gt_center">318 (100%)</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">Unknown</td>
      <td class="gt_row gt_center">207</td>
      <td class="gt_row gt_center">252</td>
      <td class="gt_row gt_center">459</td>
    </tr>
  </tbody>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          n (%)
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div>
```

```r
# Setting the "last" option to TRUE puts the column with statistics for the overall cohort in the last column of the table
# The defaults etting, "last = FALSE", would put this column first in the table
```

<br>

So of the 318 patients who had previous chemo, 51% were women and 49% were men.

Now let’s use the marathon data ("lesson2a.rds") to do something more interesting. First, I created a new category called "subfourhour" for those runners who completed the marathon in less than four hours.


```r
# Create a new variable that indicates whether patients had marathon time <= 240 minutes
lesson2a <-
  lesson2a %>%
  mutate(subfourhour =
           if_else(rt <= 240, 1, 0))
```

The `table` function is a way to make very simple tables, which is useful for doing statistical tests, although these tables do not provide as much information (variable names, totals, percentages, etc.) as `tbl_summary`.


```r
# The first variable is the row variable
# The second variable is the column variable
table(lesson2a$subfourhour, lesson2a$sex)
```

```
##    
##      0  1
##   0 30 21
##   1 36 11
```

We can compare sub-four hour marathons by sex using a chi-squared test (`chisq.test` function). The option `correct = FALSE` indicates that the default continuity correction should not be used.


```r
# Create the table and then perform the chi-squared test
table(lesson2a$subfourhour, lesson2a$sex) %>%
  chisq.test(correct = FALSE)
```

```
## 
## 	Pearson's Chi-squared test
## 
## data:  .
## X-squared = 3.513, df = 1, p-value = 0.06089
```

As a note, we can also use `tbl_summary` and the `add_p` function (also from `gtsummary`) to get the chi-squared p-value. In the `add_p` function, we specify that for the variable "subfourhour" we want to use a chi-squared test ("chisq.test.no.correct"). Specifying "chisq.test.no.correct" uses no continuity correction, and so gives the same result as the `chisq.test` function with the option `correct = FALSE`.


```r
# Create two-way table including chi-squared p-value
tbl_summary(
  lesson2a %>% select(subfourhour, sex),
  by = sex,
  type = list("subfourhour" ~ "categorical")
) %>%
  add_p(test = list("subfourhour" ~ "chisq.test.no.correct"))
```

```{=html}
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#kqtxbhydst .gt_table {
  display: table;
  border-collapse: collapse;
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

#kqtxbhydst .gt_heading {
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

#kqtxbhydst .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#kqtxbhydst .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#kqtxbhydst .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kqtxbhydst .gt_col_headings {
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

#kqtxbhydst .gt_col_heading {
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

#kqtxbhydst .gt_column_spanner_outer {
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

#kqtxbhydst .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#kqtxbhydst .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#kqtxbhydst .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#kqtxbhydst .gt_group_heading {
  padding: 8px;
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
}

#kqtxbhydst .gt_empty_group_heading {
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

#kqtxbhydst .gt_from_md > :first-child {
  margin-top: 0;
}

#kqtxbhydst .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kqtxbhydst .gt_row {
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

#kqtxbhydst .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#kqtxbhydst .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kqtxbhydst .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#kqtxbhydst .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kqtxbhydst .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#kqtxbhydst .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#kqtxbhydst .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kqtxbhydst .gt_footnotes {
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

#kqtxbhydst .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#kqtxbhydst .gt_sourcenotes {
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

#kqtxbhydst .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#kqtxbhydst .gt_left {
  text-align: left;
}

#kqtxbhydst .gt_center {
  text-align: center;
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
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 66<sup class="gt_footnote_marks">1</sup></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 32<sup class="gt_footnote_marks">1</sup></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong><sup class="gt_footnote_marks">2</sup></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">subfourhour</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center">0.061</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center">30 (45%)</td>
      <td class="gt_row gt_center">21 (66%)</td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">36 (55%)</td>
      <td class="gt_row gt_center">11 (34%)</td>
      <td class="gt_row gt_center"></td>
    </tr>
  </tbody>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          n (%)
          <br />
        </p>
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>2</em>
          </sup>
           
          Pearson's Chi-squared test
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div>
```

<br>



So whereas 55% of men completed the race in less than four hours, only 34% of women did so. The p-value here is 0.061.

**Should you categorize a continuous variable?**

If you are interested only:

Remember that the p-value when we did a t-test (`t.test(rt ~ sex, data = lesson2a, var.equal = TRUE)`) was 0.032. That is, the p-value was lower when we kept race time as a continuous variable, than when we categorized it. The reason is that we are losing information: we are treating someone who ran the race in 2.5 hours the same as someone who ran it in 3.9 hours. So in general, you should avoid turning continuous variables into categorical variables for the purposes of statistical analysis.

### Getting estimates: risk difference, risk ratio, odds ratio

This table gives you a p-value, but not an estimate. For this, we need the `epi.2by2` function from the `epiR` package. This function works for "cohort studies" and applies equally well to formal epidemiologic studies, retrospective analysis of datasets (such as in this marathon running example) or for randomized trials. You will give the `epi.2by2` function the endpoint and the cohort (see below for more details). "Endpoint" will be something like cancer, response, progression, or running a marathon in under four hours. "Cohort" is what you think might make a difference, like a toxin, chemotherapy, a genetic mutation, or gender.

The language we've been using is a little unusual for this example. A "case" is running a marathon in under four hours (i.e., subfourhour == 1). "Exposed" means that you are a woman (i.e. sex == 1). "Risk" means the proportion of patients who were a "case".

**Odds, odds ratios, risk and relative risk**

The `epi.2by2` function will give you a number of different estimates, including the odds, odds ratio, risk and relative risk. Note that in the `epi.2by2` output, the risk is in the column "Inc risk *" and the relative risk is listed as "Inc risk ratio" under "Point estimates and 95% CIs."

The probability of something is defined as the number of times it occurs divided by the total number of observations. If you do a study of 1000 patients, of whom 250 experience a surgical complication, you’d say that the probability of a complication was 250 ÷ 1000 = 25%. The odds of something is defined as the number of times it occurs divided by the number of times it doesn’t occur. The odds of a complication are therefore 250 ÷ 750 = 1 ÷ 3 = 0.33. Here are some examples of probabilities and odds:


```{=html}
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#qzjvxzfwte .gt_table {
  display: table;
  border-collapse: collapse;
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

#qzjvxzfwte .gt_heading {
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

#qzjvxzfwte .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#qzjvxzfwte .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#qzjvxzfwte .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qzjvxzfwte .gt_col_headings {
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

#qzjvxzfwte .gt_col_heading {
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

#qzjvxzfwte .gt_column_spanner_outer {
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

#qzjvxzfwte .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#qzjvxzfwte .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#qzjvxzfwte .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#qzjvxzfwte .gt_group_heading {
  padding: 8px;
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
}

#qzjvxzfwte .gt_empty_group_heading {
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

#qzjvxzfwte .gt_from_md > :first-child {
  margin-top: 0;
}

#qzjvxzfwte .gt_from_md > :last-child {
  margin-bottom: 0;
}

#qzjvxzfwte .gt_row {
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

#qzjvxzfwte .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#qzjvxzfwte .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qzjvxzfwte .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#qzjvxzfwte .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qzjvxzfwte .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#qzjvxzfwte .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#qzjvxzfwte .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qzjvxzfwte .gt_footnotes {
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

#qzjvxzfwte .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#qzjvxzfwte .gt_sourcenotes {
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

#qzjvxzfwte .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#qzjvxzfwte .gt_left {
  text-align: left;
}

#qzjvxzfwte .gt_center {
  text-align: center;
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
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">Probability of the event (e.g. surgical complication)</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">Probability of no event (e.g. no complication)</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">Odds of the event</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">50%</td>
      <td class="gt_row gt_left">50%</td>
      <td class="gt_row gt_left">1.000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">25%</td>
      <td class="gt_row gt_left">75%</td>
      <td class="gt_row gt_left">0.3333</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">10%</td>
      <td class="gt_row gt_left">90%</td>
      <td class="gt_row gt_left">0.1111</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">90%</td>
      <td class="gt_row gt_left">10%</td>
      <td class="gt_row gt_left">9.000</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">5%</td>
      <td class="gt_row gt_left">95%</td>
      <td class="gt_row gt_left">0.0526</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">2%</td>
      <td class="gt_row gt_left">98%</td>
      <td class="gt_row gt_left">0.0204</td>
    </tr>
    <tr>
      <td class="gt_row gt_left">1%</td>
      <td class="gt_row gt_left">99%</td>
      <td class="gt_row gt_left">0.0101</td>
    </tr>
  </tbody>
  
  
</table></div>
```

One thing you might notice is that when something doesn’t happen very often, the odds and the probability are very similar. So, for example, something with a probability of 5% (0.05) has an odds of 0.0526. This has important implications for interpreting odds ratios. You will often see in the literature something like “the odds ratio for stage was 1.26, so patients with high stage disease had a 26% higher risk of complications”. This statement is wrong because if the odds ratio is 1.26 then the odds are 26% higher, not the risk. The odds ratio and relative risk will only be similar if the probability of an event is low. A doubling of risk from 1% to 2% is an increase in odds from 0.0101 to 0.0204, so very close to an odds ratio of 2. But a doubling of risk from 25% to 50% is an odds ratio of 3 (odds of 0.3333 to odds of 1.000).

**Coding `epi.2by2` function**

The `epi.2by2` function takes a two-way table with the endpoint and the cohort. We can create a very simple table using the `table` function with the "cohort" variable first (as rows), and the "case" variable second (as columns).


```r
# Create a two-way table
table(lesson2a$sex, lesson2a$subfourhour)
```

```
##    
##      0  1
##   0 30 36
##   1 21 11
```

However, for the `epi.2by2` function, we need the first row to be the "exposed" group (in this case, sex == 1) and the first column be the "case" group (subfourhour == 1), so that we are comparing "exposed" to "non-exposed", rather than comparing "non-exposed" to "exposed."

By default, R will sort the table numerically, so by default the first table row will be the "non-exposed" group (sex == 0) and the first column will be the "control" group (subfourhour == 0).

Since the rows and columns are out of order, we will first convert the table to the correct format. You do not need to remember this code - you can simply copy and paste, and replace the dataset name ("lesson2a") and variable names ("sex", "subfourhour") as necessary.


```r
# This code creates the table with the correct format
matrix(rev(table(lesson2a$sex, lesson2a$subfourhour)), nrow = 2)
```

```
##      [,1] [,2]
## [1,]   11   21
## [2,]   36   30
```

```r
# For those who are curious, here is a description of the functions above:
# "table" - creates the two-way table above
# "rev" - reverses the order of the table
# "matrix(..., nrow = 2)" converts the reversed data back into a two-by-two table
```

You will see here that now both the rows and the columns are reversed in this table. You can put this code directly into the `epi.2by2` function. By default, the `epi.2by2` function gives the p-value without any continuity correction.


```r
# Apply the epi.2by2 function to the table in the correct format
epi.2by2(matrix(rev(table(lesson2a$sex, lesson2a$subfourhour)), nrow = 2))
```

```
##              Outcome +    Outcome -      Total        Inc risk *        Odds
## Exposed +           11           21         32              34.4       0.524
## Exposed -           36           30         66              54.5       1.200
## Total               47           51         98              48.0       0.922
## 
## Point estimates and 95% CIs:
## -------------------------------------------------------------------
## Inc risk ratio                               0.63 (0.37, 1.07)
## Odds ratio                                   0.44 (0.18, 1.05)
## Attrib risk *                                -20.17 (-40.54, 0.20)
## Attrib risk in population *                  -6.59 (-22.15, 8.97)
## Attrib fraction in exposed (%)               -58.68 (-168.76, 6.32)
## Attrib fraction in population (%)            -13.73 (-29.44, 0.07)
## -------------------------------------------------------------------
##  Test that OR = 1: chi2(1) = 3.513 Pr>chi2 = 0.06
##  Wald confidence limits
##  CI: confidence interval
##  * Outcomes per 100 population units
```

<!-- This code works to flip tables: matrix(rev(table(lesson2a$sex, lesson2a$subfourhour)), nrow = 2) -->

<!-- This code also works (for tabyls): as.matrix(select(rev(arrange(tabyl(lesson2a, sex, subfourhour), desc(sex))), 1:2)) -->



<!-- Used "Wald" option as these results match Stata output -->

So reading this table we get the following information:

- There were 32 women ("Exposed +" row, "Total" column) and 66 men ("Exposed -" row, "Total" column), a total of 98 patients ("Total" row and column)
- 11 of the women finished the race in under four hours ("Exposed +" row, "Outcome +" column), 21 did not ("Exposed +" row, "Outcome -" column).
- 36 of the men finished the race in under four hours ("Exposed -" row, "Outcome +" column), 30 did not ("Exposed -" row, "Outcome -" column)
- 34.4% of the women ("Exposed +" column, "Inc risk \*" row) and 54.5% of the men ("Exposed -" column, "Inc risk \*" row) finished in under four hours.
- 20% more men finished the race in under four hours ("Attrib risk \*" under "Point estimates and 95% CIs"). This is the absolute difference in rates of sub-four hour marathon in men and women.
- After the estimate of the difference in rates is shown the 95% confidence interval around this difference: from 41% more to 0.20% less.
- The chance that a woman finishes the race in under four hours is 0.63 of that for a man ("Inc risk ratio" under "Point estimates and 95% CIs"). The 95% CI is 0.37 to 1.07 (i.e about one third as likely to 7% more likely).
- The odds ratio is reported in the second row under "Point estimates and 95% CIs" and indicates the relative difference in odds.

Be aware that when interpreting a relative difference in risks, it is useful to know the absolute risk as well. A study may report that a drug reduces the risk of heart attack by 50%, but whether you choose to use the drug would depend on whether risk was reduced from 20% to 10% (a 50% relative difference and a 10% absolute difference) or whether risk was reduced from 2% to 1% (still a 50% relative difference but only a 1% absolute difference).

Here is another one to look through:


```r
# Another example using "epi.2by2" function
epi.2by2(matrix(rev(table(example4a$toxin, example4a$cancer)), nrow = 2))
```

```
##              Outcome +    Outcome -      Total        Inc risk *        Odds
## Exposed +            5            3          8              62.5       1.667
## Exposed -            1            7          8              12.5       0.143
## Total                6           10         16              37.5       0.600
## 
## Point estimates and 95% CIs:
## -------------------------------------------------------------------
## Inc risk ratio                               5.00 (0.74, 33.78)
## Odds ratio                                   11.67 (0.92, 147.56)
## Attrib risk *                                50.00 (9.37, 90.63)
## Attrib risk in population *                  25.00 (-7.98, 57.98)
## Attrib fraction in exposed (%)               80.00 (-35.11, 97.04)
## Attrib fraction in population (%)            66.67 (-69.30, 93.44)
## -------------------------------------------------------------------
##  Test that OR = 1: chi2(1) = 4.267 Pr>chi2 = 0.04
##  Wald confidence limits
##  CI: confidence interval
##  * Outcomes per 100 population units
```

Here it is easier to see that the "toxin" is the exposure and "cancer" is whether you are a case.

**Exact statistics**

Now I’ll explain what these are in more detail in the box below for whoever is interested. But for now, what everyone needs to now is that many statisticians, myself included, prefer exact statistics and if any of the "cells" in your table have five or fewer observations, all statisticians agree that you should use exact methods. A cell is one box in your table, such as the number of cancer patients who were not exposed to the toxin, or the number of non-cancer patients who were exposed to the toxin. The `epi.2by2` function gives the chi-squared p-value. However, using the `fisher.test` function gives the exact p-value. You do not need to reverse the table for the `fisher.test` function.


```r
# Calculate p-value from fisher's exact test
fisher.test(table(example4a$toxin, example4a$cancer))
```

```
## 
## 	Fisher's Exact Test for Count Data
## 
## data:  table(example4a$toxin, example4a$cancer)
## p-value = 0.1189
## alternative hypothesis: true odds ratio is not equal to 1
## 95 percent confidence interval:
##    0.6795665 625.2181311
## sample estimates:
## odds ratio 
##   9.760631
```

Similar to the chi-squared test, you can also get the Fisher's exact p-value using the `tbl_summary` and `add_p` functions, by specifying `test = "fisher.test"` for the variable of interest. 


```r
# Create formatted table with p-value from fisher's exact test
tbl_summary(
  example4a %>% select(toxin, cancer),
  by = cancer,
  type = list("toxin" ~ "categorical")
) %>%
  add_p(test = list("toxin" ~ "fisher.test"))
```

```{=html}
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#pqsnuprvju .gt_table {
  display: table;
  border-collapse: collapse;
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

#pqsnuprvju .gt_heading {
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

#pqsnuprvju .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#pqsnuprvju .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#pqsnuprvju .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pqsnuprvju .gt_col_headings {
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

#pqsnuprvju .gt_col_heading {
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

#pqsnuprvju .gt_column_spanner_outer {
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

#pqsnuprvju .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#pqsnuprvju .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#pqsnuprvju .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#pqsnuprvju .gt_group_heading {
  padding: 8px;
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
}

#pqsnuprvju .gt_empty_group_heading {
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

#pqsnuprvju .gt_from_md > :first-child {
  margin-top: 0;
}

#pqsnuprvju .gt_from_md > :last-child {
  margin-bottom: 0;
}

#pqsnuprvju .gt_row {
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

#pqsnuprvju .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#pqsnuprvju .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pqsnuprvju .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#pqsnuprvju .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pqsnuprvju .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#pqsnuprvju .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#pqsnuprvju .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pqsnuprvju .gt_footnotes {
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

#pqsnuprvju .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#pqsnuprvju .gt_sourcenotes {
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

#pqsnuprvju .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#pqsnuprvju .gt_left {
  text-align: left;
}

#pqsnuprvju .gt_center {
  text-align: center;
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
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>0</strong>, N = 10<sup class="gt_footnote_marks">1</sup></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>1</strong>, N = 6<sup class="gt_footnote_marks">1</sup></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1"><strong>p-value</strong><sup class="gt_footnote_marks">2</sup></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr>
      <td class="gt_row gt_left">Toxin exposure</td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center"></td>
      <td class="gt_row gt_center">0.12</td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">0</td>
      <td class="gt_row gt_center">7 (70%)</td>
      <td class="gt_row gt_center">1 (17%)</td>
      <td class="gt_row gt_center"></td>
    </tr>
    <tr>
      <td class="gt_row gt_left" style="text-align: left; text-indent: 10px;">1</td>
      <td class="gt_row gt_center">3 (30%)</td>
      <td class="gt_row gt_center">5 (83%)</td>
      <td class="gt_row gt_center"></td>
    </tr>
  </tbody>
  
  <tfoot>
    <tr class="gt_footnotes">
      <td colspan="4">
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>1</em>
          </sup>
           
          n (%)
          <br />
        </p>
        <p class="gt_footnote">
          <sup class="gt_footnote_marks">
            <em>2</em>
          </sup>
           
          Fisher's exact test
          <br />
        </p>
      </td>
    </tr>
  </tfoot>
</table></div>
```

<br>

_For keen students only:_

Let’s imagine that you and I each throw two coins. I throw two heads and you throw two tails. The p-value you get from a chi squared is 0.046, which seems strange as what we threw doesn’t seem that unusual. The problem is that in chi squared analysis you compare the expected and observed values, add them up, get a value for chi, and then look this up on a table. Now this table is derived from a distribution based on large samples. It is an approximation that breaks down when numbers are very small (such as less than 5 in at least one cell). "Exact" statistics works out the probability of a certain result in a different way, without reference to distributions or approximations. 

The exact approach to the coin throwing problem would be to write out all the possible tables you could have with four observations, and then work out the probability of each under the null hypothesis. Then count what proportion of tables are as unlikely or more unlikely than the observed results and you get your p-value. It turns out that there are 9 possible outcomes for the coin throwing problem: 0 vs. 0; 0 vs 1; 0 vs. 2; 1 vs. 0; 1 vs. 1; 1 vs. 2; 2 vs. 0; 2 vs 1; 2 vs. 2. Two of these (0 vs. 2 and 2 vs. 0), are at least as extreme as the result we got, so that gives a p-value of 0.33. 

**Other Commands**

You can use the `filter` command to select rows to perform t-tests on subgroups of your data. For example, to assess the association between nausea/vomiting and sex only among those patients who had a history of prior chemotherapy, you can use the following code:


```r
# Perform a t-test only among patients with prior chemotherapy
t.test(nv ~ sex, data = lesson3a %>% filter(pc == 1))
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  nv by sex
## t = -0.078122, df = 251.57, p-value = 0.9378
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.5219692  0.4821391
## sample estimates:
## mean in group 0 mean in group 1 
##        5.270161        5.290076
```

To perform the t-test on those without prior chemotherapy, switch the group you are filtering on:


```r
# t-test for patients without prior chemotherapy
t.test(nv ~ sex, data = lesson3a %>% filter(pc == 0))
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  nv by sex
## t = 0.2822, df = 254.8, p-value = 0.778
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -0.4171295  0.5566757
## sample estimates:
## mean in group 0 mean in group 1 
##        4.492537        4.422764
```

## Assignments


```r
# Copy and paste this code to load the data for week 4 assignments
lesson4a <- readRDS(here::here("Data", "Week 4", "lesson4a.rds"))
lesson4b <- readRDS(here::here("Data", "Week 4", "lesson4b.rds"))
lesson4c <- readRDS(here::here("Data", "Week 4", "lesson4c.rds"))
lesson4d <- readRDS(here::here("Data", "Week 4", "lesson4d.rds"))
lesson4e <- readRDS(here::here("Data", "Week 4", "lesson4e.rds"))
```

This week’s assignment concerns techniques developed to assess epidemiologic data. But remember that a number is just a number: the techniques for working out the relative risk of getting breast cancer if you has a silicone breast implant is exactly the same as working out the relative risk of death in transgenic mice exposed to a carcinogen.

Try to do the ones in bold, get to the non-bolded ones if you can.

- **lesson4a.rds: This is a dataset on fifteen patients recording whether they had problematic nausea or vomiting after chemotherapy (defined as grade 2 or higher for either nausea or vomiting) and whether they reported being prone to travel sickness. Does travel sickness predict chemotherapy nausea and vomiting?**
- lesson4b.rds: An epidemiological study of meat consumption and hypertension in older Americans. Meat consumption was defined as low, medium or high depending on whether subjects ate less than 3, 3 to 7 or 7 + meals with meat in per week. Does meat consumption lead to hypertension?
- lesson4c.rds: This is a dataset from a chemotherapy study. The researchers think that a mutation of a certain gene may be associated with chemotherapy toxicity. Should clinicians test for the gene during pre-chemotherapy work up? 
- **lesson4d.rds:  Patients with lung cancer are randomized to receive either chemotherapy regimen a or b and assessed for tumor response. Which regimen would you recommend to a patient? Do the treatments work differently depending on age or sex?**
- lesson4e.rds: This is a lab study of two candidate tumor-suppressor genes (gene1 and gene2). Wild-type mice are compared with mice that have gene1 knocked-out, gene2 knocked-out or both. The presence of tumors is measured after 30 days. Do the genes suppress cancer?

