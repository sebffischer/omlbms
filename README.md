# omlbms - OpenML benchmark suite 

This repository helps to: 

- Create a new benchmark suite on OpenML
- Publish a dataset / task 
- Add a new task to the benchmark suite

To use the repository, simply clone it into a local folder and install the package: 

```
devtools::install_github("sebffischer/omlbms")
```

Additionally, run the following command from `R`: 

To work on a benchmark suite, set the option `omlbms.path` to your folder: 
```
options(omlbms.path = ".../bm_suite")
```

The *./inst* directory mimics the suggested folder structure and contains example files.

* *./inst/bm_suite.md* contains the description of the benchmark suite, see the example 
[here](https://new.openml.org/search?type=benchmark&sort=tasks_included&study_type=task&id=99). 

* *./inst/bm_suite.yaml* contains the **name** and the **alias** of the benchmark suite

* *./inst/data/* contains folders that contain all relevant information to upload the respective 
                 dataset

To switch easily between test and public server, set the environment variables 
`OPENMLAPIKEY` and `OPENMLAPIKEY`

To switch to a server (only in the running R session), run either `public_server()`
or `test_server()`. This also changes the api key.
