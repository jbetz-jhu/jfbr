### table1_pvalue: Two-category X, Continuous Y ################################
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
              "0. No" = subset(jfbr_test, two_level_group == "Group 1")$continuous,
              "1. Yes" = subset(jfbr_test, two_level_group == "Group 2")$continuous,
              "overall" = jfbr_test$continuous
            ),
          variable = "two_level_group",
          digits = 3
        )
    )

    expect_no_condition(
      # Two Level Continuous: no overall
      object =
        two_level_no_overall <-
        table1_pvalue(
          x =
            list(
              "0. No" = subset(jfbr_test, two_level_group == "Group 1")$continuous,
              "1. Yes" = subset(jfbr_test, two_level_group == "Group 2")$continuous
            ),
          variable = "two_level_group",
          digits = 3,
        )
    )

    expect_equal(
      object = two_level_with_overall,
      expected = two_level_no_overall
    )
  }
)




### table1_pvalue: Multi-category X, Continuous Y ##############################
test_that(
  desc = "table1_pvalue works in isolation: Multi-category X, Continuous Y",
  code = {
    expect_no_condition(
      object =
        # Multi Level Continuous: with overall
        multi_level_with_overall <-
        table1_pvalue(
          x =
            list(
              "0. No" = subset(jfbr_test, two_level_group == "Group 1")$continuous,
              "1. Yes" = subset(jfbr_test, two_level_group == "Group 2")$continuous,
              "overall" = jfbr_test$continuous
            ),
          variable = "three_level_group",
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
              "0. No" = subset(jfbr_test, two_level_group == "Group 1")$continuous,
              "1. Yes" = subset(jfbr_test, two_level_group == "Group 2")$continuous
            ),
          variable = "three_level_group",
          digits = 3,
        )
    )

    expect_equal(
      object = multi_level_with_overall,
      expected = multi_level_no_overall
    )
  }
)




### table1_pvalue: Two category X, Multi-category Y ############################
test_that(
  desc = "table1_pvalue works in isolation: Two-level X, Multi-category Y",
  code = {
    expect_no_condition(
      object =
        # Two Level three_level_group: with overall
        two_level_with_overall <-
        table1_pvalue(
          x =
            list(
              "0. No" = subset(jfbr_test, two_level_group == "Group 1")$ordered,
              "1. Yes" = subset(jfbr_test, two_level_group == "Group 2")$ordered,
              "overall" = jfbr_test$continuous
            ),
          variable = "two_level_group",
          digits = 3,
        )
    )

    expect_no_condition(
      # Two Level three_level_group: no overall
      object =
        two_level_no_overall <-
        table1_pvalue(
          x =
            list(
              "0. No" = subset(jfbr_test, two_level_group == "Group 1")$ordered,
              "1. Yes" = subset(jfbr_test, two_level_group == "Group 2")$ordered
            ),
          variable = "two_level_group",
          digits = 3,
        )
    )

    expect_equal(
      object = two_level_with_overall,
      expected = two_level_no_overall
    )
  }
)




### table1_pvalue: Multi-category X, Multi-category Y ##########################
test_that(
  desc = "table1_pvalue works in isolation: Multi-category X, Multi-category Y",
  code = {
    expect_no_condition(
      object =
        # Multi Level three_level_group: with overall
        multi_level_with_overall <-
        table1_pvalue(
          x =
            list(
              "0. No" = subset(jfbr_test, two_level_group == "Group 1")$ordered,
              "1. Yes" = subset(jfbr_test, two_level_group == "Group 2")$ordered,
              "overall" = jfbr_test$continuous
            ),
          variable = "three_level_group",
          digits = 3,
        )
    )

    expect_no_condition(
      # Multi Level three_level_group: no overall
      object =
        multi_level_no_overall <-
        table1_pvalue(
          x =
            list(
              "0. No" = subset(jfbr_test, two_level_group == "Group 1")$ordered,
              "1. Yes" = subset(jfbr_test, two_level_group == "Group 2")$ordered
            ),
          variable = "three_level_group",
          digits = 3,
        )
    )

    expect_equal(
      object = multi_level_with_overall,
      expected = multi_level_no_overall
    )
  }
)


### table1_pvalue + table1() ###################################################
test_that(
  desc = "table1_pvalue works with table1::table1()",
  code = {
    # No grouping variable
    expect_error(
      object =
        table1::table1(
          x = ~ numbers + continuous + binary + ordered +
            binary_factor + categorical,
          data = jfbr_test,
          overall = FALSE,
          extra.col =
            list("p-value" = function(x = x, variable = variable)
              table1_pvalue(x = x, variable = variable))
        ),
      regexp = "Table has no columns"
    )

    expect_no_error(
      object =
        table1::table1(
          x = ~ numbers + continuous + binary + ordered +
            binary_factor + categorical | two_level_group,
          data = jfbr_test,
          extra.col =
            list("p-value" = function(x = x, variable = variable)
              table1_pvalue(x = x, variable = variable))
        )
    )

    expect_no_error(
      object =
        table1::table1(
          x = ~ numbers + continuous + binary + ordered +
            binary_factor + categorical | two_level_group,
          data = jfbr_test,
          extra.col =
            list("p-value" = function(x = x, variable = variable)
              table1_pvalue(
                x = x, variable = variable,
                test_numeric_2_levels = wilcox.test,
                test_numeric_more_than_2_levels = kruskal.test,
                test_categorical_2_levels = chisq.test,
                test_categorical_more_than_2_levels = chisq.test
              )
            )
        )
    )

    expect_no_error(
      object =
        table1::table1(
          x = ~ numbers + continuous + binary + ordered +
            binary_factor + categorical | three_level_group,
          data = jfbr_test,
          overall = FALSE,
          extra.col =
            list("p-value" = function(x = x, variable = variable)
              table1_pvalue(
                x = x, variable = variable,
                test_numeric_2_levels = wilcox.test,
                test_numeric_more_than_2_levels = kruskal.test,
                test_categorical_2_levels = chisq.test,
                test_categorical_more_than_2_levels = chisq.test
              )
            )
        )
    )
  }
)
