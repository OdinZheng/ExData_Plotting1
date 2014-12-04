fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "Electric_power_consumption.zip")

# Method 2 for reading data: read.table
hpc_data <- read.table(unz("Electric_power_consumption.zip", "household_power_consumption.txt"), 
           header = TRUE, sep = ";",stringsAsFactors = FALSE)
# subset the data
hpc_data_sub <- hpc_data[hpc_data$Date %in% c("1/2/2007", "2/2/2007"), ]

# Concatenate the date and time, and convert the characters to time
# Alternatively, use mutate in dplyr package
hpc_data_sub$dateTime = paste(hpc_data_sub$Date, hpc_data_sub$Time)
hpc_data_sub$dateTime <- strptime(hpc_data_sub$dateTime, "%d/%m/%Y %H:%M:%S")
# Convert to English labels
Sys.setlocale(,"C")
png("plot2.png", width=480, height=480, units="px")
plot(hpc_data_sub$dateTime, as.numeric(hpc_data_sub$Global_active_power), type = 'l',xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
