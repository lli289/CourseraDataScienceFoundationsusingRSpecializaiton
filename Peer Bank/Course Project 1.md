# Peer-graded Assignment: Course Project 1

## For this assignment, you need to do the following:
* Download Electric power consumption, unzip, set to working directory.
* Fork and clone repo [ExData_Plotting1](https://github.com/rdpeng/ExData_Plotting1)
* Construct Plot 1 Global Active power.
* Construct Plot 2.
* Construct Plot 3.
* Construct Plot 4.
* Copy and paste link to your repo.

## To pass the assignment, you need to do the following:
* Check 1: Copy and paste the URL to your repo containing the completed R code.
* Check 2: Your repo contains at least one commit beyond the original fork.
* Check 3: Make sure your repo contains plot 1, plot 2, plot 3, and plot 4.
* Check 4: Make sure your repo contains R code for EACH plot SEPARATELLY.

## R code:

#### Plot1
```{r}
data <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
data2 <- subset(data,data$Date=="1/2/2007" | data$Date =="2/2/2007")
hist(as.numeric(as.character(data2$Global_active_power)),
     col="red",main="Global Active Power",
     xlab="Global Active Power(kilowatts)")
```
![image](https://github.com/lli289/CourseraDataScienceFoundationsusingRSpecializaiton/assets/129143119/868c319f-1263-4ef7-9bb5-a0616a0f42d7)

#### Plot 2
```{r}
data2$Date <- as.Date(data2$Date, format="%d/%m/%Y")
data2$Time <- strptime(data2$Time, format="%H:%M:%S")
data2[1:1440,"Time"] <- format(data2[1:1440,"Time"],"2007-02-01 %H:%M:%S")
data2[1441:2880,"Time"] <- format(data2[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
plot(data2$Time,as.numeric(as.character(data2$Global_active_power)),
     type="l",
     xlab="",ylab="Global Active Power (kilowatts)")
```
![image](https://github.com/lli289/CourseraDataScienceFoundationsusingRSpecializaiton/assets/129143119/98af344f-3119-435b-9b4b-6afcf029dd8a)

#### Plot 3
```{r}
plot(data2$Time, data2$Sub_metering_1,
      type="n", xlab="", ylab="Energy sub metering")
with(data2,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(data2,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(data2,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
```
![image](https://github.com/lli289/CourseraDataScienceFoundationsusingRSpecializaiton/assets/129143119/a78470ce-459b-4c29-a6a8-0505963a589b)

#### Plot 4
```{r}
par(mfrow=c(2,2))
with(data2,{
  plot(data2$Time,
       as.numeric(as.character(data2$Global_active_power)),
       type="l", xlab="", ylab="Global Active Power")
  plot(data2$Time,
       as.numeric(as.character(data2$Voltage)), 
       type="l", xlab="datetime", ylab="Voltage")
  plot(data2$Time,
       data2$Sub_metering_1,
       type="n", xlab="", ylab="Energy sub metering")
  with(data2,
       lines(Time, as.numeric(as.character(Sub_metering_1))))
  with(data2,
       lines(Time, as.numeric(as.character(Sub_metering_2)),
                   col="red"))
  with(data2,
       lines(Time, as.numeric(as.character(Sub_metering_3)),
             col="blue"))
  legend("topright", lty=1, 
         col=c("black","red","blue"), cex = 0.6,
         legend=c("Sub_metering_1", "Sub_metering_2",
                  "Sub_metering_3"))
  plot(data2$Time,
       as.numeric(as.character(data2$Global_reactive_power)),
       type="l",
       xlab="datetime", ylab="Global_reactive_power")
})
``` 
![image](https://github.com/lli289/CourseraDataScienceFoundationsusingRSpecializaiton/assets/129143119/bd88c18b-25ff-4f01-93e5-d67147134d08)
