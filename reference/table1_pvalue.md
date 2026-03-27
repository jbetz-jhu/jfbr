# Compute hypothesis tests for table1::table1()

table1::table1() has the ability to add a column for hypothesis test
p-values: see ?table1::table1.

## Usage

``` r
table1_pvalue(
  x,
  variable,
  test_numeric_2_levels = stats::t.test,
  test_numeric_more_than_2_levels = function(data, formula) {
     data.frame(p.value =
    stats::anova(stats::lm(formula = formula, data = data))$`Pr(>F)`[1])
 },
  test_categorical_2_levels = stats::chisq.test,
  test_categorical_more_than_2_levels = stats::chisq.test,
  digits = 3
)
```

## Arguments

- x:

  A named `list` of values - Typically passed from table1::table1().

- variable:

  a `character` scalar indicating the grouping variable name - Typically
  passed from table1::table1().

- test_numeric_2_levels:

  a `function` that computes a hypothesis test using a formula (variable
  ~ group) where group has only two levels, and `variable` is numeric.
  The default is `t.test`, alternatives include: `wilcox.test`.

- test_numeric_more_than_2_levels:

  a `function` that computes a hypothesis test using a formula (variable
  ~ group) where group has more than two levels, and `variable` is
  numeric. The default is the omnibus F-test from anova(lm(variable ~
  group)), alternatives include: `kruskal.test`.

- test_categorical_2_levels:

  a `function` that computes a hypothesis test using a formula (variable
  ~ group) where group has only two levels and `variable` is
  categorical. The default is `chisq.test`, alternatives include:
  `fisher.test`.

- test_categorical_more_than_2_levels:

  a `function` that computes a hypothesis test using a formula (variable
  ~ group) where group has more than two levels and `variable` is
  categorical. The default is `chisq.test`, alternatives include:
  `fisher.test`.

- digits:

  `numeric` scalar: number of digits to use when formatting p-values

## Value

A `numeric` scalar containing the p-value from the specified hypothesis
tests.

## Examples

``` r
library(table1)

data(jfbr_test)

table1(
  x = ~ numbers + continuous + binary + ordered | two_level_group,
  data = jfbr_test,
  overall = FALSE,
  extra.col =
    list("p-value" = table1_pvalue)
)
#> <table class="Rtable1">
#> <thead>
#> <tr>
#> <th class='rowlabel firstrow lastrow'></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>Group 1<br/><span class='stratn'>(N=97)</span></span></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>Group 2<br/><span class='stratn'>(N=103)</span></span></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>p-value</span></th>
#> </tr>
#> </thead>
#> <tbody>
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
#> <td>0.868</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Median [Min, Max]</td>
#> <td>100 [1.00, 200]</td>
#> <td>104 [2.00, 197]</td>
#> <td></td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.0%)</td>
#> <td class='lastrow'></td>
#> </tr>
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
#> <td>0.407</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Median [Min, Max]</td>
#> <td>0.510 [0.00114, 0.993]</td>
#> <td>0.601 [0.00599, 0.990]</td>
#> <td></td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.0%)</td>
#> <td class='lastrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel firstrow'><span class='varlabel'>binary</span></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Mean (SD)</td>
#> <td>0.546 (0.500)</td>
#> <td>0.578 (0.496)</td>
#> <td>0.651</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Median [Min, Max]</td>
#> <td>1.00 [0, 1.00]</td>
#> <td>1.00 [0, 1.00]</td>
#> <td></td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.0%)</td>
#> <td class='lastrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel firstrow'><span class='varlabel'>ordered</span></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>1</td>
#> <td>29 (29.9%)</td>
#> <td>34 (33.0%)</td>
#> <td>0.263</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>2</td>
#> <td>15 (15.5%)</td>
#> <td>25 (24.3%)</td>
#> <td></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>3</td>
#> <td>28 (28.9%)</td>
#> <td>20 (19.4%)</td>
#> <td></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>4</td>
#> <td>24 (24.7%)</td>
#> <td>24 (23.3%)</td>
#> <td></td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>1 (1.0%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'></td>
#> </tr>
#> </tbody>
#> </table>

table1(
  x = ~ numbers + continuous + binary + ordered | three_level_group,
  data = jfbr_test,
  overall = FALSE,
  extra.col =
    list("p-value" =
           function(x, value) table1_pvalue(
             x = x,
             variable = variable,
             test_numeric_2_levels = wilcox.test,
             test_numeric_more_than_2_levels = kruskal.test,
             test_categorical_2_levels = chisq.test,
             test_categorical_more_than_2_levels = chisq.test
           )
    )
)
#> <table class="Rtable1">
#> <thead>
#> <tr>
#> <th class='rowlabel firstrow lastrow'></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>Group 1<br/><span class='stratn'>(N=67)</span></span></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>Group 2<br/><span class='stratn'>(N=70)</span></span></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>Group 3<br/><span class='stratn'>(N=63)</span></span></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>p-value</span></th>
#> </tr>
#> </thead>
#> <tbody>
#> <tr>
#> <td class='rowlabel firstrow'><span class='varlabel'>numbers</span></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Mean (SD)</td>
#> <td>103 (61.3)</td>
#> <td>97.7 (52.6)</td>
#> <td>101 (60.6)</td>
#> <td>0.847</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Median [Min, Max]</td>
#> <td>107 [1.00, 197]</td>
#> <td>99.5 [7.00, 185]</td>
#> <td>98.0 [3.00, 200]</td>
#> <td></td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.6%)</td>
#> <td class='lastrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel firstrow'><span class='varlabel'>continuous</span></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Mean (SD)</td>
#> <td>0.521 (0.321)</td>
#> <td>0.555 (0.282)</td>
#> <td>0.553 (0.280)</td>
#> <td>0.841</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Median [Min, Max]</td>
#> <td>0.509 [0.00693, 0.990]</td>
#> <td>0.600 [0.00114, 0.970]</td>
#> <td>0.609 [0.00865, 0.993]</td>
#> <td></td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.4%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel firstrow'><span class='varlabel'>binary</span></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Mean (SD)</td>
#> <td>0.552 (0.501)</td>
#> <td>0.507 (0.504)</td>
#> <td>0.635 (0.485)</td>
#> <td>0.33</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Median [Min, Max]</td>
#> <td>1.00 [0, 1.00]</td>
#> <td>1.00 [0, 1.00]</td>
#> <td>1.00 [0, 1.00]</td>
#> <td></td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.4%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel firstrow'><span class='varlabel'>ordered</span></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>1</td>
#> <td>13 (19.4%)</td>
#> <td>29 (41.4%)</td>
#> <td>21 (33.3%)</td>
#> <td>0.00748</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>2</td>
#> <td>21 (31.3%)</td>
#> <td>11 (15.7%)</td>
#> <td>8 (12.7%)</td>
#> <td></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>3</td>
#> <td>14 (20.9%)</td>
#> <td>20 (28.6%)</td>
#> <td>14 (22.2%)</td>
#> <td></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>4</td>
#> <td>18 (26.9%)</td>
#> <td>10 (14.3%)</td>
#> <td>20 (31.7%)</td>
#> <td></td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>1 (1.5%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'></td>
#> </tr>
#> </tbody>
#> </table>
```
