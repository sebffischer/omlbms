#' @export
upload_dataset = function(name) {
  path = get_path("data", name)
  data_desc = read_description_md(path)
  desc = read_description_yaml(path)

  # TODO: add assertions

  doc = xml2::xml_new_document()
  dat = xml2::xml_add_child(doc, "oml:data_set_description", "xmlns:oml" = "http://openml.org/openml")

  # Order matters!
  xml2::xml_add_child(.x = dat, .value = "oml:name", desc$name)
  xml2::xml_add_child(.x = dat, .value = "oml:description", data_desc)
  xml2::xml_add_child(.x = dat, .value = "oml:format", "arff")
  xml2::xml_add_child(.x = dat, .value = "oml:licence", desc$license)
  xml2::xml_add_child(.x = dat, .value = "oml:default_target_attribute", desc$default_target_attribute)
  # xml2::xml_add_child(.x = dat, .value = "oml:citation", desc$citation)
  # xml2::xml_add_child(.x = dat, .value = "oml:original_data_url", desc$citation)
  # xml2::xml_add_child(.x = dat, .value = "oml:paper_url", desc$citation)

  desc_path = tempfile(fileext = ".xml")
  withr::defer(unlink(desc_path))
  xml2::write_xml(x = doc, file = desc_path)

  data_path = sprintf("%s/data.arff", path)
  response = httr::POST(
    url = sprintf("%s/data", mlr3oml:::get_server()),
    body = list(
      description = httr::upload_file(desc_path),
      dataset = httr::upload_file(data_path)
    ),
    query = list(api_key = mlr3oml:::get_api_key())
  )
  response = xml2::as_list(httr::content(response))
  # save_data_id(response)
  return(response)
}

if (FALSE) {
  debugonce(upload_dataset)
  upload_dataset("example")
}
