# load the data, reading only dates 2007-02-01 and 2007-02-02
df <- read.table(pipe('egrep \'^Date|^[1-2]/2/2007\' ./Data/household_power_consumption.txt'), 
                 sep=";", 
                 header = T, 
                 na.strings = "?")

# assign proper class to date and time
df$date.time <- paste(df$Date, df$Time)
df$date.time <- strptime(df$date.time, "%d/%m/%Y %H:%M:%S")

#plot3
plot(df.subs$date.time, df.subs$Sub_metering_1, 
     xlab = "",
     ylab = "Energy sub metering",
     type = "n")
lines(df.subs$date.time, df.subs$Sub_metering_1)
lines(df.subs$date.time, df.subs$Sub_metering_2, lwd = 2, col = "red")
lines(df.subs$date.time, df.subs$Sub_metering_3,lwd = 1.5, col = "blue")
legend("topright", lwd = 2, col = c("black", "red", "blue"), 
       legend = c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png")
dev.off()

