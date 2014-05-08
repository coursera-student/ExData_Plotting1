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

#plot2
df$week.day <- (df$date.time)$wday  # 0–6 day of the week, starting on Sunday 
df.subs <- subset(df, df$week.day == c(4, 5, 6))

plot(df.subs$date.time, df.subs$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot2.png")
dev.off()

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
