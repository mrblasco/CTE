# CTE

<!-- badges: start -->
<!-- badges: end -->

The goal of the Cancer Trials Explorer (CTE) package is to provide an easy way to query clinical trials that are interventional (as opposed to observational) and related to cancer (i.e., listing conditions with cancer-related terms). 

## Installation

You can install the development version of CTE like so:

``` r
devtools::install_github("mrblasco/CTE")
```

## Data on cancer-related trials

This repository pulls data from several sources:

- [ClinicalTrials.gov](https://clinicaltrials.gov)

- [Drugbank](https://go.drugbank.com)

- [Drug Repurposing Hub](https://www.broadinstitute.org/drug-repurposing-hub)

- [TTD: Therapeutic Target Database](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC99057/)

Please, refer to the information reported in the urls above for further information about the data sources. 

## Basic usage

The package provides functions to find cancer-related clinical trials that list a particular drug as treatment intervention. 

For example, you can query all cancer-related CTs associated with the chemical compound Bortezomib like so: 

```{r}
library(CTE)
tbl <- find_intervention("Bortezomib")
tbl
```

```
# A tibble: 54 × 8
   id          name  title status date       description enrollment enrollment_type
   <chr>       <chr> <chr> <chr>  <date>     <chr>            <dbl> <chr>          
 1 NCT00006362 bort… A Ph… Compl… 2000-10-04 "OBJECTIVE…         NA NA             
 2 NCT00006773 bort… Phas… Termi… 2000-12-06 "OBJECTIVE…         42 Actual         
 3 NCT00011778 bort… A Ph… Compl… 2001-02-28 "Backgroun…         25 Actual         
 4 NCT00024011 bort… A Ph… Compl… 2001-09-13 "OBJECTIVE…         50 Actual         
 5 NCT00027716 bort… A Mu… Compl… 2001-12-07 "OBJECTIVE…         NA NA             
 6 NCT00051987 VELC… A Ra… Compl… 2003-01-21 "In this s…        175 NA             
 7 NCT00052689 bort… A Ra… Compl… 2003-01-24 "OBJECTIVE…         88 Anticipated    
 8 NCT00061932 bort… A Ph… Compl… 2003-06-05 "PRIMARY O…         41 Actual         
 9 NCT00072150 bort… Phas… Compl… 2003-11-04 "PRIMARY O…         40 Actual         
10 NCT00077428 bort… Phas… Compl… 2004-02-10 "OBJECTIVE…         37 Actual   
```

## Full description of data access and functions

The vignette `explorer` in the CTE package contains more details about all the data available nad the functions for matching drugs by name using fuzzy string matching. 

```{r}
vignette('explorer',package="CTE")
```




