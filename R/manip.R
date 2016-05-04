#' @export ManipEnvironment
#' @keywords internal
#' @importFrom R6 R6Class
ManipEnvironment <- R6Class('ManipEnvironment',
  inherit = EdmlEnvironment
)


#' Create an manip evaluation environment.
#' TODO: add documentation
#'
#' \code{manip()} initializes an manip evaluation.
#'
#' @export
manip <- function(x, text) {
  manip_env <- new.env()
  class(manip_env) <- c("environment", "manipEnvironment")


  eval(parse(text = quote(text)), envir = manip_env)
}

#' Determines which actions to perform on numerics.
#' TODO: add documentation
#'
#'
#' @export
numerics <- function(text) {
  eval(parse(text = quote(text)))
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
transform <- function(text, func, keep = TRUE) {
  eval(parse(text = quote(text)))
}

#' Set column numbers of variables.
#' TODO: add documentation
#'
#'
#' @export
`.` <- function(..., edml_object, parent_function) {
  browser()
}

