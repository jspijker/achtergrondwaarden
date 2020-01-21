context("rmoutlier")

test_that("proper functioning",{
             # for a normal distribution MAD=sd
             set.seed(1234) 
             x <- rnorm(1e5)
             maxx <- max(x)
             xtrim <- rmoutlier(x)
             # x should contain NA's and trimmed values
             expect_true(any(is.na(xtrim)))
             expect_true(maxx>max(xtrim,na.rm=TRUE))
             #max x must be smaller than 0 + 3 times MAD
             expect_true(max(xtrim,na.rm=TRUE)<3)

             #try other factor b
             xtrim <- rmoutlier(x,b=2)
             expect_true(max(xtrim,na.rm=TRUE)<2)


})
