library(testthat)
library(andras)


test_that("forint function returns 42 HUF", {
  expect_equal(forint(42), "42Ft")
})
