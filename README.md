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


You can also query all cancer-related clinical trials in the package to see what interventions have been targeting a specific condition. 

For example, you can query all the drugs listed as interventions in CTs related to sarcomas with the following commands: 

```{r}
find_drugs("sarcoma")
```

```
# A tibble: 1,200 × 5
   name                      num_ct first      last       ct_id                 
   <chr>                      <int> <date>     <date>     <chr>                 
 1 Doxorubicin                   66 2002-05-29 2021-08-02 NCT00038142|NCT000683…
 2 Temozolomide                  63 2005-01-31 2021-05-15 NCT00102648|NCT001947…
 3 ifosfamide                    52 1999-11-01 2014-08-15 NCT00001300|NCT000024…
 4 Cyclophosphamide              49 2002-05-29 2021-07-09 NCT00038142|NCT001651…
 5 doxorubicin hydrochloride     49 1999-11-01 2010-08-25 NCT00002466|NCT000024…
 6 Ifosfamide                    39 1999-11-01 2021-07-13 NCT00003657|NCT000895…
 7 cyclophosphamide              37 1999-11-01 2013-09-16 NCT00002466|NCT000025…
 8 etoposide                     37 1999-11-01 2013-09-16 NCT00002466|NCT000025…
 9 Gemcitabine                   34 2003-09-10 2021-05-21 NCT00068393|NCT001425…
10 vincristine sulfate           28 1999-11-01 2008-04-18 NCT00002466|NCT000025…
# … with 1,190 more rows
```

## Full description of data access and functions

The vignette `explorer` in the CTE package contains more details about all the data available and functions for matching drugs by name using fuzzy string matching. 

```{r}
vignette('explorer',package="CTE")
```




