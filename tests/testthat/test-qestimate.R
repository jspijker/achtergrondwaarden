context("qestimates")

test_that("proper functioning", {

              set.seed(1234)
              x <- rlnorm(1000)
              dl <- quantile(x,p=.4)
              x.dl <- ifelse(x>dl,x,-1*dl)
              res <- qestimates(x,p=.5)

              expect_equal(res$result$bs.mean,1,tol=.05)
              expect_equal(res$result$fit.qnorm,1,tol=.05)
              expect_equal(res$result$fcens.qnorm,1,tol=.05)

              resdl <- qestimates(x.dl,p=.5)

              expect_equal(resdl$result$bs.mean,1,tol=.05)
              # LOQ's result in meanlog>0, hence median(x)>1
              expect_true(resdl$result$fcens.qnorm<resdl$result$fit.qnorm)
              expect_equal(resdl$result$fcens.qnorm,1,tol=.05)

})

