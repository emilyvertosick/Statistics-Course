

# Exam

## Question 1

I have provided a data set ("exam 01") in two formats: R (.rds) and Excel. The excel file consists of two worksheets, one with the data, and another describing what the variables are. The data are from a study of advanced prostate cancer. The investigators are studying the "bone scan index", a new way of quantifying the extent of metastatic disease. They want to see whether the index predicts survival (I didn’t include survival data in the data set because we aren’t going to analyze that).   What I’d like you to do is create a "table 1" to describe the study cohort. You can either do this by analyzing real data or by explaining what you’d do. As a hypothetical illustration, if I’d sent you data from a study on pain, you could either send me:

1:

<center>**Table 1. Characteristics of sample. Data are mode (range) or percentage.**</center><br>

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#pdmswcaxzc .gt_table {
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

#pdmswcaxzc .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#pdmswcaxzc .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 1px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#pdmswcaxzc .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 1px;
  padding-bottom: 4px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#pdmswcaxzc .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#pdmswcaxzc .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#pdmswcaxzc .gt_col_heading {
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

#pdmswcaxzc .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#pdmswcaxzc .gt_group_heading {
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

#pdmswcaxzc .gt_empty_group_heading {
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

#pdmswcaxzc .gt_striped {
  background-color: #f2f2f2;
}

#pdmswcaxzc .gt_from_md > :first-child {
  margin-top: 0;
}

#pdmswcaxzc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#pdmswcaxzc .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
}

#pdmswcaxzc .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#pdmswcaxzc .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#pdmswcaxzc .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#pdmswcaxzc .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#pdmswcaxzc .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#pdmswcaxzc .gt_table_body {
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

#pdmswcaxzc .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  padding: 4px;
  /* footnote.padding */
}

#pdmswcaxzc .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#pdmswcaxzc .gt_center {
  text-align: center;
}

#pdmswcaxzc .gt_left {
  text-align: left;
}

#pdmswcaxzc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#pdmswcaxzc .gt_font_normal {
  font-weight: normal;
}

#pdmswcaxzc .gt_font_bold {
  font-weight: bold;
}

#pdmswcaxzc .gt_font_italic {
  font-style: italic;
}

#pdmswcaxzc .gt_super {
  font-size: 65%;
}

#pdmswcaxzc .gt_footnote_glyph {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="pdmswcaxzc" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><!--gt table start-->
<table class='gt_table'>
<tr>
<th class='gt_col_heading gt_left' rowspan='1' colspan='1'>Characteristic</th>
<th class='gt_col_heading gt_left' rowspan='1' colspan='1'>Statistic</th>
</tr>
<tbody class='gt_table_body'>
<tr>
<td class='gt_row gt_left'>Mean baseline pain</td>
<td class='gt_row gt_left'>4.5 (1.4 - 45)</td>
</tr>
<tr>
<td class='gt_row gt_left gt_striped'>Mean post-treatment pain</td>
<td class='gt_row gt_left gt_striped'>4.5 (1.4 - 45)</td>
</tr>
<tr>
<td class='gt_row gt_left'>Women</td>
<td class='gt_row gt_left'>52%</td>
</tr>
</tbody>
</table>
<!--gt table end-->
</div><!--/html_preserve-->

<br>

2:

<center>**Table 1. Characteristics of sample. Data are mode (range) or percentage.**</center><br>

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#ckkcatsiet .gt_table {
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

#ckkcatsiet .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#ckkcatsiet .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 1px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#ckkcatsiet .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 1px;
  padding-bottom: 4px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ckkcatsiet .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#ckkcatsiet .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#ckkcatsiet .gt_col_heading {
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

#ckkcatsiet .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#ckkcatsiet .gt_group_heading {
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

#ckkcatsiet .gt_empty_group_heading {
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

#ckkcatsiet .gt_striped {
  background-color: #f2f2f2;
}

#ckkcatsiet .gt_from_md > :first-child {
  margin-top: 0;
}

#ckkcatsiet .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ckkcatsiet .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
}

#ckkcatsiet .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#ckkcatsiet .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#ckkcatsiet .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#ckkcatsiet .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#ckkcatsiet .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#ckkcatsiet .gt_table_body {
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

#ckkcatsiet .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  padding: 4px;
  /* footnote.padding */
}

#ckkcatsiet .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#ckkcatsiet .gt_center {
  text-align: center;
}

#ckkcatsiet .gt_left {
  text-align: left;
}

#ckkcatsiet .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ckkcatsiet .gt_font_normal {
  font-weight: normal;
}

#ckkcatsiet .gt_font_bold {
  font-weight: bold;
}

#ckkcatsiet .gt_font_italic {
  font-style: italic;
}

#ckkcatsiet .gt_super {
  font-size: 65%;
}

#ckkcatsiet .gt_footnote_glyph {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="ckkcatsiet" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><!--gt table start-->
<table class='gt_table'>
<tr>
<th class='gt_col_heading gt_left' rowspan='1' colspan='1'>Characteristic</th>
<th class='gt_col_heading gt_left' rowspan='1' colspan='1'>Statistic</th>
</tr>
<tbody class='gt_table_body'>
<tr>
<td class='gt_row gt_left'>Mean baseline pain</td>
<td class='gt_row gt_left'>?? (?? - ??)</td>
</tr>
<tr>
<td class='gt_row gt_left gt_striped'>Mean post-treatment pain</td>
<td class='gt_row gt_left gt_striped'>?? (?? - ??)</td>
</tr>
<tr>
<td class='gt_row gt_left'>Women</td>
<td class='gt_row gt_left'>??%</td>
</tr>
</tbody>
</table>
<!--gt table end-->
</div><!--/html_preserve-->

<br>

Note that both of these tables are rather silly, I am just doing this for illustration. Your table should be in a format suitable for publication in a journal. 

## Question 2

Some colleagues of yours are working on a project to predict preoperatively which patients will be found to have positive lymph nodes. They send you the following print-out describing a logistic regression and give you the following: "nodes is coded 1 for positive, 0 for negative; yos is year of surgery; age is in years; CA125 is in units of 10 μg/mL; histol is coded as 0, 1 or 2 whether the tumor was well differentiated, moderately differentiated or poorly differentiated on biopsy".

<!--html_preserve--><style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#pzquqvmkav .gt_table {
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

#pzquqvmkav .gt_heading {
  background-color: #FFFFFF;
  /* heading.background.color */
  border-bottom-color: #FFFFFF;
}

#pzquqvmkav .gt_title {
  color: #000000;
  font-size: 125%;
  /* heading.title.font.size */
  padding-top: 4px;
  /* heading.top.padding */
  padding-bottom: 1px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#pzquqvmkav .gt_subtitle {
  color: #000000;
  font-size: 85%;
  /* heading.subtitle.font.size */
  padding-top: 1px;
  padding-bottom: 4px;
  /* heading.bottom.padding */
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#pzquqvmkav .gt_bottom_border {
  border-bottom-style: solid;
  /* heading.border.bottom.style */
  border-bottom-width: 2px;
  /* heading.border.bottom.width */
  border-bottom-color: #A8A8A8;
  /* heading.border.bottom.color */
}

#pzquqvmkav .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  padding-top: 4px;
  padding-bottom: 4px;
}

#pzquqvmkav .gt_col_heading {
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

#pzquqvmkav .gt_sep_right {
  border-right: 5px solid #FFFFFF;
}

#pzquqvmkav .gt_group_heading {
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

#pzquqvmkav .gt_empty_group_heading {
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

#pzquqvmkav .gt_striped {
  background-color: #f2f2f2;
}

#pzquqvmkav .gt_from_md > :first-child {
  margin-top: 0;
}

#pzquqvmkav .gt_from_md > :last-child {
  margin-bottom: 0;
}

#pzquqvmkav .gt_row {
  padding: 8px;
  /* row.padding */
  margin: 10px;
  vertical-align: middle;
}

#pzquqvmkav .gt_stub {
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #A8A8A8;
  padding-left: 12px;
}

#pzquqvmkav .gt_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* summary_row.background.color */
  padding: 8px;
  /* summary_row.padding */
  text-transform: inherit;
  /* summary_row.text_transform */
}

#pzquqvmkav .gt_grand_summary_row {
  color: #000000;
  background-color: #FFFFFF;
  /* grand_summary_row.background.color */
  padding: 8px;
  /* grand_summary_row.padding */
  text-transform: inherit;
  /* grand_summary_row.text_transform */
}

#pzquqvmkav .gt_first_summary_row {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
}

#pzquqvmkav .gt_first_grand_summary_row {
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #A8A8A8;
}

#pzquqvmkav .gt_table_body {
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

#pzquqvmkav .gt_footnote {
  font-size: 90%;
  /* footnote.font.size */
  padding: 4px;
  /* footnote.padding */
}

#pzquqvmkav .gt_sourcenote {
  font-size: 90%;
  /* sourcenote.font.size */
  padding: 4px;
  /* sourcenote.padding */
}

#pzquqvmkav .gt_center {
  text-align: center;
}

#pzquqvmkav .gt_left {
  text-align: left;
}

#pzquqvmkav .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#pzquqvmkav .gt_font_normal {
  font-weight: normal;
}

#pzquqvmkav .gt_font_bold {
  font-weight: bold;
}

#pzquqvmkav .gt_font_italic {
  font-style: italic;
}

#pzquqvmkav .gt_super {
  font-size: 65%;
}

#pzquqvmkav .gt_footnote_glyph {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="pzquqvmkav" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><!--gt table start-->
<table class='gt_table'>
<tr>
<th class='gt_col_heading gt_left' rowspan='1' colspan='1'>Covariate</th>
<th class='gt_col_heading gt_left' rowspan='1' colspan='1'>Odds Ratio</th>
<th class='gt_col_heading gt_left' rowspan='1' colspan='1'>Std. Err.</th>
<th class='gt_col_heading gt_left' rowspan='1' colspan='1'>z</th>
<th class='gt_col_heading gt_left' rowspan='1' colspan='1'>P&gt;z</th>
<th class='gt_col_heading gt_left' rowspan='1' colspan='1'>95% Conf. Interval</th>
</tr>
<tbody class='gt_table_body'>
<tr>
<td class='gt_row gt_left'>yos</td>
<td class='gt_row gt_left'>1.026621</td>
<td class='gt_row gt_left'>0.0168909</td>
<td class='gt_row gt_left'>1.60</td>
<td class='gt_row gt_left'>0.110</td>
<td class='gt_row gt_left'>0.9940435, 1.060266</td>
</tr>
<tr>
<td class='gt_row gt_left gt_striped'>age</td>
<td class='gt_row gt_left gt_striped'>1.039007</td>
<td class='gt_row gt_left gt_striped'>0.0054137</td>
<td class='gt_row gt_left gt_striped'>7.34</td>
<td class='gt_row gt_left gt_striped'>0.000</td>
<td class='gt_row gt_left gt_striped'>1.02845, 1.049672</td>
</tr>
<tr>
<td class='gt_row gt_left'>CA125</td>
<td class='gt_row gt_left'>1.04026</td>
<td class='gt_row gt_left'>0.0051741</td>
<td class='gt_row gt_left'>7.94</td>
<td class='gt_row gt_left'>0.000</td>
<td class='gt_row gt_left'>1.030169, 1.050451</td>
</tr>
<tr>
<td class='gt_row gt_left gt_striped'>histol</td>
<td class='gt_row gt_left gt_striped'>0.4306271</td>
<td class='gt_row gt_left gt_striped'>0.0292454</td>
<td class='gt_row gt_left gt_striped'>-12.41</td>
<td class='gt_row gt_left gt_striped'>0.000</td>
<td class='gt_row gt_left gt_striped'>0.3769584, 0.4919369</td>
</tr>
</tbody>
</table>
<!--gt table end-->
</div><!--/html_preserve-->

Put this information in a format suitable for reporting in a journal article. Briefly state (in no more than 2 – 3 sentences) any criticisms, comments or questions you might you offer your colleagues on their analysis.

## Question 3

You read the following in a journal article:

<div class="quote-container">

>There was no difference in progression-free survival (p=0.1433) between the group given platinum only therapy compared to those on platinum plus immunotherapy. Immunotherapy therefore does not improve progression-free survival for patients receiving platinum therapy for advanced lung cancer. In the correlative analysis, the serum marker YLK44 (p=0.0132) but not ELCA (p=0.0622), EPLA (p=0.7764), LDH (p=0.6475) nor PPR-3 (p=0.2150) was associated with response, defined as a 50% or greater reduction in tumor size. We conclude that there is a statistically significant association between YLK44 and response rates in second-line therapy. Patients who responded to platinum (mean age 69, 95% C.I. 62 to 76) were on average no younger than non-responders (mean age 73, 95% C.I. 70 to 76).

</div>

What errors of statistical analysis or interpretation can you find in this paragraph? Write out your answers _briefly_, in bullet point form.

## Question 4

Look through the PDF of the study on childhood cancer survivors. [[TODO: ADD LINK]] You don’t have to read the discussion, or the second half of the results if you don’t want, because the questions focus on the earlier part of the paper.

a)	Ignoring the first section of the results on patient characteristics, and the associated table 1, what is the null hypothesis associated with the first statistical test reported in the paper? You don’t have worry too much about working out exactly which null hypothesis is the first one, a null hypothesis somewhere near the beginning will do.

b)	Look at table 2. Write two brief bullet points commenting on the statistical methods used in the table and / or the conclusions that the authors draw from the data presented in the table. 
