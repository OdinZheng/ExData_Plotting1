

fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "/Electric_power_consumption.zip")

# Method 1 for reading data: use dplyr package: tbl_df, filter to subset the data
library(dplyr)
hpc_data <- filter(tbl_df
                   (read.table(unz("Electric_power_consumption.zip", "household_power_consumption.txt"), 
                    header = TRUE, sep = ";",stringsAsFactors = FALSE)),
                    as.Date(Date,"%d/%m/%Y") ==  "2007-02-01" | as.Date(Date,"%d/%m/%Y") ==  "2007-02-02"
           )
# draw png
png("plot1.png", width=480, height=480, units="px")
attach(hpc_data)
hist(as.numeric(Global_active_power),col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()


