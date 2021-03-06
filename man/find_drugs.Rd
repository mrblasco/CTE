% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{find_drugs}
\alias{find_drugs}
\title{Find interventional drugs listed in clinical trials associated with a given clinical condition}
\usage{
find_drugs(pattern)
}
\arguments{
\item{pattern, }{regular expression string to match clinical condition}
}
\description{
Find interventional drugs listed in clinical trials associated with a given clinical condition
}
\examples{
find_drugs('sarcoma')
}
