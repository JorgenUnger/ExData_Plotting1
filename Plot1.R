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

#Create Plot1
png(filename = "Plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
hist(hpc$Global_active_power, main = "Global Active Power", col="red", xlab = "Global Active Power (kilowatts)")
dev.off()


