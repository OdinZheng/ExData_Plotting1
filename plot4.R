fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "Electric_power_consumption.zip")

# Method 3 for reading data: read.table / a dirty trick to speed up the reading
hpc_data <- read.table(unz("Electric_power_consumption.zip", "household_power_consumption.txt"), 
                       header = TRUE, sep = ";",stringsAsFactors = FALSE, na.strings = "?", nrows = 5)
classes <- sapply(hpc_data, class)
hpc_data <- read.table(unz("Electric_power_consumption.zip", "household_power_consumption.txt"), 
                       header = TRUE, sep = ";",stringsAsFactors = FALSE,  na.strings = "?", colClasses = classes)



# subset the data
hpc_data_sub <- hpc_data[hpc_data$Date %in% c("1/2/2007", "2/2/2007"), ]

# Concatenate the date and time, and convert the characters to time
hpc_data_sub$dateTime = paste(hpc_data_sub$Date, hpc_data_sub$Time)
hpc_data_sub$dateTime <- strptime(hpc_data_sub$dateTime, "%d/%m/%Y %H:%M:%S")

# Convert to English labels for plot
Sys.setlocale(,"C")
attach(hpc_data_sub)

png("plot4.png", width=480, height=480, units="px")

par(mfcol = c(2,2))
plot(hpc_data_sub$dateTime, Global_active_power, type = 'l',xlab="", ylab="Global Active Power")
plot(dateTime, Sub_metering_1, type = 'l',xlab="", ylab="Energy sub metering")
lines(dateTime, Sub_metering_2,type = 'l', col = "red")
lines(dateTime, Sub_metering_3,type = 'l', col = "blue")
legend("topright", lty = 1, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(dateTime, Voltage, type = 'l', xlab="datetime")
plot(dateTime, Global_reactive_power, type = 'l', xlab="datetime")

dev.off()