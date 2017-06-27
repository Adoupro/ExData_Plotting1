plot2 <- function(){
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
        
        
        # Create plot number 2
        
        par(mfrow = c(1,1))
        
        plot( Global_active_power ~ Date, data, type='l', xlab='', ylab = 'Global Active Power (kilowatts)' )
        
        
        # Save plot number 2
        
        dev.copy(png, file ='plot2.png')
        dev.off()
}