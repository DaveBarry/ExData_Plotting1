setwd("K:/Documents/RCode/EDA")

## Read data
cur<-read.csv2("household_power_consumption.txt", header=TRUE, sep=";",dec=".",na.strings = "?")

## convert Date
cur[, 1] <- as.Date(cur[, 1],format="%d/%m/%Y")

## convert Time 
library(chron)
cur$Time <- times(cur$Time)


outcome1<-subset(cur, cur$Date=="2007-02-01",drop=TRUE)
outcome2<-subset(cur, cur$Date=="2007-02-02",drop=TRUE)

#Join the data into one data frame "outcome"
outcome <- rbind(outcome1,outcome2)
res<-na.omit(outcome)

hist(outcome$Global_active_power,main='Global Active Power',xlab='Global Active Power (kilowatts)',ylab='Frequency',col = 'red')
dev.copy(png, file='plot1.png')
dev.off()