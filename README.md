
<!-- README.md is generated from README.Rmd. Please edit that file -->

# jfbr

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

## Examples: Tabulation

Convenience functions have been added for the `table1::table1()`
function to make it easier to do different summaries and add hypothesis
testing.

``` r
# Create Example Data:
set.seed(12345)
n_obs <- 1000

my_data <-
  data.frame(
    numbers = 1:n_obs,
    continuous = runif(n = n_obs),
    binary = rbinom(n = n_obs, size = 1, prob = 0.5),
    binary_factor =
      factor(
        x = rbinom(n = n_obs, size = 1, prob = 0.5),
        levels = 0:1,
        labels = c("0. No", "1. Yes")
      ),
    categorical = factor(sample(x = 1:4, size = n_obs, replace = TRUE)),
    ordered = ordered(sample(x = 1:4, size = n_obs, replace = TRUE))
  )
```

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

The default for `table1::table1()` is to produce Mean (SD) and Median
\[Min, Max\]. Note: saving the result of `table1::table1()` and using
`knitr::kable()`is only necessary when HTML output is not possible:

``` r
# table1() defaults
my_table <-
  table1(
    x = ~ continuous + numbers | binary_factor,
    data = my_data
  )

kable(my_table)
```

|                     | 0\. No                   | 1\. Yes                  | Overall                  |
|:--------------------|:-------------------------|:-------------------------|:-------------------------|
|                     | (N=503)                  | (N=497)                  | (N=1000)                 |
| continuous          |                          |                          |                          |
| Mean (SD)           | 0.513 (0.287)            | 0.515 (0.282)            | 0.514 (0.284)            |
| Median \[Min, Max\] | 0.515 \[0.00114, 0.997\] | 0.527 \[0.00425, 0.993\] | 0.521 \[0.00114, 0.997\] |
| numbers             |                          |                          |                          |
| Mean (SD)           | 492 (289)                | 509 (289)                | 501 (289)                |
| Median \[Min, Max\] | 490 \[5.00, 1000\]       | 509 \[1.00, 999\]        | 501 \[1.00, 1000\]       |

Using the argument `render.continuous = table1_numeric` adds Median
\[IQR\] and \[Max, Min\]:

``` r
my_table <-
  table1(
    x = ~ continuous + numbers | binary_factor,
    data = my_data,
    render.continuous = table1_numeric
  )

kable(my_table)
```

|                | 0\. No          | 1\. Yes         | Overall        |
|:---------------|:----------------|:----------------|:---------------|
|                | (N=503)         | (N=497)         | (N=1000)       |
| continuous     |                 |                 |                |
| Mean (SD)      | 0.51 (0.29)     | 0.52 (0.28)     | 0.51 (0.28)    |
| Median \[IQR\] | 0.51 (0.29)     | 0.53 (0.28)     | 0.52 (0.28)    |
| \[Min, Max\]   | \[0, 1\]        | \[0, 0.99\]     | \[0, 1\]       |
| numbers        |                 |                 |                |
| Mean (SD)      | 492.08 (289.16) | 509.02 (288.52) | 500.5 (288.82) |
| Median \[IQR\] | 490 (289.16)    | 509 (288.52)    | 500.5 (288.82) |
| \[Min, Max\]   | \[5, 1000\]     | \[1, 999\]      | \[1, 1000\]    |

The arguments `mean_sd`, `median_iqr`, and `range` control which
summaries are computed. Quantiles can be added optionally with the
`quantiles` argment:

``` r
# Only Mean/SD
my_table <-
  table1(
    x = ~ continuous + numbers | binary_factor,
    data = my_data,
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

|            | 0\. No          | 1\. Yes         | Overall        |
|:-----------|:----------------|:----------------|:---------------|
|            | (N=503)         | (N=497)         | (N=1000)       |
| continuous |                 |                 |                |
| Mean (SD)  | 0.51 (0.29)     | 0.52 (0.28)     | 0.51 (0.28)    |
| numbers    |                 |                 |                |
| Mean (SD)  | 492.08 (289.16) | 509.02 (288.52) | 500.5 (288.82) |

``` r

# Only Mean/SD, 5% and 95% Quantiles
my_table <-
  table1(
    x = ~ continuous + numbers | binary_factor,
    data = my_data,
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

|            | 0\. No          | 1\. Yes         | Overall        |
|:-----------|:----------------|:----------------|:---------------|
|            | (N=503)         | (N=497)         | (N=1000)       |
| continuous |                 |                 |                |
| Mean (SD)  | 0.51 (0.29)     | 0.52 (0.28)     | 0.51 (0.28)    |
| 5%, 95%    | 0.04, 0.94      | 0.06, 0.95      | 0.05, 0.94     |
| numbers    |                 |                 |                |
| Mean (SD)  | 492.08 (289.16) | 509.02 (288.52) | 500.5 (288.82) |
| 5%, 95%    | 52.3, 948.9     | 50.6, 950.2     | 50.95, 950.05  |

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
    x = ~ numbers + continuous + binary + ordered | binary_factor,
    data = my_data,
    overall = FALSE,
    extra.col =
      list("p-value" = table1_pvalue)
  )

kable(my_table)
```

|                     | 0\. No                   | 1\. Yes                  | p-value |
|:--------------------|:-------------------------|:-------------------------|:--------|
|                     | (N=503)                  | (N=497)                  |         |
| numbers             |                          |                          |         |
| Mean (SD)           | 492 (289)                | 509 (289)                | 0.354   |
| Median \[Min, Max\] | 490 \[5.00, 1000\]       | 509 \[1.00, 999\]        |         |
| continuous          |                          |                          |         |
| Mean (SD)           | 0.513 (0.287)            | 0.515 (0.282)            | 0.895   |
| Median \[Min, Max\] | 0.515 \[0.00114, 0.997\] | 0.527 \[0.00425, 0.993\] |         |
| binary              |                          |                          |         |
| Mean (SD)           | 0.491 (0.500)            | 0.535 (0.499)            | 0.163   |
| Median \[Min, Max\] | 0 \[0, 1.00\]            | 1.00 \[0, 1.00\]         |         |
| ordered             |                          |                          |         |
| 1                   | 136 (27.0%)              | 119 (23.9%)              | 0.725   |
| 2                   | 112 (22.3%)              | 115 (23.1%)              |         |
| 3                   | 121 (24.1%)              | 122 (24.5%)              |         |
| 4                   | 134 (26.6%)              | 141 (28.4%)              |         |

``` r

my_table <-
  table1::table1(
    x = ~ numbers + continuous + binary + ordered | categorical,
    data = my_data,
    overall = FALSE,
    extra.col =
      list("p-value" = table1_pvalue)
  )

kable(my_table)
```

|                     | 1                        | 2                        | 3                        | 4                        | p-value |
|:--------------------|:-------------------------|:-------------------------|:-------------------------|:-------------------------|:--------|
|                     | (N=240)                  | (N=269)                  | (N=253)                  | (N=238)                  |         |
| numbers             |                          |                          |                          |                          |         |
| Mean (SD)           | 475 (290)                | 505 (290)                | 523 (285)                | 496 (290)                | 0.326   |
| Median \[Min, Max\] | 463 \[3.00, 996\]        | 488 \[1.00, 987\]        | 539 \[2.00, 997\]        | 494 \[6.00, 1000\]       |         |
| continuous          |                          |                          |                          |                          |         |
| Mean (SD)           | 0.508 (0.283)            | 0.497 (0.295)            | 0.556 (0.282)            | 0.494 (0.273)            | 0.0492  |
| Median \[Min, Max\] | 0.508 \[0.00693, 0.997\] | 0.517 \[0.00425, 0.995\] | 0.598 \[0.00946, 0.996\] | 0.512 \[0.00114, 0.990\] |         |
| binary              |                          |                          |                          |                          |         |
| Mean (SD)           | 0.504 (0.501)            | 0.487 (0.501)            | 0.534 (0.500)            | 0.529 (0.500)            | 0.686   |
| Median \[Min, Max\] | 1.00 \[0, 1.00\]         | 0 \[0, 1.00\]            | 1.00 \[0, 1.00\]         | 1.00 \[0, 1.00\]         |         |
| ordered             |                          |                          |                          |                          |         |
| 1                   | 77 (32.1%)               | 57 (21.2%)               | 62 (24.5%)               | 59 (24.8%)               | 0.155   |
| 2                   | 54 (22.5%)               | 66 (24.5%)               | 57 (22.5%)               | 50 (21.0%)               |         |
| 3                   | 54 (22.5%)               | 76 (28.3%)               | 56 (22.1%)               | 57 (23.9%)               |         |
| 4                   | 55 (22.9%)               | 70 (26.0%)               | 78 (30.8%)               | 72 (30.3%)               |         |

Any function that returns an element `p.value` can be passed as an
argument, allowing users to customize which tests are performed:

``` r
my_table <-
  table1::table1(
    x = ~ numbers + continuous + binary + ordered | binary_factor,
    data = my_data,
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

|                     | 0\. No                   | 1\. Yes                  | p-value |
|:--------------------|:-------------------------|:-------------------------|:--------|
|                     | (N=503)                  | (N=497)                  |         |
| numbers             |                          |                          |         |
| Mean (SD)           | 492 (289)                | 509 (289)                | 0.354   |
| Median \[Min, Max\] | 490 \[5.00, 1000\]       | 509 \[1.00, 999\]        |         |
| continuous          |                          |                          |         |
| Mean (SD)           | 0.513 (0.287)            | 0.515 (0.282)            | 0.904   |
| Median \[Min, Max\] | 0.515 \[0.00114, 0.997\] | 0.527 \[0.00425, 0.993\] |         |
| binary              |                          |                          |         |
| Mean (SD)           | 0.491 (0.500)            | 0.535 (0.499)            | 0.163   |
| Median \[Min, Max\] | 0 \[0, 1.00\]            | 1.00 \[0, 1.00\]         |         |
| ordered             |                          |                          |         |
| 1                   | 136 (27.0%)              | 119 (23.9%)              | 0.724   |
| 2                   | 112 (22.3%)              | 115 (23.1%)              |         |
| 3                   | 121 (24.1%)              | 122 (24.5%)              |         |
| 4                   | 134 (26.6%)              | 141 (28.4%)              |         |
