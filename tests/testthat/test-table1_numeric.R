test_that(
  desc = "table1_numeric works in isolation",
  code = {
    expect_no_condition(
      object =
        table1_numeric(
          x = 0:100,
          mean_sd = TRUE,
          median_iqr = TRUE,
          range = TRUE,
          quantiles = c(0.05, 0.95),
          quantile_type = 4
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
          x = ~ continuous + numbers | two_level_group,
          data = jfbr_test,
          render.continuous = table1_numeric
        )
    )

    expect_no_condition(
      object =
        table1(
          x = ~ continuous + numbers | three_level_group,
          data = jfbr_test,
          render.continuous =
            function(x) table1_numeric(x = x, quantiles = c(0.05, 0.95))
        )
    )
  }
)
