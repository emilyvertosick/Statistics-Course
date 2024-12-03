

# Week 3

## Setting up


``` r
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

# The "trial" and "midwest" datasets are available automatically after you load the packages above

# Load other data necessary to run Week 3 examples
lesson1a <- readRDS(here::here("Data", "Week 1", "lesson1a.rds"))
example3a <- readRDS(here::here("Data", "Week 3", "example3a.rds"))
```

## R Instructions

### Example Datasets

Normally, to do an analysis in R, you will have to load in a dataset. However, R and some packages come with built-in example datasets. For example, there is a dataset called **trial** that comes built in with the {gtsummary} package. We will use the **trial** dataset for many examples, but you do not need to load it, as the **trial** dataset will automatically be loaded after you run `library(gtsummary)`.

### Hypothesis Testing

For this week's assignment, you will need to learn the following functions:

- `t.test`
- `wilcox.test`
- `binom.test`

#### t-test

This is used to compare a continuous outcome (such as hemoglobin) in two groups (e.g. vegetarians and carnivores, or patients in a randomized trial receiving an anemia treatment or placebo). Now statisticians normally say that the t-test makes two assumptions: (1) data are normally distributed and (2) variances are equal. Don’t worry about assumption (2) for now. Also, assumption (1) has an odd feature: it doesn’t matter once sample sizes get large (for those of you who want to boast that you know a "theorem", this is called the "central limit theorem"). Just how large is "large" is a matter of judgment, but generally speaking, it is said that you can feel okay using a t-test on non-normal data once the sample size is above 30 a group. As it turns out, the t-test is "robust" to non-normal data, even if sample sizes are low. "Robust" means that it gives similar results regardless of whether the data are normally distributed or not. So many people feel comfortable using the t-test for to compare a continuous outcome between two groups even if the data are pretty skewed.

**Different forms of the t-test**

The two main forms of the t-test are "paired" and "unpaired". "Unpaired" is the default.

"Unpaired" is used when, for example, testing marker levels between two groups taking different drugs, as there are different patients in each group:


``` r
# t-test for marker levels between treatment arms
t.test(marker ~ trt, data = trial, var.equal = TRUE)
```

```
## 
## 	Two Sample t-test
## 
## data:  marker by trt
## t = 1.5816, df = 188, p-value = 0.1154
## alternative hypothesis: true difference in means between group Drug A and group Drug B is not equal to 0
## 95 percent confidence interval:
##  -0.04858916  0.44161134
## sample estimates:
## mean in group Drug A mean in group Drug B 
##            1.0173478            0.8208367
```

The first variable, "marker", is the continuous endpoint that you are comparing by the two groups of the second variable, "trt" (Drug A vs Drug B). Next, you are telling R to get the data from the dataset called **trial**. By default an "unpaired" test is performed. The last option (`var.equal = TRUE`) tells the `t.test` function to treat the two variances as being equal. For this course, you will need to include this option in two-group `t.test` commands but you do not need to know specific details about this concept.

A "paired" test would be used for comparing blood pressure taken before and after an intervention, for example, because you are looking at two observations on the same patient.

<!-- Note: Don't need to specify "var.equal = TRUE" for paired tests, as this is the default, but I thought it might be easier to be consistent across all. -->

Since these are two measurements taken on the same patient, a paired t-test is necessary. To perform a paired t-test, you use the `t.test` function including the outcome variable, the predictor variable, and the option `paired = TRUE`.


``` r
# paired t-test for blood pressure between "before" and "after" groups
t.test(example3a$bp_after, example3a$bp_before, paired = TRUE, var.equal = TRUE)
```

```
## 
## 	Paired t-test
## 
## data:  example3a$bp_after and example3a$bp_before
## t = -3.3372, df = 119, p-value = 0.00113
## alternative hypothesis: true mean difference is not equal to 0
## 95 percent confidence interval:
##  -8.112776 -2.070557
## sample estimates:
## mean difference 
##       -5.091667
```

A single sample test compares the mean of a group of observations with some hypothetical value, for example, is the average rate of college-educated adults in the Midwest different than the national average of 32%?


``` r
# t-test assessing whether the rate of college education is different than 32%
t.test(midwest$percollege, mu = 32)
```

```
## 
## 	One Sample t-test
## 
## data:  midwest$percollege
## t = -45.827, df = 436, p-value < 2.2e-16
## alternative hypothesis: true mean is not equal to 32
## 95 percent confidence interval:
##  17.68400 18.86147
## sample estimates:
## mean of x 
##  18.27274
```

Let’s look at the print out from a t-test in more detail:


``` r
# t-test for difference in horsepower for manual vs automatic transmission
t.test(hp ~ am, data = mtcars, var.equal = TRUE)
```

```
## 
## 	Two Sample t-test
## 
## data:  hp by am
## t = 1.3733, df = 30, p-value = 0.1798
## alternative hypothesis: true difference in means between group 0 and group 1 is not equal to 0
## 95 percent confidence interval:
##  -16.27768  83.11169
## sample estimates:
## mean in group 0 mean in group 1 
##        160.2632        126.8462
```

This example is testing whether there is a difference in horsepower (hp) between cars with an automatic transmission (`am == 0`) vs manual transmission (`am == 1`).

The `t.test` function reports the data and variables you are testing, followed by the t statistic (t), degrees of freedom (df) and p-value. Below that, it states the alternative hypothesis you are testing, prints the mean in each group, and gives the 95% confidence interval around the difference in group means. You don't need to worry about the t statistic or degrees of freedom (df). The numbers you are most interested in are the p-value, the group means, and the 95% confidence interval.

While for an unpaired test, the `t.test` command prints the group means in each group, you may want to report the difference between means.

To easily calculate and display the mean and standard deviation in each group, the difference in means with 95% confidence interval and the p-value for this difference, you can use the functions `tbl_summary` and `add_difference` from the {gtsummary} package.




``` r
# Start off with the tbl_summary function
tbl_summary(
  # keep the "am" and "hp" variables from the "mtcars" dataset
  mtcars %>%
    select(am, hp),
  # group by "am"
  by = am,
  # display mean and SD (rather than default median and IQR)
  statistic = list(hp = "{mean} ({sd})")
) %>%
  # the "add_difference" function adds the difference, 95% confidence interval and p-value
  add_difference(
    test = list(hp = "ancova")
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

#iwrgxmosvm .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#iwrgxmosvm div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_1"><span class='gt_from_md'><strong>0</strong><br />
N = 19</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="stat_2"><span class='gt_from_md'><strong>1</strong><br />
N = 13</span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="estimate"><span class='gt_from_md'><strong>Difference</strong></span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="conf.low"><span class='gt_from_md'><strong>95% CI</strong></span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2,3</sup></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="p.value"><span class='gt_from_md'><strong>p-value</strong></span><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">hp</td>
<td headers="stat_1" class="gt_row gt_center">160 (54)</td>
<td headers="stat_2" class="gt_row gt_center">127 (84)</td>
<td headers="estimate" class="gt_row gt_center">33</td>
<td headers="conf.low" class="gt_row gt_center">-16, 83</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>1</sup></span> <span class='gt_from_md'>Mean (SD)</span></td>
    </tr>
    <tr>
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>2</sup></span> <span class='gt_from_md'>One-way ANOVA</span></td>
    </tr>
    <tr>
      <td class="gt_footnote" colspan="6"><span class="gt_footnote_marks" style="white-space:nowrap;font-style:italic;font-weight:normal;line-height:0;"><sup>3</sup></span> <span class='gt_from_md'>CI = Confidence Interval</span></td>
    </tr>
  </tfoot>
</table>
</div>
```

As you can see, this table gives the same results as using the `t.test` function, formatted as a clean table. To get the results for a t-test with equal variances (`var.equal = TRUE` in the `t.test` function), specify "ancova" for the `test` option in the `add_difference` function. If you specify "t.test" for the `test` option in the `add_difference` function, this is the same as running the `t.test` function with `var.equal = FALSE`.

Now we haven’t discussed the 95% confidence interval yet, but think of it in simple terms as a plausible range of true values of the difference between means. In this data, the average horsepower is 33.4 higher in cars with an automatic transmission, but it could be that, in fact, the true horsepower is between 16.3 lower or 83.1 higher in the automatic group vs the manual group.

#### Non-parametric methods

These are used to compare continuous outcomes in two groups. There are no assumptions about normality or variance. 

Unpaired case, for example, do marker levels differ between the drug and placebo groups?


``` r
# non-parametric test for difference in marker levels by treatment group
wilcox.test(marker ~ trt, data = trial, exact = FALSE)
```

```
## 
## 	Wilcoxon rank sum test with continuity correction
## 
## data:  marker by trt
## W = 5161.5, p-value = 0.08475
## alternative hypothesis: true location shift is not equal to 0
```

The inputs for the `wilcox.test` function are very similar to the inputs for the `t.test` function. You will see here we are using the same example - comparing marker levels by treatment group, so the outcome variable ("marker"), the group variable ("trt") and the dataset (**trial**) are all the same. As with the `t.test` function, this is an unpaired test by default.

Paired case, for example, does an intervention cause a change in a patient's blood pressure?


``` r
# paired non-parametric test for difference in "before" and "after" blood pressure measurements
wilcox.test(example3a$bp_after, example3a$bp_before, paired = TRUE)
```

```
## 
## 	Wilcoxon signed rank test with continuity correction
## 
## data:  example3a$bp_after and example3a$bp_before
## V = 2234.5, p-value = 0.001417
## alternative hypothesis: true location shift is not equal to 0
```

Single sample, for example, is the rate of college education in the midwest different than the national average (32%)?


``` r
# non-parametric test - is rate of college education different from 32%?
wilcox.test(midwest$percollege, mu = 32)
```

```
## 
## 	Wilcoxon signed rank test with continuity correction
## 
## data:  midwest$percollege
## V = 924, p-value < 2.2e-16
## alternative hypothesis: true location is not equal to 32
```

Note here that you don’t get any parameters for the groups such as means, medians or standard deviations. You also don’t get an estimate for the difference between groups.

#### Binomial test

The binomial test compares a proportion to a hypothesized value. For example, what is the probability that an unbiased coin thrown 100 times would give a result as or more extreme than 60 heads? (This probability is equivalent to the p-value). 

The first argument of `binom.test` is the number of successes, then the number of total tests (total observations). The hypothesized probability is specified by the `p =` option - the default is 0.5 (50%).


``` r
# Compare a proportion to a hypothesized value "p"
binom.test(60, 100, p = 0.5)
```

```
## 
## 	Exact binomial test
## 
## data:  60 and 100
## number of successes = 60, number of trials = 100, p-value = 0.05689
## alternative hypothesis: true probability of success is not equal to 0.5
## 95 percent confidence interval:
##  0.4972092 0.6967052
## sample estimates:
## probability of success 
##                    0.6
```

You can also use `binom.test` on data from a dataset. For example, if we want to test whether the proportion of women (sex = 1) is different from 50%:


``` r
# The "sum" function adds up the number of observations where sex == 1 (women)
nwomen <- sum(lesson1a$sex)
nwomen
```

```
## [1] 205
```

``` r
# The "nrow" function (for "number of rows") counts the total number of observations
# The "filter" function is used to count only the number of observations where
# "sex" is not missing (NA)
ntotal <- nrow(lesson1a %>% filter(!is.na(sex)))
ntotal
```

```
## [1] 386
```

``` r
# Compare a proportion of patients in a dataset to a hypothesized value "p"
binom.test(nwomen, ntotal, p = 0.5)
```

```
## 
## 	Exact binomial test
## 
## data:  nwomen and ntotal
## number of successes = 205, number of trials = 386, p-value = 0.2417
## alternative hypothesis: true probability of success is not equal to 0.5
## 95 percent confidence interval:
##  0.4799345 0.5817614
## sample estimates:
## probability of success 
##              0.5310881
```

Note that above, we used the `filter` function to only count those observations where "sex" was not missing (NA). The function `is.na` gives a value of TRUE if the data is missing (NA) and FALSE if the data is non-missing. The `!` means "is not" in R, so that the statement `!is.na(sex)` is indicating that we want to keep the data where sex **is not** missing.

In this dataset, there are no missing values for "sex", but it is a good habit to include this condition so you are using the correct denominator if your dataset does have missing values.



This tells you that you had 386 observations, and there were 205 where sex was coded as 1, an observation proportion of 0.53. Now the "assumed" proportion was 0.5, giving an expected number of 193 women. These two values are quite close and the p-value is 0.2. 

## Assignments


``` r
# Copy and paste this code to load the data for week 3 assignments
lesson3a <- readRDS(here::here("Data", "Week 3", "lesson3a.rds"))
lesson3b <- readRDS(here::here("Data", "Week 3", "lesson3b.rds"))
lesson3c <- readRDS(here::here("Data", "Week 3", "lesson3c.rds"))
lesson3d <- readRDS(here::here("Data", "Week 3", "lesson3d.rds"))
lesson3e <- readRDS(here::here("Data", "Week 3", "lesson3e.rds"))
lesson3f <- readRDS(here::here("Data", "Week 3", "lesson3f.rds"))
```

Again, more questions than you need to do, unless you’re keen (also, most won’t take long). Try to do at least the first three. 

- **lesson3a**: These are data from over 1000 patients undergoing chemotherapy reporting a nausea and vomiting score from 0 to 10 on the day of treatment.  Does previous chemotherapy increase nausea scores? What about sex? 
- **lesson3b**: Patients with wrist osteoarthritis are randomized to a new drug or placebo. Pain is measured before and two hours after taking a dose of the drug. Is the drug effective?
- **lesson3c**: Some postoperative pain data again. Is pain on day 2 different than pain on day 1? Is pain on day 3 different from pain on day 2? 
- **lesson3d**: This is a single-arm, uncontrolled study of acupuncture for patients with neck pain. Does acupuncture increase range of motion?  Just as many men as women get neck pain. Can we say anything about the sample chosen for this trial with respect to gender? The mean age of patients with neck pain is 58.2 years. Is the trial population representative with respect to age?
- **lesson3e**: These data are length of stay from two different hospitals. One of the hospitals uses a new chemotherapy regimen that is said to reduce adverse events and therefore length of stay. Does the new regimen decrease length of stay? 
- **lesson3f**: These data are from a randomized trial on the effects of physiotherapy treatment on physical function in pediatric patients recovering from cancer surgery. Function is measured on a 100 point scale. Does physiotherapy help improve physical functioning?
