#' Cumulative Frequency Diagram
#'
#' Plots a cumulative frequency diagram, a diagram comparable with a
#' q-q- plot but with percentiles instead of quantiles on the x-axis.
#'
#' @param d vector with data
#' @param prob which percentile to indicate on graph, default is the
#' 95th percentile
#' @param graphtitle title of the graph
#'
#' @return a ggplot2 object
#'
#' This function plots a Q-Q plot but instead of theoretical quantiles
#' it plots against the theoretical percentile, using a normal
#' distribution.
#'
#' By default, this function indicates the values at the 95th
#' percentile. Using the prob parameter, the percentile can be
#' changed.
#'
#' This function returns a ggplot2 object with the graph. This object
#' can be extended using ggplot2's grammar.
#'
#' @import ggplot2 
#' @importFrom stats qnorm quantile ppoints
#'
#' @export



cfp <- function(d,prob=.95,graphtitle="CFP") {

    y <- c()
    x <- d

    ylim<-range(x,na.rm=TRUE);

    n<-length(x);
    x1<-qnorm(ppoints(length(x)));
    y1<-quantile(x,probs=ppoints(x),na.rm=T);

    xseq<-c(0.01,0.1,0.5,0.90,0.99);
    xperc<-qnorm(xseq);
    xplab<-as.character(xseq*100);

    py <- as.numeric(quantile(x,probs=prob))
    px <- qnorm(prob);

    d.plot <- data.frame(x=x1,y=y1)

    p <- ggplot(d.plot,aes(x=x,y=y))
    p <- p + geom_point()
    p <- p + geom_smooth(alpha=I(1/5))
    p <- p + xlab("percentile") + ylab("value")
    p <- p + scale_x_continuous(breaks=xperc,labels=xplab)
    p <- p + geom_vline(xintercept=px)
    p <- p + geom_hline(yintercept=py)
    p <- p + ggtitle(graphtitle)
    return(p)

}



