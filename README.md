ethis::use_news_md()


# CTE

<!-- badges: start -->
<!-- badges: end -->

The goal of Cancer Trials Explorer (CTE) is to provide an easy tool to explore cancer-related clinical trials data.

## Installation

You can install the development version of CTE like so:

``` r
devtools::install_github("mrblasco/CTE")
```

## Example

This is a basic example which shows you how to find cancer-related clinical trials that list a particular drug, e.g., aspirin, as treatment intervention:

```r
library(DT)
library(CTE)
tbl <- find_intervention("aspirin") 
DT::datatable(tbl)
```

## Source data

This repository pulls data from several sources:

- [ClinicalTrials.gov](https://clinicaltrials.gov)

- [Drugbank](https://go.drugbank.com)

- [Drug Repurposing Hub](https://www.broadinstitute.org/drug-repurposing-hub)

- [TTD: Therapeutic Target Database](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC99057/)

## Cancer-related trials

The dataset selects only clinical trials that are interventional (as opposed to observational) and related to cancer (i.e., listing conditions with cancer-related terms). 

