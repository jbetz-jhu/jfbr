#' Apply rounding to basic descriptive statistics.
#'
#' This is a slight modification of [table1::stats.apply.rounding]. For more
#' information
#'
#' @param x A list, such as that returned by \code{stats.default}.
#' @param digits An integer specifying the number of significant digits to keep.
#' @param digits.pct An integer specifying the number of digits after the
#' decimal place for percentages.
#' @param round.median.min.max Should rounding applied to median, min and max?
#' @param round.integers should rounding be limited to digits to the right of
#' the decimal point?
#' @param round5up Should numbers with 5 as the last digit always be rounded up?
#' The standard R approach is "go to the even digit" (IEC 60559 standard,
#' see \code{round}), while some other software (e.g. SAS, Excel) always round
#' up.
#' @param rounding.fn The function to use to do the rounding. Defaults to
#' \code{signif_pad}.
#' @param ... Further arguments.
#'
#' @return A list with the same number of elements as \code{x}. The rounded
#' values will be character (not numeric) and will have 0 padding to ensure
#' consistent number of significant digits.
#'
#' @export
#'
#' @examples
#' library(table1)
#' stats.default(x = jfbr_test$continuous)
#' stats.apply.rounding(stats.default(x = jfbr_test$continuous), digits = 3)
#' stats_jfbr(x = jfbr_test$continuous)
#' stats_apply_rounding_jfbr(stats_jfbr(x = jfbr_test$continuous), digits = 3)
#' stats_apply_rounding_jfbr(
#'   x =
#'     stats_jfbr(
#'       x = jfbr_test$continuous,
#'       custom_quantiles = c(0.47, 0.52)
#'     ),
#'   digits = 3
#' )

stats_apply_rounding_jfbr <-
  function(
    x,
    digits = 3,
    digits.pct = 1,
    round.median.min.max = TRUE,
    round.integers = TRUE,
    round5up = TRUE,
    rounding.fn = table1::signif_pad,
    ...
  ) {
    mindig <- function(x, digits) {
      cx <- format(x)
      ndig <- nchar(gsub("\\D", "", cx))
      ifelse(
        test = ndig > digits,
        yes = cx,
        no =
          rounding.fn(
            x,
            digits = digits,
            round.integers = round.integers,
            round5up = round5up,
            ...
          )
      )
    }

    format.percent <- function(x, digits) {
      if (x == 0)
        "0"
      else if (x == 100)
        "100"
      else round_pad(x, digits = digits.pct, ...)
    }

    format_n <- function (x, ...) {
      args <- list(...)
      args <- args[!(names(args) %in% c("format"))]

      cx <- do.call(formatC,
                    c(list(x=x, format="d"),
                      args[names(args) %in% names(formals(formatC))]))
      ifelse(is.na(x), NA, cx)
    }


    if (!is.list(x)) {
      stop("Expecting a list")
    }
    if (is.list(x[[1]])) {
      lapply(
        X = x,
        FUN = stats.apply.rounding,
        digits = digits,
        digits.pct = digits.pct,
        round.integers = round.integers,
        round5up = round5up,
        ...
      )
    }
    else {
      r <-
        lapply(
          X = x,
          FUN = rounding.fn,
          digits = digits,
          round.integers = round.integers,
          round5up = round5up,
          ...
        )
      nr <- c("N", "FREQ", "NMISS")
      nr <- nr[nr %in% names(x)]
      nr <- nr[!is.na(x[nr])]
      r[nr] <- lapply(x[nr], format_n, ...)
      if (!round.median.min.max) {
        sr <- c("MEDIAN", "MIN", "MAX")
        sr <- sr[sr %in% names(x)]
        r[sr] <- lapply(x[sr], mindig, digits = digits)
      }
      pr <- c("PCT", "PCTnoNA", "PCTNMISS", "CV", "GCV")
      pr <- pr[pr %in% names(x)]
      pr <- pr[!is.na(x[pr])]
      r[pr] <- lapply(as.numeric(x[pr]), format.percent, digits = digits.pct)
      r
    }
  }
