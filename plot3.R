fname <- unzip("power.zip")
print(paste(fname," is the unzipped file name"))
data <- read.table(fname,header=TRUE,sep=";")
print(head(data))
print("Now we have read the data into data frame data")

data[,1] <- as.Date(data[,1],format="%d/%m/%Y")
subdata <- subset(data,Date=="2007-02-01" | Date == "2007-02-02")

subdata$Global_active_power <- as.numeric(as.character(subdata$Global_active_power))
subdata$Global_reactive_power <- as.numeric(as.character(subdata$Global_reactive_power))
subdata$Voltage <- as.numeric(as.character(subdata$Voltage))
print(head(subdata))


### Combine Date and Time
subdata$datetime <- paste(subdata$Date, subdata$Time)
print("Date and Time have been combined")
print(head(subdata))
### Normalize
subdata$datetime <- strptime(subdata$datetime, format="%Y-%m-%d %H:%M:%S")




subdata$Sub_metering_2 <- as.numeric(as.character(subdata$Sub_metering_2))
 
plot(subdata$datetime, subdata$Sub_metering_1,type="l")
points(subdata$datetime, subdata$Sub_metering_2,col="red",type="l")
points(subdata$datetime, subdata$Sub_metering_3,col="blue",type="l")
legend(lwd=1,x="topright",col=c("black","red","blue"),legend=c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"))
dev.copy(png, file = "p3.png")
dev.off() ## Don't forget to close the PNG device!
