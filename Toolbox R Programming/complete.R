specdata<-list.files("specdata", full.names=TRUE)

pollutantmean<-function(directory, pollutant, id) {
    dat <- data.frame()
    for (i in id) {
        dat <- rbind(dat, read.csv(specdata[i]))
    }
    newdata<-dat[c(2:3)]
    format(mean(newdata [[pollutant]], na.rm = TRUE),digits=4)
    
}

pollutantmean("specdata", "sulfate", 1:10)

pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used

        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)
        ## NOTE: Do not round the result!
}


specdata<-list.files("specdata", full.names=TRUE)
complete <- function(directory, id = 1:332) {
	dat <- data.frame()
	for (i in id) {
        dat <- rbind(dat, read.csv(specdata[i]))
    }
    	newdata<-dat[ which(dat$nitrate>=0 & dat$sulfate>=0),]
    	sum(ID, (newdata[[nobs]]))
    }
   
specdata<-list.files("specdata", full.names=TRUE)
complete <- function(directory, id) {
	dat <- data.frame()
	newdf<-data.frame()
	for (i in id) {
        dat <- rbind(dat, read.csv(specdata[i]))
    }
    newdf<-sum(dat[complete.cases(dat),])
    print (newdf)
       }


specdata<-list.files("specdata", full.names=TRUE)
complete <- function(directory, id) {
	dat <- data.frame()
	for (i in id) {
        dat <- rbind(dat, read.csv(specdata[i]))
        subdf<-subset(dat, sulfate>= 0 & nitrate>=0)
        }##View(subdf)
       return 
  }
    
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases

        #sum(as.numeric(complete.cases(airquality)))



complete("specdata", 1)
##   id nobs
## 1  1  117
complete("specdata", c(2, 4, 8, 10, 12))
##   id nobs
## 1  2 1041
## 2  4  474
## 3  8  192
## 4 10  148
## 5 12   96
complete("specdata", 30:25)
##   id nobs
## 1 30  932
## 2 29  711
## 3 28  475
## 4 27  338
## 5 26  586
## 6 25  463
complete("specdata", 3)
##   id nobs
## 1  3  243


add2<-function(x,y){
	sum(x + y)
}

sum3<-function(x,y,z){
	sum(x,y,z)
}

meanofwhatever<-function(x,...){
	mean(x,...)
}

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)

rankhospital <- function(state, outcome, num = "best") {
	read.csv("outcome.csv",header=T,sep",")
## Check that state and outcome are valid
## Return hospital name in that state with the given rank
## 30-day death rate
}
best <- function(state, outcome) {
	read.csv("outcome.csv",header=T,sep",")
## Check that state and outcome are valid
## Return hospital name in that state with lowest 30-day death
## rate
}


Data=sample2#did not put in console
> sum(as.numeric(complete.cases(sample2)))
[1] 1041
#sums all the rows that have completed data in each column

read.csv("sample1.csv",header=T,sep",")
read.csv("sample2.csv",header=T,sep=",")
combined_samples<-rbind(sample1,sample2)#combined files 1 & 2
combined_samples2<-na.omit(rbind(sample1,sample2))
sum(as.numeric(complete.cases(combined_samples2)))


contains_letter<-function(word){
	if ( word == grep("s"){
		return ("yes")
	}
	else
	}
	return("no")
}
