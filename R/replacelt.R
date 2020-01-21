#' Replace '<' with negative signs
#'
#'Replace '<' ('lesser than' sign) 
#' with '-' (negative sign) for the whole dataset 
#' and remove spaces while we're at it.
#' 
#' @param x data set
#'
#' @return Dataset where '<' is replaced with '-'
#'
#' In Dutch environmental reports, chemical analyses with a result
#' below the limit of quanitfication is often indicated with `<LOQ`,
#' where LOQ is the numerical value of the limit of quantification.
#' This function replaces the '<' character with a minus. The LOQ
#' value can then be turned into a negative numerical value.
#'
#' When values below the limit of quantification are negative, it is
#' easy to do calculations or imputations. With the function
#' `replaceNegative` such values can be replaced using a imputation
#' factor.
#'
#' @export
#' @importFrom magrittr %>%
#' @importFrom stringr str_replace str_replace_all

replacelt <- function(x) {
    r <- x %>% stringr::str_replace_all(" ","") %>%
        stringr::str_replace("<","-")
}


