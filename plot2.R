filename<-"household_power_consumption.zip"
if (!file.exists(filename)) {
  retval=download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile=filename)
}

df.power<-read.csv(unz(filename,"household_power_consumption.txt"),header=TRUE,sep=";",na.strings="?",
                   colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

df.power$DateTime<-strptime(paste(df.power$Date,df.power$Time),format="%d/%m/%Y %H:%M:%S",tz="UTC")
start.date<-strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S", tz="UTC")
end.date<-strptime("02/02/2007 23:59:59", format="%d/%m/%Y %H:%M:%S", tz="UTC")
df.power<-df.power[df.power$DateTime>=start.date & df.power$DateTime<=end.date,]

png(filename="plot2.png",width=480,height=480)
plot(df.power$DateTime,df.power$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()
