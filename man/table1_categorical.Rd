% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/table1_categorical.R
\name{table1_categorical}
\alias{table1_categorical}
\title{Summary Functions for table1::table1() for Numeric Data}
\usage{
table1_categorical(x, na_is_category = FALSE)
}
\arguments{
\item{x}{A \code{vector} of values passed from \code{\link[table1:table1]{table1::table1()}}}

\item{na_is_category}{A \code{logical} scalar, indicating whether missing
values should be treated as one of the values of the variable (TRUE) or
tabulated separately (FALSE).}
}
\value{
Tabulations for \code{\link[table1:table1]{table1::table1()}}
}
\description{
Summary Functions for table1::table1() for Numeric Data
}
\examples{
library(table1)

table1(
  x = ~ ordered + binary_factor + categorical | two_level_group,
  data = jfbr_test,
  render.categorical = table1_categorical
)
}
