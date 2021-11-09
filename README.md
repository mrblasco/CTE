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

