library(xlsx)
library(plyr)
library(dplyr)
hiv<-read.xlsx("hiv15-49.xlsx", sheetIndex=1, header=TRUE, colClasses=NA)
dim(hiv)
names(hiv)

#testing rename function
d<-data.frame(alpha=1:3, beta=4:6)
names(d)
d2<-rename(d, anita = alpha )
names(d2)

install.packages("alr3")
install.packages("car")
install.packages("pbkrtest")
library(alr3)


library(ggplot2)
ggplot(alr3, aes(Month, Temp)) + geom_point(aes(color=cyl))
cor.test(Mitchell$Month, Mitchell$Temp)

data("mtcars")
ggplot(mpg, aes(hwy))  + geom_density(kernel = "gaussian")
