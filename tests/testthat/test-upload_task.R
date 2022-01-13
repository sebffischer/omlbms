test_that("Can upload task", {
  withr::local_options(omlbms.path = "~/r/omlbms/inst") # TODO: fix this
  mlr3oml:::with_test_server()
  withr::defer({
    mlr3oml::delete(id)
  })
  debugonce(upload_task)
  upload_task("example")


