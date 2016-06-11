#sleepdata

str(sleepdata)
dim(sleepdata)
summary(sleepdata)

library(plyr)
count(sleepdata, "bedTime")

# 2-Way Frequency Table 
attach(frequencyChart)
mytable <- table(frequencyChart$Day, frequencyChart$X8pm) # A will be rows, B will be columns 
mytable # print table 
