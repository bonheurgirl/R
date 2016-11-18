#dplyr

countries <- read.csv("~/Documents/R/countries.csv", sep=",")
library(dplyr)
count(countries, Countries)
x<-as.vector(countries$Countries)
n_distinct(x)
