context("SyntaxNode correctness")
test_that("id can be found when added to tree with single child", {
  require(edml)
  root <- SyntaxNode$new(0, NULL, NULL)
  child <- root$add_child(1, "'{'", '{')

  expect_equal(child$search_id(1), '{')
  expect_equal(root$search_id(1), '{')
})
