plot4 <- function() {
  
  plotGraph <- function() {
    par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
    with(data, {
      plot(Global_active_power ~ Datetime, type = "l", 
           ylab = "Global Active Power", xlab = "")
      plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
      plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering",
           xlab = "")
      lines(Sub_metering_2 ~ Datetime, col = 'Red')
      lines(Sub_metering_3 ~ Datetime, col = 'Blue')
      legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
      plot(Global_reactive_power ~ Datetime, type = "l", 
           ylab = "Global_rective_power", xlab = "datetime")
    })
  }
  
  if(!file.exists("household_power_consumption.txt")) {
    temp <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    file <- unzip(temp)
    unlink(temp)
  }
  
  ## Getting full dataset
  data_full_household_power <- read.csv("household_power_consumption.txt", header = T, sep = ';', 
                                        na.strings = "?", nrows = 2075259, check.names = F, 
                                        stringsAsFactors = F, comment.char = "", quote = '\"')
  data_full_household_power$Date <- as.Date(data_full_household_power$Date, format = "%d/%m/%Y")
  
  ## Subsetting the data
  data <- subset(data_full_household_power, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
  ## Removing full dataset
  rm(data_full_household_power)
  
  ## Converting dates to usable format
  datetime <- paste(as.Date(data$Date), data$Time)
  data$Datetime <- as.POSIXct(datetime)
  
  ## Generating Plot 4
  plotGraph()
  
  ## Copying plot to png file
  png("plot4.png", width=480, height=480)
  plotGraph()
  dev.off()
  ## Output directory where the png file was saved
  cat("plot4.png has been saved in", getwd())
}

plot4()