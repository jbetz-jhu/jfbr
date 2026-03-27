# jfbr_test: Example data for testing functions.

A `data.frame` containing columns with the following data types:
`integer`, `numeric`, 0/1 binary, `ordered`, `factor`. Each column has a
missing value

## Usage

``` r
jfbr_test
```

## Format

### `jfbr_test`

A data frame with 200 rows and 8 columns:

- numbers:

  Participant ID

- continuous:

  Baseline Covariates 1-4

- binary:

  Binary treatment assignment (1 = Treatment; 0 = Control)

- ordered:

  Outcomes at assessments 1-4

- binary_factor:

  Time from study initiation to randomization

- categorical:

  Study time of assessments 1-4

- two_level_group:

  Two level factor for grouping: No missing data

- three_level_group:

  Three level factor for grouping: No missing data

## Details

Two grouping variables are included with no missing values, since
missing values in grouping variables creates an error in
[`table1::table1()`](https://rdrr.io/pkg/table1/man/table1.html).
