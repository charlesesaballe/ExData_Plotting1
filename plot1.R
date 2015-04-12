
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

# Generating the histogram
hist(dat$active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red", freq = TRUE)

# Plotting the graph to png file
dev.copy(png, file = "plot1.png")
dev.off()