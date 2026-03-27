# Computing p-values from Bootstrap Confidence Intervals

This function computes *p*-values by finding the smallest \\100(1 -
\alpha)\\\\ bootstrap confidence interval that does not contain the null
value of the estimand.

## Usage

``` r
boot_p_value(
  boot_object,
  ci_method = "bca",
  index = 1,
  null_value = 0,
  alternative = c("two-sided", "greater", "less")[1],
  var_adjust = 1,
  alpha_max = 1,
  alpha_min = 10^-5,
  tolerance = 1e-04,
  max_evaluations = 30,
  verbose = FALSE
)
```

## Arguments

- boot_object:

  The result of a call to
  [boot::boot](https://rdrr.io/pkg/boot/man/boot.html)

- ci_method:

  A `character` scalar containing the method used to compute bootstrap
  confidence intervals

- index:

  A `numeric` scalar indicating which element of the result to use in
  computing a p-value.

- null_value:

  A `numeric` scalar indicating the null value of the estimand of
  interest

- alternative:

  A `character` scalar indicating the type of alternative hypothesis
  being tested: either `"two-sided"`, `"greater"`, or `"less"`.

- var_adjust:

  A `numeric` scalar for adjusting the confidence interval width:
  defaults to 1.

- alpha_max:

  A `numeric` scalar

- alpha_min:

  A `numeric` scalar

- tolerance:

  A `numeric` scalar indicating the tolerance for assessing convergence

- max_evaluations:

  A `numeric` scalar indicating the maximum number of iterations to
  perform

- verbose:

  A `logical` scalar, indicating whether to only return the *p*-value
  (`FALSE`: default), or return the results of each iteration (`TRUE`)

## Value

If `verbose == FALSE` (default), the *p*-value is returned as a numeric
scalar. Otherwise, a `list` is returned.

## Details

The *p*-value is the smallest value of \\\alpha\\ at which \\H\_{0}\\ is
rejected (i.e. the confidence interval does not contain the null value
of the estimand). This function takes a object of class `"boot"` and
iteratively finds the *p*-value through a search algorithm.

A `warning` is provided when the approximation may be incorrect, or if
the number of bootstrap replicates may not provide sufficient precision.

## Examples

``` r
if (FALSE) { # \dontrun{
set.seed(12345)
x <- rnorm(n = 50)

boot_mean <-
  boot::boot(
    data = x,
    statistic = function(data, indices){mean(data[indices])},
    R = 10000
  )

t.test(x = x, alternative = "two.sided")$p.value
boot_p_value(boot_object = boot_mean, alternative = "two-sided")

t.test(x = x, alternative = "less")$p.value
boot_p_value(boot_object = boot_mean, alternative = "less")

t.test(x = x, alternative = "greater")$p.value
boot_p_value(boot_object = boot_mean, alternative = "greater")

t.test(x = x, mu = 0.5, alternative = "less")$p.value
boot_p_value(boot_object = boot_mean, null_value = 0.5, alternative = "less")

t.test(x = x, mu = 0.5, alternative = "greater")$p.value
boot_p_value(boot_object = boot_mean, null_value = 0.5, alternative = "greater")

# Warnings should trigger when approximation may be inaccurate.
t.test(x = x, mu = -1, alternative = "less")$p.value
boot_p_value(boot_object = boot_mean, null_value = -1, alternative = "less")

t.test(x = x, mu = -1, alternative = "greater")$p.value
boot_p_value(boot_object = boot_mean, null_value = -1, alternative = "greater")
} # }
```
