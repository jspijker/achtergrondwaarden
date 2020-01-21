#' Remove outliers using the MAD criterium
#'
#' This function removes outliers using the MAD criterium according to
#' Leys e.a. (2013).
#'
#' @param x Vector of data
#' @param b Factor
#' @param mconstant MAD constant
#' @param na.rm remove NA's
#'
#' 
#'
#'
#'
#'
#'
#'
#' @importFrom stats mad median
#'
#' @export


rmoutlier<-function (x,b=3,mconstant=1.4826,na.rm=FALSE) {
	if (b <= 0) {
		stop("'b' must not be <= 0")
	}else {
        xmad <- b*mad(x,constant=mconstant,na.rm=na.rm)
		out <- x < median(x,na.rm=na.rm)-xmad | x > median(x,na.rm=na.rm)+xmad
		x[out]<-NA
	}
	return(x)
}

