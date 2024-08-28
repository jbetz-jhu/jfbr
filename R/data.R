#' jfbr_test: Example data for testing functions.
#'
#' A \code{data.frame} containing columns with the following data types:
#' \code{integer}, \code{numeric}, 0/1 binary, \code{ordered}, \code{factor}.
#' Each column has a missing value
#'
#' Two grouping variables are included with no missing values, since missing
#' values in grouping variables creates an error in [table1::table1()].
#'
#' @format ## `jfbr_test `
#' A data frame with 200 rows and 8 columns:
#' \describe{
#'   \item{numbers}{Participant ID}
#'   \item{continuous}{Baseline Covariates 1-4}
#'   \item{binary}{Binary treatment assignment (1 = Treatment; 0 = Control)}
#'   \item{ordered}{Outcomes at assessments 1-4}
#'   \item{binary_factor}{Time from study initiation to randomization}
#'   \item{categorical}{Study time of assessments 1-4}
#'   \item{two_level_group}{Two level factor for grouping: No missing data}
#'   \item{three_level_group}{Three level factor for grouping: No missing data}
#' }
"jfbr_test"

