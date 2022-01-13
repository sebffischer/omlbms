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


if (FALSE) {
  desc_md = read_description_md(get_path("inst", "data", "example"))
  desc_yaml = read_description_yaml(get_path("inst", "data", "example"))
}

save_data_id = function(response) {
  id = response$upload_data_set$id[[1]]
  if (!is.character(id)) {
    return(NULL) # do nothing as upload was not successfull
  }
  server = mlr3oml:::get_server()
  id_path = get_path("inst", "ids")
  if (server == "https://test.openml.org/api/v1") {
    data_ids_path = paste0(id_path, "/test_data_ids.rds")
  } else if (server == "https://test.openml.org/api/v1") {
    data_ids_path = paste0(id_path, "/test_data_ids.rds")
  } else {
    stop("Server not supported")
  }

  if (file.exists(data_ids_path)) {
    data_ids = readRDS(data_ids_path)
  } else {
    data_ids = list()
  }

  data_ids = append(data_ids, id)

  saveRDS(data_ids, data_ids_path)
}
