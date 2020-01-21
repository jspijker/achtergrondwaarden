#' Calculates fitted quantiles and CI, including censored data
#'
#' To calculate the quantile and CI, a log-normal distribution is
#' fitted on the censored data and the quantile and CI for this fit is
#' returned. 
#'
#' @param x Data
#' @param prob quantile probability
#'
#' @return A list with the fitdistcens and bootdistcens objects, and a
#' data,frame with a summary of of the procedure
#'
#' This functions uses the `fitdistcens` function of the fitdistrplus
#' package. Censored data (i.e. concentrations) are indicated with
#' negative values. A log normal distribuion is fitted on the data and the
#' quantile and confidence interval (CI) is calculated by
#' bootstrapping of the fitted function.
#'
#' @importFrom fitdistrplus fitdistcens bootdistcens
#' @importFrom stats qlnorm quantile
#'
#' @export


logfitcicens <- function(x,prob=.95) {


    xlr <- data.frame(left=x,right=x)
    xlr$right[xlr$left<0]<- -1*xlr$right[xlr$left<0]
    xlr$left[xlr$left<0]<-NA

    f <- fitdistrplus::fitdistcens(xlr,"lnorm")
    fq <- qlnorm(prob,meanlog=f$estimate[1],sdlog=f$estimate[2])
    f.bs <- fitdistrplus::bootdistcens(f,niter=1000)
    f.bs.q <- quantile(f.bs,prob)
    qlci <- quantile(f.bs.q$bootquant[,1],probs=c(.025))[1]
    quci <- quantile(f.bs.q$bootquant[,1],probs=c(.975))[1]

    result <- data.frame(meanlog=f$estimate[1],
                         sdlog=f$estimate[2],
                         qnorm=fq,
                         lci=qlci,
                         uci=quci
                         )
                         
    return(list(f=f,b=f.bs,xlr=xlr,result=result))

}

