plot3 <- function()
{
    # checking / downloading / unzipping files
    if (!file.exists("household_power_consumption.txt"))
    {
        if (!file.exists("household_power_consumption.zip"))
        {
            url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
            download.file(url, "household_power_consumption.zip")
        }
        unzip("household_power_consumption.zip")
    }
    
    # reading file
    classes<-c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
    data<-read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", colClasses=classes)
    
    # cleaning data
    data$datetime<-as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
    data$Date<-as.Date(data$Date, format="%d/%m/%Y")
    data$Time<-strptime(data$Time, format="%H:%M:%S")
    data1<-subset(data, Date>="2007-02-01" & Date<="2007-02-02")
    
    #plotting
    png("plot3.png")
    plot(data1$datetime, data1$Sub_metering_1, type="n",  xlab="", ylab="Energy sub metering")
    lines(data1$datetime, data1$Sub_metering_1, type="l")
    lines(data1$datetime, data1$Sub_metering_2, type="l", col="red")
    lines(data1$datetime, data1$Sub_metering_3, type="l", col="blue")
    legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)
    dev.off()
}