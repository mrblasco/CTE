require(dplyr)

URL <- "https://go.drugbank.com/releases/5-1-8/downloads/all-drugbank-vocabulary"

## Download raw data
temp <- tempfile()
download.file(URL, temp)
unzip(temp, exdir = "data-raw")
unlink(temp)

raw <- readr::read_csv("data-raw/drugbank vocabulary.csv")

drugbank <- # rename column names
    raw %>%
    rename_all(function(x) gsub("[ ]", "_", tolower(x))) %>%
    select(id=drugbank_id, name=common_name, synonyms)


usethis::use_data(drugbank, overwrite = TRUE)
#save(drugbank, file = "data/drugbank.rda")

