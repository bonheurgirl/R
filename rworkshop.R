View(diamonds)
boxplot(price ~ cut, diamonds)
ggplot(diamonds,aes(x = cut, y = price, fill = clarity))+ geom_violin()
str(diamonds)
diamonds[c(1,2,3,4),'clarity']
diamonds$price[diamonds$color =="D"]
diamonds$above_mean<-ifelse(diamonds$price > mean(diamonds$price), T, F)
diamonds$above_mean<-ifelse(diamonds$price > mean(diamonds$price), "hi", "yo")
boxplot(price ~ cut, diamonds)
load("~/Documents/datasciencecoursera/easy_function")
getwd()
setwd("/Users/anitaowens/Documents/datasciencecoursera")
getwd()
qplot(enrollments, x=status)

library(datasets)
data("mtcars")
debug(ls)
ls()
library(datasets)
data("mtcars")
levels(mtcars$cyl)
# mean of the rows
apply(m, 1, mean)
# mean of the columns
apply(m, 2, mean)
#[1]  5.5 15.5
apply(iris[, 1:4], 2, mean)
with(mtcars, tapply(mpg, cyl, mean))
four_cyl<-mtcars[ which(mtcars$cyl==4),]
eight_cyl<-mtcars[ which(mtcars$cyl==8),]
mean(four_cyl$mpg)
mean(eight_cyl$hp)


xlsfile <- file.path(path.package('gdata'),'xls','iris.xls')
iris <- read.xls(xlsfile)
View(iris)

