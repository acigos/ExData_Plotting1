getwd()
rm(list=ls())
setwd("/home/alexander/Escritorio/Data_Scientist_Speciality/ExploratoryDataAnalisis/Courseproyect1")

#Open de data. Column 1 and 2 as character, no NA. 2,075259 obs. of 9 variables
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", dec=".", 
                   comment.char = "", na.strings= "?", colClasses=c(rep("character",2), rep("numeric",7)) )

#Convert and mix column 1 and 2 as Date and then add to data this new column

DateTime<-strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")
data<- cbind(data, DateTime) # 2,075259 obs. of 10 variables

#Clean data
rm(DateTime)

#subset from data two dates in a new data frame with 2880 obs and 10 variables
df<- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007") #2,880 obs and 10 variables

attach(df)
#[1] "Date"                 
#[2] "Time"                 
#[3] "Global_active_power"  
#[4] "Global_reactive_power"
#[5] "Voltage"              
#[6] "Global_intensity"     
#[7] "Sub_metering_1"       
#[8] "Sub_metering_2"       
#[9] "Sub_metering_3"       
#[10] "DateTime"   


#Create plot 4
png(file = "plot4.png")

par(mfrow = c(2,2))
par("mar")
with(df, {
        plot(DateTime, Global_active_power, type = "l",
             col = "black", 
             main = " ", 
             xlab = " ",
             ylab = "Global Active Power")
        
        plot(DateTime, Voltage, type = "l",
             xlab = "datetime",
             ylab = "Voltage")
        
        plot(Sub_metering_1+Sub_metering_2+Sub_metering_3 ~ DateTime, xlab = " ", 
             ylab = "Energy sub metering", ylim = c(0,40), type = "n")
        
        lines(DateTime, Sub_metering_1, 
              type = "l", 
              col = "black")
        
        
        lines(DateTime,  Sub_metering_2, 
              type = "l", 
              col = "red")
        
        lines(DateTime,  Sub_metering_3, 
              type = "l", 
              col = "blue")
        
        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               col = c("black", "red", "blue"),
               lty = c(1,1,1))
        
        plot(DateTime, Global_reactive_power,
             xlab = "datetime",
             col = "black",
             type = "l")
        
        
})
dev.off()