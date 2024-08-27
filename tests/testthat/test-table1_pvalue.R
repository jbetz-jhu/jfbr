test_that(
  desc = "table1_pvalue works in isolation: Two-level X, Continuous Y",
  code = {
    expect_no_condition(
      object =
        # Two Level Continuous: with overall
        two_level_with_overall <-
        table1_pvalue(
          x =
            list(
              "0. No" = subset(jfbr_test, binary_factor == "0. No")$continuous,
              "1. Yes" = subset(jfbr_test, binary_factor == "1. Yes")$continuous,
              "overall" = jfbr_test$continuous
            ),
          variable = "binary_factor",
          digits = 3,
        )
    )

    expect_no_condition(
      # Two Level Continuous: no overall
      object =
        two_level_no_overall <-
        table1_pvalue(
          x =
            list(
              "0. No" = subset(jfbr_test, binary_factor == "0. No")$continuous,
              "1. Yes" = subset(jfbr_test, binary_factor == "1. Yes")$continuous
            ),
          variable = "binary_factor",
          digits = 3,
        )
    )

    expect_equal(
      object = two_level_with_overall,
      expected = two_level_no_overall
    )
  }
)


test_that(
  desc = "table1_pvalue works in isolation: Multi-level X, Continuous Y",
  code = {
    expect_no_condition(
      object =
        # Multi Level Continuous: with overall
        multi_level_with_overall <-
        table1_pvalue(
          x =
            list(
              "0. No" = subset(jfbr_test, binary_factor == "0. No")$continuous,
              "1. Yes" = subset(jfbr_test, binary_factor == "1. Yes")$continuous,
              "overall" = jfbr_test$continuous
            ),
          variable = "categorical",
          digits = 3,
        )
    )

    expect_no_condition(
      # Multi Level Continuous: no overall
      object =
        multi_level_no_overall <-
        table1_pvalue(
          x =
            list(
              "0. No" = subset(jfbr_test, binary_factor == "0. No")$continuous,
              "1. Yes" = subset(jfbr_test, binary_factor == "1. Yes")$continuous
            ),
          variable = "categorical",
          digits = 3,
        )
    )

    expect_equal(
      object = multi_level_with_overall,
      expected = multi_level_no_overall
    )
  }
)






test_that(
  desc = "table1_pvalue works in isolation: Two-level X, Categorical Y",
  code = {
    expect_no_condition(
      object =
        # Two Level Categorical: with overall
        two_level_with_overall <-
        table1_pvalue(
          x =
            list(
              "0. No" = subset(jfbr_test, binary_factor == "0. No")$ordered,
              "1. Yes" = subset(jfbr_test, binary_factor == "1. Yes")$ordered,
              "overall" = jfbr_test$continuous
            ),
          variable = "binary_factor",
          digits = 3,
        )
    )

    expect_no_condition(
      # Two Level Categorical: no overall
      object =
        two_level_no_overall <-
        table1_pvalue(
          x =
            list(
              "0. No" = subset(jfbr_test, binary_factor == "0. No")$ordered,
              "1. Yes" = subset(jfbr_test, binary_factor == "1. Yes")$ordered
            ),
          variable = "binary_factor",
          digits = 3,
        )
    )

    expect_equal(
      object = two_level_with_overall,
      expected = two_level_no_overall
    )
  }
)


test_that(
  desc = "table1_pvalue works in isolation: Multi-level X, Categorical Y",
  code = {
    expect_no_condition(
      object =
        # Multi Level Categorical: with overall
        multi_level_with_overall <-
        table1_pvalue(
          x =
            list(
              "0. No" = subset(jfbr_test, binary_factor == "0. No")$ordered,
              "1. Yes" = subset(jfbr_test, binary_factor == "1. Yes")$ordered,
              "overall" = jfbr_test$continuous
            ),
          variable = "categorical",
          digits = 3,
        )
    )

    expect_no_condition(
      # Multi Level Categorical: no overall
      object =
        multi_level_no_overall <-
        table1_pvalue(
          x =
            list(
              "0. No" = subset(jfbr_test, binary_factor == "0. No")$ordered,
              "1. Yes" = subset(jfbr_test, binary_factor == "1. Yes")$ordered
            ),
          variable = "categorical",
          digits = 3,
        )
    )

    expect_equal(
      object = multi_level_with_overall,
      expected = multi_level_no_overall
    )
  }
)

test_that(
  desc = "table1_pvalue works with table1::table1()",
  code = {
    expect_no_error(
      object =
        table1::table1(
          x = ~ numbers + continuous + binary + ordered | categorical,
          data = jfbr_test,
          extra.col =
            list("p-value" = table1_pvalue)
        )
    )

    expect_no_error(
      object =
        table1::table1(
          x = ~ numbers + continuous + binary + ordered | categorical,
          data = jfbr_test,
          overall = FALSE,
          extra.col =
            list("p-value" = table1_pvalue)
        )
    )
  }
)
