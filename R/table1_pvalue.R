#' Compute hypothesis tests for table1::table1()
#'
#' table1::table1() has the ability to add a column for hypothesis test
#' p-values: see ?table1::table1.
#'
#' @param x A named \code{list} of values - Typically passed from
#' table1::table1().
#' @param variable a \code{character} scalar indicating the grouping variable
#' name - Typically passed from table1::table1().
#' @param test_numeric_2_levels a \code{function} that computes a hypothesis
#' test using a formula (variable ~ group) where group has only two levels, and
#' `variable` is numeric. The default is \code{t.test}, alternatives include:
#' \code{wilcox.test}.
#' @param test_numeric_more_than_2_levels a \code{function} that computes a hypothesis
#' test using a formula (variable ~ group) where group has more than two levels,
#' and `variable` is numeric. The default is the omnibus F-test from
#' anova(lm(variable ~ group)), alternatives include: \code{kruskal.test}.
#' @param test_categorical_2_levels a \code{function} that computes a hypothesis
#' test using a formula (variable ~ group) where group has only two levels and
#' `variable` is categorical. The default is \code{chisq.test}, alternatives
#' include: \code{fisher.test}.
#' @param test_categorical_more_than_2_levels a \code{function} that computes a
#' hypothesis test using a formula (variable ~ group) where group has more than
#' two levels and `variable` is categorical. The default is \code{chisq.test},
#' alternatives include: \code{fisher.test}.
#' @param digits \code{numeric} scalar: number of digits to use when formatting
#' p-values
#'
#' @return A \code{numeric} scalar containing the p-value from the specified
#' hypothesis tests.
#'
#' @export
#'
#' @examples
#'
#' table1::table1(
#'   x = ~ numbers + continuous + binary + ordered | group_two_level,
#'   data = jfbr_test,
#'   overall = FALSE,
#'   extra.col =
#'     list("p-value" = table1_pvalue)
#' )
#'
#' table1::table1(
#'   x = ~ numbers + continuous + binary + ordered | group_three_level,
#'   data = jfbr_test,
#'   overall = FALSE,
#'   extra.col =
#'     list("p-value" =
#'            function(x, value) table1_pvalue(
#'              x = x,
#'              variable = variable,
#'              test_numeric_2_levels = wilcox.test,
#'              test_numeric_more_than_2_levels = kruskal.test,
#'              test_categorical_2_levels = fisher.test,
#'              test_categorical_more_than_2_levels = fisher.test
#'            )
#'     )
#' )


table1_pvalue <-
  function(
    x,
    variable,
    test_numeric_2_levels = stats::t.test,
    test_numeric_more_than_2_levels =
      function(data, formula) {
        data.frame(
          p.value =
            stats::anova(stats::lm(formula = formula, data = data))$`Pr(>F)`[1]
        )
      },
    test_categorical_2_levels = stats::chisq.test,
    test_categorical_more_than_2_levels = stats::chisq.test,
    digits = 3
  ) {

    group_labels <- names(x)

    # Construct vectors of data y, and groups (strata) g
    if("overall" %in% names(x)){

      group_sizes <-
        sapply(
          X = x,
          FUN = length
        )

      # If 'overall' is created by table1() its length will be equal to the
      # sum of all categories: otherwise 'overall' may be a level in a factor.
      if(
        (max(group_sizes) == sum(group_sizes[-which.max(group_sizes)])) &
        (names(group_sizes[which.max(group_sizes)]) == "overall")
      ){
        overall_index <- which.max(group_sizes) # 'overall' created by table1()
        x <- x[-overall_index]
      }
    }

    y <- unlist(x)
    group_labels <- names(x)
    g <-
      factor(
        x = rep(1:length(x), times = sapply(x, length)),
        labels = group_labels
      )

    if(length(group_labels) > 2){
      if(is.numeric(y)){
        p <-
          do.call(
            what = test_numeric_more_than_2_levels,
            args =
              list(
                formula = y ~ g,
                data = data.frame(y = y, g = g)
              )
          )$p.value
      } else {
        p <-
          do.call(
            what = test_categorical_more_than_2_levels,
            args =
              list(
                x = table(y, g)
              )
          )$p.value
      }
    } else {
      if(is.numeric(y)){
        p <-
          do.call(
            what = test_numeric_2_levels,
            args =
              list(
                formula = y ~ g,
                data = data.frame(y = y, g = g)
              )
          )$p.value
      } else {
        p <-
          do.call(
            what = test_categorical_2_levels,
            args =
              list(
                x = table(y, g)
              )
          )$p.value
      }
    }


    return(c("", sub("<", "&lt;",
                     format.pval(p, digits = digits, eps = 10^-(digits)))))
  }
