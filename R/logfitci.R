#' Calculates fitted quantile and CI
#'
#' To calculate the quantile and CI, a log-normal distribution is
#' fitted on the data and the quantile and CI for this fit is returned
#'
#' @param x Data
#' @param prob quantile probability
#'
#' @return A list with the fitdist and bootdist objects, and a
#' data.frame with a summary of of the procedure
#'
#' This functions uses the `fitdist` function of the fitdistrplus
#' package. A log normal distribuion is fitted on the data and the
#' quantile and confidence interval (CI) is calculated by
#' bootstrapping of the fitted fucntion.
#'
#' @importFrom fitdistrplus fitdist bootdist
#' @importFrom stats qlnorm quantile
#'
#' @export

logfitci <- function(x,prob=.95) {
    f <- fitdistrplus::fitdist(x,"lnorm")
    fq <- qlnorm(prob,meanlog=f$estimate[1],sdlog=f$estimate[2])
    f.bs <- fitdistrplus::bootdist(f,niter=1000)
    f.bs.q <- quantile(f.bs,prob)
    qlci <- quantile(f.bs.q$bootquant[,1],probs=c(.025))[1]
    quci <- quantile(f.bs.q$bootquant[,1],probs=c(.975))[1]

    result <- data.frame(meanlog=f$estimate[1],
                         sdlog=f$estimate[2],
                         qnorm=fq,
                         lci=qlci,
                         uci=quci
                         )
                         
    return(list(f=f,b=f.bs,result=result))

}


