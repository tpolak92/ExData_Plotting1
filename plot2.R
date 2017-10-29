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

#Plot 2.png
plot(x = power$DateTime, y = power$Global_active_power,type = "l", ylab="Global Active Power (kilowatts)",xlab="")

dev.copy(png, file = "plot2.png")  ## Copy my plot to a PNG file 
dev.off() 