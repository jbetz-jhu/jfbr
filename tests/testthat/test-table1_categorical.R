test_that(
  desc = "table1_categorical works with table1::table1()",
  code = {
    expect_no_condition(
      object =
        table1(
          x = ~ ordered + binary_factor + categorical | two_level_group,
          data = jfbr_test,
          render.categorical = table1_categorical
        )
    )
  }
)
