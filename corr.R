corr <- function(directory, threshold = 0) {
        ## creates a data frame that has the monitor number and how many complete cases it has
        totalCompleteCasesPerMonitor <- complete(directory, 1:332)
        
        ## test that the previous statement is working
        ## totalCompleteCasesPerMonitor
        
        ## matrix showing whether the file 's complete cases exceeds threshold or not
        greatThresh <- totalCompleteCasesPerMonitor['nobs'] > threshold
        
        ## which() on greatThresh to see which are TRUE
        ## whichTRUE <- which(greatThresh)
        
        ## if completes cases is > threshold
        ## if(greatThresh == TRUE) {        
        ## }
        
        ## creating the vector for the results
        corrResults <- numeric()
        
        for(i in 1:332) {
                if(greatThresh[i] == TRUE) {
                       tempFrame <- read.csv(getName[i])        
                       corrResults <- c(corrResults,cor(tempFrame$sulfate, tempFrame$nitrate, use='complete.obs'))        
                }                      
        }
        corrResults
}