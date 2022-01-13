upload_task = function(name) {
  path = sprintf("%s/%s", get_path("tasks"), name)
  desc = read_description_yaml(path)
  task_type_id = get_task_type_id(desc$task_type)
  doc = xml2::xml_new_document()
  task = xml2::xml_add_child(doc, "oml:task_inputs", "xmlns:oml" = "http://openml.org/openml")
  xml2::xml_add_child(.x = task, "oml:task_type_id", task_type_id)
  xml2::xml_add_child(task, "oml:input", name = "source_data", desc$source_data)
  xml2::xml_add_child(task, "oml:input", name = "target_feature", desc$target_feature)
  xml2::xml_add_child(task, "oml:input", name = "estimation_procedure", desc$estimation_procedure)

  desc_path = tempfile(fileext = ".xml")
  on.exit(unlink(desc_path), add = TRUE)

  xml2::write_xml(x = doc, file = desc_path)
  response = httr::POST(
    url = sprintf("%s/task", mlr3oml:::get_server()),
    body = list(
      description = httr::upload_file(desc_path)
    ),
    query = list(api_key = mlr3oml:::get_api_key())
  )
  response = xml2::as_list(httr::content(response))
  save_task_id(response)
  return(response)
}

get_task_type_id = function(task_type) {
  id = switch(task_type,
    "Supervised Classification" = "1",
    "Supervised Regression" = "2",
    "Learning Curve" = "3",
    "Supervised Data Stream Classification" = "4",
    "Clustering" = "5",
    "Machine Learning Challenge" = "6",
    "Survival Analysis" = "7",
    "Subgroup Discovery" =  "8",
    stop("Invalid task_type")
  )
  return(id)
}

if (FALSE) {
  response = upload_task("example")
}
