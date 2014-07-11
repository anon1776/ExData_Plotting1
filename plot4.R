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



###Now for the 4-way plot
par(mfrow = c(2,2))

plot(subdata$datetime, subdata$Global_active_power,type="l")
plot(subdata$datetime, subdata$Voltage)
plot(subdata$datetime, subdata$Sub_metering_1,type="l")
points(subdata$datetime, subdata$Sub_metering_2,type="l",col="red")
points(subdata$datetime, subdata$Sub_metering_3,type="l",col="blue")
legend(lwd=1,x="topright",col=c("black","red","blue"),legend=c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"))
plot(subdata$datetime, subdata$Global_reactive_power,type="l")
dev.copy(png, file = "p4.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
