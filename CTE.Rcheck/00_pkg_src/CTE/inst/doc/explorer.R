## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(dplyr, warn = FALSE) # for data wrangling 
library(DT) # use datatables to format outcomes

## ----setup--------------------------------------------------------------------
library(CTE)

## -----------------------------------------------------------------------------
data(ct_info)
ct_info

## -----------------------------------------------------------------------------
data(ct_interv)
ct_interv

## -----------------------------------------------------------------------------
data(ct_cond)
ct_cond

## -----------------------------------------------------------------------------
data(drugbank)
drugbank

## -----------------------------------------------------------------------------
data(repurp)
repurp

## -----------------------------------------------------------------------------
data(gene_targets)
gene_targets

## -----------------------------------------------------------------------------
tbl <- find_intervention("bortezomib")

## -----------------------------------------------------------------------------
require(DT)
DT::datatable(dplyr::select(tbl, -enrollment,-enrollment_type)
    , rownames = FALSE
    , filter = "top"
    , extensions = "Buttons"
    , plugins = "ellipsis"
    , options = list (
        dom = 'Bfrtip'
        , buttons =  c('copy', 'csv')
        , columnDefs = list(list(
                targets = c(2, 5)
                , render = JS("$.fn.dataTable.render.ellipsis( 125 )")
                )
            )
        )
    )

