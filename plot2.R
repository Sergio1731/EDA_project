library(dplyr)
#read data | used read.csv2 because the separation between values was a ';'
househ_data2 <- read.csv2("household_power_consumption.txt")

#change Date column to date object
househ_data2$Date <- as.Date(househ_data2$Date, format = "%d/%m/%Y")

#subset desired data. Data from 2007-02-01 and 2007-02-02 and with 
#the specified days of interest(THU,FRI,SAT)
househ_data2 <- househ_data2 %>% filter(Date =="2007-02-01" | 
                                          Date == "2007-02-02")

# Convert dates and times
househ_data2$datetime <- strptime(paste(househ_data2$Date, 
                                househ_data2$Time), "%Y-%m-%d %H:%M:%S")

#convert the global active power column to numeric
househ_data2[,3] <- as.numeric(househ_data2[,3])

#line plot with global active power variable power in y and day in x
househ_data2$datetime <- as.POSIXct(househ_data2$datetime)
attach(househ_data2)
plot(Global_active_power ~ datetime, type = "l")

#copy plot to png file
dev.copy(png, file = "plot2.png")
dev.off()
detach(househ_data2)
