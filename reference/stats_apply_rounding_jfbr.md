# Apply rounding to basic descriptive statistics.

This is a slight modification of
[table1::stats.apply.rounding](https://rdrr.io/pkg/table1/man/stats.apply.rounding.html).
For more information

## Usage

``` r
stats_apply_rounding_jfbr(
  x,
  digits = 3,
  digits.pct = 1,
  round.median.min.max = TRUE,
  round.integers = TRUE,
  round5up = TRUE,
  rounding.fn = table1::signif_pad,
  ...
)
```

## Arguments

- x:

  A list, such as that returned by `stats.default`.

- digits:

  An integer specifying the number of significant digits to keep.

- digits.pct:

  An integer specifying the number of digits after the decimal place for
  percentages.

- round.median.min.max:

  Should rounding applied to median, min and max?

- round.integers:

  should rounding be limited to digits to the right of the decimal
  point?

- round5up:

  Should numbers with 5 as the last digit always be rounded up? The
  standard R approach is "go to the even digit" (IEC 60559 standard, see
  `round`), while some other software (e.g. SAS, Excel) always round up.

- rounding.fn:

  The function to use to do the rounding. Defaults to `signif_pad`.

- ...:

  Further arguments.

## Value

A list with the same number of elements as `x`. The rounded values will
be character (not numeric) and will have 0 padding to ensure consistent
number of significant digits.

## Examples

``` r
library(table1)
#> 
#> Attaching package: ‘table1’
#> The following objects are masked from ‘package:base’:
#> 
#>     units, units<-
stats.default(x = jfbr_test$continuous)
#> $N
#> [1] 199
#> 
#> $NMISS
#> [1] 1
#> 
#> $SUM
#> [1] 108.0907
#> 
#> $MEAN
#> [1] 0.5431696
#> 
#> $SD
#> [1] 0.2939148
#> 
#> $CV
#> [1] 54.11105
#> 
#> $GMEAN
#> [1] 0.4016413
#> 
#> $GSD
#> [1] 2.851476
#> 
#> $GCV
#> [1] 141.3524
#> 
#> $MEDIAN
#>      0.5 
#> 0.587948 
#> 
#> $MIN
#> [1] 0.001136587
#> 
#> $MAX
#> [1] 0.9933775
#> 
#> $q01
#>        0.01 
#> 0.006910398 
#> 
#> $q02.5
#>      0.025 
#> 0.01870823 
#> 
#> $q05
#>       0.05 
#> 0.05437357 
#> 
#> $q10
#>       0.1 
#> 0.1465087 
#> 
#> $q25
#>      0.25 
#> 0.3058979 
#> 
#> $q50
#>      0.5 
#> 0.587948 
#> 
#> $q75
#>      0.75 
#> 0.7954743 
#> 
#> $q90
#>       0.9 
#> 0.9300332 
#> 
#> $q95
#>      0.95 
#> 0.9657794 
#> 
#> $q97.5
#>     0.975 
#> 0.9840511 
#> 
#> $q99
#>      0.99 
#> 0.9897444 
#> 
#> $Q1
#>      0.25 
#> 0.3058979 
#> 
#> $Q2
#>      0.5 
#> 0.587948 
#> 
#> $Q3
#>      0.75 
#> 0.7954743 
#> 
#> $IQR
#>      0.75 
#> 0.4895763 
#> 
#> $T1
#>       1/3 
#> 0.3797362 
#> 
#> $T2
#>      2/3 
#> 0.735685 
#> 
stats.apply.rounding(stats.default(x = jfbr_test$continuous), digits = 3)
#> $N
#> [1] "199"
#> 
#> $NMISS
#> [1] "1"
#> 
#> $SUM
#> [1] "108"
#> 
#> $MEAN
#> [1] "0.543"
#> 
#> $SD
#> [1] "0.294"
#> 
#> $CV
#> [1] "54.1"
#> 
#> $GMEAN
#> [1] "0.402"
#> 
#> $GSD
#> [1] "2.85"
#> 
#> $GCV
#> [1] "141.4"
#> 
#> $MEDIAN
#>     0.5 
#> "0.588" 
#> 
#> $MIN
#> [1] "0.00114"
#> 
#> $MAX
#> [1] "0.993"
#> 
#> $q01
#>      0.01 
#> "0.00691" 
#> 
#> $q02.5
#>    0.025 
#> "0.0187" 
#> 
#> $q05
#>     0.05 
#> "0.0544" 
#> 
#> $q10
#>     0.1 
#> "0.147" 
#> 
#> $q25
#>    0.25 
#> "0.306" 
#> 
#> $q50
#>     0.5 
#> "0.588" 
#> 
#> $q75
#>    0.75 
#> "0.795" 
#> 
#> $q90
#>     0.9 
#> "0.930" 
#> 
#> $q95
#>    0.95 
#> "0.966" 
#> 
#> $q97.5
#>   0.975 
#> "0.984" 
#> 
#> $q99
#>    0.99 
#> "0.990" 
#> 
#> $Q1
#>    0.25 
#> "0.306" 
#> 
#> $Q2
#>     0.5 
#> "0.588" 
#> 
#> $Q3
#>    0.75 
#> "0.795" 
#> 
#> $IQR
#>    0.75 
#> "0.490" 
#> 
#> $T1
#>     1/3 
#> "0.380" 
#> 
#> $T2
#>     2/3 
#> "0.736" 
#> 
stats_jfbr(x = jfbr_test$continuous)
#> $N
#> [1] 199
#> 
#> $NMISS
#> [1] 1
#> 
#> $PCTNMISS
#> [1] 99.5
#> 
#> $SUM
#> [1] 108.0907
#> 
#> $MEAN
#> [1] 0.5431696
#> 
#> $SD
#> [1] 0.2939148
#> 
#> $MEDIAN
#> [1] 0.587948
#> 
#> $MIN
#> [1] 0.001136587
#> 
#> $MAX
#> [1] 0.9933775
#> 
#> $q01
#>          1% 
#> 0.006910398 
#> 
#> $q02.5
#>       2.5% 
#> 0.01870823 
#> 
#> $q25
#>       25% 
#> 0.3058979 
#> 
#> $q50
#>      50% 
#> 0.587948 
#> 
#> $q75
#>       75% 
#> 0.7954743 
#> 
#> $q90
#>       90% 
#> 0.9300332 
#> 
#> $q95
#>       95% 
#> 0.9657794 
#> 
#> $q97.5
#>     97.5% 
#> 0.9840511 
#> 
#> $q99
#>       99% 
#> 0.9897444 
#> 
#> $Q1
#>       25% 
#> 0.3058979 
#> 
#> $Q2
#>      50% 
#> 0.587948 
#> 
#> $Q3
#>       75% 
#> 0.7954743 
#> 
#> $IQR
#>       75% 
#> 0.4895763 
#> 
#> $T1
#> 33.33333% 
#> 0.3797362 
#> 
#> $T2
#> 66.66667% 
#>  0.735685 
#> 
#> $CQ
#> NULL
#> 
stats_apply_rounding_jfbr(stats_jfbr(x = jfbr_test$continuous), digits = 3)
#> $N
#> [1] "199"
#> 
#> $NMISS
#> [1] "1"
#> 
#> $PCTNMISS
#> [1] "99.5"
#> 
#> $SUM
#> [1] "108"
#> 
#> $MEAN
#> [1] "0.543"
#> 
#> $SD
#> [1] "0.294"
#> 
#> $MEDIAN
#> [1] "0.588"
#> 
#> $MIN
#> [1] "0.00114"
#> 
#> $MAX
#> [1] "0.993"
#> 
#> $q01
#>        1% 
#> "0.00691" 
#> 
#> $q02.5
#>     2.5% 
#> "0.0187" 
#> 
#> $q25
#>     25% 
#> "0.306" 
#> 
#> $q50
#>     50% 
#> "0.588" 
#> 
#> $q75
#>     75% 
#> "0.795" 
#> 
#> $q90
#>     90% 
#> "0.930" 
#> 
#> $q95
#>     95% 
#> "0.966" 
#> 
#> $q97.5
#>   97.5% 
#> "0.984" 
#> 
#> $q99
#>     99% 
#> "0.990" 
#> 
#> $Q1
#>     25% 
#> "0.306" 
#> 
#> $Q2
#>     50% 
#> "0.588" 
#> 
#> $Q3
#>     75% 
#> "0.795" 
#> 
#> $IQR
#>     75% 
#> "0.490" 
#> 
#> $T1
#> 33.33333% 
#>   "0.380" 
#> 
#> $T2
#> 66.66667% 
#>   "0.736" 
#> 
#> $CQ
#> logical(0)
#> 
stats_apply_rounding_jfbr(
  x =
    stats_jfbr(
      x = jfbr_test$continuous,
      custom_quantiles = c(0.47, 0.52)
    ),
  digits = 3
)
#> $N
#> [1] "199"
#> 
#> $NMISS
#> [1] "1"
#> 
#> $PCTNMISS
#> [1] "99.5"
#> 
#> $SUM
#> [1] "108"
#> 
#> $MEAN
#> [1] "0.543"
#> 
#> $SD
#> [1] "0.294"
#> 
#> $MEDIAN
#> [1] "0.588"
#> 
#> $MIN
#> [1] "0.00114"
#> 
#> $MAX
#> [1] "0.993"
#> 
#> $q01
#>        1% 
#> "0.00691" 
#> 
#> $q02.5
#>     2.5% 
#> "0.0187" 
#> 
#> $q25
#>     25% 
#> "0.306" 
#> 
#> $q50
#>     50% 
#> "0.588" 
#> 
#> $q75
#>     75% 
#> "0.795" 
#> 
#> $q90
#>     90% 
#> "0.930" 
#> 
#> $q95
#>     95% 
#> "0.966" 
#> 
#> $q97.5
#>   97.5% 
#> "0.984" 
#> 
#> $q99
#>     99% 
#> "0.990" 
#> 
#> $Q1
#>     25% 
#> "0.306" 
#> 
#> $Q2
#>     50% 
#> "0.588" 
#> 
#> $Q3
#>     75% 
#> "0.795" 
#> 
#> $IQR
#>     75% 
#> "0.490" 
#> 
#> $T1
#> 33.33333% 
#>   "0.380" 
#> 
#> $T2
#> 66.66667% 
#>   "0.736" 
#> 
#> $CQ
#>     47%     52% 
#> "0.515" "0.602" 
#> 
```
