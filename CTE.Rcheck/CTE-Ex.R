pkgname <- "CTE"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('CTE')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("find_drugs")
### * find_drugs

flush(stderr()); flush(stdout())

### Name: find_drugs
### Title: Find interventional drugs listed in clinical trials associated
###   with a given clinical condition
### Aliases: find_drugs

### ** Examples

find_drugs('sarcoma')



cleanEx()
nameEx("find_intervention")
### * find_intervention

flush(stderr()); flush(stdout())

### Name: find_intervention
### Title: Find trials listing a given drug name as intervention
### Aliases: find_intervention

### ** Examples

find_intervention('bortezomib')



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
