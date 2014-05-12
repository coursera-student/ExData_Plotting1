# load the data, reading only dates 2007-02-01 and 2007-02-02
df <- read.table(pipe('egrep \'^Date|^[1-2]/2/2007\' ./Data/household_power_consumption.txt'), 
                 sep=";", 
                 header = T, 
                 na.strings = "?")

# assign proper class to date and time
df$date.time <- paste(df$Date, df$Time)
df$date.time <- strptime(df$date.time, "%d/%m/%Y %H:%M:%S")


#plot4
par(mfrow = c(2, 2))
# 1
plot(df.subs$date.time, df.subs$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")
#2
plot(df.subs$date.time, df.subs$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

#3
plot(df.subs$date.time, df.subs$Sub_metering_1, 
     xlab = "",
     ylab = "Energy sub metering",
     type = "n")
lines(df.subs$date.time, df.subs$Sub_metering_1)
lines(df.subs$date.time, df.subs$Sub_metering_2, lwd = 2, col = "red")
lines(df.subs$date.time, df.subs$Sub_metering_3,lwd = 1.5, col = "blue")
legend("topright", lwd = 2, col = c("black", "red", "blue"), bty = "n", 
       legend = c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#4
plot(df.subs$date.time, df.subs$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.copy(png, file = "plot4.png")
dev.off()
