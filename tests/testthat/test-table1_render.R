### table1_pvalue + table1() ###################################################
test_that(
  desc = "table1_render works with table1::table1()",
  code = {
    expect_no_error(
      object =
        table1::table1(
          x = ~ numbers + continuous + binary + ordered +
            binary_factor + categorical | three_level_group,
          data = jfbr_test,
          render = table1_render,
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
          render =
            function(...) table1_render(
              numeric = render.continuous.default,
              categorical = render.categorical.default,
              ...
            ),
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
