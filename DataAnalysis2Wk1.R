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
