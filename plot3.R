plot3 <- function() {
  
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
  
  ## Generating Plot 3
  with(data, {
    plot(Sub_metering_1 ~ Datetime, type = "l", 
         ylab = "Global Active Power (kilowatts)", xlab = "")
    lines(Sub_metering_2 ~ Datetime, col = 'Red')
    lines(Sub_metering_3 ~ Datetime, col = 'Blue')
  })
  
  ## adding legend
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
  
  ## Copying plot to png file
  dev.copy(png, file="plot3.png", width=480, height=480)
  dev.off()
  ## Output directory where the png file was saved
  cat("plot3.png has been saved in", getwd())
}

plot3()