library(dplyr)
#read data | used read.csv2 because the separation between values was a ';'
househ_data <- read.csv2("household_power_consumption.txt")

#change Date column to date object
househ_data[,1] <- as.Date(househ_data[,1], "%d/%m/%Y")

#subset desired data. Data from 2007-02-01 and 2007-02-02
subset1 <- househ_data %>% filter(Date =="2007-02-01" | Date == "2007-02-02")

#convert the global active power column to numeric
subset1[,3] <- as.numeric(subset1[,3])

#plot histogram
plot1 <- hist(subset1[,3], col = "red", main = "Global Active Power",
              xlab = "Global Active Power (kilowatts)")

#save the plot to a png file
dev.copy(png, file = "plot1.png")
dev.off()