library(dplyr)
#read data | used read.csv2 because the separation between values was a ';'
househ_data3 <- read.csv2("household_power_consumption.txt")

#change Date column to date object
househ_data3$Date <- as.Date(househ_data3$Date, format = "%d/%m/%Y")

#subset desired data. Data from 2007-02-01 and 2007-02-02 and with 
#the specified days of interest(THU,FRI,SAT)
househ_data3 <- househ_data3 %>% filter(Date =="2007-02-01" | 
                                                Date == "2007-02-02")

# Convert dates and times
househ_data3$datetime <- strptime(paste(househ_data3$Date, 
                                        househ_data3$Time), "%Y-%m-%d %H:%M:%S")

#convert the sub_metering_n variables to numeric
househ_data3$Sub_metering_1 <- as.numeric(househ_data3$Sub_metering_1)
househ_data3$Sub_metering_2 <- as.numeric(househ_data3$Sub_metering_2)
househ_data3$Sub_metering_3 <- as.numeric(househ_data3$Sub_metering_3)

#plot the three variables in a single plot
househ_data3$datetime <- as.POSIXct(househ_data3$datetime)
par(mar = c(1,1,1,1))
attach(househ_data3)
plot(Sub_metering_1 ~ datetime, type = "l", col = "red", 
     ylab = "Energy sub metering", main = "Energy sub metering in 2007-02-01 & 2007-02-02")
lines(Sub_metering_2 ~ datetime, col = "blue")
lines(Sub_metering_3 ~ datetime, col = "green")
legend("topright", lty = 1, col = c("red", "blue", "green"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#copy plot to png file
dev.copy(png, file = "plot3.png")
dev.off()
detach(househ_data3)