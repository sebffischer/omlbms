# omlbms - OpenML benchmark suite 


## TODO
- create folder example_bms in inst, after installing this is then located in package/example_bms
  and can be used for testing

This repository helps to: 

- Create a new benchmark suite on OpenML
- Publish a dataset / task 
- Add a new task to the benchmark suite

To use the repository, simply clone it into a local folder and run the following R commands: 

```
devtools::install_github("mlr-org/mlr3oml@oml_run")
devtools::install_github("sebffischer/omlbms")
```


To work on a benchmark suite, set the option `omlbms.path` to your folder: 

```
options(omlbms.path = ".../bm_suite")
```

To create and curate a benchmark suite using this repository, the following folder-structure
is proposed. It is located in the *omlbms/inst*.

```
example_bms
├── data
│   └── example
│       ├── data.arff
│       ├── data.R
│       ├── description.md
│       └── description.yaml
├── ids
├── suite
│   ├── description.md
│   └── description.yaml
└── tasks
    └── example
        └── description.yaml
```

**data**
The data folder contains a subfolder for each data-set that is to be added to the benchark suite
but which is not already uploaded to OpenML. An R-Script is suggested, that creates and 
prepares the data and writes the *data.arff* file, that can be uploaded to OpenML.
The *description.md* file should contain a proper desription of the data as in the example.
The *description.yaml* currently supports.

  - the "name" of the dataset
  - the "ignore_attribute", i.e. which columns should not be used as features
  - the "default_target_attribute""
  - the "license"

When this is done, the dataset can be uploaded using the call, note that this store the id 
upon success, in the folder *example_bms/ids*, so it is easy to keep track of the uploaded datasets
and to e.g. remove then when an error has been detected.

```
upload_dataset("example")
```

To use a task, that is not already on OpenML, create a folder in *example_bms/tasks* that contains
the file *description.yaml*. This file should contain: 

  - The "task_type"
  - The "source_data"
  - The "target_feature"
  - The "estimation_procedure"

To initialze the benchmark suite, create the files *description.md* and *description.yaml* where
*description.md* contains a proper description of the benchmark suite and the latter contains
the alias, the name and the task_ids that should be uploaded.
To extend the benchmark suite with a new task, the following call can be made

```
add_to_suite("example")
```

During exploration to easily switch between the public and the test server, set the environment
variables `OPENMLAPIKEY` and `OPENMLAPIKEY`

To switch to a server (only in the running R session), run either `public_server()`
or `test_server()`. This also changes the api key.
