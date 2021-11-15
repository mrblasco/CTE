# Get data frome the Therapeutic Target Database
# http://db.idrblab.net/ttd/full-data-download
require(dplyr, warn = F)

URL <- 'http://db.idrblab.net/ttd/sites/default/files/ttd_database'

download_ifnot <- function(url, filename) {
    if (!file.exists(filename)) {
        download.file(url, filename)
    }
}

## Drug names 

infile <- "P1-04-Drug_synonyms.txt"
download_ifnot(file.path(URL, infile), file.path("data-raw", infile))

raw <- 
    file.path("data-raw", infile) %>% 
    readr::read_tsv(skip = 21
        , col_names = c("id", "type", "name"))

ttd_info <- 
    raw %>% 
    filter(type == 'DRUGNAME') %>% select(-type)


## Drug information 

infile <- "P1-02-TTD_drug_download.txt"
download_ifnot(file.path(URL, infile), file.path("data-raw", infile))

raw <- 
    file.path("data-raw", infile) %>% 
    readr::read_tsv(skip = 28
        , col_names = c("id", "name", "value"))

str_collapse <- function(x) {
    paste(sort(x), collapse = "|")
}

ttd <-  
    raw %>% 
    group_by(id, name) %>% 
    summarize(value = str_collapse(value), .groups = 'drop') %>%
    tidyr::pivot_wider(values_from = value, names_from = name) %>%
    select(-DRUG__ID) %>%
    rename_all(tolower)

## Targets

infile <- "P1-01-TTD_target_download.txt"
download_ifnot(file.path(URL, infile), file.path("data-raw", infile))


raw <- 
    file.path("data-raw", infile) %>% 
    readr::read_tsv(skip = 39, col_names = c("id", "name", "value"))

targets <- 
    raw %>% 
    filter(name == 'GENENAME') %>% 
    select(id, gene_name = value)


## Target mapping 

infile <- "P1-07-Drug-TargetMapping.xlsx"
download_ifnot(file.path(URL, infile), file.path("data-raw", infile))

raw <- 
    file.path("data-raw", infile) %>%
    readxl::read_xlsx()

map <- 
    raw %>%     
    left_join(targets, by = c("TargetID" = "id")) %>% 
    left_join(ttd_info, by = c("DrugID" = "id")) 

## Merge 

gene_targets <- 
    map %>% 
    group_by(name) %>% 
    summarize(genes = str_collapse(gene_name))


## Save dataset 
usethis::use_data(gene_targets, overwrite = TRUE)


