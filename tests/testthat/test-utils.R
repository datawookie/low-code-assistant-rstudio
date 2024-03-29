test_that("%||% works", {
  expect_equal("a" %||% "b", "a")
  expect_equal(c("a", "b") %||% "c", c("a", "b"))
  expect_equal(NULL %||% "a", "a")
  expect_equal("a" %||% NULL, "a")
  expect_equal(NULL %||% NULL, NULL)
  expect_equal(NULL %||% NA, NA)
  expect_equal(NA %||% NULL, NA)
  expect_equal(NULL %||% c("a", "b"), c("a", "b"))
})

test_that("firstup works", {
  expect_equal(firstup("one"), "One")
  expect_equal(firstup(".one"), ".one")
  expect_equal(firstup("one two"), "One two")
  expect_equal(firstup("a"), "A")
})

test_that("is_valid_name works", {
  expect_true(is_valid_name("one"))
  expect_true(is_valid_name(".one"))
  expect_true(is_valid_name("one.two"))
  expect_true(is_valid_name("a5"))
  expect_true(is_valid_name("a_b"))

  expect_false(is_valid_name("5a"))
  expect_false(is_valid_name("_ab"))
  expect_false(is_valid_name("one!"))
  expect_false(is_valid_name(" one"))
  expect_false(is_valid_name("one two"))
  expect_false(is_valid_name("one-two"))
  expect_false(is_valid_name("one:two"))
})

test_that("remove_duplicate_lines works", {
  expect_equal(remove_duplicate_lines("a", "a"), "")

  text <- "a\nb\nc\nd\n b\nab\nb\nc\na\na"
  expect_equal(
    remove_duplicate_lines(text),
    text
  )
  expect_equal(
    remove_duplicate_lines(text, "a"),
    "b\nc\nd\n b\nab\nb\nc"
  )
  expect_equal(
    remove_duplicate_lines(text, "b"),
    "a\nc\nd\n b\nab\nc\na\na"
  )
  expect_equal(
    remove_duplicate_lines(text, "c"),
    "a\nb\nd\n b\nab\nb\na\na"
  )
  expect_equal(
    remove_duplicate_lines(text, " b"),
    "a\nb\nc\nd\nab\nb\nc\na\na"
  )
  expect_equal(
    remove_duplicate_lines(text, c("a", "b")),
    "c\nd\n b\nab\nc"
  )
  expect_equal(
    remove_duplicate_lines(text, c("a", "b", "ab")),
    "c\nd\n b\nc"
  )
  expect_equal(
    remove_duplicate_lines(text, c("a", "b", "c")),
    "d\n b\nab"
  )
  expect_equal(
    remove_duplicate_lines(text, c("a", "b", "c", "d")),
    " b\nab"
  )
  expect_equal(
    remove_duplicate_lines(text, c("a", "b", "c", "d", "ab")),
    " b"
  )
  expect_equal(
    remove_duplicate_lines(text, c("a", "b", "c", "d", "ab", " b")),
    ""
  )

  text <- "library(shiny)\nfirst\n#library(shiny)\nsecond\nlibraray(shiny)\nthird\nlibrary(shiny)\nlibrary(shinyalert)\nfourth\nlibrary(shiny)\nfifth\nlibrary(shinyjs)\nsixth\nlibrary(shinyalert)\n"
  expect_identical(
    remove_duplicate_lines(text),
    text
  )
  expect_identical(
    remove_duplicate_lines(text, "library(shiny)"),
    "first\n#library(shiny)\nsecond\nlibraray(shiny)\nthird\nlibrary(shinyalert)\nfourth\nfifth\nlibrary(shinyjs)\nsixth\nlibrary(shinyalert)\n"
  )
  expect_identical(
    remove_duplicate_lines(text, "library(shinyalert)"),
    "library(shiny)\nfirst\n#library(shiny)\nsecond\nlibraray(shiny)\nthird\nlibrary(shiny)\nfourth\nlibrary(shiny)\nfifth\nlibrary(shinyjs)\nsixth\n"
  )
  expect_identical(
    remove_duplicate_lines(text, "library(shinyjs)"),
    "library(shiny)\nfirst\n#library(shiny)\nsecond\nlibraray(shiny)\nthird\nlibrary(shiny)\nlibrary(shinyalert)\nfourth\nlibrary(shiny)\nfifth\nsixth\nlibrary(shinyalert)\n"
  )
  expect_identical(
    remove_duplicate_lines(text, c("library(shiny)", "library(shinyalert)")),
    "first\n#library(shiny)\nsecond\nlibraray(shiny)\nthird\nfourth\nfifth\nlibrary(shinyjs)\nsixth\n"
  )
})
