

# Week 4

## R Instructions

For this lesson, make sure you have loaded the following packages.


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

Here are some of the commands you might use when analyzing epidemiological data or data that has a similar form. For example, if you had two variables "diet" (where 1 = high fat, 0 = low fat) and "hypertension", you could use the same forms of analysis regardless of whether you were investigating a randomized trial (dietary advice assigned randomly to patients) or an epidemiological study (patients interviewed about eating habits). You can also use these methods for lab data (e.g. proportion of mice with a knockout versus wild type who develop a tumor).

## Tables

The first command is the `tbl_summary` function from the `gtsummary` package which makes a table. This was introduced in the week 1 lesson. We are interested in "two-way" tables. In other words, we are not interested in just how many people had hypertension, but in the number of people who had hypertension in each different category of diet. I’ll use the data set for assignment 3a ("lesson3a.rds") to illustrate these points.


```r
tbl_summary(
  lesson3a %>% select(pc, sex),
  by = "sex",
  type = list(pc = "categorical")
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
  padding-bottom: 1px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#iwrgxmosvm .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 1px;
  padding-bottom: 4px;
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

#iwrgxmosvm .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  padding: 4px;
  /* footnote.padding */
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
<div id="iwrgxmosvm" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><!--gt table start-->
<table class='gt_table'>
<tr>
<th class='gt_col_heading gt_left' rowspan='1' colspan='1'><strong>Characteristic</strong><sup class='gt_footnote_glyph'>1</sup></th>
<th class='gt_col_heading gt_center' rowspan='1' colspan='1'><strong>0</strong>, N = 523</th>
<th class='gt_col_heading gt_center' rowspan='1' colspan='1'><strong>1</strong>, N = 575</th>
</tr>
<tbody class='gt_table_body'>
<tr>
<td class='gt_row gt_left'>previous chemo:1 if yes</td>
<td class='gt_row gt_center'></td>
<td class='gt_row gt_center'></td>
</tr>
<tr>
<td class='gt_row gt_left gt_striped' style="text-align:left;text-indent:10px;">0</td>
<td class='gt_row gt_center gt_striped'>160 (51%)</td>
<td class='gt_row gt_center gt_striped'>161 (50%)</td>
</tr>
<tr>
<td class='gt_row gt_left' style="text-align:left;text-indent:10px;">1</td>
<td class='gt_row gt_center'>156 (49%)</td>
<td class='gt_row gt_center'>162 (50%)</td>
</tr>
<tr>
<td class='gt_row gt_left gt_striped' style="text-align:left;text-indent:10px;">Unknown</td>
<td class='gt_row gt_center gt_striped'>207</td>
<td class='gt_row gt_center gt_striped'>252</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan='3' class='gt_footnote'><sup class='gt_footnote_glyph'><em>1</em></sup> Statistics presented: n (%)</td>
</tr>
</tfoot></table>
<!--gt table end-->
</div><!--/html_preserve-->



<br>

So, for example, we can see that there were 575 women, 162 had prior chemo and 161 had no prior chemo. You can see that 252 women were missing data on prior chemotherapy use. By default, the table shows the percent among all observations with non-missing data.

This table also tells us that of men, 51% had no prior chemo, and 49% had prior chemo.

As mentioned in lesson 2, the `tbl_summary` command gives column percentages by default, but can also give row percents using the `row_percent = TRUE` option:


```r
tbl_summary(
  lesson3a %>% select(pc, sex),
  by = "sex",
  type = list(pc = "categorical"),
  row_percent = TRUE
) %>%
  add_overall(last = TRUE)
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
  padding-bottom: 1px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#hlleqxdave .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 1px;
  padding-bottom: 4px;
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

#hlleqxdave .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  padding: 4px;
  /* footnote.padding */
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
<div id="hlleqxdave" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><!--gt table start-->
<table class='gt_table'>
<tr>
<th class='gt_col_heading gt_left' rowspan='1' colspan='1'><strong>Characteristic</strong><sup class='gt_footnote_glyph'>1</sup></th>
<th class='gt_col_heading gt_center' rowspan='1' colspan='1'><strong>0</strong>, N = 523</th>
<th class='gt_col_heading gt_center' rowspan='1' colspan='1'><strong>1</strong>, N = 575</th>
<th class='gt_col_heading gt_center' rowspan='1' colspan='1'><strong>Overall</strong>, N = 1098</th>
</tr>
<tbody class='gt_table_body'>
<tr>
<td class='gt_row gt_left'>previous chemo:1 if yes</td>
<td class='gt_row gt_center'></td>
<td class='gt_row gt_center'></td>
<td class='gt_row gt_center'></td>
</tr>
<tr>
<td class='gt_row gt_left gt_striped' style="text-align:left;text-indent:10px;">0</td>
<td class='gt_row gt_center gt_striped'>160 (50%)</td>
<td class='gt_row gt_center gt_striped'>161 (50%)</td>
<td class='gt_row gt_center gt_striped'>321 (100%)</td>
</tr>
<tr>
<td class='gt_row gt_left' style="text-align:left;text-indent:10px;">1</td>
<td class='gt_row gt_center'>156 (49%)</td>
<td class='gt_row gt_center'>162 (51%)</td>
<td class='gt_row gt_center'>318 (100%)</td>
</tr>
<tr>
<td class='gt_row gt_left gt_striped' style="text-align:left;text-indent:10px;">Unknown</td>
<td class='gt_row gt_center gt_striped'>207</td>
<td class='gt_row gt_center gt_striped'>252</td>
<td class='gt_row gt_center gt_striped'>459</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan='4' class='gt_footnote'><sup class='gt_footnote_glyph'><em>1</em></sup> Statistics presented: n (%)</td>
</tr>
</tfoot></table>
<!--gt table end-->
</div><!--/html_preserve-->

<br>

So of the 318 patients who had previous chemo, 51% were women and 49% were men.

Now let’s use the marathon data ("lesson2a.rds") to do something more interesting. First, I created a new category called "subfourhour" for those runners who completed the marathon in less than four hours.


```r
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

We can compare sub-four hour marathons by sex using a chi-squared test (`chisq.test` function):


```r
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

As a note, we can also use `tbl_summary` and the `add_p` function (also from `gtsummary`) to get the chi-squared pvalue. In the `add_p` function, we specify that for the variable "subfourhour" we want to use a chi-squared test ("chisq.test").

TODO: PENDING BEING ABLE TO DO THIS WITHOUT CONTINUITY CORRECTION


```r
tbl_summary(
  lesson2a %>% select(subfourhour, sex),
  by = "sex",
  type = list(subfourhour = "categorical")
) %>%
  add_p(test = list(subfourhour = "chisq.test"))
```

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
  padding-bottom: 1px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#kqtxbhydst .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 1px;
  padding-bottom: 4px;
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

#kqtxbhydst .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  padding: 4px;
  /* footnote.padding */
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

#kqtxbhydst .gt_footnote_glyph {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="kqtxbhydst" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><!--gt table start-->
<table class='gt_table'>
<tr>
<th class='gt_col_heading gt_left' rowspan='1' colspan='1'><strong>Characteristic</strong><sup class='gt_footnote_glyph'>1</sup></th>
<th class='gt_col_heading gt_center' rowspan='1' colspan='1'><strong>0</strong>, N = 66</th>
<th class='gt_col_heading gt_center' rowspan='1' colspan='1'><strong>1</strong>, N = 32</th>
<th class='gt_col_heading gt_center' rowspan='1' colspan='1'><strong>p-value</strong><sup class='gt_footnote_glyph'>2</sup></th>
</tr>
<tbody class='gt_table_body'>
<tr>
<td class='gt_row gt_left'>subfourhour</td>
<td class='gt_row gt_center'></td>
<td class='gt_row gt_center'></td>
<td class='gt_row gt_center'>0.10</td>
</tr>
<tr>
<td class='gt_row gt_left gt_striped' style="text-align:left;text-indent:10px;">0</td>
<td class='gt_row gt_center gt_striped'>30 (45%)</td>
<td class='gt_row gt_center gt_striped'>21 (66%)</td>
<td class='gt_row gt_center gt_striped'></td>
</tr>
<tr>
<td class='gt_row gt_left' style="text-align:left;text-indent:10px;">1</td>
<td class='gt_row gt_center'>36 (55%)</td>
<td class='gt_row gt_center'>11 (34%)</td>
<td class='gt_row gt_center'></td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan='4' class='gt_footnote'><sup class='gt_footnote_glyph'><em>1</em></sup> Statistics presented: n (%)<br /><sup class='gt_footnote_glyph'><em>2</em></sup> Statistical tests performed: chi-square test of independence</td>
</tr>
</tfoot></table>
<!--gt table end-->
</div><!--/html_preserve-->

<br>



So whereas 55% of men completed the race in less than four hours, only 34% of women did so. The p value here is 0.061.

**Should you categorize a continuous variable?**

If you are interested only:

Remember that the p value when we did a ttest (`t.test(rt ~ sex, data = lesson2a, var.equal = TRUE)`) was 0.032. That is, the p value was lower when we kept race time as a continuous variable, than when we categorized it. The reason is that we are losing information: we are treating someone who ran the race in 2.5 hours the same as someone who ran it in 3.9 hours. So in general, you should avoid turning continuous variables into categorical variables for the purposes of statistical analysis.

## Getting estimates: risk difference, risk ratio, odds ratio

This table gives you a pvalue, but not an estimate. For this, we need the `epi.2by2` function from the `epiR` package. This function works for "cohort studies" and applies equally well to formal epidemiologic studies, retrospective analysis of datasets (such as in this marathon running example) or for randomized trials. You will give the `epi.2by2` function the endpoint and the cohort (see below for more details). "Endpoint" will be something like cancer, response, progression, or running a marathon in under four hours. "Cohort" is what you think might make a difference, like a toxin, chemotherapy, a genetic mutation, or gender.

The language we've been using is a little unusual for this example. A "case" is running a marathon in under four hours (i.e., subfourhour == 1). "Exposed" means that you are a woman (i.e. sex == 1). "Risk" means the proportion of patients who were a "case".

**Coding `epi.2by2` function**

The `epi.2by2` function takes a two-way table with the endpoint and the cohort. We can create a very simple table using the `table` function with the "cohort" variable first (as rows), and the "case" variable second (as columns).


```r
table(lesson2a$sex, lesson2a$subfourhour)
```

```
##    
##      0  1
##   0 30 36
##   1 21 11
```

However, `epi.2by2` requires that the first row be the "exposed" group (in this case, sex == 1) and the first column be the "case" group (subfourhour == 1). By default, R will sort the table numerically, so by default the first table row will be the "non-exposed" group (sex == 0) and the first column will be the "control" group (subfourhour == 0).

Since the rows and columns are out of order, we should first convert the table to the correct format.


```r
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

You will see here that now both the rows and the columns are reversed in this table. You can put this code directly into the `epi.2by2` function.


```r
epi.2by2(matrix(rev(table(lesson2a$sex, lesson2a$subfourhour)), nrow = 2))
```

```
##              Outcome +    Outcome -      Total        Inc risk *
## Exposed +           11           21         32              34.4
## Exposed -           36           30         66              54.5
## Total               47           51         98              48.0
##                  Odds
## Exposed +       0.524
## Exposed -       1.200
## Total           0.922
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
##  Test that odds ratio = 1: chi2(1) = 3.513 Pr>chi2 = 0.061
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
- 20% more men finished the race in under four hours ("Attrib risk *" under "Point estimates and 95% CIs"). The 95% CI is 41% more to 0.20% less.
- The chance that a woman finishes the race in under four hours is 0.63 of that for a man ("Inc risk ratio" under "Point estimates and 95% CIs"). The 95% CI is 0.37 to 1.07 (i.e about one third as likely to 7% more likely).
- The odds ratio is reported in the second row under "Point estimates and 95% CIs."

Here is another one to look through:


```r
epi.2by2(matrix(rev(table(example4a$toxin, example4a$cancer)), nrow = 2))
```

```
##              Outcome +    Outcome -      Total        Inc risk *
## Exposed +            5            3          8              62.5
## Exposed -            1            7          8              12.5
## Total                6           10         16              37.5
##                  Odds
## Exposed +       1.667
## Exposed -       0.143
## Total           0.600
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
##  Test that odds ratio = 1: chi2(1) = 4.267 Pr>chi2 = 0.039
##  Wald confidence limits
##  CI: confidence interval
##  * Outcomes per 100 population units
```

Here it is easier to see that the "toxin" is the exposure and "cancer" is whether you are a case.

**Exact statistics**

Now I’ll explain what these are in more detail in the box below for whoever is interested. But for now, what everyone needs to now is that many statisticians, myself included, prefer exact statistics and if any of the "cells" in your table have five or fewer observations, all statisticians agree that you should use exact methods. A cell is one box in your table, such as the number of cancer patients who were not exposed to the toxin, or the number of non-cancer patients who were exposed to the toxin. The `epi.2by2` function gives the chi-squared p-value. However, using the `fisher.test` function gives the exact pvalue.


```r
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

```r
# Note - you do not need to reverse the row/column order for the "fisher.test" function
```

Similar to the chi-squared test, you can also get the Fisher's exact pvalue using the `tbl_summary` and `add_p` functions, by specifying `test = "fisher.test"` for the variable of interest.


```r
tbl_summary(
  example4a %>% select(toxin, cancer),
  by = "cancer",
  type = list(toxin = "categorical")
) %>%
  add_p(test = list(toxin = "fisher.test"))
```

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
  padding-bottom: 1px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#qzjvxzfwte .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 1px;
  padding-bottom: 4px;
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

#qzjvxzfwte .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  padding: 4px;
  /* footnote.padding */
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

#qzjvxzfwte .gt_footnote_glyph {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="qzjvxzfwte" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><!--gt table start-->
<table class='gt_table'>
<tr>
<th class='gt_col_heading gt_left' rowspan='1' colspan='1'><strong>Characteristic</strong><sup class='gt_footnote_glyph'>1</sup></th>
<th class='gt_col_heading gt_center' rowspan='1' colspan='1'><strong>0</strong>, N = 10</th>
<th class='gt_col_heading gt_center' rowspan='1' colspan='1'><strong>1</strong>, N = 6</th>
<th class='gt_col_heading gt_center' rowspan='1' colspan='1'><strong>p-value</strong><sup class='gt_footnote_glyph'>2</sup></th>
</tr>
<tbody class='gt_table_body'>
<tr>
<td class='gt_row gt_left'>Toxin exposure</td>
<td class='gt_row gt_center'></td>
<td class='gt_row gt_center'></td>
<td class='gt_row gt_center'>0.12</td>
</tr>
<tr>
<td class='gt_row gt_left gt_striped' style="text-align:left;text-indent:10px;">0</td>
<td class='gt_row gt_center gt_striped'>7 (70%)</td>
<td class='gt_row gt_center gt_striped'>1 (17%)</td>
<td class='gt_row gt_center gt_striped'></td>
</tr>
<tr>
<td class='gt_row gt_left' style="text-align:left;text-indent:10px;">1</td>
<td class='gt_row gt_center'>3 (30%)</td>
<td class='gt_row gt_center'>5 (83%)</td>
<td class='gt_row gt_center'></td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan='4' class='gt_footnote'><sup class='gt_footnote_glyph'><em>1</em></sup> Statistics presented: n (%)<br /><sup class='gt_footnote_glyph'><em>2</em></sup> Statistical tests performed: Fisher's exact test</td>
</tr>
</tfoot></table>
<!--gt table end-->
</div><!--/html_preserve-->

<br>

_For keen students only:_

Let’s imagine that you and I each throw two coins. I throw two heads and you throw two tails. The p value you get from a chi squared is 0.046, which seems strange as what we threw doesn’t seem that unusual. The problem is that in chi squared analysis you compare the expected and observed values, add them up, get a value for chi, and then look this up on a table. Now this table is derived from a distribution based on large samples. It is an approximation that breaks down when numbers are very small (such as less than 5 in at least one cell). "Exact" statistics works out the probability of a certain result in a different way, without reference to distributions or approximations. 

The exact approach to the coin throwing problem would be to write out all the possible tables you could have with four observations, and then work out the probability of each under the null hypothesis. Then count what proportion of tables are as unlikely or more unlikely than the observed results and you get your p value. It turns out that there are 9 possible outcomes for the coin throwing problem: 0 vs. 0; 0 vs 1; 0 vs. 2; 1 vs. 0; 1 vs. 1; 1 vs. 2; 2 vs. 0; 2 vs 1; 2 vs. 2. Two of these (0 vs. 2 and 2 vs. 0), are at least as extreme as the result we got, so that gives a p value of 0.33. 

**Other Commands**

You can use the `filter` command to select rows to perform ttests on subgroups of your data. For example, to assess the association between nausea/vomiting and sex only among those patients who had a history of prior chemotherapy, you can use the following code:


```r
t.test(nv ~ sex, data = lesson3a %>% filter(pc==1))
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

To perform the ttest on those without prior chemotherapy, switch the group you are filtering on:


```r
t.test(nv ~ sex, data = lesson3a %>% filter(pc==0))
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

This week’s assignment concerns techniques developed to assess epidemiologic data. But remember that a number is just a number: the techniques for working out the relative risk of getting breast cancer if you has a silicone breast implant is exactly the same as working out the relative risk of death in transgenic mice exposed to a carcinogen.

Try to do the ones in bold, get to the non-bolded ones if you can.

- **lesson4a.rds: This is a data set on fifteen patients recording whether they had problematic nausea or vomiting after chemotherapy (defined as grade 2 or higher for either nausea or vomiting) and whether they reported being prone to travel sickness. Does travel sickness predict chemotherapy nausea and vomiting?**
- lesson4b.rds: An epidemiological study of meat consumption and hypertension in older Americans. Meat consumption was defined as low, medium or high depending on whether subjects ate less than 3, 3 to 7 or 7 + meals with meat in per week. Does meat consumption lead to hypertension?
- lesson4c.rds: This is a data set from a chemotherapy study. The researchers think that a mutation of a certain gene may be associated with chemotherapy toxicity. Should clinicians test for the gene during pre-chemotherapy work up? 
- **lesson4d.rds:  Patients with lung cancer are randomized to receive either chemotherapy regimen a or b and assessed for tumor response. Which regimen would you recommend to a patient? Do the treatments work differently depending on age or sex?**
- lesson4e.rds: This is a lab study of two candidate tumor-suppressor genes (gene1 and gene2). Wild-type mice are compared with mice that have gene1 knocked-out, gene2 knocked-out or both. The presence of tumors is measured after 30 days. Do the genes suppress cancer?

