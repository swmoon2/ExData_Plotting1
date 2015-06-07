# plot2.R
## 1. Download and read data from remote zip file
temp <- tempfile()
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, temp, method="curl")
ds_all <- read.table(unz(temp, "household_power_consumption.txt"), 
                     header=TRUE, sep=";", stringsAsFactors=FALSE,
                     na.strings="?", numerals="no.loss")
unlink(temp)
## 2. Convert Date and Time column 
ds_all$Time <- strptime(paste(ds_all$Date, ds_all$Time), "%d/%m/%Y %H:%M:%S")
ds_all$Date <- as.Date(ds_all$Date, "%d/%m/%Y")

## 3. Extract data from the dates 2007-02-01 and 2007-02-02
fromDate <- as.Date("2007-02-01")
toDate <- as.Date("2007-02-02")
ds_ext <- subset(ds_all, Date >= fromDate & Date <= toDate)
rm(ds_all)

## 4. Reconstruct Plot 2 to png
png(filename="plot2.png", width=480, height=480, units="px")
with(ds_ext, 
     plot(Time, Global_active_power, type="l",
          xlab="", ylab="Global Active Power (kilowatts)")
)
dev.off()


