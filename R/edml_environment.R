#' @export EdmlEnvironment
#' @keywords internal
#' @importFrom R6 R6Class
EdmlEnvironment <- R6Class('EdmlEnvironment',
  private = list(
    parent_node = NA
  ),
  public = list(
    environment = NA
  )
)
