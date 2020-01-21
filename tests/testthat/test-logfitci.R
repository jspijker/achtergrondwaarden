context("logfitci")

test_that("proper functioning", {

              t1 <- rlnorm(1000)
              t1f <- logfitci(t1,p=.5)
              t1f

              expect_equal(t1f$result$meanlog,0,tol=.1)
              expect_equal(t1f$result$sdlog,1,tol=.05)
              expect_true(t1f$result$lci<1)
              expect_true(t1f$result$uci>1)
              expect_true(t1f$result$lci<t1f$result$uci)

})

