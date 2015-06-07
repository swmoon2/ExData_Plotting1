# plot4.R
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

## 4. Reconstruct Plot 4 to png
png(filename="plot4.png", width=480, height=480, units="px")
par(mfrow=c(2,2))
### 1.1
with(ds_ext, plot(Time, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
### 1.2
with(ds_ext, plot(Time, Voltage, type="l", xlab="datetime"))
### 2.1
with(ds_ext, {
     plot(Time, Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
     lines(Time, Sub_metering_2, col="red")
     lines(Time, Sub_metering_3, col="blue")
     legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
            col=c("black","red","blue"), lty=1, cex=0.8, box.lwd=0)
})
### 2.2
with(ds_ext, plot(Time, Global_reactive_power, type="l", xlab="datetime"))

dev.off()


