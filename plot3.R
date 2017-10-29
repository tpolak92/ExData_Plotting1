library(tidyverse)
library(lubridate)

headers <- read.table('./household_power_consumption.txt',nrows=1,sep=";",header=TRUE)

firstRowToRead <- min(grep("^1/2/2007", readLines("./household_power_consumption.txt")))
rowsToRead <- max(grep("^2/2/2007", readLines("./household_power_consumption.txt"))) - firstRowToRead


power <- read.table('./household_power_consumption.txt',
                    skip = firstRowToRead,
                    nrows= rowsToRead, 
                    sep=";",
                    col.names = names(read.table('./household_power_consumption.txt',nrows=1,sep=";",header=TRUE))) %>%
  mutate(
    Date = as.Date(Date,"%d/%m/%Y"),
    DoW = wday(Date),
    DateTime = as.POSIXct( paste(Date,Time),format="%Y-%m-%d %H:%M:%S")
  )

#Plot 3.png
plot(x = power$DateTime, y = power$Sub_metering_1,type = "l", ylab="Energy sub metering",xlab="")
points(x = power$DateTime, y = power$Sub_metering_2,type = "l", ylab="Energy sub metering",xlab="", col = "red")
points(x = power$DateTime, y = power$Sub_metering_3,type = "l", ylab="Energy sub metering",xlab="", col = "blue")
legend("topright", pch = "l", col = c("black","red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(png, file = "plot3.png")  ## Copy my plot to a PNG file 
dev.off() 