test_that(
  desc = "Error handling works appropriately",
  code = {
    expect_error(
      object = in_text_proportion(x = c(0, 1), n = 1, output_format = "p"),
      regexp = "Length of x"
    )

    expect_error(
      object = in_text_proportion(x = 2, n = 1, output_format = "p"),
      regexp = "Numerator \\(\\d{1,}) is greater than denominator"
    )

    expect_error(
      object = in_text_proportion(x = -1, n = 1, output_format = "p"),
      regexp = "Numerator (.*) is negative"
    )

    expect_error(
      object = in_text_proportion(x = 0, n = 0, output_format = "p"),
      regexp = "Denominator (.*) is less than 1"
    )

    expect_error(
      object = in_text_proportion(x = 0.1, n = 1, output_format = "p"),
      regexp = "must be whole numbers"
    )

    expect_error(
      object = in_text_proportion(x = 1, n = 1.1, output_format = "p"),
      regexp = "must be whole numbers"
    )

    expect_error(
      object =
        in_text_proportion(
          x = 1,
          n = 2,
          output = "something",
          output_format = "p"
        ),
      regexp = "Output type must be one of"
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
        in_text_proportion(x = 0, n = 10, output_format = "p", ci_method = "exact")
    )
  })
