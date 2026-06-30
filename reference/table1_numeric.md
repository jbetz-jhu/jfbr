# Summary Functions for table1::table1() for Numeric Data

The default functions in table1::table1() compute the Mean (SD) and
Median (Min, Max) for continuous values. These summary functions are
meant to offer more flexibility in terms of summaries.

## Usage

``` r
table1_numeric(
  x,
  mean_sd = TRUE,
  median_iqr = TRUE,
  range = TRUE,
  quantiles = NULL,
  ...
)
```

## Arguments

- x:

  A `vector` of values passed from
  [`table1::table1()`](https://rdrr.io/pkg/table1/man/table1.html)

- mean_sd:

  A `logical` scalar: Compute Mean & SD?

- median_iqr:

  A `logical` scalar: Compute Median & IQR?

- range:

  A `logical` scalar: Compute Range?

- quantiles:

  A `vector` of `numeric` values: Quantiles to compute

- ...:

  Arguments passed to
  [`stats_jfbr()`](https://jbetz-jhu.github.io/jfbr/reference/stats_jfbr.md)

## Value

A `vector` of character-formatted results

## Examples

``` r

table1_numeric(
  x = c(1:100, NA),
  quantiles = c(0.05, 0.95)
)
#>                               Mean (SD)        Median [IQR]          [Min, Max] 
#>                  ""       "50.5 (29.0)" "50.5 [25.8, 75.3]"       "[1.00, 100]" 
#>             5%, 95% 
#>        "5.95, 95.1" 

data(jfbr_test)
library(table1)

  table1(
    x = ~ continuous + numbers | two_level_group,
    data = jfbr_test,
    render.continuous = table1_numeric
  )
#> <table class="Rtable1">
#> <thead>
#> <tr>
#> <th class='rowlabel firstrow lastrow'></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>Group 1<br/><span class='stratn'>(N=97)</span></span></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>Group 2<br/><span class='stratn'>(N=103)</span></span></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>Overall<br/><span class='stratn'>(N=200)</span></span></th>
#> </tr>
#> </thead>
#> <tbody>
#> <tr>
#> <td class='rowlabel firstrow'><span class='varlabel'>continuous</span></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Mean (SD)</td>
#> <td>0.525 (0.297)</td>
#> <td>0.560 (0.291)</td>
#> <td>0.543 (0.294)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Median [IQR]</td>
#> <td>0.510 [0.294, 0.757]</td>
#> <td>0.601 [0.317, 0.811]</td>
#> <td>0.588 [0.306, 0.795]</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>[Min, Max]</td>
#> <td>[0.00114, 0.993]</td>
#> <td>[0.00599, 0.990]</td>
#> <td>[0.00114, 0.993]</td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.0%)</td>
#> <td class='lastrow'>1 (0.5%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel firstrow'><span class='varlabel'>numbers</span></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Mean (SD)</td>
#> <td>100 (57.0)</td>
#> <td>101 (59.0)</td>
#> <td>101 (57.9)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Median [IQR]</td>
#> <td>100 [56.0, 146]</td>
#> <td>104 [49.5, 154]</td>
#> <td>101 [51.5, 151]</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>[Min, Max]</td>
#> <td>[1.00, 200]</td>
#> <td>[2.00, 197]</td>
#> <td>[1.00, 200]</td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.0%)</td>
#> <td class='lastrow'>1 (0.5%)</td>
#> </tr>
#> </tbody>
#> </table>
```
