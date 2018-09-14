# Import and subset the data

powerdata <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, sep = ";", header = TRUE)
powerdata[powerdata == "?"] <- NA
powerdata$Time <- strptime(paste(powerdata$Date, powerdata$Time), "%d/%m/%Y %H:%M:%S")
powerdata$Date <- as.Date(powerdata$Date, "%d/%m/%Y")
powerdata2day <- subset(powerdata, Date == "2007-02-01" | Date == "2007-02-02")
rm(powerdata)
powerdata2day[,3:9] <- sapply(powerdata2day[,3:9], as.numeric)

# Generate the plot and export to file

png(filename = "plot1.png")
with(powerdata2day, hist(Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power"))
dev.off()