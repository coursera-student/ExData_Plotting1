# load the data, reading only dates 2007-02-01 and 2007-02-02
df <- read.table(pipe('egrep \'^Date|^[1-2]/2/2007\' ./Data/household_power_consumption.txt'), 
                 sep=";", 
                 header = T, 
                 na.strings = "?")

# assign proper class to date and time
df$date.time <- paste(df$Date, df$Time)
df$date.time <- strptime(df$date.time, "%d/%m/%Y %H:%M:%S")

#plot2
df$week.day <- (df$date.time)$wday  # 0–6 day of the week, starting on Sunday 
df.subs <- subset(df, df$week.day == c(4, 5, 6))

plot(df.subs$date.time, df.subs$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.copy(png, file = "plot2.png")
dev.off()