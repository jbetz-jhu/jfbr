# Wrapper for render in [table1::table1](https://rdrr.io/pkg/table1/man/table1.html)

Wrapper for render in
[table1::table1](https://rdrr.io/pkg/table1/man/table1.html)

## Usage

``` r
table1_render(numeric = table1_numeric, categorical = table1_categorical, ...)
```

## Arguments

- numeric:

  A function for computing summaries for numeric variables (e.g.
  [table1::render.categorical.default](https://rdrr.io/pkg/table1/man/render.categorical.default.html))

- categorical:

  A function for computing summaries for categorical variables (e.g.
  [table1::render.continuous.default](https://rdrr.io/pkg/table1/man/render.continuous.default.html))

- ...:

  Other arguments passed onto
  [table1::render.default](https://rdrr.io/pkg/table1/man/render.default.html)

## Value

The evaluated results

## Examples

``` r
table1::table1(
  x = ~ numbers + continuous + binary + ordered +
    binary_factor + categorical | three_level_group,
  data = jfbr_test,
  render = table1_render
)
#> <table class="Rtable1">
#> <thead>
#> <tr>
#> <th class='rowlabel firstrow lastrow'></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>Group 1<br/><span class='stratn'>(N=67)</span></span></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>Group 2<br/><span class='stratn'>(N=70)</span></span></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>Group 3<br/><span class='stratn'>(N=63)</span></span></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>Overall<br/><span class='stratn'>(N=200)</span></span></th>
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
#> <td>101 (57.9)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Median [IQR]</td>
#> <td>107 [49.5, 153]</td>
#> <td>99.5 [54.3, 140]</td>
#> <td>98.0 [53.8, 158]</td>
#> <td>101 [51.5, 151]</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>[Min, Max]</td>
#> <td>[1.00, 197]</td>
#> <td>[7.00, 185]</td>
#> <td>[3.00, 200]</td>
#> <td>[1.00, 200]</td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.6%)</td>
#> <td class='lastrow'>1 (0.5%)</td>
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
#> <td>0.543 (0.294)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Median [IQR]</td>
#> <td>0.509 [0.239, 0.827]</td>
#> <td>0.600 [0.325, 0.793]</td>
#> <td>0.609 [0.342, 0.778]</td>
#> <td>0.588 [0.306, 0.795]</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>[Min, Max]</td>
#> <td>[0.00693, 0.990]</td>
#> <td>[0.00114, 0.970]</td>
#> <td>[0.00865, 0.993]</td>
#> <td>[0.00114, 0.993]</td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.4%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (0.5%)</td>
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
#> <td>0.563 (0.497)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Median [IQR]</td>
#> <td>1.00 [0, 1.00]</td>
#> <td>1.00 [0, 1.00]</td>
#> <td>1.00 [0, 1.00]</td>
#> <td>1.00 [0, 1.00]</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>[Min, Max]</td>
#> <td>[0, 1.00]</td>
#> <td>[0, 1.00]</td>
#> <td>[0, 1.00]</td>
#> <td>[0, 1.00]</td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.4%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (0.5%)</td>
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
#> <td>13 (19.7%)</td>
#> <td>29 (41.4%)</td>
#> <td>21 (33.3%)</td>
#> <td>63 (31.7%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>2</td>
#> <td>21 (31.8%)</td>
#> <td>11 (15.7%)</td>
#> <td>8 (12.7%)</td>
#> <td>40 (20.1%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>3</td>
#> <td>14 (21.2%)</td>
#> <td>20 (28.6%)</td>
#> <td>14 (22.2%)</td>
#> <td>48 (24.1%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>4</td>
#> <td>18 (27.3%)</td>
#> <td>10 (14.3%)</td>
#> <td>20 (31.7%)</td>
#> <td>48 (24.1%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>1 (1.5%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (0.5%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel firstrow'><span class='varlabel'>binary_factor</span></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>0. No</td>
#> <td>26 (38.8%)</td>
#> <td>40 (57.1%)</td>
#> <td>27 (43.5%)</td>
#> <td>93 (46.7%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>1. Yes</td>
#> <td>41 (61.2%)</td>
#> <td>30 (42.9%)</td>
#> <td>35 (56.5%)</td>
#> <td>106 (53.3%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.6%)</td>
#> <td class='lastrow'>1 (0.5%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel firstrow'><span class='varlabel'>categorical</span></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>1</td>
#> <td>18 (27.3%)</td>
#> <td>15 (21.4%)</td>
#> <td>14 (22.2%)</td>
#> <td>47 (23.6%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>2</td>
#> <td>13 (19.7%)</td>
#> <td>12 (17.1%)</td>
#> <td>17 (27.0%)</td>
#> <td>42 (21.1%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>3</td>
#> <td>22 (33.3%)</td>
#> <td>18 (25.7%)</td>
#> <td>15 (23.8%)</td>
#> <td>55 (27.6%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>4</td>
#> <td>13 (19.7%)</td>
#> <td>25 (35.7%)</td>
#> <td>17 (27.0%)</td>
#> <td>55 (27.6%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>1 (1.5%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (0.5%)</td>
#> </tr>
#> </tbody>
#> </table>

table1::table1(
  x = ~ numbers + continuous + binary + ordered +
    binary_factor + categorical | three_level_group,
  data = jfbr_test,
  render =
    function(...) table1_render(
      numeric = table1::render.continuous.default,
      categorical = table1::render.categorical.default,
      ...
    )
)
#> <table class="Rtable1">
#> <thead>
#> <tr>
#> <th class='rowlabel firstrow lastrow'></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>Group 1<br/><span class='stratn'>(N=67)</span></span></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>Group 2<br/><span class='stratn'>(N=70)</span></span></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>Group 3<br/><span class='stratn'>(N=63)</span></span></th>
#> <th class='firstrow lastrow'><span class='stratlabel'>Overall<br/><span class='stratn'>(N=200)</span></span></th>
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
#> <td>101 (57.9)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Median [Min, Max]</td>
#> <td>107 [1.00, 197]</td>
#> <td>99.5 [7.00, 185]</td>
#> <td>98.0 [3.00, 200]</td>
#> <td>101 [1.00, 200]</td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.6%)</td>
#> <td class='lastrow'>1 (0.5%)</td>
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
#> <td>0.543 (0.294)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Median [Min, Max]</td>
#> <td>0.509 [0.00693, 0.990]</td>
#> <td>0.600 [0.00114, 0.970]</td>
#> <td>0.609 [0.00865, 0.993]</td>
#> <td>0.588 [0.00114, 0.993]</td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.4%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (0.5%)</td>
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
#> <td>0.563 (0.497)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>Median [Min, Max]</td>
#> <td>1.00 [0, 1.00]</td>
#> <td>1.00 [0, 1.00]</td>
#> <td>1.00 [0, 1.00]</td>
#> <td>1.00 [0, 1.00]</td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.4%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (0.5%)</td>
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
#> <td>63 (31.5%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>2</td>
#> <td>21 (31.3%)</td>
#> <td>11 (15.7%)</td>
#> <td>8 (12.7%)</td>
#> <td>40 (20.0%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>3</td>
#> <td>14 (20.9%)</td>
#> <td>20 (28.6%)</td>
#> <td>14 (22.2%)</td>
#> <td>48 (24.0%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>4</td>
#> <td>18 (26.9%)</td>
#> <td>10 (14.3%)</td>
#> <td>20 (31.7%)</td>
#> <td>48 (24.0%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>1 (1.5%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (0.5%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel firstrow'><span class='varlabel'>binary_factor</span></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>0. No</td>
#> <td>26 (38.8%)</td>
#> <td>40 (57.1%)</td>
#> <td>27 (42.9%)</td>
#> <td>93 (46.5%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>1. Yes</td>
#> <td>41 (61.2%)</td>
#> <td>30 (42.9%)</td>
#> <td>35 (55.6%)</td>
#> <td>106 (53.0%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (1.6%)</td>
#> <td class='lastrow'>1 (0.5%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel firstrow'><span class='varlabel'>categorical</span></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> <td class='firstrow'></td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>1</td>
#> <td>18 (26.9%)</td>
#> <td>15 (21.4%)</td>
#> <td>14 (22.2%)</td>
#> <td>47 (23.5%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>2</td>
#> <td>13 (19.4%)</td>
#> <td>12 (17.1%)</td>
#> <td>17 (27.0%)</td>
#> <td>42 (21.0%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>3</td>
#> <td>22 (32.8%)</td>
#> <td>18 (25.7%)</td>
#> <td>15 (23.8%)</td>
#> <td>55 (27.5%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel'>4</td>
#> <td>13 (19.4%)</td>
#> <td>25 (35.7%)</td>
#> <td>17 (27.0%)</td>
#> <td>55 (27.5%)</td>
#> </tr>
#> <tr>
#> <td class='rowlabel lastrow'>Missing</td>
#> <td class='lastrow'>1 (1.5%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>0 (0%)</td>
#> <td class='lastrow'>1 (0.5%)</td>
#> </tr>
#> </tbody>
#> </table>
```
