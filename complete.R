complete <- function(directory, id = 1:332) {
        ## get vector of filenames
        getName <- list.files(directory, full.names= TRUE)
        
        ## test the above works
        ## getName
        
        ## create empty data frame 
        completeCases <- data.frame()
        
        ## here comes the for loop
        for(i in id) {
                pollutantData <- read.csv(getName[i])
                pollutantData <- as.numeric(complete.cases(pollutantData))
                completeCases <- rbind(completeCases, cbind(i, sum(pollutantData)))
        }
        
        ##last part of the function
        colnames(completeCases) <- c('id', 'nobs')
        completeCases
}