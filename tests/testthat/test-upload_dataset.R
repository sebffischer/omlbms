test_that("Can upload benchmark suite", {
  mlr3oml:::with_test_server()
  withr::local_options(list(
    omlbms.path = "~/r/omlbms/inst/example_bms"))
  withr::defer({
    mlr3oml:::delete("data", id, confirm = FALSE)
  })
  debugonce(upload_benchmark_suite)
  id = upload_dataset("example")
})
