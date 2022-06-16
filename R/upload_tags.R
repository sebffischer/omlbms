
upload_tags<-function(data_ids,tags_set) {
  
#tags_set<-c("Graphical models","MaRDI","TA3")
  
  url_set<-sprintf("%s/data/tag", mlr3oml:::get_server())
  
  ap_key<-mlr3oml:::get_api_key() 
  api1_key<- setOMLConfig(apikey = "9a77a84cfa84ca57a89e00d41835d45e")
    #response_list <- vector(mode = "list", length = desired_length)
  
  response_list<-list()
  i<-1
  for (new_tag in tags_set){
    
    curr_response = httr::POST(
      
      url = url_set,
      body = list(
        data_id = data_ids,
        tag = new_tag
        
      ),
      
      query = list(api_key =api1_key$apikey)
      
    )
    
    response_list[[length(response_list)+1]]<-list(curr_response)
    
  }
  
  
}