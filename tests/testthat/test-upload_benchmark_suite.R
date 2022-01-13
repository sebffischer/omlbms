test_that("Can upload suite", {
  mlr3oml:::with_test_server()
  withr::local_options(list(
    omlbms.path = "~/r/omlbms/inst/example_bms"))
  # withr::defer(delete("suite", ""))

  id = upload_benchmark_suite()
})
