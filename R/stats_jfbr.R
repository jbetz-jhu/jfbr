#' Compute some basic descriptive statistics.
#'
#' A slight modification of [table1::stats.default()] to allow for custom
#' quantiles and produce the percentage of non-missing values. For more
#' information, see \code{?table1::stats.default}.
#'
#' @param x A vector of \code{numeric}, \code{factor}, \code{character}, or
#' \code{logical} values.
#' @param custom_quantiles A vector of \code{numeric} values in (0, 1) of
#' quantiles to compute
#' @param quantile_type An integer from 1 to 9, passed as the type argument to
#' function [stats::quantile()]
#' @param ... Further arguments (ignored).
#'
#' @return A list of statistics. See \code{?table1::stats.default}.
#' @export
#'
#' @examples
#' stats_jfbr(x = jfbr_test$continuous)
#' stats_jfbr(x = jfbr_test$continuous, custom_quantiles = c(0.42, 0.57))

stats_jfbr <-
  function(
    x,
    custom_quantiles = NULL,
    quantile_type = 7,
    ...
  ) {
    if(is.logical(x)) {
      x <- factor(
        x = 1 - x,
        levels = c(0, 1),
        labels = c("Yes", "No")
      )
    }

    if (is.factor(x) || is.character(x)) {
      y <- table(x, useNA = "no")
      nn <- names(y)
      nn[is.na(nn)] <- "Missing"
      names(y) <- nn
      lapply(
        X = y,
        FUN = function(z)
          list(
            FREQ = z,
            PCT = 100 * z/length(x),
            PCTnoNA = 100 * z/sum(y),
            NMISS = sum(is.na(x)))
      )
    } else if (is.numeric(x) && sum(!is.na(x)) == 0) {
      list(
        N = sum(!is.na(x)), NMISS = sum(is.na(x)), SUM = NA,
        MEAN = NA, SD = NA, CV = NA, GMEAN = NA, GSD = NA,
        GCV = NA, MEDIAN = NA, MIN = NA, MAX = NA, q01 = NA,
        q025 = NA, q05 = NA, q10 = NA, q25 = NA, q50 = NA,
        q75 = NA, q90 = NA, q95 = NA, q975 = NA, q99 = NA,
        Q1 = NA, Q2 = NA, Q3 = NA, IQR = NA, T1 = NA, T2 = NA
      )
    } else if (is.numeric(x)){
      q <-
        quantile(
          x = x,
          probs = c(0.01, 0.025, 0.05, 0.1, 0.25, 1/3, 0.5, 2/3, 0.75, 0.9,
                    0.95, 0.975, 0.99),
          na.rm = TRUE,
          type = quantile_type
        )

      if(!is.null(custom_quantiles)){
        cq <-
          quantile(
            x = x,
            probs = custom_quantiles,
            na.rm = TRUE,
            type = quantile_type
          )
      } else {
        cq <- NULL
      }

      list(
        N = sum(!is.na(x)),
        NMISS = sum(is.na(x)),
        PCTNMISS = 100*mean(!is.na(x)),
        SUM = sum(x, na.rm = TRUE),
        MEAN = mean(x, na.rm = TRUE),
        SD = sd(x, na.rm = TRUE),
        MEDIAN = median(x, na.rm = TRUE),
        MIN = min(x, na.rm = TRUE),
        MAX = max(x, na.rm = TRUE),
        q01 = q["1%"],
        q02.5 = q["2.5%"],
        q25 = q["25%"],
        q50 = q["50%"],
        q75 = q["75%"], q90 = q["90%"],
        q95 = q["95%"],
        q97.5 = q["97.5%"],
        q99 = q["99%"],
        Q1 = q["25%"],
        Q2 = q["50%"],
        Q3 = q["75%"],
        IQR = q["75%"] - q["25%"],
        T1 = q["33.33333%"],
        T2 = q["66.66667%"],
        CQ = cq
      )
    } else {
      stop(paste("Unrecognized variable type:", class(x)))
    }
  }

