str_collapse <- function(x) {
    paste(sort(unique(x)), collapse = "|")
}



#' Find trials listing a given drug name as intervention
#'
#' @param name, drug name (or other keyword) 
#' @export
#' @examples
#' find_intervention('bortezomib')
find_intervention <- function(name) {
    df <- CTE::ct_interv 
    indices <- grep(sprintf("\\b%s\\b", name)
        , df$name, useBytes = TRUE, ignore = TRUE)
    tbl <- dplyr::as_tibble(df[indices, ])
    dplyr::left_join(tbl, CTE::ct_info, by = 'id')
}


#' Find interventional drugs listed in clinical trials associated with a given clinical condition
#'
#' @param pattern, regular expression string to match clinical condition
#' @export
#' @examples
#' find_drugs('sarcoma')
find_drugs <- function(pattern) {
    if (length(pattern) > 1) stop("only one pattern at a time...")
    if (nchar(pattern) < 1) stop("pattern must have at least 2 characters")
    cond <- CTE::ct_cond
    interv <- CTE::ct_interv
    info <- CTE::ct_info
    ok <- grepl(pattern, cond$condition, ignore.case = TRUE)
    if (sum(ok) == 0) {
        warning("The regular expression `", pattern, "` matched no CT data")
        return(NA)
    }
    tmp <- dplyr::filter(cond, ok)
    tmp <- dplyr::inner_join(tmp, interv, by = "id")
    tmp <- dplyr::inner_join(tmp, info, by = "id")
    by_name <- dplyr::group_by(tmp, name)
    out <- 
        dplyr::summarize(by_name
            , num_ct    = dplyr::n_distinct(id)
            , first     = min(date, na.rm = TRUE)
            , last      = max(date, na.rm = TRUE)
            , ct_id     = paste(sort(unique(id)), collapse = "|")
            )
    dplyr::arrange(out, desc(num_ct))
}





 

