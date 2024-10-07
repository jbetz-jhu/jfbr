#' Format proportions and percentages for presentation
#'
#' This function is for calculating
#'
#' @param x a numeric scalar for the numerator
#' @param n a numeric scalar for the denominator
#' @param output a string specifying the type of output requested:
#' either "percentage" or "proportion"
#' @param output_format a string specifying the formatting of the output,
#' which may include the numerator, the denominator, and percentage/proportion
#' @param digits_proportion the digits of precision for proportions
#' (see \code{table1::round_pad}).
#' @param digits_percent the digits of precision for percentages
#' (see \code{table1::round_pad}).
#' @param ci_method a string containing the type of interval estimate to
#' compute, if any. See \code{?binom::binom.confint}.
#' @param level the confidence/credible interval coefficient
#' @param ... other arguments passed to \code{binom::binom.confint}
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
    output = c("percentage", "proportion")[1],
    output_format = c("p", "xn", "xp", "xnp")[4],
    digits_proportion = 3,
    digits_percent = 1,
    ci_method = NULL,
    level = 0.95,
    ...
  ){
    is_whole_number <-
      function(x, tol = .Machine$double.eps^0.5)  abs(x - round(x)) < tol

    if(length(x) > 1 | length(n) > 1){
      stop("Length of x (", length(x), ") and n (", length(n), ") must be 1.")
    }

    if(x > n){
      stop("Numerator (", x, ") is greater than denominator (", n, ").")
    }

    if(x < 0){
      stop("Numerator (", x, ") is negative.")
    }

    if(n < 1){
      stop("Denominator (", n, ") is less than 1.")
    }

    if(!all(is_whole_number(x), is_whole_number(n))){
      stop("Numerator (", x, ") and denominator (", n,
           ") must be whole numbers.")
    }

    accepted_outputs <-
      substr(x = c("percentage", "proportion"),
             start = 1, stop = 7)

    output <- substr(x = tolower(output[1]), start = 1, stop = 7)

    if(output %in% c("percent")){
      as_percent <- TRUE
    } else if(output %in% c("probabi", "proport")){
      as_percent <- FALSE
    } else {
      stop("Output type must be one of: \"percentage\" or \"proportion\"")
    }


    if(!is.null(ci_method)){
      if(ci_method == "all" | length(ci_method) > 1){
        stop("Select a single method. See ?binom::binom.confint")
      } else {
        pr_ci <-
          binom::binom.confint(
            x = x,
            n = n,
            conf.level = level,
            methods = ci_method,
            ...
          )

        ci_rounded <-
          if(as_percent){
            table1::round_pad(
              x = 100*c(pr_ci$lower, pr_ci$upper),
              digits = digits_percent
            )
          } else {
            table1::round_pad(
              x = c(pr_ci$lower, pr_ci$upper),
              digits = digits_proportion
            )
          }

        ci_string <-
          paste0("(95% CI: ", paste0(ci_rounded, collapse = ", "), ")")

        if(ci_method == "bayes"){
          pr_estimate <- pr_ci$mean
        } else {
          pr_estimate <- NULL
        }
      }
    } else {
      ci <- ci_rounded <- ci_string <- NULL
    }

    pct <-
      if (x == 0) {
        "0"
      } else if (x == n) {
        if(as_percent){
          "100"
        } else {
          "1"
        }
      } else {
        if(as_percent){
          table1::round_pad(x = 100*(x/n), digits = digits_percent)
        } else {
          table1::round_pad(x = x/n, digits = digits_percent)
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
                substr(x = pr, start = 1, stop = nchar(pr) - 1), ", ",
                substr(x = ci_string, start = 2, stop = nchar(ci_string))
              )
            } else {
              paste(pr, ci_string)
            },
          ci = pr_ci,
          ci_rounded = ci_rounded,
          ci_string = ci_string
        )
      )
    }
  }
