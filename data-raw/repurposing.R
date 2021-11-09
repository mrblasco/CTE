URL <- "https://s3.amazonaws.com/data.clue.io/repurposing/downloads/repurposing_drugs_20200324.txt"

outfile <- "data-raw/repurposing_drugs_20200324.txt"
download.file(URL, outfile)

repurp <- readr::read_tsv(outfile, skip = 9)

usethis::use_data(repurp)

