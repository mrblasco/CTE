str_collapse <- function(x) {
    paste(sort(unique(x)), collapse = "|")
}

find_intervention <- function(name) {
    df <- CTE::ct_interv 
    indices <- grep(sprintf("\\b%s\\b", name), df$name, useBytes = TRUE, ignore = TRUE)
    tbl <- dplyr::as_tibble(df[indices, ])
    dplyr::left_join(tbl, CTE::ct_info, by = 'id')
}


# require(DT)
# require(htmltools)
# 
# find_intervention('aspirin') %>% 
#     mutate(description = substr(description, 1, 250)) %>%
#     DT::datatable(options(
#         columnDefs = list(list(
#                            targets = "description",
#                            render = JS("$.fn.dataTable.render.ellipsis( 5 )")
#                          ))
#         )
#     )

