require(CTE)
require(dplyr, warn = FALSE)




name <- CTE::ct_interv$name[1] 

find_drugbank_name <- function(name) {
    drugs <- unique(CTE::drugbank$common_name)
    agrep_values <- sapply(drugs, agrep, x=name, ignore = TRUE, useBytes = TRUE)
    matches <- names(agrep_values)[sapply(agrep_values, length) > 0]
    distances <- as.vector(adist(name, matches))
    dplyr::arrange(dplyr::tibble(matches, distances), distances)
}

CTE::drugbank %>% 
mutate(synonyms = strsplit(synonyms, split = "|"))

find_drugbank_name(name = "Aspirin")

verbose <- FALSE 

# https://www.princeton.edu/~otorres/FuzzyMergeR101.pdf
ct_file <- 'data/ct-interventions.csv'
db_file <- "data/drugbank_vocabulary.csv"

# Functions 
str_sub <- function(x, pattern, replacement, ...) {
    gsub(pattern = pattern, x = x, replacement = replacement, ...)
}
str_standardize <- function(x) {
    x %>%
    tolower() %>%
    str_sub(" ?[®]", "") %>%
    str_sub(" hydrochloride", "") %>%
    str_sub("per day|daily|weekly", "") %>%
    str_sub("once|twice", "") %>%
    str_sub("[0-9.]+%", "", ignore = T) %>% # rm doses 
    str_sub(" ([0-9.]+ mg[/kmg]*)", "", ignore = T) %>% # rm doses 
    str_sub("(oral)? Tablets?| injection", "", ignore = TRUE) %>%
    str_sub("[ ]+"," ") %>%
    trimws()
}
fuzzy <- function(x, y, ...) {
    agrep(x, y, ignore.case = TRUE
        , useBytes = TRUE, max.distance = 0.05, ...)
}
add_name <- function(x, y) {
    ifelse(is.na(x), y, paste(x, y, sep = "|"))
}

# Load data 
message("Loading data...", appendLF = FALSE)
ct <- readr::read_csv(ct_file, show_col_types = FALSE)
db <- readr::read_csv(db_file, show_col_types = FALSE)
message("ok")

message("Unique DrugBank strings...", appendLF = FALSE)
db.uniq <- 
    tibble(name = db$`Common name`) %>%
    dplyr::distinct()
message(nrow(db.uniq))


message("Unique ClinicalTrials strings...", appendLF = FALSE)
ct.uniq <- 
    dplyr::filter(ct, type == 'Drug') %>%
    dplyr::mutate(name = tolower(name)) %>%
    dplyr::select(name) %>%
    dplyr::distinct()
message(nrow(ct.uniq))

n <- nrow(db.uniq) 

message("Expected time ", round(n * 0.2 / 60, 1), " mins")

message("Matching from DrugBank to ClinicalTrials...",appendLF=FALSE)

#n <- nrow(db.name) n 
t0 <- Sys.time()
ct.uniq$name_db <- NA
for (j in seq(n)) {
    input <- db.uniq$name[j]
    if (verbose) message(input, "...")
    indices <- fuzzy(input, ct.uniq$name, value = FALSE)
    ct.uniq$name_db[indices] <- add_name(ct.uniq$name_db[indices], input)
}
t1 <- Sys.time()
message("ok")

#ct.uniq %>% filter(!is.na(name_db)) %>% reactable::reactable()
message("Actual time ", round((t1 - t0) / 60,1), " mins")

# Saving 
message("Saving file...", appendLF = FALSE)
filter(ct.uniq, !is.na(name_db)) %>% saveRDS(file = "data/drugnames.rds")
message("ok")
message("end")