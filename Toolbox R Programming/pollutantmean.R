specdata<-list.files("specdata", full.names=TRUE)

pollutantmean<-function(directory, pollutant, id=1:332) {
    dat <- data.frame()
    for (i in id) {
        dat <- rbind(dat, read.csv(specdata[i]))
    }
    newdata<-dat[c(2:3)]
    format(mean(newdata [[pollutant]], na.rm = TRUE),digits=4)
    
}