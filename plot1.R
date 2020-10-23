library("data.table")

setwd("/Users/Esteban/OneDrive/Exploratory/Preject_1")

#Leer los datos de origen
datapower <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# datos en notacion científica
 datapower[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# cambio en el tipo de datos
 datapower[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# seleccionar datos entre 2007-02-01 y 2007-02-02
 datapower <- datapower[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(datapower[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()