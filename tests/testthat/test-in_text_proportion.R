test_that(
  desc = "Error handling works appropriately",
  code = {
    expect_error(
      object = in_text_proportion(x = 2, n = 1, output_format = "p"),
      regexp = "all\\(x <= n\\) must be TRUE"
    )

    expect_error(
      object = in_text_proportion(x = -1, n = 1, output_format = "p"),
      regexp = "Element \\d{1,} is not >= 0"
    )

    expect_error(
      object = in_text_proportion(x = 0, n = 0, output_format = "p"),
      regexp = "Element \\d{1,} is not >= 1"
    )

    expect_error(
      object = in_text_proportion(x = 0.1, n = 1, output_format = "p"),
      regexp = "not close to an integer"
    )

    expect_error(
      object = in_text_proportion(x = 1, n = 1.1, output_format = "p"),
      regexp = "not close to an integer"
    )

    expect_error(
      object =
        in_text_proportion(
          x = 1,
          n = 2,
          output = "something",
          output_format = "p"
        ),
      regexp = "'percentage','percent','proportion','probability'"
    )
  }
)

test_that(
  desc = "No errors with test input",
  code = {

    expect_no_condition(
      object = in_text_proportion(x = 2, n = 10, output_format = "p")
    )

    expect_no_condition(
      object = in_text_proportion(x = 0, n = 10, output_format = "xp")
    )
    expect_no_condition(
      object = in_text_proportion(x = 10, n = 10, output_format = "xnp")
    )

    expect_no_condition(
      object =
        in_text_proportion(x = 2, n = 10, output = "proportion", output_format = "p")
    )

    expect_no_condition(
      object =
        in_text_proportion(x = 0, n = 10, output = "proportion", output_format = "xp")
    )

    expect_no_condition(
      object =
        in_text_proportion(x = 10, n = 10, output = "proportion", output_format = "xnp")
    )

    expect_no_condition(
      object =
        in_text_proportion(x = 1, n = 1e4, output_format = "xp", digits_percent = 2)
    )

    expect_no_condition(
      object =
        in_text_proportion(x = 1, n = 1e4, output_format = "xp", digits_percent = 2)
    )

    expect_no_condition(
      object =
        in_text_proportion(x = 0, n = 10, output_format = "p", ci_method = "bayes")
    )

    expect_no_condition(
      object =
        in_text_proportion(
          x = c(1, 2),
          n = 10,
          output_format = "p",
          ci_method = "exact"
        )
    )
  })
