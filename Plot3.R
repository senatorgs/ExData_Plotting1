##############################################################
##### READS IN RAW DATA
##############################################################

fileurl<-"https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
temp <- tempfile()
download.file(fileurl,temp)
pcdata <- read.table(unz(temp, "household_power_consumption.txt"),header=T, sep = ";", na.strings = "?",colClasses=c(rep("character", 2), rep("numeric", 7)))
unlink(temp)

##############################################################
##### CREATES DATE/TIME VARIABLES & SUBSETS DATA
##############################################################

pcdata$Date1 <- as.Date(pcdata$Date, "%d/%m/%Y"); 
pcdata$Time1 <- as.POSIXlt(paste(pcdata$Date,"T",pcdata$Time,sep=""),format="%d/%m/%YT%H:%M:%S")

dt1=as.Date("01/02/2007", "%d/%m/%Y")
dt2=as.Date("02/02/2007", "%d/%m/%Y")
pcdata2 = subset(pcdata,pcdata$Date1==dt1 | pcdata$Date1==dt2)

##############################################################
##### PLOT #3
##############################################################

png("plot3.png", width=480, height=480)
plot(pcdata2$Time1, pcdata2$Sub_metering_1, type="l", xlab="", 
    ylab="Energy sub metering")
lines(pcdata2$Time1, pcdata2$Sub_metering_2, type="l", col="red")
lines(pcdata2$Time1, pcdata2$Sub_metering_3, type="l", col="blue")
legend("topright",c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"),lty=1, lwd=2.5,col=c("black","red","blue"))
dev.off()
