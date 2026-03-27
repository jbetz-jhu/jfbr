#' Computing p-values from Bootstrap Confidence Intervals
#'
#' This function computes \emph{p}-values by finding the smallest
#' \eqn{100(1 - \alpha)\%} bootstrap confidence interval that does not contain
#' the null value of the estimand.
#'
#' The \emph{p}-value is the smallest value of \eqn{\alpha} at which \eqn{H_{0}}
#' is rejected (i.e. the confidence interval does not contain the null value of
#' the estimand). This function takes a object of class \code{"boot"} and
#' iteratively finds the \emph{p}-value through a search algorithm.
#'
#' A \code{warning} is provided when the approximation may be incorrect, or if
#' the number of bootstrap replicates may not provide sufficient precision.
#'
#' @param boot_object The result of a call to [boot::boot]
#' @param ci_method A \code{character} scalar containing the method used to
#' compute bootstrap confidence intervals
#' @param index A \code{numeric} scalar indicating which element of the result
#' to use in computing a p-value.
#' @param null_value A \code{numeric} scalar indicating the null value of the
#' estimand of interest
#' @param alternative A \code{character} scalar indicating the type of
#' alternative hypothesis being tested: either \code{"two-sided"},
#' \code{"greater"}, or \code{"less"}.
#' @param var_adjust A \code{numeric} scalar for adjusting the confidence
#' interval width: defaults to 1.
#' @param alpha_max A \code{numeric} scalar
#' @param alpha_min A \code{numeric} scalar
#' @param tolerance A \code{numeric} scalar indicating the tolerance for
#' assessing convergence
#' @param max_evaluations A \code{numeric} scalar indicating the maximum number
#' of iterations to perform
#' @param verbose A \code{logical} scalar, indicating whether to only return
#' the \emph{p}-value (\code{FALSE}: default), or return the results of each
#' iteration (\code{TRUE})
#'
#' @returns If \code{verbose == FALSE} (default), the \emph{p}-value is returned
#' as a numeric scalar. Otherwise, a \code{list} is returned.
#' @export
#'
#' @examples
#' \dontrun{
#' set.seed(12345)
#' x <- rnorm(n = 50)
#'
#' boot_mean <-
#'   boot::boot(
#'     data = x,
#'     statistic = function(data, indices){mean(data[indices])},
#'     R = 10000
#'   )
#'
#' t.test(x = x, alternative = "two.sided")$p.value
#' boot_p_value(boot_object = boot_mean, alternative = "two-sided")
#'
#' t.test(x = x, alternative = "less")$p.value
#' boot_p_value(boot_object = boot_mean, alternative = "less")
#'
#' t.test(x = x, alternative = "greater")$p.value
#' boot_p_value(boot_object = boot_mean, alternative = "greater")
#'
#' t.test(x = x, mu = 0.5, alternative = "less")$p.value
#' boot_p_value(boot_object = boot_mean, null_value = 0.5, alternative = "less")
#'
#' t.test(x = x, mu = 0.5, alternative = "greater")$p.value
#' boot_p_value(boot_object = boot_mean, null_value = 0.5, alternative = "greater")
#'
#' # Warnings should trigger when approximation may be inaccurate.
#' t.test(x = x, mu = -1, alternative = "less")$p.value
#' boot_p_value(boot_object = boot_mean, null_value = -1, alternative = "less")
#'
#' t.test(x = x, mu = -1, alternative = "greater")$p.value
#' boot_p_value(boot_object = boot_mean, null_value = -1, alternative = "greater")
#' }
#'

boot_p_value <-
  function(
    boot_object,
    ci_method = "bca",
    index = 1,
    null_value = 0,
    alternative = c("two-sided", "greater", "less")[1],
    var_adjust = 1,
    alpha_max = 1,
    alpha_min = 10^-5,
    tolerance = 0.0001,
    max_evaluations = 30,
    asymptotic_extreme_z = TRUE,
    verbose = FALSE
  ){
    if(!inherits(x = boot_object, what = "boot")){
      stop("`boot_object` should inherit class \"boot\". See ?boot::boot")
    }

    # Need to do MC testing to finalize these threshold
    boot_rep_threshold <- 2500
    z_stat_threshold <- 3

    if(boot_object$R < boot_rep_threshold){
      warning(
        "The accuracy of this approximation depends on having a large number ",
        "(e.g. ", boot_rep_threshold, " or more) bootstrap replicates. See ",
        "?boot::boot"
      )
    }

    alternative <- tolower(substr(x = alternative[1], start = 1, stop = 3))
    if(!(alternative %in% c("two", "gre", "les"))){
      stop("`alternative` should be one of \"two-sided\", \"greater\", or ",
           "\"less\".")
    } else if(alternative == "two"){
      alpha_scale <- 1
      test_sides <- 2
    } else if(alternative %in% c("gre", "les")){
      alpha_scale <- 2
      test_sides <- 1
    }

    z_stat <-
      with(data = boot_object, expr = (t0[index] - null_value)/sd(t[, index]))
    if(abs(z_stat) > z_stat_threshold){
      warning(
        "Estimate is ", round(z_stat, digits = 2), " standard errors from the ",
        "null value: bootstrap approximation may not be accurate when the ",
        "absolute value of test statistic is greater than |", z_stat_threshold,
        "|."
      )
      extreme_z <- TRUE
    } else {
      extreme_z <- FALSE
    }

    if(asymptotic_extreme_z & extreme_z){
      wald_p_value <-
        2^(test_sides == 2)*
        pnorm(
          q = ifelse(test_sides == 2, yes = -abs(z_stat), no = z_stat),
          lower.tail = alternative %in% c("les", "two")
        )
      message("Wald approximation used for p-value.")

      return(wald_p_value)
    } else {

      if(
        !all(
          length(ci_method) == 1,
          class(ci_method) == "character"
        )
      ){
        stop(
          "`ci_method` must have class \"character\" with length 1. ",
          "Currently, length(ci_method) = ", length(ci_method),
          " and class(ci_method) = \"", class(ci_method), "\""
        )
      } else if(!ci_method %in% c("norm", "basic", "perc", "bca")){
        stop("`ci_method` must be one of \"basic\", \"perc\", or ",
             "\"bca\".")
      }

      ci_type <-
        switch(
          EXPR = ci_method,
          "norm" = "normal",
          "basic" = "basic",
          "perc" = "percent",
          "bca" = "bca"
        )



      converged <- FALSE
      continue <- TRUE
      j <- n_rejected <- n_fail_to_reject <- 0
      all_ci_results <-
        data.frame(
          alpha = rep(NA, max_evaluations),
          confidence = NA,
          lcl = NA,
          ucl = NA,
          rejected = NA
        )
      current_min <- alpha_min
      current_max <- alpha_max
      current_alpha <- mean(c(alpha_max, alpha_min))

      while(continue) {
        j <- j + 1

        all_ci_results$alpha[j] <- current_alpha
        all_ci_results$confidence[j] <- 1 - current_alpha

        ci_result <-
          boot::boot.ci(
            boot.out = boot_object,
            conf = 1 - current_alpha*alpha_scale,
            type = ci_method,
            index = index
          )

        ci_method_name <-
          setdiff(
            x = names(ci_result),
            y = c("R", "t0", "call")
          )

        ci_unadjusted <-
          utils::tail(x = ci_result[[ci_type]][1,], n = 2)

        if(var_adjust == 1) {
          ci_adjusted <- ci_unadjusted
        } else {
          ci_adjusted <-
            boot_object$t0[index] +
            sqrt(var_adjust)*(ci_unadjusted - boot_object$t0[index])
        }

        if(alternative == "les"){
          ci_adjusted <- c(-Inf, ci_adjusted[2])
        } else if(alternative == "gre"){
          ci_adjusted <- c(ci_adjusted[1], Inf)
        }

        all_ci_results[j, c("lcl", "ucl")] <- ci_adjusted

        rejected_greater <- (ci_adjusted[1] > null_value)
        rejected_less <- (ci_adjusted[2] < null_value)

        if(alternative == "two"){
          rejected <- rejected_less | rejected_greater
        } else if(alternative == "les"){
          rejected <- rejected_less
        } else if(alternative == "gre"){
          rejected <- rejected_greater
        }

        all_ci_results$rejected[j] <- rejected

        if(rejected) {
          # Decrease Alpha
          n_rejected <- n_rejected + 1
          current_max <- min(c(current_alpha, current_max))
          current_alpha <-
            current_alpha - c(current_alpha - current_min)/2
        } else {
          # Increase Alpha
          n_fail_to_reject <- n_fail_to_reject + 1
          current_min <- max(c(current_alpha, current_min))
          current_alpha <-
            current_alpha + c(current_max - current_alpha)/2
        }

        # Evaluate convergence
        if(j > 1){
          diff_alpha <- abs(diff(all_ci_results$alpha[c(j - 1, j)]))

          if(n_fail_to_reject > 4 & n_rejected > 4 & diff_alpha <= tolerance) {
            converged <- TRUE
            continue <- FALSE
            boundary <- FALSE
          }

          if(diff_alpha <= tolerance &
             ((alpha_max - current_alpha) < tolerance |
              (current_alpha - alpha_min) < tolerance)
          ){
            converged <- TRUE
            continue <- FALSE
            boundary <- TRUE
          }

        }
        if(j >= max_evaluations){
          continue <- FALSE
          warning("Iteration limit reached without convergence.")
        }
      }

      if(boundary){
        boot_p_value <- current_alpha
      } else {
        boot_p_value <- min(subset(all_ci_results, rejected)$alpha)
      }



      if(verbose){
        return(
          list(
            boot_p_value = boot_p_value,
            converged = converged,
            boot_object = boot_object,
            ci_method = ci_method,
            index = index,
            var_adjust = var_adjust,
            alpha_max = alpha_max,
            alpha_min = alpha_min,
            tolerance = tolerance,
            max_evaluations = 40,
            n_evaluations = j,
            all_ci_results = all_ci_results
          )
        )
      } else {
        return(boot_p_value)
      }
    }
  }
