library("data.table")

setwd("~/Desktop/datasciencecoursera/4_Exploratory_Data_Analysis/project/data")

#Leer los datos de origen
datapower <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# datos en notacion científica
datapower[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# cambio en el tipo de datos
datapower[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# seleccionar datos entre 2007-02-01 y 2007-02-02
datapower <- datapower[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(datapower[, dateTime], datapower[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(datapower[, dateTime],datapower[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(datapower[, dateTime], datapower[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(datapower[, dateTime], datapower[, Sub_metering_2], col="red")
lines(datapower[, dateTime], datapower[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(datapower[, dateTime], datapower[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()