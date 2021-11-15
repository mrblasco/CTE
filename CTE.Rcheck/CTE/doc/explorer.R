## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(CTE)
library(dplyr, warn = FALSE) # for data wrangling 
library(DT) # use datatables to format outcomes

## -----------------------------------------------------------------------------
tbl <- find_intervention("bortezomib")
tbl

## -----------------------------------------------------------------------------
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

