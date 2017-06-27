plot3 <- function(){
        # Load useful packages
        
        library(data.table)
        library(dplyr)
        
        
        # Download data
        
        if(!file.exists('data.zip')){
                url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip' 
                download.file( url = url, destfile = 'data.zip', method = 'curl')
        }
        
        
        #Extract data
        
        if(!file.exists('household_power_consumption.txt')){
                unzip('data.zip')
        }
        
        
        # Put and clean data into R
        
        data <- fread('household_power_consumption.txt', sep=';', na.strings = '?')
        data <- filter(data, Date == '1/2/2007' | Date == '2/2/2007')
        
        data <- as.data.frame(data)
        data[ , 1] <- as.Date(data[ , 'Date'], '%d/%m/%Y' )
        Date <- paste(data[ , 'Date'], data[ , 'Time'] )
        Date <- as.POSIXct(Date, '%Y-%m-%d %H:%M:%S')
        
        data <- select(data, -c(Date, Time) )
        data <- cbind(Date, data)
        
        
        # Create plot number 3
        
        par(mfrow = c(1,1))
        
        with(data, {
                plot( Sub_metering_1 ~ Date, type='n', xlab='', ylab = 'Energy sub metering')  
                points( Sub_metering_1 ~ Date, type='l', xlab='', ylab = 'Energy sub metering', col = 'black' )   
                points( Sub_metering_2 ~ Date, type='l', xlab='', ylab = 'Energy sub metering', col = 'red' )
                points( Sub_metering_3 ~ Date, type='l', xlab='', ylab = 'Energy sub metering', col = 'blue' )
                legend('topright', pch= '-' , col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
        })
        
        # Save plot number 3
        
        dev.copy(png, file ='plot3.png')
        dev.off()
}