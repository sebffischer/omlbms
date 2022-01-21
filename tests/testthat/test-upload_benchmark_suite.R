test_that("Can upload suite", {
  mlr3oml:::with_test_server()
  withr::local_options(list(
    omlbms.path = "~/r/omlbms/inst/example_bms"))
  withr::defer(delete("study", id, confirm = FALSE))
  # withr::defer(delete("suite", ""))
  response = upload_benchmark_suite("example")
  id = as.integer(response$study_upload$id[[1]])
  print(id)
  expect_integer(id, any.missing = FALSE, len = 1)
})

test_that("Can upload suite and add task to it", {
  mlr3oml:::with_test_server()
  withr::local_options(list(
    omlbms.path = "~/r/omlbms/inst/example_bms"))
  withr::defer(delete("study", id, confirm = FALSE))
  # withr::defer(delete("suite", ""))
  response = upload_benchmark_suite("example")
  id = as.integer(response$study_upload$id[[1]])
  print(id)
  expect_integer(id, any.missing = FALSE, len = 1)
})
