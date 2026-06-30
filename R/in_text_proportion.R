#' Format proportions and percentages for presentation
#'
#' This is for formatting proportions, percentages and confidence intervals for
#' reporting. Confidence intervals are calculated using[binom::binom.confint].
#' Formatting is performed using [table1::round_pad].
#'
#' @param x a \code{numeric} \code{vector} for the numerator.
#' @param n a \code{numeric} \code{vector} for the denominator. If
#' \code{length(x) > 1} and \code{length(n) == 1}, the denominator is assumed
#' to be the same for all values of \code{x}.
#' @param output a string specifying the type of output requested:
#' either "percentage" or "proportion". Defaults to proportion.
#' @param output_format a string specifying the formatting of the output,
#' which may include the numerator, the denominator, and percentage/proportion:
#' one of \code{"p"} (proportion only), \code{"xn"} (numerator and denominator),
#' \code{"xp"} (numerator and proportion/percentage), or \code{"xnp"}
#' (numerator/denominator and proportion/percentage)
#' @param digits_proportion the digits of precision for proportions
#' (see \code{table1::round_pad}).
#' @param digits_percent the digits of precision for percentages
#' (see [table1::round_pad]).
#' @param ci_method a string containing the type of interval estimate to
#' compute, if any. See ?[binom::binom.confint].
#' @param level the confidence/credible interval coefficient
#' @param ... other arguments passed to [binom::binom.confint]
#'
#' @return When a CI is computed, the result is a list, containing the output
#' and individual components: otherwise, the result is a string.
#' @export
#'
#' @examples
#' # Calculating percentages
#' in_text_proportion(x = 2, n = 10, output_format = "p")
#' in_text_proportion(x = 0, n = 10, output_format = "xp")
#' in_text_proportion(x = 10, n = 10, output_format = "xnp")
#'
#' in_text_proportion(x = 2, n = 10, output = "proportion", output_format = "p")
#' in_text_proportion(x = 0, n = 10, output = "proportion", output_format = "xp")
#' in_text_proportion(x = 10, n = 10, output = "proportion", output_format = "xnp")
#'
#' in_text_proportion(x = 1, n = 1e4, output_format = "xp", digits_percent = 2)
#' in_text_proportion(x = 1, n = 1e4, output_format = "xp", digits_percent = 2)
#'
#' in_text_proportion(x = 0, n = 10, output_format = "p", ci_method = "bayes")
#' in_text_proportion(x = 0, n = 10, output_format = "p", ci_method = "exact")

in_text_proportion <-
  function(
    x,
    n,
    output = c("proportion", "percentage")[1],
    output_format = c("p", "xn", "xp", "xnp")[4],
    digits_proportion = 3,
    digits_percent = 1,
    ci_method = NULL,
    level = 0.95,
    ...
  ) {
    checkmate::assert(
      checkmate::check_integerish(
        x = x,
        lower = 0,
        any.missing = FALSE,
        min.len = 1
      ),

      checkmate::check_integerish(
        x = n,
        lower = 1,
        any.missing = FALSE,
        min.len = 1
      ),

      checkmate::check_choice(
        x = output,
        choices = c("percentage", "percent", "proportion", "probability"),
        null.ok = FALSE
      ),

      checkmate::check_choice(
        x = output_format,
        choices = c("p", "xn", "xp", "xnp"),
        null.ok = FALSE
      ),

      checkmate::check_integerish(
        x = digits_proportion,
        lower = 0,
        any.missing = FALSE,
        len = 1
      ),

      checkmate::check_integerish(
        x = digits_percent,
        lower = 0,
        any.missing = FALSE,
        len = 1
      ),

      checkmate::check_choice(
        x = ci_method,
        choices = c("exact", "ac", "asymptotic", "wilson", "prop.test", "bayes",
                    "logit", "cloglog", "probit"),
        null.ok = TRUE
      ),

      combine = "and"
    )

    if(length(x) > length(n) & length(n) != 1){
      stop("If length(x) > 1 then length(n) must be 1 or equal to length(x).")
    } else if(length(x) > length(n) & length(n) == 1){
      n <- rep(n, length(x))
    }

    if(any(x > n)){
      stop("all(x <= n) must be TRUE.")
    }

    if(output %in% c("percentage", "percent")){
      as_percent <- TRUE
    } else if(output %in% c("probability", "proportion")){
      as_percent <- FALSE
    }

    if(!is.null(ci_method)){
      pr_ci <-
        binom::binom.confint(
          x = x,
          n = n,
          conf.level = level,
          methods = ci_method,
          ...
        )

      lcl_rounded <-
        if(as_percent){
          table1::round_pad(
            x = 100*pr_ci$lower,
            digits = digits_percent
          )
        } else {
          table1::round_pad(
            x = pr_ci$lower,
            digits = digits_proportion
          )
        }

      ucl_rounded <-
        if(as_percent){
          table1::round_pad(
            x = 100*pr_ci$upper,
            digits = digits_percent
          )
        } else {
          table1::round_pad(
            x = pr_ci$upper,
            digits = digits_proportion
          )
        }

      ci_string <-
        paste0("(95% CI: ", lcl_rounded, ", ", ucl_rounded, ")")

      if(ci_method == "bayes"){
        pr_estimate <- pr_ci$mean
      } else {
        pr_estimate <- NULL
      }
    } else {
      ci <- ci_rounded <- ci_string <- NULL
    }

    pct <- NA*x

    for(i in 1:length(x)){
      pct[i] <-
        if (x[i] == 0) {
          "0"
        } else if (x[i] == n[i]) {
          if(as_percent){
            "100"
          } else {
            "1"
          }
        } else {
          if(as_percent){
            table1::round_pad(x = 100*(x[i]/n[i]), digits = digits_percent)
          } else {
            table1::round_pad(x = x[i]/n[i], digits = digits_percent)
          }
        }
    }

    pr <-
      if(as_percent){
        switch(
          EXPR = output_format,
          "p" = paste0(pct, "%"),
          "xn" = paste0(x, "/", n),
          "xp" = paste0(x, " (", pct, "%)"),
          "xnp" = paste0(x, "/", n, " (", pct, "%)"),
          stop("Invalid value for `output`:", output)
        )
      } else {
        switch(
          EXPR = output_format,
          "p" = paste0(pct, ""),
          "xn" = paste0(x, "/", n),
          "xp" = paste0(x, " (", pct, ")"),
          "xnp" = paste0(x, "/", n, " (", pct, ")"),
          stop("Invalid value for `output`:", output)
        )
      }

    if(is.null(ci_method)){
      return(pr)
    } else {
      return(
        list(
          x = x,
          n = n,
          output = pr,
          output_ci =
            if(output_format %in% c("p", "xp", "xnp")){
              paste0(
                substr(x = pr, start = 1, stop = nchar(pr) - 1),
                if(as_percent){"%"} else {""}, " ",
                substr(x = ci_string, start = 1, stop = nchar(ci_string))
              )
            } else {
              paste(pr, ci_string)
            },
          ci = pr_ci,
          lcl_rounded = lcl_rounded,
          ucl_rounded = ucl_rounded,
          ci_string = ci_string,
          level = level
        )
      )
    }
  }
