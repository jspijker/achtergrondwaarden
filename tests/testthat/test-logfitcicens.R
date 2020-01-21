context("logfitcicens")

test_that("proper functioning", {
              set.seed(1234)

              t1 <- rlnorm(1000)
              dl <- quantile(t1,p=.70)
              t1s <- ifelse(t1>dl,t1,-1*dl)

              t1f <- logfitcicens(t1s,p=.5)
              expect_equal(t1f$result$meanlog,0,tol=.1)
              expect_equal(t1f$result$sdlog,1,tol=.05)
              expect_true(t1f$result$lci<1)
              expect_true(t1f$result$uci>1)
              expect_true(t1f$result$lci<t1f$result$uci)

})

