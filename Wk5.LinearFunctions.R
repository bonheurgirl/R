#Week 5 Linear Functions--Lecture

#set wd
setwd("/Users/anitaowens/Documents/R")

#read csv
wr<-read.csv("worldrecords.csv")
names(wr)
View(wr)

#subsetting data
mens800<-wr[ which(wr$Event=="Mens 800m"),]
#or
mens800<-wr[wr$Event=='Mens 800m',]

#regression
#does not work--linFit(mens800$Year,mens800$Record)
plot(mens800$Year, mens800$Record, type="p", pch=16, main="Linear Fit", xlab = "Year", ylab = "Mens 800 World Records")

#installed linfit function
linFit(mens800$Year,mens800$Record)

#1a. How many different types of events (e.g. "Mens 100m," "Womens shotput," etc.) are represented in the dataset?
library(dplyr)
count(wr,Event)
#10 events

#1b. In what year did Usain Bolt first break the world record for the men's 100m dash?
mens100<-wr[ which(wr$Event=="Mens 100m"),]
plot(mens100$Year, mens100$Record, type="p", pch=16, main="Mens 100", xlab = "Year", ylab = "Mens 100 World Records")
#2008

#1c. Who was the first woman to break the women’s 1 mile world record with a time of less than 260 seconds?
womenmile<-wr[ which(wr$Event=="Womens Mile" & wr$Record<260),]
#mary slaney


#analysis
#Subset the data
menshot <- wr[wr$Event=='Mens Shotput',]
womenshot <- wr[wr$Event=='Womens Shotput',] 

#Create scatterplots
plot(menshot$Year,menshot$Record,main='Mens Shotput World Records',xlab='Year',ylab='World Record Distance (m)',pch=16)
plot(womenshot$Year,womenshot$Record,main='Womens Shotput World Records',xlab='Year',ylab='World Record Distance (m)',pch=16)

#Run linear models
linFit(menshot$Year, menshot$Record)
linFit(womenshot$Year,womenshot$Record)

#correlation matrix men
vars <-c("Record", "Year")
round(cor(menshot[,vars]), digits = 3)

#correlation matrix women
vars <-c("Record", "Year")
round(cor(womenshot[,vars]), digits = 3)

#What is the equation for the linear model that predicts the World Record shotput distance for women?
#equation: record distance= -440.3 + (.234 * year)
#r2: .962
# distance = intercept + (slope * variable value)

#What is the equation for the linear model that predicts the World Record shotput distance for men?
#equation: record distance= -243.3384 + (.13411 * year)
#r2: .941


#Lab: Primary Research Question
#How have the world record times for the men's and the women’s
#mile event changed over the years?

#1. Create a subset of the data that contains World Record cases for the men’s Mile event.
menmile<-wr[ which(wr$Event=="Mens Mile"),]

#2. Create a subset of the data that contains World Record cases for the women's Mile event. 
womenmile<-wr[ which(wr$Event=="Womens Mile"),]

#3. Create a scatterplot for each relationship of Mile time and year: one for men and one for women. 
plot(menmile$Year,menmile$Record,main='Mens Mile World Records',xlab='Year',ylab='World Record Distance (m)',pch=16)
plot(womenmile$Year,womenmile$Record,main='Womens Mile World Records',xlab='Year',ylab='World Record Distance (m)',pch=16)

#4. Confirm from these plots that a linear model is appropriate. 
linFit(menmile$Year, menmile$Record)
linFit(womenmile$Year,womenmile$Record)

#2. On average, how many seconds do men trim off the world record time in the Mile each year? (Round to three decimal places)
round(-0.39347, digits = 3)
#answer: .393 seconds

#3. On average, how many seconds do women trim off the world record time in the Mile each year? (Round to three decimal places)
round(-0.97288, digits = 3)

#4. How many years would you predict it would take for the men’s mile record to decrease by one full second? Use the model equation to help you answer the question.
1/.393
#answer: 2.5 years

#5. How many years would you predict it would take for the women’s mile record to decrease by one full second? Use the model equation to help you answer the question.
1/0.97288
#answer: 1 year

#6. What proportion of variance in the men's World Record times in the Mile can be explained by year? (Round to three decimal places)
#answer is r squared
round(.97746, digits = 3)

#7. What proportion of the variance in women's World Record times in the Mile can be explained by year? (Round to three decimal places)
round(.89558, digits = 3)

#8. Which of the following is a reasonable conclusion to draw from this analysis?
# World record times in the Mile have decreased linearly over the last several decades for both men and women.

#Based on scatterplots of the men’s and women’s world record mile event, both of these events follow a strong,   
#negative relationship over time. (i.e. downward slope)

#Problem Set
#Question 1
#We want to find the best-fitting linear model for men's pole vault world records since 1970.
count(wr,Event)
menpole<-wr[ which(wr$Event=="Mens Polevault"),]

#1b. In what year did the pole vault record first exceed 6 meters? (Look at the data to find the year.)
over6<-menpole[ which(menpole$Record > 6),]

#1c. Create a scatterplot showing the men's pole vault records since 1970 as a function of year. Fit a linear model to the data.
#Which of the following best describes how the record has changed over time?
menpole1970<-wr[ which(wr$Event=="Mens Polevault" & wr$Year >= 1970),]
plot(menpole1970$Year,menpole1070$Record,main='Mens Pole Vault World Records',xlab='Year',ylab='World Record Distance (m)',pch=16)
linFit(menpole1970$Year, menpole1970$Record)
#answer:  The record pole vault height steadily increases over time. 

#Report the coefficient estimates for the linear model that describes the change in the men's pole vault world record since 1970.
round(-51.8541, digits = 3)

#1e. What is the slope? (Round to 3 decimal places.)
round(0.02911, digits = 3)

#1f. Which of the following best describes how the men's pole vault world record has changed since 1970?
#The record has increased by an average of 0.03 meters per year since 1970.


#Question 2
#The table below shows several points for the function C = f(h),
#where C is the cost (in dollars) for a band of 4 members to play
#at a wedding, based on the number of hours, h, they perform.

cost<-c(140, 280, 420, 560)
hours<-c(0, 2, 4, 6)

#2a. Which variable is the independent variable?
#answer: h

#2b. Identify the y-intercept for this function.
#answer: 140
plot(hours,cost)
linFit(hours,cost)

#2c. How much does the band charge per hour that they perform?
70 #the slope

#2d. If each member of the band earned $175 for the night and profits were split evenly among them, how many hours did the band perform?
175*4
#6 hours equals 560 so (700-560=140)
# answer: 6 hours plus 2 hours


#Question 3

#We have bivariate data on a group of college
#students: the total amount (in dollars) spent
#on textbooks throughout their college career,
#and their GPA. The following linear regression
#model was used to predict GPA from number of
#dollars (in hundreds) spent:
        
        #Predicted GPA = 2.84 + .04*Dollars

#3a. What is the predicted GPA of a student who
#spent a total of $970 on textbooks in college? (Round to 2 decimal places.)
2.84+.04*9.7

#3b. If a student spent $0 on textbooks in
#college and graduated with a GPA of 3.71, 
#what is her residual? (Round to 2 decimal places.)
3.71-2.84
#Answer: .87
#A random pattern of residuals supports a linear model. 

#3c. If a student spent $1,450 on textbooks and 
#graduated with a GPA of 2.91, what is his 
#residual? (Please indicate whether the residual
#is positive or negative in your response, and
#round to 2 decimal places.)

2.84+.04*14.5
#: 3.42
3.42-2.91
answer: -.51