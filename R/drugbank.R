
#' DrugBank vocabulary
#'
#' DrugBank identifiers, names, and synonyms.
#'
#' @source DrugBank Open Data dataset,
#'   <https://go.drugbank.com/releases/latest#open-data>.
#'
#' @format A data frame with columns:
#' @docType data
#' @keywords datasets
#' @name drugbank
#'
#' @format A data frame with 53940 rows and 10 variables
#' \describe{
#'      \item{id}{DrugBank identifier.}
#'      \item{name}{character for drug's common name.}
#'      \item{synonyms}{string expression for alternative names, delimited by the pipe character.}
#' }
"drugbank"