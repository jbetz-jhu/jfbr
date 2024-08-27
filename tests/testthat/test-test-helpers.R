test_that(
  desc = "Test Data Found",
  code = {
    expect_equal(
      object = exists(x = "jfbr_test"),
      expected = TRUE
    )

    expect_contains(
      object = unlist(sapply(X = jfbr_test, FUN = class)),
      expected = c("integer", "numeric", "factor", "ordered")
    )
  }
)
