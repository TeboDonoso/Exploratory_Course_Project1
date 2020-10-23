library("data.table")

setwd("/Users/Esteban/OneDrive/Exploratory/Preject_1")

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

png("plot3.png", width=480, height=480)

# Plot 3
plot(datapower[, dateTime], datapower[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(datapower[, dateTime], datapower[, Sub_metering_2],col="red")
lines(datapower[, dateTime], datapower[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()