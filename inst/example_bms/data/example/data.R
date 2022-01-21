name = "example"

# Daten herunterladen
url = "https://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data"
dt = data.table::fread(url)

# Datenaufbereitung
# ...

dt$ignore1 = 1
dt$ignore2 = 2
foreign::write.arff(dt, file = sprintf("%s/inst/data/%s/data.arff", get_path(), name))


# upload_dataset(name)
