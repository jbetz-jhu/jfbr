#' Determine whether numeric elements are whole numbers
#'
#' Note: this is shamelessly adapted from ?is.integer
#'
#' @param x A \code{numeric} \code{vector} or \code{matrix}
#' @param tol The precision threshold used to make the determination of a whole
#' number.
#'
#' @returns A \code{logical} vector or matrix, depending on the class of
#' \code{x}.
#' @export
#'
#' @examples
#' is_whole_number(0)
#' is_whole_number(0.1)
#' is_whole_number(0.1^7)
#' is_whole_number(0.1^24)
#' is_whole_number(c(0.1^7, 0.1^24))

is_whole_number <-
  function(x, tol = .Machine$double.eps^0.5) {
    if(!(is.vector(x) | is.matrix(x))){
      stop("`x` must be a vector or matrix")
    } else if(!is.numeric(x)){
      stop("`x` must be numeric")
    }

    return(abs(x - round(x)) < tol)
  }
