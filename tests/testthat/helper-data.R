set.seed(12345)

n_obs <- 1000

jfbr_test <-
  data.frame(
    numbers = 1:n_obs,
    continuous = runif(n = n_obs),
    binary = rbinom(n = n_obs, size = 1, prob = 0.5),
    binary_factor =
      factor(
        x = rbinom(n = n_obs, size = 1, prob = 0.5),
        levels = 0:1,
        labels = c("0. No", "1. Yes")
      ),
    categorical = factor(sample(x = 1:4, size = n_obs, replace = TRUE)),
    ordered = ordered(sample(x = 1:4, size = n_obs, replace = TRUE))
  )
