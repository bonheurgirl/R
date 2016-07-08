bookings <- read.csv("~/Documents/R/bookings.csv")
View(bookings)
library(dplyr)

confirmed<-count(bookings$request.id)

distinct(bookings)


library(sqldf)
