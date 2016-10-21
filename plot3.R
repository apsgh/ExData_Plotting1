# Load 'downloader' package
library(downloader)

# Download and save the file in working directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(fileUrl, "assignmentData.zip", mode = "wb")

# Unzip the downloaded file
unzip("assignmentData.zip",exdir = "./assignmentData")

# Read electricity consumption data
PowerData <- read.table("./assignmentData/household_power_consumption.txt",sep=";",header=TRUE,na="?")

# Convert date and time variables to Date/Time class

PowerData$Time <- strptime(paste(PowerData$Date, PowerData$Time), "%d/%m/%Y %H:%M:%S")
PowerData$Date <- as.Date(PowerData$Date, "%d/%m/%Y")

# Subset the PowerData for 2007-02-01 and 2007-02-02
SubsetData=subset(PowerData,PowerData$Date %in% as.Date(c("2007-02-01","2007-02-02")))

# Open "PNG"  graphic device
png(filename="plot3.png", width=480, height=480)

#Plot the required graph
plot(SubsetData$Time, SubsetData$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(SubsetData$Time, SubsetData$Sub_metering_2, type="l", col="red")
lines(SubsetData$Time, SubsetData$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black", "red", "blue"),c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

#Turn off the graphic device
dev.off()