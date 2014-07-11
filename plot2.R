###download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","power.zip")
fname <- unzip("power.zip")
data <- read.table(fname,header=TRUE,sep=";")
head(data)

data[,1] <- as.Date(data[,1],format="%d/%m/%Y")
subdata <- subset(data,Date=="2007-02-01" | Date == "2007-02-02")

subdata$Global_active_power <- as.numeric(as.character(subdata$Global_active_power))
### Combine Date and Time
subdata$datetime <- paste(subdata$Date, subdata$Time)
### Normalize
subdata$datetime <- strptime(subdata$datetime, format="%Y-%m-%d %H:%M:%S")

### Plot
plot(subdata$datetime, subdata$Global_active_power,type="l",ylab="Global Active Power (kilowatts)")
dev.copy(png, file = "p2.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!