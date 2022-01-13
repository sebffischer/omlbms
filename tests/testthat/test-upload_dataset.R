test_that("Can upload example dataset", {
  mlr3oml:::with_test_server()
  withr::local_options(list(
    omlbms.path = "~/r/omlbms/inst",
    mlr3oml.api_key = Sys.getenv("TESTOPENMLAPIKEY")))
  withr::defer({
    mlr3oml:::delete("data", id, confirm = FALSE)
  })
  id = upload_dataset("example")

})
