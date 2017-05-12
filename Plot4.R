#If file "household_power_consumption.txt" not exist then download zip file if it doesent exist. Then unzip file.
if(!file.exists("household_power_consumption.txt")){
  
  if(!file.exists("exdata_data_household_power_consumption.zip"))
  {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl,destfile="exdata_data_household_power_consumption.zip",method="auto")
  }
  
  unzip("exdata_data_household_power_consumption.zip") 
}

#Read file
hpc <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na = "?")

#Subset rows with date 2007-02-01 or 2007-02-02
hpc <- hpc[(hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007"),]

#Create new column with DateTime format based on column Date and Time
hpc$datetime <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")

#Create Plot4
png(filename = "Plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
#If not English local settings, you may need to uncomment a run Sys.setlocale code below to get x labels correct. 
#If that the case you also need to uncomment code at the end of this file to restore locale settings. 
#Sys.setlocale("LC_ALL","English")
par(mfcol = c(2,2))

#Subplot 1,1
with(hpc, plot(datetime, Global_active_power, type="l", xlab = "Global Active Power", ylab = ""))

#Subplot 2,1
xrange <- range(hpc$datetime)
yrange <- range(hpc$Sub_metering_1, hpc$Sub_metering_1, hpc$Sub_metering_1)
with(hpc, plot(xrange, yrange, type="n", xlab="", ylab = "Energy sub metering"))
lines(hpc$datetime, hpc$Sub_metering_1, col="black")
lines(hpc$datetime, hpc$Sub_metering_2, col="red")
lines(hpc$datetime, hpc$Sub_metering_3, col="blue")
legend("topright",col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1, bty="n")

#Subplot 1,2
with(hpc, plot(datetime, Voltage, type="l"))

#Subplot 2,2
with(hpc, plot(datetime, Global_reactive_power, type="l"))
dev.off()
#Sys.setlocale("LC_ALL")