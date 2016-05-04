#'
#' @export SyntaxNode
#' @keywords internal
#' @importFrom R6 R6Class
SyntaxNode <- R6Class("SyntaxNode",
  lock_objects = FALSE,
  private = list(
  ),
  public = list(
    id = NA,
    text = "",
    token = "",
    children = NULL,
    parent = NULL,
    promised = NULL,
    root = NULL,
    initialize = function(id, token, text) {
      self$id <- id
      self$text <- as.character(text)
      self$token <- as.character(token)
    },
    add_child = function(id, token, text) {
      # Make sure to verify whether the node exists as a promise.
      if (id %in% names(self$root$promised)) {
        child = self$root$promised[[id]]
        self$root$promised[[id]] = NULL
        child$complete_promise(token, text)
      } else {
        child = SyntaxNode$new(id, token, text)
      }

      child$set_parent(self)
      child$set_root()
      new_child <- list()
      new_child[[id]] <- child
      self$children <- c(self$children, new_child)
      invisible(child)
    },
    add_child_given_parent_id = function(id, token, text, parent_id) {
      # First verify whether parent is set in the tree.
      parent <- self$search_id(parent_id)
      # If the parent was not found, we can add the parent as a promise.
      if (is.null(parent)) parent <- self$add_promise(parent_id)

      if (!is.null(parent)) child <- parent$add_child(id, token, text)

    },
    add_promise = function(id) {
      child <- SyntaxNode$new(id, NULL, NULL)
      child$set_parent(self)
      child$set_root()
      new_promise <- list()
      new_promise[[id]] <- child
      self$root$promised <- c(self$root$promised, new_promise)
      invisible(child)
    },
    complete_promise = function(token, text) {
      self$text <- as.character(text)
      self$token <- as.character(token)
    },
    set_parent = function(node) {
      self$parent <- node
    },
    get_parent = function(node) {
      self$parent
    },
    set_root = function() {
      if (is.null(self$parent))
        stop("self$parent is not set so will be unable to set root")

      # Make sure that the first level will have root set to their parent and
      # the levels deeper will have the root equal to their parent's root.
      if (is.null(self$parent$get_root())) self$root = self$parent
      else self$root = self$parent$root

    },
    get_root = function() {
      self$root
    },
    search_id_from_node = function(id) {
      to_return = NULL
      if (id == self$id) {
        to_return = self
      } else {
        if (!is.null(self$children)) {
          for (child in self$children) {
            child_result <- child$search_id_from_node(id)
            if (!is.null(child_result)) {
              if (!is.null(to_return)) {
                to_return <- c(to_return, child_result)
              } else {
                to_return <- child_result
              }
            }
          }
        }
      }

      return(to_return)
    },
    search_id = function(id) {
      if (!is.null(self$root)) self$root$search_id_from_node(id)
      else self$search_id_from_node(id)
    },
    print = function(level = 0) {
      if (is.null(self$parent)) {
        cat(self$text, "\n")
      } else {
        cat(paste(c(rep(" ", level), self$text, "\n")))
      }
      if (!is.null(self$children)) {
        indention = level + 1
        for (child in self$children) {
          child$print(indention)
        }
      }
      invisible()
    }
 )
)
