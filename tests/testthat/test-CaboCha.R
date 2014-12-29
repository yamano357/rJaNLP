context("CaboCha")

test_that("CaboCha result test", {
  example <- JaNLP$new(text = "すもももももももものうち")
  expect_equal(
    object = example$cabocha()$chunk_id,
    expected = c(0, 0, 1, 1, 2, 2, 3)
  )
})
