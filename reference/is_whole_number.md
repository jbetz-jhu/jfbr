# Determine whether numeric elements are whole numbers

Note: this is shamelessly adapted from ?is.integer

## Usage

``` r
is_whole_number(x, tol = .Machine$double.eps^0.5)
```

## Arguments

- x:

  A `numeric` `vector` or `matrix`

- tol:

  The precision threshold used to make the determination of a whole
  number.

## Value

A `logical` vector or matrix, depending on the class of `x`.

## Examples

``` r
is_whole_number(0)
#> [1] TRUE
is_whole_number(0.1)
#> [1] FALSE
is_whole_number(0.1^7)
#> [1] FALSE
is_whole_number(0.1^24)
#> [1] TRUE
is_whole_number(c(0.1^7, 0.1^24))
#> [1] FALSE  TRUE
```
