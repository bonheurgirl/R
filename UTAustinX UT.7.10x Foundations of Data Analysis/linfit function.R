#linfit function script

linFit <- function (x, y, sub.title = NULL, xlab = deparse(substitute(x)), 
                    ylab = deparse(substitute(y))) 
{
        y1 <- as.numeric(y)
        x1 <- as.numeric(x)
        lin_model <- summary(lm(y1 ~ x1))
        b0 <- lin_model$coef[1]
        b1 <- lin_model$coef[2]
        r2 <- lin_model$r.squared
        plot(x1, y1, main = "Linear", pch = 16, xlab = xlab, ylab = ylab)
        abline(lm(y1 ~ x1))
        mtext(sub.title, 3)
        lin.out <- list(Intercept = b0, Slope = b1, r_sq = r2)
        cat("Linear Fit", "\n", "Intercept = ", round(b0, 5), "\n", 
            "Slope = ", round(b1, 5), "\n", "R-squared = ", round(r2, 
                                                                  5))
        return(invisible(lin.out))
}