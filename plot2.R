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
png(filename="plot2.png", width=480, height=480)

#Plot the required graph
plot(SubsetData$Time,SubsetData$Global_active_power,type = "l",xlab="",ylab="Global Active Power (kilowatts)")

#Turn off the graphic device
dev.off()