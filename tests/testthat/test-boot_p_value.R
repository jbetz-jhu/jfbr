test_that(
  desc = "Error Handling Works",
  code = {
    expect_error(
      object =
        boot_p_value(
          boot_object = mtcars,
          ci_method = "bca",
          index = 1,
          null_value = 0,
          alternative = c("two-sided", "greater", "less")[1],
          var_adjust = 1,
          alpha_max = 1,
          alpha_min = 10^-5,
          tolerance = 0.0001,
          max_evaluations = 30,
          verbose = FALSE
        ),
      regexp = "`boot_object` should inherit class \\\"boot\\\""
    )

    set.seed(12345)
    x <- rnorm(n = 50)

    boot_mean <-
      boot::boot(
        data = x,
        statistic = function(data, indices){mean(data[indices])},
        R = 10000
      )

    expect_error(
      object =
        boot_p_value(
          boot_object = boot_mean,
          ci_method = "bbca",
          index = 1,
          null_value = 0,
          alternative = c("two-sided", "greater", "less")[1],
          var_adjust = 1,
          alpha_max = 1,
          alpha_min = 10^-5,
          tolerance = 0.0001,
          max_evaluations = 30,
          verbose = FALSE
        ),
      regexp = "`ci_method` must be one of"
    )

    expect_error(
      object =
        boot_p_value(
          boot_object = boot_mean,
          ci_method = c("bca", "perc"),
          index = 1,
          null_value = 0,
          alternative = c("two-sided", "greater", "less")[1],
          var_adjust = 1,
          alpha_max = 1,
          alpha_min = 10^-5,
          tolerance = 0.0001,
          max_evaluations = 30,
          verbose = FALSE
        ),
      regexp = "`ci_method` must have class "
    )

    expect_error(
      object =
        boot_p_value(
          boot_object = boot_mean,
          ci_method = "bca",
          index = 1,
          null_value = 0,
          alternative = "ttwo-sided",
          var_adjust = 1,
          alpha_max = 1,
          alpha_min = 10^-5,
          tolerance = 0.0001,
          max_evaluations = 30,
          verbose = FALSE
        ),
      regexp = "`alternative` should be"
    )
  }
)


test_that(
  desc = "Works with Valid Input",
  code = {
    set.seed(12345)
    x <- rnorm(n = 50)

    boot_mean <-
      boot::boot(
        data = x,
        statistic = function(data, indices){mean(data[indices])},
        R = 10000
      )

    ### H_{0}: \mu = \mu_{0} vs. H_{1}: \mu \neq \mu_{0}
    p_t_two_sided <- t.test(x = x, alternative = "two.sided")$p.value

    p_boot_two_sided <-
      expect_no_condition(
        boot_p_value(boot_object = boot_mean, alternative = "two-sided")
      )

    expect_lte(
      object = p_t_two_sided - p_boot_two_sided,
      expected = 0.05
    )


    ### H_{0}: \mu \ge \mu_{0} vs. H_{1}: \mu < \mu_{0}
    p_t_less <- t.test(x = x, alternative = "less")$p.value

    p_boot_less <-
      expect_no_condition(
        boot_p_value(boot_object = boot_mean, alternative = "less")
      )

    expect_lte(
      object = p_t_less - p_boot_less,
      expected = 0.05
    )


    ### H_{0}: \mu \le \mu_{0} vs. H_{1}: \mu > \mu_{0}
    p_t_greater <- t.test(x = x, alternative = "greater")$p.value

    p_boot_greater <-
      expect_no_condition(
        boot_p_value(boot_object = boot_mean, alternative = "greater")
      )

    expect_lte(
      object = p_t_greater - p_boot_greater,
      expected = 0.05
    )

    ### Test Null Value ###
    p_t_two_sided <- t.test(x = x, mu = 0.25, alternative = "two.sided")$p.value

    p_boot_two_sided <-
      expect_no_condition(
        boot_p_value(boot_object = boot_mean, null_value = 0.25,
                     alternative = "two-sided")
      )

    expect_lte(
      object = p_t_two_sided - p_boot_two_sided,
      expected = 0.05
    )

    p_t_less <- t.test(x = x, alternative = "less", mu = 0.25)$p.value

    p_boot_less <-
      expect_no_condition(
        boot_p_value(boot_object = boot_mean, null_value = 0.25,
                     alternative = "less")
      )

    expect_lte(
      object = p_t_less - p_boot_less,
      expected = 0.05
    )

    p_t_greater <- t.test(x = x, alternative = "greater", mu = -0.25)$p.value

    p_boot_greater <-
      expect_no_condition(
        boot_p_value(boot_object = boot_mean, null_value = -0.25,
                     alternative = "greater")
      )

    expect_lte(
      object = p_t_greater - p_boot_greater,
      expected = 0.05
    )


    ### Test each type of bootstrap CI
    expect_no_condition(
      object =
        boot_p_value(
          boot_object = boot_mean,
          alternative = "two-sided",
          ci_method = "norm"
        )
    )

    expect_no_condition(
      object =
        boot_p_value(
          boot_object = boot_mean,
          alternative = "two-sided",
          ci_method = "perc"
        )
    )

    expect_no_condition(
      object =
        boot_p_value(
          boot_object = boot_mean,
          alternative = "two-sided",
          ci_method = "basic"
        )
    )

    ### Test Extreme Z Cases ###
    expect_warning(
      object =
        boot_p_value(
          boot_object = boot_mean,
          null_value = 5,
          alternative = "less",
          ci_method = "perc"
        )
    )

    expect_warning(
      object =
        boot_p_value(
          boot_object = boot_mean,
          null_value = -5,
          alternative = "greater",
          ci_method = "perc"
        )
    )
  }
)
