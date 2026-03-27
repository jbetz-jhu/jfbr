# Format proportions and percentages for presentation

This function is for calculating

## Usage

``` r
in_text_proportion(
  x,
  n,
  output = c("percentage", "proportion")[1],
  output_format = c("p", "xn", "xp", "xnp")[4],
  digits_proportion = 3,
  digits_percent = 1,
  ci_method = NULL,
  level = 0.95,
  ...
)
```

## Arguments

- x:

  a numeric scalar for the numerator

- n:

  a numeric scalar for the denominator

- output:

  a string specifying the type of output requested: either "percentage"
  or "proportion"

- output_format:

  a string specifying the formatting of the output, which may include
  the numerator, the denominator, and percentage/proportion

- digits_proportion:

  the digits of precision for proportions (see
  [`table1::round_pad`](https://rdrr.io/pkg/table1/man/signif_pad.html)).

- digits_percent:

  the digits of precision for percentages (see
  [`table1::round_pad`](https://rdrr.io/pkg/table1/man/signif_pad.html)).

- ci_method:

  a string containing the type of interval estimate to compute, if any.
  See
  [`?binom::binom.confint`](https://rdrr.io/pkg/binom/man/binom.confint.html).

- level:

  the confidence/credible interval coefficient

- ...:

  other arguments passed to
  [`binom::binom.confint`](https://rdrr.io/pkg/binom/man/binom.confint.html)

## Value

When a CI is computed, the result is a list, containing the output and
individual components: otherwise, the result is a string.

## Examples

``` r
# Calculating percentages
in_text_proportion(x = 2, n = 10, output_format = "p")
#> [1] "20.0%"
in_text_proportion(x = 0, n = 10, output_format = "xp")
#> [1] "0 (0%)"
in_text_proportion(x = 10, n = 10, output_format = "xnp")
#> [1] "10/10 (100%)"

in_text_proportion(x = 2, n = 10, output = "proportion", output_format = "p")
#> [1] "0.2"
in_text_proportion(x = 0, n = 10, output = "proportion", output_format = "xp")
#> [1] "0 (0)"
in_text_proportion(x = 10, n = 10, output = "proportion", output_format = "xnp")
#> [1] "10/10 (1)"

in_text_proportion(x = 1, n = 1e4, output_format = "xp", digits_percent = 2)
#> [1] "1 (0.01%)"
in_text_proportion(x = 1, n = 1e4, output_format = "xp", digits_percent = 2)
#> [1] "1 (0.01%)"

in_text_proportion(x = 0, n = 10, output_format = "p", ci_method = "bayes")
#> $x
#> [1] 0
#> 
#> $n
#> [1] 10
#> 
#> $output
#> [1] "0%"
#> 
#> $output_ci
#> [1] "0, 95% CI: 0.0, 17.1)"
#> 
#> $ci
#>   method x  n       mean lower     upper
#> 1  bayes 0 10 0.04545455     0 0.1707731
#> 
#> $ci_rounded
#> [1] "0.0"  "17.1"
#> 
#> $ci_string
#> [1] "(95% CI: 0.0, 17.1)"
#> 
in_text_proportion(x = 0, n = 10, output_format = "p", ci_method = "exact")
#> $x
#> [1] 0
#> 
#> $n
#> [1] 10
#> 
#> $output
#> [1] "0%"
#> 
#> $output_ci
#> [1] "0, 95% CI: 0.0, 30.8)"
#> 
#> $ci
#>   method x  n mean lower     upper
#> 1  exact 0 10    0     0 0.3084971
#> 
#> $ci_rounded
#> [1] "0.0"  "30.8"
#> 
#> $ci_string
#> [1] "(95% CI: 0.0, 30.8)"
#> 
```
