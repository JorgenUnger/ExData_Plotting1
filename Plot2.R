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

#Create Plot2
png(filename = "Plot2.png", width = 480, height = 480, units = "px", bg = "transparent")

#If not English local settings, you may need to uncomment a run Sys.setlocale below to get x labels correct.
#Sys.setlocale("LC_ALL","English")
with(hpc, plot(datetime, Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowatts)"))
#Sys.setlocale("LC_ALL")
dev.off()




