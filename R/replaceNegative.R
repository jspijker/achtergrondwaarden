#' Replace negative values with positive ones
#'
#' Replaces negative values, decoding for values below LOQ, into
#' positive values using a factor
#'
#' @param x data set
#' @param replaceval value used for replacement
#'
#' @return Dataset with positive values
#'
#' A way to work with values below the limit of Quantification
#' (LOQ) is to convert these values to negative concentrations.
#' Since negative concentrations do not exists, changing sign makes
#' easy to discern them from other values. Depending on the type of
#' analyses, these negative values can easily imputed by a positive
#' value, using a factor like 0.5 or 0.7, or by other values like 0 or
#' NA. 
#'
#' @export

replaceNegative <- function(x,replaceval=NA) {

    d <- ifelse(x<0,-1*x*replaceval,x)
    return(d)
}


