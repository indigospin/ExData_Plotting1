# Import and subset the data

powerdata <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, sep = ";", header = TRUE)
powerdata[powerdata == "?"] <- NA
powerdata$Time <- strptime(paste(powerdata$Date, powerdata$Time), "%d/%m/%Y %H:%M:%S")
powerdata$Date <- as.Date(powerdata$Date, "%d/%m/%Y")
powerdata2day <- subset(powerdata, Date == "2007-02-01" | Date == "2007-02-02")
rm(powerdata)
powerdata2day[,3:9] <- sapply(powerdata2day[,3:9], as.numeric)

# Generate the plot and export to file

png(filename = "plot4.png")

par(mfrow = c(2,2))

with(powerdata2day, plot(Time, Global_active_power, xlab = "", ylab = "Global Active Power", type = "n"))
with(powerdata2day, lines(Time, Global_active_power))

with(powerdata2day, plot(Time, Voltage, xlab = "datetime", ylab = "Voltage", type = "n"))
with(powerdata2day, lines(Time, Voltage))

with(powerdata2day, plot(Time, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
with(powerdata2day, lines(Time, Sub_metering_1))
with(powerdata2day, lines(Time, Sub_metering_2, col = "red"))
with(powerdata2day, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue") , lty = 1, bty = "n")

with(powerdata2day, plot(Time, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "n"))
with(powerdata2day, lines(Time, Global_reactive_power))

dev.off()