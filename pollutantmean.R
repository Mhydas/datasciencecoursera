pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## create vector for file names
        getName <- vector()
        
        ## put file names into a vector
        getName <- list.files(directory, full.names= TRUE)
        
        ##test if the above works as expected
        ## getName
        ## print(is.vector(getName))
        
        ## create data frame for pollutant data
        pollutantData <- data.frame()
        
        ## Add specified monitor data to pollutantData
        ## pollutantData <- read.csv(getName[id], nrows = 5, header = TRUE)
        
        ## first attempt at for loop
        for(vec_position in id) {
                pollutantData <- rbind(pollutantData, read.csv(getName[vec_position], header = TRUE))
        }
        
        ## test that rbind within loop is working as expected
        ## tail(pollutantData)
        ## head(pollutantData)
        
        ## lets get the mean of the pollutant
        print(mean(pollutantData[, pollutant], na.rm= TRUE), digits=4)
        
        ## test pulling data by pollutant
        ## tail(pollutantData[pollutant])
}