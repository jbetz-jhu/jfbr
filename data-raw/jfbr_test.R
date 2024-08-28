set.seed(12345)

n_obs <- 200

jfbr_test <-
  data.frame(
    numbers = 1:n_obs,
    continuous = runif(n = n_obs),
    binary = rbinom(n = n_obs, size = 1, prob = 0.5),
    ordered = ordered(sample(x = 1:4, size = n_obs, replace = TRUE)),
    binary_factor =
      factor(
        x = rbinom(n = n_obs, size = 1, prob = 0.5),
        levels = 0:1,
        labels = c("0. No", "1. Yes")
      ),
    categorical = factor(sample(x = 1:4, size = n_obs, replace = TRUE)),
    two_level_group =
      factor(
        x = rbinom(n = n_obs, size = 1, prob = 0.5),
        levels = 0:1,
        labels = c("Group 1", "Group 2")
      ),
    three_level_group =
      factor(
        x = sample(x = 1:3, size = n_obs, replace = TRUE),
        levels = 1:3,
        labels = c("Group 1", "Group 2", "Group 3")
      )
  )

# Add missing value to each column
missing_cols <-
  c("numbers", "continuous", "binary", "ordered", "binary_factor",
    "categorical")
jfbr_test[
  cbind(sample(x = 1:n_obs, size = length(missing_cols), replace = TRUE),
        which(names(jfbr_test) %in% missing_cols))
] <- NA

usethis::use_data(jfbr_test, overwrite = TRUE)
