# Compute some basic descriptive statistics.

A slight modification of
[`table1::stats.default()`](https://rdrr.io/pkg/table1/man/stats.default.html)
to allow for custom quantiles and produce the percentage of non-missing
values. For more information, see
[`?table1::stats.default`](https://rdrr.io/pkg/table1/man/stats.default.html).

## Usage

``` r
stats_jfbr(x, custom_quantiles = NULL, quantile_type = 7, ...)
```

## Arguments

- x:

  A vector of `numeric`, `factor`, `character`, or `logical` values.

- custom_quantiles:

  A vector of `numeric` values in (0, 1) of quantiles to compute

- quantile_type:

  An integer from 1 to 9, passed as the type argument to function
  [`stats::quantile()`](https://rdrr.io/r/stats/quantile.html)

- ...:

  Further arguments (ignored).

## Value

A list of statistics. See
[`?table1::stats.default`](https://rdrr.io/pkg/table1/man/stats.default.html).

## Examples

``` r
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
stats_jfbr(x = jfbr_test$continuous, custom_quantiles = c(0.42, 0.57))
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
#>       42%       57% 
#> 0.4857978 0.6535020 
#> 
```
