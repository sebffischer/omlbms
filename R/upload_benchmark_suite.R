upload_benchmark_suite = function() {
  path = get_path("suite")
  suite_desc = read_description_md(path)
  desc = read_description_yaml(path)

  # TODO: add assertions

  doc = xml2::xml_new_document()
  dat = xml2::xml_add_child(doc, "oml:study", "xmlns:oml" = "http://openml.org/openml")

  browser()
  # Order matters!
  xml2::xml_add_child(.x = dat, .value = "oml:alias", desc$alias)
  xml2::xml_add_child(.x = dat, .value = "oml:main_entity_type", "task")
  xml2::xml_add_child(.x = dat, .value = "oml:name", desc$name)
  xml2::xml_add_child(.x = dat, .value = "oml:description", suite_desc)

  desc_path = tempfile(fileext = ".xml")
  withr::defer(unlink(desc_path))
  xml2::write_xml(x = doc, file = desc_path)

  data_path = sprintf("%s/data.arff", path)
  browser()
  response = httr::POST(
    url = sprintf("%s/study", mlr3oml:::get_server()),
    body = list(
      description = httr::upload_file(desc_path)
    ),
    query = list(api_key = mlr3oml:::get_api_key())
  )
  response = xml2::as_list(httr::content(response))
  save_benchmark_suite_id(response)
  return(response)
}

if (FALSE) {
  debugonce(upload_dataset)
  upload_benchmark_suite()
}
