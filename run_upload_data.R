# 
library("mlr3")
library("mlr3oml")
library("OpenML")
library("omlbms")


options(mlr3oml.api_key="9a77a84cfa84ca57a89e00d41835d45e")



root_name <- "C:/Work/OpenMLStuff/Data_Collection"
datasets_raw <-"datasets_raw"
datafiles <- "data"

path_to_files<-paste(root_name,datasets_raw,sep='/')

options(omlbms.path = root_name)


list_datasets<- list.files(path=path_to_files,pattern = ".csv")
list_names <- tools::file_path_sans_ext(list_datasets)

for (dataset_name in list_names){
  upload_dataset(dataset_name)
}



