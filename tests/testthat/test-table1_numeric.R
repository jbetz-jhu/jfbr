test_that(
  desc = "table1_numeric error handling works",
  code = {
    expect_error(
      object =
        table1_numeric(
          x = 0:100,
          mean_sd = TRUE,
          median_iqr = TRUE,
          range = TRUE,
          quantiles = c(-2, 3),
          na.rm = FALSE,
          quantile_type = 4,
          digits = 2
        ),
      regexp = "Quantiles must be numeric values in range"
    )

    expect_error(
      object =
        table1_numeric(
          x = 0:100,
          mean_sd = TRUE,
          median_iqr = TRUE,
          range = TRUE,
          quantiles = c(0.05, NA, 0.95),
          na.rm = FALSE,
          quantile_type = 4,
          digits = 2
        ),
      regexp = "Quantiles must be numeric values in range"
    )
  }
)

test_that(
  desc = "table1_numeric works in isolation",
  code = {
    expect_error(
      object = table1_numeric(x = jfbr_test$binary_factor),
      regexp = "x must be numeric"
    )

    expect_no_condition(
      object =
        table1_numeric(
          x = 0:100,
          mean_sd = TRUE,
          median_iqr = TRUE,
          range = TRUE,
          quantiles = c(0.05, 0.95),
          na.rm = FALSE,
          quantile_type = 4,
          digits = 2
        )
    )
  }
)

test_that(
  desc = "table1_numeric works with table1::table1()",
  code = {
    expect_no_condition(
      object =
        table1(
          x = ~ continuous + numbers | binary_factor,
          data = jfbr_test,
          render.continuous = table1_numeric
        )
    )

    expect_no_condition(
      object =
        table1(
          x = ~ continuous + numbers | binary_factor,
          data = jfbr_test,
          render.continuous =
            function(x) table1_numeric(x = x, quantiles = c(0.05, 0.95))
        )
    )

    expect_error(
      object =
        table1(
          x = ~ continuous + numbers | binary_factor,
          data = jfbr_test,
          render.continuous =
            function(x) table1_numeric(
              x = x, mean_sd = FALSE, median_iqr = FALSE, range = FALSE
            )
        ),
      regexp = "At least one summary must be computed."
    )
  }
)
