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
    categorical = factor(sample(x = 1:4, size = n_obs, replace = TRUE))
  )

# Add missing value to each column
missing_cols <- c("numbers", "continuous", "binary", "ordered")
jfbr_test[
  cbind(sample(x = 1:n_obs, size = length(missing_cols), replace = TRUE),
    which(names(jfbr_test) %in% missing_cols))
] <- NA
