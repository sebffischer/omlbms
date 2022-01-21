#' @export
attach_to_study = function(study_id, ids) {
  url = sprintf("%s/study/%s/attach", mlr3oml:::get_server(), study_id)
  print(url)
  response = httr::POST(
    url = url,
    body = list(ids = ids),
    query = list(api_key = mlr3oml:::get_api_key()))

  response = xml2::as_list(httr::content(response))
  return(response)
}

#' @export
detach_from_study = function(study_id, ids) {
  response = httr::POST(
    url = sprintf("%s/study/%s/detach", mlr3oml:::get_server(), study_id),
    body = list(ids = as.character(ids)),
    query = list(api_key = mlr3oml:::get_api_key())
  )
  response = xml2::as_list(httr::content(response))
  return(response)
}

modify_study_status = function(study_id, status) {
  # assert_choice(status, c("in_preparation", "active", "deactivated"))
  response = httr::POST(
    url = sprintf("%s/study/status/update", mlr3oml:::get_server()),
    body = list(study_id = study_id, status = status),
    query = list(api_key = mlr3oml:::get_api_key())
  )
  response = xml2::as_list(httr::content(response))
  return(response)
}
