require(dplyr)

# Cancer terms 
rgx <- "cancer|leukemia|tumor|neoplasm|.+coma|.+blastoma|.+noma"

## ------ 
# Download raw data
# -------- 
# URL <- "https://ClinicalTrials.gov/AllAPIJSON.zip"
# temp <- tempfile()
# download.file(URL, temp) # 2 GB it may take a lot 
# unzip(temp, exdir = "data-raw")
# unlink(temp)
## ------ 

raw <- readr::read_csv("data-raw/ct-conditions.csv", guess_max = 1e4)

cancer_id <- # list of cancer-related CTs
    raw %>%
    filter(grepl(rgx, condition)) %>%
    pull(id) %>% 
    unique()

ct_cond <- 
    raw %>%
    filter(id %in% cancer_id) %>% 
    arrange(id)
    
raw <- readr::read_csv("data-raw/ct-info.csv", guess_max = 1e4)

ct_info <- 
    raw %>%
    mutate(date = as.Date(date, "%B %d, %Y")) %>%
    filter(id %in% cancer_id)

raw <- readr::read_csv("data-raw/ct-interventions.csv", guess_max = 1e4)

ct_interv <- 
    raw %>%
    filter(type == 'Drug', id %in% cancer_id) %>% 
    select(id, name) 


## Save 
usethis::use_data(ct_cond, overwrite = TRUE)
usethis::use_data(ct_info, overwrite = TRUE)
usethis::use_data(ct_interv, overwrite = TRUE)

