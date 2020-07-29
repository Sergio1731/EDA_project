library(dplyr)
#read data | used read.csv2 because the separation between values was a ';'
househ_data4 <- read.csv2("household_power_consumption.txt")

#change Date column to date object
househ_data4$Date <- as.Date(househ_data4$Date, format = "%d/%m/%Y")

#subset desired data. Data from 2007-02-01 and 2007-02-02 and with 
#the specified days of interest(THU,FRI,SAT)
househ_data4 <- househ_data4 %>% filter(Date =="2007-02-01" | 
                                                Date == "2007-02-02")

# Convert dates and times
househ_data4$datetime <- strptime(paste(househ_data4$Date, 
                                        househ_data4$Time), "%Y-%m-%d %H:%M:%S")

#convert the sub_metering_n variables to numeric
househ_data4$Sub_metering_1 <- as.numeric(househ_data4$Sub_metering_1)
househ_data4$Sub_metering_2 <- as.numeric(househ_data4$Sub_metering_2)
househ_data4$Sub_metering_3 <- as.numeric(househ_data4$Sub_metering_3)


househ_data4$datetime <- as.POSIXct(househ_data4$datetime)
#set the window to put multiple plots in it
par(mfrow = c(2,2), mar = c(1,1,1,1))
#start putting the plots in the window
attach(househ_data4)
#top left plot
plot(Global_active_power ~ datetime, type = "l")
#top right plot
plot(Voltage ~ datetime, type = "l")
#bottom left plot
plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Energy sub metering", 
     col = "red")
lines(Sub_metering_2 ~ datetime, col = "blue")
lines(Sub_metering_3 ~ datetime, col = "green")
legend("topright", lty = 1, col = c("red", "blue", "green"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#bottom right plot
plot(Global_reactive_power ~ datetime, type = "l")

#copy plots to png file
dev.copy(png, file = "plot4.png")
dev.off()
detach(househ_data4)