---
output: html_document
---
Are visitors more likely to convert when they engage by viewing more pages within our site?
========================================================
author: Anita Owens
date: April 2016

Let's access our data in Google Analytics and export it as a spreadsheet.
========================================================


E-commerce data exported from Google Analytics
========================================================


```r
library(xlsx)
library(ggplot2)
gd<-read.xlsx("gd.xlsx", sheetIndex=1, header=TRUE, colClasses=NA)
str(gd)
```

```
'data.frame':	10 obs. of  12 variables:
 $ source.medium    : Factor w/ 10 levels "bing / organic",..: 6 3 9 4 8 2 1 10 5 7
 $ sessions         : num  44069 17323 4895 1848 1595 ...
 $ per.new.sessions : num  0.549 0.653 0.807 0.477 0.681 ...
 $ new.users        : num  24170 11293 3948 881 1086 ...
 $ bounce.rate      : num  0.333 0.549 0.803 0.602 0.871 ...
 $ pages.session    : num  5.54 4.2 1.62 3.96 1.25 ...
 $ avg.sess.dur     : num  227.2 158.8 50.1 228.9 37 ...
 $ convert.rate     : num  0.062604 0.041568 0.004904 0.017316 0.000627 ...
 $ trans            : num  2755 721 24 32 1 ...
 $ revenue          : num  2084842 1095998 8045 96012 292 ...
 $ avg.order        : num  757 1520 335 3000 292 ...
 $ per.session.value: num  47.31 63.27 1.64 51.95 0.18 ...
```

Conversion rate based on the number of pages per session with 95% confidence interval.
========================================================

![plot of chunk unnamed-chunk-2](GoogleAnalyticsData-figure/unnamed-chunk-2-1.png) 
What is the strength of the relationship between number of pages viewed per session and conversion rate? (correlation coefficient)
========================================================

```r
cor(gd$pages.session,gd$convert.rate)
```

```
[1] 0.9562102
```

```r
#If |r| is between 0.85 and 1, there is a strong correlation.
#There is a linear & strong relationship between pages viewed per session and the conversion rate.
```
How much of the conversion rate can be explained by number of pages viewed per session? (coefficient of determination)
========================================================

```r
#linear model
convertlm<-lm(pages.session ~ convert.rate, data=gd)
summary(convertlm)$r.squared 
```

```
[1] 0.914338
```

```r
#91% of the conversion rate can be explained by the number of pages viewed per session.
```
Insights & Recommendations
========================================================
- There is a strong relationship between pages viewed per session and the conversion rate.

- We need to focus on ensuring high-quality relevant content on our blog (more "how to" videos and promotions of our new products)

- Encourage our customers to leave reviews for products they have purchased before. (this can be automated with drip emails)
