#old faithful

oldFaithfulData<-read.csv('oldfaithfuldata.csv', header=TRUE, sep=',')
str(oldFaithfulData)


duration=oldFaithfulData$Duration.of.eruption
minutes=oldFaithfulData$Minutes.between.eruptions

library(ggplot2)

#qplot(data=gd, x=pages.session, y=convert.rate, geom="point")

plot(duration, minutes)
abline(lm(minutes ~ duration))

eruptionlm<-lm(minutes ~ duration)
summary(eruptionlm)$r.squared 
# Rsquared=0.8114608

summary(eruptionlm)

http://www.r-tutor.com/elementary-statistics/simple-linear-regression/estimated-simple-regression-equation
http://www.r-tutor.com/elementary-statistics/simple-linear-regression/significance-test-linear-regression

ggplot(data=oldFaithfulData, aes(y=Duration.of.eruption,x=Minutes.between.eruptions))
+ geom_point(shape=16)  # Use round circles
+ geom_smooth(method=lm)# Add linear regression line 
#  (by default includes 95% confidence region)

hist(duration)
hist(minutes)
