context("replaceNegative")

test_that("proper functioning",{

              x<-c(-1,-2,3)
              x.repl <- replaceNegative(x)
              x.expect <- c(NA,NA,3)
              expect_equal(x.repl,x.expect)

              x.repl <- replaceNegative(x,replaceval=0)
              x.expect <- c(0,0,3)
              expect_equal(x.repl,x.expect)

              x.repl <- replaceNegative(x,replaceval=0.5)
              x.expect <- c(0.5,1,3)
              expect_equal(x.repl,x.expect)
})
