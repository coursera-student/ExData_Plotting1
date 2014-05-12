# load the data, reading only dates 2007-02-01 and 2007-02-02
df <- read.table(pipe('egrep \'^Date|^[1-2]/2/2007\' ./Data/household_power_consumption.txt'), 
                 sep=";", 
                 header = T, 
                 na.strings = "?")

# assign proper class to date and time
df$date.time <- paste(df$Date, df$Time)
df$date.time <- strptime(df$date.time, "%d/%m/%Y %H:%M:%S")

#plot1
hist(df$Global_active_power, col="red",
     xlim = range(0:6),
     main = "Global active power",
     xlab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot1.png")
dev.off()