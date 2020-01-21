context("replacelt")

test_that("propor functioning",{

              x<-c("<1","< 2"," < 3 ")
              x.repl <- replacelt(x)
              x.expect <- c("-1","-2","-3")
              expect_equal(x.repl,x.expect)
})
