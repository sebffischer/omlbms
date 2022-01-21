test_server = function() {
  options(
    mlr3oml.api_key = Sys.getenv("TESTOPENMLAPIKEY"),
    mlr3oml.server = "https://test.openml.org/api/v1"
  )
}

public_server = function() {
  options(
    mlr3oml.api_key = Sys.getenv("OPENMLAPIKEY"),
    mlr3oml.server = "https://openml.org/api/v1"
  )
}

#' @export
get_path = function(...) {
  path = getOption("omlbms.path")
  if (is.null(path)) {
    stop("Please set option omlbms.path to be the root directory as described in the README.")
  }
  dots = list(...)
  if (length(dots) == 0) {
    return(path)
  }
  path = paste0(path, "/", paste(list(...), collapse = "/"))
  return(path)
}

read_description_md = function(path) {
  path = paste0(path, "/description.md")
  lines = readLines(path)
  desc = paste(lines, collapse = "\n")

  return(desc)
}

read_description_yaml = function(path) {
  path = paste0(path, "/description.yaml")
  desc = yaml::read_yaml(path)
  return(desc)
}


load_data = function(...) {
  full_path = get_path()
}
# if (FALSE) {
#   desc_md = read_description_md(get_path("inst", "data", "example"))
#   desc_yaml = read_description_yaml(get_path("inst", "data", "example"))
# }

# make_save_id = function(type) {
#   function(response) {
#     id = response$upload_data_set$id[[1]]
#     if (!is.character(id)) {
#       return(NULL) # do nothing as upload was not successfull
#     }
#     server = mlr3oml:::get_server()
#     path = get_path("example_bms", "ids")
#     if (server == "https://test.openml.org/api/v1") {
#       ids_path = paste0(path, "/test_data_ids.rds")
#     } else if (server == "https://test.openml.org/api/v1") {
#       ids_path = paste0(path, "/test_data_ids.rds")
#     } else {
#       stop("Server not supported")
#     }
#
#     if (file.exists(ids_path)) {
#       ids = readRDS(ids_path)
#     } else {
#       ids = list()
#     }
#
#     ids = append(ids, id)
#
#     saveRDS(ids, ids_path)
#   }
# }
#
# save_data_id = make_save_id("data")
# save_benchmark_suite_id = make_save_id("benchmark_suite")
# save_task_id = make_save_id("benchmark_suite")
