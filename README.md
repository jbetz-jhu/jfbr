
<!-- README.md is generated from README.Rmd. Please edit that file -->

# jfbr: A Package of Miscellaneous Workflow Functions

<!-- badges: start -->

[![R-CMD-check](https://github.com/jbetz-jhu/impart/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jbetz-jhu/impart/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/jbetz-jhu/jfbr/graph/badge.svg)](https://app.codecov.io/gh/jbetz-jhu/jfbr)
<!-- badges: end -->

The `jfbr` package is meant to test and share miscellaneous functions
for quantitative workflows.

## Installation

You can install the development version of jfbr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools") # Install devtools if not already installed
devtools::install_github("jbetz-jhu/jfbr")
```

## Examples:

### Tabulation

Convenience functions have been added for the `table1::table1()`
function to make it easier to do different summaries and add hypothesis
testing.

``` r
library(jfbr)
library(table1)
#> 
#> Attaching package: 'table1'
#> The following objects are masked from 'package:base':
#> 
#>     units, units<-
library(knitr)
```

The package includes an example dataset `jfbr_test` which is used in the
examples below:

``` r
head(jfbr_test)
#>   numbers continuous binary ordered binary_factor categorical two_level_group
#> 1       1  0.7209039      1       3        1. Yes           1         Group 1
#> 2       2  0.8757732      1       2         0. No           4         Group 2
#> 3       3  0.7609823      0       1        1. Yes           1         Group 1
#> 4       4  0.8861246      1       3        1. Yes           3         Group 1
#> 5       5  0.4564810      1       1         0. No           1         Group 2
#> 6       6  0.1663718      1       4        1. Yes           2         Group 1
#>   three_level_group
#> 1           Group 1
#> 2           Group 1
#> 3           Group 3
#> 4           Group 3
#> 5           Group 3
#> 6           Group 1
```

#### `table1()`: Default

The default for `table1::table1()` is to produce Mean (SD) and Median
\[Min, Max\] for numeric values, and `NA` is treated as a level of a
factor for categorical variables.

**Note: saving the result of `table1::table1()` and using
`knitr::kable()`is only necessary when HTML output is not possible
(e.g. `output: github_document` in R Markdown)**

``` r
# table1() defaults
my_table <-
  table1(
    x = ~ continuous + numbers + ordered + binary_factor + categorical |
      two_level_group,
    data = jfbr_test
  )

kable(my_table)
```

|                     | Group 1                  | Group 2                  | Overall                  |
|:--------------------|:-------------------------|:-------------------------|:-------------------------|
|                     | (N=97)                   | (N=103)                  | (N=200)                  |
| continuous          |                          |                          |                          |
| Mean (SD)           | 0.525 (0.297)            | 0.560 (0.291)            | 0.543 (0.294)            |
| Median \[Min, Max\] | 0.510 \[0.00114, 0.993\] | 0.601 \[0.00599, 0.990\] | 0.588 \[0.00114, 0.993\] |
| Missing             | 0 (0%)                   | 1 (1.0%)                 | 1 (0.5%)                 |
| numbers             |                          |                          |                          |
| Mean (SD)           | 100 (57.0)               | 101 (59.0)               | 101 (57.9)               |
| Median \[Min, Max\] | 100 \[1.00, 200\]        | 104 \[2.00, 197\]        | 101 \[1.00, 200\]        |
| Missing             | 0 (0%)                   | 1 (1.0%)                 | 1 (0.5%)                 |
| ordered             |                          |                          |                          |
| 1                   | 29 (29.9%)               | 34 (33.0%)               | 63 (31.5%)               |
| 2                   | 15 (15.5%)               | 25 (24.3%)               | 40 (20.0%)               |
| 3                   | 28 (28.9%)               | 20 (19.4%)               | 48 (24.0%)               |
| 4                   | 24 (24.7%)               | 24 (23.3%)               | 48 (24.0%)               |
| Missing             | 1 (1.0%)                 | 0 (0%)                   | 1 (0.5%)                 |
| binary_factor       |                          |                          |                          |
| 0\. No              | 46 (47.4%)               | 47 (45.6%)               | 93 (46.5%)               |
| 1\. Yes             | 51 (52.6%)               | 55 (53.4%)               | 106 (53.0%)              |
| Missing             | 0 (0%)                   | 1 (1.0%)                 | 1 (0.5%)                 |
| categorical         |                          |                          |                          |
| 1                   | 23 (23.7%)               | 24 (23.3%)               | 47 (23.5%)               |
| 2                   | 26 (26.8%)               | 16 (15.5%)               | 42 (21.0%)               |
| 3                   | 25 (25.8%)               | 30 (29.1%)               | 55 (27.5%)               |
| 4                   | 23 (23.7%)               | 32 (31.1%)               | 55 (27.5%)               |
| Missing             | 0 (0%)                   | 1 (1.0%)                 | 1 (0.5%)                 |

#### `table1()` + `table1_numeric` + `table1_categorical`

Using the argument `render.continuous = table1_numeric` adds Median
\[IQR\] and \[Max, Min\], while
`render.categorical = table1_categorical` summarizes the observed
frequencies and tabulates the proportion of missing values separately:

``` r
my_table <-
  table1(
    x = ~ continuous + numbers | two_level_group,
    data = jfbr_test,
    render.continuous = table1_numeric,
    render.categorical = table1_categorical
  )

kable(my_table)
```

|                | Group 1        | Group 2        | Overall        |
|:---------------|:---------------|:---------------|:---------------|
|                | (N=97)         | (N=103)        | (N=200)        |
| continuous     |                |                |                |
| Mean (SD)      | 0.53 (0.3)     | 0.56 (0.29)    | 0.54 (0.29)    |
| Median \[IQR\] | 0.51 (0.3)     | 0.6 (0.29)     | 0.59 (0.29)    |
| \[Min, Max\]   | \[0, 0.99\]    | \[0.01, 0.99\] | \[0, 0.99\]    |
| Complete (N%)  | 97 (100%)      | 102 (99.03%)   | 199 (99.5%)    |
| Missing        | 0 (0%)         | 1 (1.0%)       | 1 (0.5%)       |
| numbers        |                |                |                |
| Mean (SD)      | 100.05 (57.01) | 101.42 (59.03) | 100.75 (57.91) |
| Median \[IQR\] | 100 (57.01)    | 103.5 (59.03)  | 101 (57.91)    |
| \[Min, Max\]   | \[1, 200\]     | \[2, 197\]     | \[1, 200\]     |
| Complete (N%)  | 97 (100%)      | 102 (99.03%)   | 199 (99.5%)    |
| Missing        | 0 (0%)         | 1 (1.0%)       | 1 (0.5%)       |

The arguments `mean_sd`, `median_iqr`, and `range` control which
summaries are computed. Quantiles can be added optionally with the
`quantiles` argment:

``` r
# Only Mean/SD
my_table <-
  table1(
    x = ~ continuous + numbers | two_level_group,
    data = jfbr_test,
    render.continuous = 
      function(x)
        table1_numeric(
          x = x,
          mean_sd = TRUE, median_iqr = FALSE, range = FALSE,
          quantiles = NULL
        )
  )

kable(my_table)
```

|               | Group 1        | Group 2        | Overall        |
|:--------------|:---------------|:---------------|:---------------|
|               | (N=97)         | (N=103)        | (N=200)        |
| continuous    |                |                |                |
| Mean (SD)     | 0.53 (0.3)     | 0.56 (0.29)    | 0.54 (0.29)    |
| Complete (N%) | 97 (100%)      | 102 (99.03%)   | 199 (99.5%)    |
| Missing       | 0 (0%)         | 1 (1.0%)       | 1 (0.5%)       |
| numbers       |                |                |                |
| Mean (SD)     | 100.05 (57.01) | 101.42 (59.03) | 100.75 (57.91) |
| Complete (N%) | 97 (100%)      | 102 (99.03%)   | 199 (99.5%)    |
| Missing       | 0 (0%)         | 1 (1.0%)       | 1 (0.5%)       |

``` r

# Only Mean/SD, 5% and 95% Quantiles
my_table <-
  table1(
    x = ~ continuous + numbers | two_level_group,
    data = jfbr_test,
    render.continuous = 
      function(x)
        table1_numeric(
          x = x,
          mean_sd = TRUE, median_iqr = FALSE, range = FALSE,
          quantiles = c(0.05, 0.95)
        )
  )

kable(my_table)
```

|               | Group 1        | Group 2        | Overall        |
|:--------------|:---------------|:---------------|:---------------|
|               | (N=97)         | (N=103)        | (N=200)        |
| continuous    |                |                |                |
| Mean (SD)     | 0.53 (0.3)     | 0.56 (0.29)    | 0.54 (0.29)    |
| 5%, 95%       | 0.03, 0.97     | 0.09, 0.96     | 0.05, 0.97     |
| Complete (N%) | 97 (100%)      | 102 (99.03%)   | 199 (99.5%)    |
| Missing       | 0 (0%)         | 1 (1.0%)       | 1 (0.5%)       |
| numbers       |                |                |                |
| Mean (SD)     | 100.05 (57.01) | 101.42 (59.03) | 100.75 (57.91) |
| 5%, 95%       | 10.2, 189      | 12.05, 189.95  | 10.9, 190.1    |
| Complete (N%) | 97 (100%)      | 102 (99.03%)   | 199 (99.5%)    |
| Missing       | 0 (0%)         | 1 (1.0%)       | 1 (0.5%)       |

#### `table1()` + `table1_pvalue`

Hypothesis tests can be added to `table1` using the `extra.col`
argument: there is a worked example of including `t.test` and
`chisq.test` in the [table1
documentation](https://cran.r-project.org/web/packages/table1/vignettes/table1-examples.html#example-a-column-of-p-values).
The `table1_pvalue` function is a convenience function that allows users
to supply their own tests to be computed in `table1`. The defaults
include `t.test` and ANOVA omnibus test (via a `lm` and `anova` wrapper)
for continuous variables, and `chisq.test` for categorical variables:

``` r
my_table <-
  table1::table1(
    x = ~ numbers + continuous + binary + ordered + binary_factor +
      categorical | two_level_group,
    data = jfbr_test,
    overall = FALSE,
    extra.col =
      list("p-value" = table1_pvalue)
  )

kable(my_table)
```

|                     | Group 1                  | Group 2                  | p-value |
|:--------------------|:-------------------------|:-------------------------|:--------|
|                     | (N=97)                   | (N=103)                  |         |
| numbers             |                          |                          |         |
| Mean (SD)           | 100 (57.0)               | 101 (59.0)               | 0.868   |
| Median \[Min, Max\] | 100 \[1.00, 200\]        | 104 \[2.00, 197\]        |         |
| Missing             | 0 (0%)                   | 1 (1.0%)                 |         |
| continuous          |                          |                          |         |
| Mean (SD)           | 0.525 (0.297)            | 0.560 (0.291)            | 0.407   |
| Median \[Min, Max\] | 0.510 \[0.00114, 0.993\] | 0.601 \[0.00599, 0.990\] |         |
| Missing             | 0 (0%)                   | 1 (1.0%)                 |         |
| binary              |                          |                          |         |
| Mean (SD)           | 0.546 (0.500)            | 0.578 (0.496)            | 0.651   |
| Median \[Min, Max\] | 1.00 \[0, 1.00\]         | 1.00 \[0, 1.00\]         |         |
| Missing             | 0 (0%)                   | 1 (1.0%)                 |         |
| ordered             |                          |                          |         |
| 1                   | 29 (29.9%)               | 34 (33.0%)               | 0.263   |
| 2                   | 15 (15.5%)               | 25 (24.3%)               |         |
| 3                   | 28 (28.9%)               | 20 (19.4%)               |         |
| 4                   | 24 (24.7%)               | 24 (23.3%)               |         |
| Missing             | 1 (1.0%)                 | 0 (0%)                   |         |
| binary_factor       |                          |                          |         |
| 0\. No              | 46 (47.4%)               | 47 (45.6%)               | 0.962   |
| 1\. Yes             | 51 (52.6%)               | 55 (53.4%)               |         |
| Missing             | 0 (0%)                   | 1 (1.0%)                 |         |
| categorical         |                          |                          |         |
| 1                   | 23 (23.7%)               | 24 (23.3%)               | 0.24    |
| 2                   | 26 (26.8%)               | 16 (15.5%)               |         |
| 3                   | 25 (25.8%)               | 30 (29.1%)               |         |
| 4                   | 23 (23.7%)               | 32 (31.1%)               |         |
| Missing             | 0 (0%)                   | 1 (1.0%)                 |         |

``` r

my_table <-
  table1::table1(
    x = ~ numbers + continuous + binary + ordered + binary_factor +
      categorical | three_level_group,
    data = jfbr_test,
    overall = FALSE,
    extra.col =
      list("p-value" = table1_pvalue)
  )

kable(my_table)
```

|                     | Group 1                  | Group 2                  | Group 3                  | p-value |
|:--------------------|:-------------------------|:-------------------------|:-------------------------|:--------|
|                     | (N=67)                   | (N=70)                   | (N=63)                   |         |
| numbers             |                          |                          |                          |         |
| Mean (SD)           | 103 (61.3)               | 97.7 (52.6)              | 101 (60.6)               | 0.85    |
| Median \[Min, Max\] | 107 \[1.00, 197\]        | 99.5 \[7.00, 185\]       | 98.0 \[3.00, 200\]       |         |
| Missing             | 0 (0%)                   | 0 (0%)                   | 1 (1.6%)                 |         |
| continuous          |                          |                          |                          |         |
| Mean (SD)           | 0.521 (0.321)            | 0.555 (0.282)            | 0.553 (0.280)            | 0.756   |
| Median \[Min, Max\] | 0.509 \[0.00693, 0.990\] | 0.600 \[0.00114, 0.970\] | 0.609 \[0.00865, 0.993\] |         |
| Missing             | 0 (0%)                   | 1 (1.4%)                 | 0 (0%)                   |         |
| binary              |                          |                          |                          |         |
| Mean (SD)           | 0.552 (0.501)            | 0.507 (0.504)            | 0.635 (0.485)            | 0.332   |
| Median \[Min, Max\] | 1.00 \[0, 1.00\]         | 1.00 \[0, 1.00\]         | 1.00 \[0, 1.00\]         |         |
| Missing             | 0 (0%)                   | 1 (1.4%)                 | 0 (0%)                   |         |
| ordered             |                          |                          |                          |         |
| 1                   | 13 (19.4%)               | 29 (41.4%)               | 21 (33.3%)               | 0.00748 |
| 2                   | 21 (31.3%)               | 11 (15.7%)               | 8 (12.7%)                |         |
| 3                   | 14 (20.9%)               | 20 (28.6%)               | 14 (22.2%)               |         |
| 4                   | 18 (26.9%)               | 10 (14.3%)               | 20 (31.7%)               |         |
| Missing             | 1 (1.5%)                 | 0 (0%)                   | 0 (0%)                   |         |
| binary_factor       |                          |                          |                          |         |
| 0\. No              | 26 (38.8%)               | 40 (57.1%)               | 27 (42.9%)               | 0.0825  |
| 1\. Yes             | 41 (61.2%)               | 30 (42.9%)               | 35 (55.6%)               |         |
| Missing             | 0 (0%)                   | 0 (0%)                   | 1 (1.6%)                 |         |
| categorical         |                          |                          |                          |         |
| 1                   | 18 (26.9%)               | 15 (21.4%)               | 14 (22.2%)               | 0.364   |
| 2                   | 13 (19.4%)               | 12 (17.1%)               | 17 (27.0%)               |         |
| 3                   | 22 (32.8%)               | 18 (25.7%)               | 15 (23.8%)               |         |
| 4                   | 13 (19.4%)               | 25 (35.7%)               | 17 (27.0%)               |         |
| Missing             | 1 (1.5%)                 | 0 (0%)                   | 0 (0%)                   |         |

Any function that returns an element `p.value` can be passed as an
argument, allowing users to customize which tests are performed:

``` r
my_table <-
  table1::table1(
    x = ~ numbers + continuous + binary + ordered + binary_factor +
      categorical | two_level_group,
    data = jfbr_test,
    overall = FALSE,
    extra.col =
      list("p-value" =
             function(x, value) table1_pvalue(
               x = x,
               variable = variable,
               test_numeric_2_levels = wilcox.test,
               test_numeric_more_than_2_levels = kruskal.test,
               test_categorical_2_levels = fisher.test,
               test_categorical_more_than_2_levels = fisher.test
             )
      )
  )

kable(my_table)
```

|                     | Group 1                  | Group 2                  | p-value |
|:--------------------|:-------------------------|:-------------------------|:--------|
|                     | (N=97)                   | (N=103)                  |         |
| numbers             |                          |                          |         |
| Mean (SD)           | 100 (57.0)               | 101 (59.0)               | 0.866   |
| Median \[Min, Max\] | 100 \[1.00, 200\]        | 104 \[2.00, 197\]        |         |
| Missing             | 0 (0%)                   | 1 (1.0%)                 |         |
| continuous          |                          |                          |         |
| Mean (SD)           | 0.525 (0.297)            | 0.560 (0.291)            | 0.377   |
| Median \[Min, Max\] | 0.510 \[0.00114, 0.993\] | 0.601 \[0.00599, 0.990\] |         |
| Missing             | 0 (0%)                   | 1 (1.0%)                 |         |
| binary              |                          |                          |         |
| Mean (SD)           | 0.546 (0.500)            | 0.578 (0.496)            | 0.651   |
| Median \[Min, Max\] | 1.00 \[0, 1.00\]         | 1.00 \[0, 1.00\]         |         |
| Missing             | 0 (0%)                   | 1 (1.0%)                 |         |
| ordered             |                          |                          |         |
| 1                   | 29 (29.9%)               | 34 (33.0%)               | 0.266   |
| 2                   | 15 (15.5%)               | 25 (24.3%)               |         |
| 3                   | 28 (28.9%)               | 20 (19.4%)               |         |
| 4                   | 24 (24.7%)               | 24 (23.3%)               |         |
| Missing             | 1 (1.0%)                 | 0 (0%)                   |         |
| binary_factor       |                          |                          |         |
| 0\. No              | 46 (47.4%)               | 47 (45.6%)               | 0.888   |
| 1\. Yes             | 51 (52.6%)               | 55 (53.4%)               |         |
| Missing             | 0 (0%)                   | 1 (1.0%)                 |         |
| categorical         |                          |                          |         |
| 1                   | 23 (23.7%)               | 24 (23.3%)               | 0.241   |
| 2                   | 26 (26.8%)               | 16 (15.5%)               |         |
| 3                   | 25 (25.8%)               | 30 (29.1%)               |         |
| 4                   | 23 (23.7%)               | 32 (31.1%)               |         |
| Missing             | 0 (0%)                   | 1 (1.0%)                 |         |
