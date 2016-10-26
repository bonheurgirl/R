#Statistical Functions

library(help = "datasets")

#Linear Regression
fit<-lm(formula,data)
fit <-lm(weight ~ height, data=women)
summary(fit)
summary(fit)$r.squared 


attach(women)
plot(height, weight, main="Scatterplot")#plot(x,y)
#add fit lines
abline(lm(weight~height), col="red") #regression line (y~x)

#correlation
x<-c(2,2,3,5,6,7,9,14,15,18)
y<-c(2,2,3,5,6,8,9,14,15,18)
cor(x,y)

cor(height,weight)

#2 way frequency table
mytable<-table(x,y)#x will be rows, y will be columns
mytable
margin.table(mytable,1)# x frequencies, summed over y
margin.table(mytable,2) #y frequencies, summed over x

#create a proportion table
prop.table(mytable) # cell percentages
prop.table(mytable, 1) # row percentages 
prop.table(mytable, 2) # column percentages

