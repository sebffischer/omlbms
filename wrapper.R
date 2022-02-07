wrapper<-function(){# Creation of the directories with subfolders to simulate the environment for omlbms

root_name <- "C:/Work/OpenMLStuff/Data_Collection"
datasets_raw <-"datasets_raw"
datafiles <- "data4"


dir.create(file.path(root_name, datafiles))

setwd(paste(root_name,datasets_raw,sep='/'))
list_datasets<- list.files(pattern = ".csv")
list_names <- tools::file_path_sans_ext(list_datasets)

for (filename in list_datasets){
  df <- read.csv(filename)
  dataset_name <- tools::file_path_sans_ext(filename)
  dataset_name_arff<-paste(dataset_name,"arff",sep=".")
  dir.create(paste(root_name,datafiles,dataset_name,sep = "/"),recursive = TRUE )
  
  foreign::write.arff(df,paste(root_name,datafiles,dataset_name,"data.arff",sep = "/"))
  foreign::write.arff(df,paste(root_name,datafiles,dataset_name,dataset_name_arff,sep = "/"))
  
  line_print<-paste0("Successfully created dataset ", dataset_name)
  print(line_print)
  
  # creating description and yaml files
  
  file.create(paste(root_name,datafiles,dataset_name,"description.md",sep = "/"))
  file.create(paste(root_name,datafiles,dataset_name,"description.yaml",sep = "/"))
  
  line_print1<-paste0("Successfully created description.md and description.yaml file of ", dataset_name)
  
  line_md<-paste0("//Add the description.md of the data file ",dataset_name)
  line_yaml<-paste0("#Add the description.yaml of the data file ",dataset_name)
  line_yaml2 <-paste0("# The description.yaml currently supports : 
  # --- the name of the dataset
  # ---  the ignore_attribute, i.e. which columns should not be used as features
  # ---  the default_target_attribute
  # ---  the license")
  
  lineyaml_name<-paste("#name:",noquote(" \" example_name \" "))
  lineyaml_ing<-paste("#ignore_attribute:",noquote(" \" -ignore1 \" "))
  lineyaml_def_targt<-paste("#default_target_attribute:",noquote(" \" attribute_to_ignore \" ") )
  lineyaml_lic<-paste("#license: ", noquote(" \" CC BY 4.0 \" "))
  
  line_yaml3 <- paste("# Example:",lineyaml_name,lineyaml_ing,lineyaml_def_targt,lineyaml_lic,sep="\n")
  
  ##ignore_attribute: # Which columns are not to used as features
  ##- ,
  ##-"ignore2" 
  ##default_target_attribute: "V9"
  ##license: "CC BY 4.0" # The data license")
  
  write(line_md,file = paste(root_name,datafiles,dataset_name,"description.md",sep = "/"),append = TRUE)
  
  write(line_yaml,file = paste(root_name,datafiles,dataset_name,"description.yaml",sep = "/"),append = TRUE)
  write(line_yaml2,file = paste(root_name,datafiles,dataset_name,"description.yaml",sep = "/"),append = TRUE)
  
  write(line_yaml3,file = paste(root_name,datafiles,dataset_name,"description.yaml",sep = "/"),append = TRUE)
  
  print(line_print1)
  
  # editing the description.md and description.yaml files
  
  file.edit(paste(root_name,datafiles,dataset_name,"description.md",sep = "/"))
  promt_line<-paste0("Change the ddescription.md of the file ",dataset_name, " and press [enter] to continue")
  readline(prompt=promt_line)
  
  file.edit(paste(root_name,datafiles,dataset_name,"description.yaml",sep = "/"))
  promt_line<-paste0("Change the description.yaml of the file ",dataset_name, " and press [enter] to continue")
  readline(prompt=promt_line)
  
  line_print2 <- paste0("Successfully edited description.md and description.yaml file of ", dataset_name)
  
  print(line_print2)
  
  
}

}

