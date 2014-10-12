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

outcome$Date <- as.POSIXct(paste(as.Date(outcome$Date,"%d/%m/%Y"),outcome$Time),"%d/%m/%Y %H:%M:%S")

attach(mtcars)
par(mfrow = c(2, 2))
with(outcome, {
  plot(Date,Global_active_power, type = "l")
  plot(Date, Voltage,  xlab="Datetime", ylab="Voltage", type = "l")
  plot(outcome$Date, outcome$Sub_metering_1, xlab="", ylab="Energy sub metering", type = "l")
  lines(outcome$Date, outcome$Sub_metering_2,col="red")
  lines(outcome$Date, outcome$Sub_metering_3,col="blue")
  legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black","red","blue"),lty = 1)
  plot(Date, Global_reactive_power,  xlab="Datetime", type = "l")
  
})
dev.copy(png, file='plot4.png')
dev.off()