context("MeCab")

test_that("MeCab result test", {
  example <- ja_nlp$new(text = "すもももももももものうち")
  expect_equal(
    object = as.character(example$mecab()$surface),
    expected = c("すもも", "も", "もも", "も", "もも", "の", "うち")
  )
})
