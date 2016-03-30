#week 1 Sampling

#pre-lab
survey<-read.csv("StudentSurvey.csv", sep=",",na.strings="?", header=T,  stringsAsFactors=FALSE)
str(survey)

library(dplyr)

#number of variables
ncol(survey)
#number of rows
nrow(survey)

#or use dimension function
dim(survey)

#number of distinct values
n_distinct(survey$name_letters)

#1b) How many of the first 10 students in the dataset had names longer than 5 letters?
first10<-slice(survey, 1:10)
morethan5<-filter(first10, name_letters > 5)
nrow(morethan5)

#1c) How long is the name of the first student in the dataset who is happy less than 40% of the time?
happystud<-filter(survey, happy < 40 )
slice(happystud, 1)

#comprehension check
zscore2<-(77-74)/13
round(1-pnorm(zscore2), digits = 3)

#Primary Research Question

#How many letters long is the typical UT student’s name?  How does our estimate change as we increase the size of our sample?

# Calculate the population parameters
hist(survey$name_letters)
fivenum(survey$name_letters)
mean(survey$name_letters)
sd(survey$name_letters)

# Draw 1,000 samples of n=5 and find the mean of each sample.
xbar5 <-rep(NA, 1000)
for (i in 1:1000)
{x <-sample(survey$name_letters, size =5)
xbar5[i] <-  mean(x)}

# Graph the histogram of 1,000 sample means.
hist(xbar5,xlim=c(2,10))

# Calculate the mean and sd of the sampling distribution.
mean(xbar5)
sd(xbar5)

# Compare to the std dev predicted by the CTL.
sd(survey$name_letters)/sqrt(5)

#Repeat for samples of size n=15
xbar15 <-rep(NA, 1000)
for (i in 1:1000)
{x <-sample(survey$name_letters, size =15)
xbar15[i] <- mean(x)}
hist(xbar15,xlim=c(2,10))
mean(xbar15)
sd(xbar15)
sd(survey$name_letters)/sqrt(15)

#Repeat for samples of size n=25
xbar25 <-rep(NA, 1000)
for (i in 1:1000)
{x <-sample(survey$name_letters, size =25)
xbar25[i] <- mean(x)}
hist(xbar25,xlim=c(2,10))
mean(xbar25)
sd(xbar25)
sd(survey$name_letters)/sqrt(25)

#1a) What is x?
# x is a sample of 5 data values drawn from the population

#1b) What is mean(x)?
# It is the mean of the 5 data points drawn in each sample. 

#1c) When the loop is in the 200th iteration (i=200), what will the following code be doing:

xbar5[i] <- mean(x)
# Calculating the mean of the 200th sample, and placing it in the 200th position of xbar5 vector. 

#2) The standard deviation of a sampling distribution is called a "standard error." What goes in the denominator of this equation to solve for standard error (SE)?
#√n

#3) We used the following code to try to show the sampling distribution of ages:
xbar5 <-rep(NA, 1000)
for (i in 1:1000)
{x <-sample(survey$age, size =5)
xbar5[i] <- mean(x)}
hist(xbar5,xlim=c(2,10))
#The scale of the x-axis is set from 2 to 10, but the ages are not in this range. 

#Population Parameters

#1a) What is the average name length, in number of letters, for all of the students in the population? (Round to 2 decimal places.)
round(mean(survey$name_letters), digits = 2)

#1b) By how many letters, on average, do names vary from the mean? (Round to 2 decimal places.)
round(sd(survey$name_letters), digits = 2)

#Observing the Sampling Distributions
mean(xbar5)
mean(xbar15)
mean(xbar25)

#3b) The size of the standard error ________ as the sample size increased from 5 to 25.
#decreased

#According to the Central Limit Theorem:

#4a) What is the mean of the sampling distribution (for n=5, 15, or 25)? (Round to 2 decimal places)
round((mean(xbar5) + mean(xbar15) + mean(xbar25))/3, digits = 2)

#4b) What is the standard error of the sampling distribution 
round(sd(survey$name_letters)/sqrt(5), digits = 3)
round(sd(survey$name_letters)/sqrt(15), digits = 3)
round(sd(survey$name_letters)/sqrt(25), digits = 3)

#Write Your Conclusion

"""In this lab, we knew the average name length for our population of college students. The population mean was   
5.97 - This answer is correct. 5.97 letters and the standard deviation was   
1.49 - This answer is correct. 1.49 . The name lengths were   
Normally distributed - This answer is correct. Normally distributed . 

We drew samples of different sizes from our population to simulate the Central Limit Theorem. In short, the CLT says three things:
        
1. As sample size increases, sampling distributions become more  
Normal - This answer is correct. Normal .
2. The mean of the sampling distribution will be the  
population mean - This answer is correct. population mean . 
3. The variability of the sample means can be predicted by dividing the population   
standard deviation - This answer is correct. standard deviation by the square root of   
the sample size - This answer is correct. the sample size .

Our simulation results were consistent with this theory. As we increased the size of our sample from 5 to 25, the sample means become  
less - This answer is correct. less variable and tended to cluster   
more tightly - This answer is correct. more tightly around the true mean . In other words, our sample means became  
better - This answer is correct. better estimators of the true population mean.
"""

#The variability of the sample means can be
#predicted by dividing the population standard
#deviation by the square root of the sample size.

"1.  The average resting pulse of adult women is about 74 beats per minute. The standard deviation in the population is believed to be 13 beats per minute. The distribution of resting pulse rates is known to be skewed right."
#1c. How much variation should we expect in sample means given a sample size of 36? In other words, what is the value of the standard error?
13/sqrt(36)

#1d. What is the z-score of our sample mean of 77 in the sampling distribution given sample sizes of 36? (Round to 2 decimal places.)
77-73
round(4/13, digits = 2)


#Lab 1: UT Student Survey Data
# Calculate the population parameters
hist(survey$happy)
fivenum(survey$happy)
mean(survey$happy)
sd(survey$happy)
round(sd(survey$happy), digits = 1)

#3. Draw 1,000 samples of size n=5 from the population data.  Calculate the mean of each sample. 
happy5 <-rep(NA, 1000)
for (i in 1:1000)
{x <-sample(survey$happy, size =5)
happy5[i] <-  mean(x)}

# Graph the histogram of 1,000 sample means.
hist(happy5)

# Calculate the mean and sd of the sampling distribution.
mean(happy5)
sd(happy5)

# Compare to the std dev predicted by the CTL.
sd(survey$happy)/sqrt(5)

#n=15
happy15 <-rep(NA, 1000)
for (i in 1:1000)
{x <-sample(survey$happy, size =15)
happy15[i] <-  mean(x)}

# Graph the histogram of 1,000 sample means.
hist(happy15)

# Calculate the mean and sd of the sampling distribution.
mean(happy15)
sd(happy15)

# Compare to the std dev predicted by the CTL.
sd(survey$happy)/sqrt(15)

#n=25
happy25 <-rep(NA, 1000)
for (i in 1:1000)
{x <-sample(survey$happy, size =25)
happy25[i] <-  mean(x)}

# Graph the histogram of 1,000 sample means.
hist(happy25)

# Calculate the mean and sd of the sampling distribution.
mean(happy25)
sd(happy25)

# Compare to the std dev predicted by the CTL.
sd(survey$happy)/sqrt(25)

#2a) The mean was ________ for all three sampling distributions.
m5<-round(mean(happy5), digits = 2)
m15<-round(mean(happy15), digits = 2)
m25<-round(mean(happy25), digits = 2)

#2b) The sample error (SE) ________ as sample size increased.
sd(happy5)
sd(happy15)
sd(happy25)

#2c) The distributions became _______ as sample size increased.
par(mfrow=c(1,3))
hist(happy5)
hist(happy15)
hist(happy25)

#http://www.statmethods.net/graphs/density.html
par(mfrow=c(3,1))
dph5<-density(happy5)
plot(dp, main="Happy5")
polygon(dp, col="red", border="blue")
abline(v=m5, col="black", lwd=2)
text(x=90,y=.05, m5, pos=4, col="black", font=2)

dph15<-density(happy15)
plot(dph15, main="Happy15")
polygon(dph15, col="green", border="blue")
abline(v=m15, col="black", lwd=2)
text(x=87,y=.05, m15, pos=4, col="black", font=2)

dph25<-density(happy25)
plot(dph25, main="Happy25")
polygon(dph25, col="yellow", border="blue")
abline(v=m25, col="black", lwd=2)
text(x=85,y=.08, m25, pos=4, col="black", font=2)

"""If you have data frames with more columns using of ggplot2 package is my preferred option:
ggplot (data, aes (x = colname)) + geom_vline(xintercept=mean(data$colname), color="red")
Colname is column in your data.frame for which you would like to plot the histogram and mean."""

#3a) According to the Central Limit Theorem, what do we expect the mean to be for each sampling distribution (n=5, n=15 and n=25)? (round to 2 decimal places)
round(mean(survey$happy), digits = 2)

#3b) According to the Central Limit Theorem, what should be the standard error for the sampling distribution of n=5? (round to 2 decimal places).
round(sd(survey$happy)/sqrt(5), digits = 2)

#3c) According to the Central Limit Theorem, what should be the standard error for the sampling distribution of n=15? (round to 2 decimal places).
round(sd(survey$happy)/sqrt(15), digits = 2)

#3d) According to the Central Limit Theorem, what should be the standard error for the sampling distribution of n=25? (round to 2 decimal places).
round(sd(survey$happy)/sqrt(25), digits = 2)

"""Answer the question and support your answer with statistics:

In this lab, we knew the average percentage of the time college students are happy for our population of college students. The population mean was   
78.03 - This answer is correct.  % and the standard deviation was   
16.31 - This answer is correct.  %. The happiness scores were   
negatively skewed - This answer is correct.  .

We drew samples of different sizes from our population to simulate the Central Limit Theorem. In short, the CLT says three things:

1. As sample size   
increases - This answer is correct.  , sampling distributions become more Normal.
2. The mean of the   
sampling distribution - This answer is correct.  will be the population mean.
3. The variability of the sample means, or the  
standard error - This answer is correct.  , can be predicted by dividing the population standard deviation by the square root of the sample size.

Our simulation results   
were - This answer is correct.  consistent with this theory. As we increased the size of our sample from 5 to 25, the sample means become less variable and tended to cluster more tightly around the true mean. In other words, our sample means became  
better estimators of - This answer is correct.  the true population mean. In addition, the shape of the distribution became more   
Normal - This answer is correct.  as sample size increased."""

#Problem Set: Question 1
#1a. Create a histogram of the "austin" variable for the entire population of students that took the survey. Which best describes the shape of the distribution?
hist(survey$austin)

#1b. What is the population mean for the "austin" variable? (Round to 2 decimal places.)
round(mean(survey$austin), digits = 2)

#1c. What is the population standard deviation for the "austin" variable? (Report to 2 decimal places.)
round(sd(survey$austin), digits = 2)

#1d. Use the Central Limit Theorem to predict the mean and standard deviation of the sampling distribution of means for samples of size n=10 drawn from this population: 
austin10 <-rep(NA, 1000)
for (i in 1:1000)
{x <-sample(survey$austin, size =10)
austin10[i] <-  mean(x)}

# Graph the histogram of 1,000 sample means.
hist(austin10)

# Calculate the mean and sd of the sampling distribution.
mean(austin10)
sd(austin10)


#What is the expected standard deviation? (Round to 2 decimal places.)
# Compare to the std dev predicted by the CTL.
round(sd(survey$austin/sqrt(10)), digits = 2)

#What is the expected mean? (Round to 2 decimal places.)
round(mean(survey$austin), digits = 2)


#Question 2
#A population of sunflower plants is described as having a monthly growth rate that follows a normal distribution with μ = 3.08 in and σ = 0.40 in.

#2a. What is the probability that a randomly chosen sunflower plant grows more than 3.2 inches in a month? (Round to 3 decimal places.)
answer: 0.382
zscore<-(3.2-3.08)/.40
round(1-pnorm(zscore), digits = 3)
