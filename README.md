# omlbms - OpenML benchmark suite 


This repository helps to create and maintain  benchmark suites on [OpenML](https://new.openml.org/).
To use the repository, simply clone it into a local folder and run the following R commands: 

```r
devtools::install_github("mlr-org/mlr3oml@oml_run")
devtools::install_github("sebffischer/omlbms")
```


To work on a benchmark suite, set the option `omlbms.path` to a new folder, where you will store
the files for the benchmark suite

```r
options(omlbms.path = "PATH/TO/YOUR/FOLDER")
```

To create and curate a benchmark suite using this repository, the a specific folder-structure
is suggested. An example is locate in `omlbms/inst` and its structure is explained below.

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

The data folder contains a subfolder for each dataset that should be uploaded to OpenML. 
Here the R-Script `data.R` does the preprocessing of the data and saves the `data.arff` file
in the same folder. The data must be in this format to be able to upload it to 
OpenML and must be called `data.arff` 
The *description.md* file should contain a proper description of the data as in the example.
The *description.yaml* currently supports.

  - the `name` of the dataset
  - the `ignore_attribute`, i.e. which columns should not be used as features
  - the `default_target_attribute`
  - the `license`

When this is done, the dataset can be uploaded as follows: 

```r
upload_dataset("example")
```

**tasks** 

To use a task, that is not already on OpenML, create a folder in *example_bms/tasks* that contains
the file *description.yaml*. This file should contain: 

  - The `task_type` - E.g. "Supervised Classification" (see [here](https://www.openml.org/api/v1/json/tasktype/list))
  - The `source_data` - data id 
  - The `target_feature`
  - The `estimation_procedure` (see [here](https://www.openml.org/api/v1/json/estimationprocedure/list))

**benchmark suite**

To initialze the benchmark suite, create the files *description.md* and *description.yaml* where
*description.md* contains a proper description of the benchmark suite and the latter contains
the alias, the name and the task_ids that should be uploaded.
To extend the benchmark suite with a new task, the following call can be made

```r
upload_benchmark_suite("example")
```

During exploration to easily switch between the public and the test server, set the environment
variables `OPENMLAPIKEY` and `OPENMLAPIKEY`

To switch to a server (only in the running R session), run either `public_server()`
or `test_server()`. This also changes the api key.
