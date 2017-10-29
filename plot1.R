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

#Plot 1 .png
hist(power$Global_active_power, freq = TRUE, main = "Global Active Power", col= "Red",breaks = 12)

dev.copy(png, file = "plot1.png")  ## Copy my plot to a PNG file 
dev.off() 