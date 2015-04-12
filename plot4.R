
# Setting the URL, destination and then downloading the file
if (!file.exists("data")) {dir.create("data")}
fUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dest <- "./data/power_consumption.zip"
download.file(fUrl, dest, method = "curl")

# Reading the file
dat <- read.table(text = grep("^[1,2]/2/2007", readLines(file("./data/household_power_consumption.txt", "r")), value = TRUE), 
                  sep = ";", skip = 0, na.strings = "?", stringsAsFactors = FALSE)

# Renaming the columns
names(dat) <- c("date", "time", "active_power", "reactive_power", "voltage", "intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3")

# Adding a formatted date-time column
dat$formtime <- as.POSIXct(paste(dat$date, dat$time), format = "%d/%m/%Y %T")

# Generating the plots
par(mfrow = c(2, 2))
with(dat, {
  plot(formtime, active_power, type = "l", xlab = "", ylab = "Global Active Power")
  plot(formtime, voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(formtime, sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(formtime, sub_metering_2, col = "red")
  lines(formtime, sub_metering_3, col = "blue")
  legend("topright","(x,y)", col = c("black", "red", "blue"), cex = 0.5, bty = "n", lty = 1,legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  plot(formtime, reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})


# Plotting the graph to png file
dev.copy(png, file = "plot4.png")
dev.off()