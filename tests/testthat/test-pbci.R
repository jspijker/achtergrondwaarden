context("pbci")


test_that("valid return",{
              set.seed(1234)
              res1 <- pbci(rnorm(10000),p=.5)
              expect_equal(0,res1$result$original,tolerance=.05)
              expect_equal(res1$result$mean,res1$result$original,tolerance=.01)
              expect_true(res1$result$lci<0)
              expect_true(res1$result$uci>0)
})



