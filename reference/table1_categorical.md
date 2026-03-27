# Summary Functions for table1::table1() for Numeric Data

Summary Functions for table1::table1() for Numeric Data

## Usage

``` r
table1_categorical(x, na_is_category = FALSE)
```

## Arguments

- x:

  A `vector` of values passed from
  [`table1::table1()`](https://rdrr.io/pkg/table1/man/table1.html)

- na_is_category:

  A `logical` scalar, indicating whether missing values should be
  treated as one of the values of the variable (TRUE) or tabulated
  separately (FALSE).

## Value

Tabulations for
[`table1::table1()`](https://rdrr.io/pkg/table1/man/table1.html)

## Examples

``` r
library(table1)

table1(
  x = ~ ordered + binary_factor + categorical | two_level_group,
  data = jfbr_test,
  render.categorical = table1_categorical
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
#> <td class='rowlabel firstrow'><span class='varlabel'>ordered</span></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>1</td>
#> <td>29 (30.2%)</td>
#> <td>34 (33.0%)</td>
#> <td>63 (31.7%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>2</td>
#> <td>15 (15.6%)</td>
#> <td>25 (24.3%)</td>
#> <td>40 (20.1%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>3</td>
#> <td>28 (29.2%)</td>
#> <td>20 (19.4%)</td>
#> <td>48 (24.1%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>4</td>
#> <td>24 (25.0%)</td>
#> <td>24 (23.3%)</td>
#> <td>48 (24.1%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>1 (1.0%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (0.5%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel firstrow'><span class='varlabel'>binary_factor</span></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>0. No</td>
#> <td>46 (47.4%)</td>
#> <td>47 (46.1%)</td>
#> <td>93 (46.7%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>1. Yes</td>
#> <td>51 (52.6%)</td>
#> <td>55 (53.9%)</td>
#> <td>106 (53.3%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.0%)</td>
#> <td class='lastrow'>1 (0.5%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel firstrow'><span class='varlabel'>categorical</span></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>1</td>
#> <td>23 (23.7%)</td>
#> <td>24 (23.5%)</td>
#> <td>47 (23.6%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>2</td>
#> <td>26 (26.8%)</td>
#> <td>16 (15.7%)</td>
#> <td>42 (21.1%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>3</td>
#> <td>25 (25.8%)</td>
#> <td>30 (29.4%)</td>
#> <td>55 (27.6%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>4</td>
#> <td>23 (23.7%)</td>
#> <td>32 (31.4%)</td>
#> <td>55 (27.6%)</td>
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
