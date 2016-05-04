#' Create an manip evaluation environment.
#' TODO: add documentation
#'
#' \code{manip()} initializes an manip evaluation.
#'
#' @export
manip <- function(x, text) {
  p = parse(text = text, keep.source = TRUE)
  d = getParseData(p)
  return(d)
}

#' Determines which actions to perform on numerics.
#' TODO: add documentation
#'
#'
#' @export
numerics <- function(text) {
}

#' Remove outliers.
#' TODO: add documentation
#'
#'
#' @export
remove_outliers <- function(...) {
}

#' Apply transformation.
#' TODO: add documentation
#'
#'
#' @export
transform <- function(...) {
}

#' Set column numbers of variables.
#' TODO: add documentation
#'
#'
#' @export
`.` <- function(...) {
}

