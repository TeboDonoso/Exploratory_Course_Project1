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

# Selecciona el dispositivo gráfico
png("plot2.png", width=480, height=480)

## Plot 2
plot(x = datapower[, dateTime]
     , y = datapower[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()