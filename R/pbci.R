#' Calculates bootstrapped percentiles and conf. intervals
#'
#' This function calculates a bootstrapped percentile and its
#' confidence interval of a given dataset.
#'
#' @param x vector with data
#' @param prob Probability of percentile
#' 
#' @return list with boot objects and summary data.frame
#' 
#' This functions is a wrapper arround boot and boot.ci from the boot
#' package. The boot statistic is the quantile function. 
#' 
#' The returned list contains the boot (tag b) and boot.ci (tag ci)
#' objects. The data from these objects is summarised in the result
#' tag. This contains a data.frame with, respecively, original percentile value
#' (original), mean of bootstrapped results (mean), bias of
#' bootstrapped results towards mean (bias), standard error of
#' bootstrapped results (error), and upper (uci) and lower lci
#' confidence intervals of boot.ci. Confidence intervals are
#' calculated for aan alpan of 0.05.
#' 
#' @importFrom boot boot boot.ci
#' @importFrom stats var quantile
#' @export
#' 
#' 
#' 
#' 
#' 
#' 


pbci <- function(x,prob=.95) {

    perc <- function(x,i,p) {
        xsample <- x[i]
        xperc <- quantile(xsample,p)
        return(xperc)
    }

    b <- boot(data=x,
              statistic=qnt<-function(x,i,p=prob){perc(x,i,p)}
              ,R=1000)
    b.mean <- mean(b$t)
    ci <- boot.ci(b,conf=prob,type="perc")
    result <- data.frame(original=b$t0,
                         mean=b.mean,
                         bias=b.mean-b$t0,
                         error=sqrt(var(b$t)),
                         lci=ci$percent[4],
                         uci=ci$percent[5])
    return(list(b=b,ci=ci,result=result))
}
