#' Calculates quantile statistics and CI
#'
#' This is a wrapper function to calculate quantile statistics and CI
#' using the pbci, logfitci and logfitcicens functions.
#'
#' @param x vector with data
#' @param p quantile probability
#'
#' @return A list with the fitdist and bootdist objects, and a
#' data,frame with a summary of of the procedure
#'
#' This functions uses the `fitdist` function of the fitdistrplus
#' package. A log normal distribuion is fitted on the data and the
#' quantile and confidence interval (CI) is calculated by
#' bootstrapping of the fitted fucntion.
#'
#' @importFrom fitdistrplus fitdist bootdist
#' @importFrom stats fivenum
#'
#' @export

#qestimates <- function(x,dl=NA, dlfactor=.7,p=.95){
qestimates <- function(x,p=.95){

    res <- data.frame()
    ro <- data.frame(n=NA,floq=NA,quant=NA)
    bs <- data.frame(mean=NA,bias=NA,error=NA,lci=NA,uci=NA)
    fit <- data.frame(meanlog=NA,sdlog=NA,qnorm=NA,lci=NA,uci=NA)
    fcens <- data.frame(meanlog=NA,sdlog=NA,qnorm=NA,lci=NA,uci=NA)

    error <- FALSE

    if(!is.numeric(x)) {
        error <- TRUE
        warning("x is not numeric")
    }

    if(length(x)<=2){
        error <- TRUE
        warning("x has equal or less than 2 values")
    }

    if(length(unique(x))<2){
        error <- TRUE
        warning("x has less than 2 unique values")
    }

    xdl <- x
    x <- replaceNegative(x,replaceval=1)

    if(!error) {
        ro.obj <- list(n=length(x),
                       floq= length(which(xdl<0))/length(x),
                       five=fivenum(x),
                       quant=quantile(x,prob=p,na.rm=TRUE)[1]
                       )
        ro <- data.frame(n=ro.obj$n,floq=ro.obj$floq,
                         quant=ro.obj$quant)
    } else {
        ro.obj <- NA
    }

    if(!error) {
        err <- try( bs.obj <- pbci(x,prob=p))
        if(class(err)=="try-error") {
            warning("Error in pbci\n")
            bs.obj <- NA
        } else {
            i <- bs.obj$result
            bs <- data.frame(mean=i$mean,bias=i$bias,error=i$error,
                             lci=i$lci,uci=i$uci)
        }
    } else {
            bs.obj <- NA
    }

    if(!error) {
        err <- try( fit.obj <- logfitci(x,prob=p))
        if(class(err)=="try-error") {
            warning("Error in logfitci\n")
            fit.obj <- NA
        } else {
            i <- fit.obj$result
            fit <- data.frame(meanlog=i$meanlog,sdlog=i$sdlog,
                              qnorm=i$qnorm,
                             lci=i$lci,uci=i$uci)
        }
    } else {
            fit.obj <- NA
    }

    if(!error) {
        err <- try( fcens.obj <- logfitcicens(xdl,prob=p))
        if(class(err)=="try-error") {
            warning("Error in logfitci\n")
            fcens.obj <- NA
        } else {
            i <- fcens.obj$result
            fcens <- data.frame(meanlog=i$meanlog,sdlog=i$sdlog,
                              qnorm=i$qnorm,
                             lci=i$lci,uci=i$uci)
        }
    } else {
            fcens.obj <- NA
    }

    result <- data.frame(ro=ro,bs=bs,fit=fit,fcens=fcens)
    return <- list(ro=ro.obj,bs=bs.obj,fit=fit.obj,
                   fcens=fcens.obj,result=result,data=x)

}

