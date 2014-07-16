rankhospital <- function(state, outcome, num = "best") {
        ## Read in outcomes data .csv
        outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## Make the 3 colums we need to be numeric, numeric
        suppressWarnings(outcomes[, 11] <- as.numeric(outcomes[, 11]))
        suppressWarnings(outcomes[, 17] <- as.numeric(outcomes[, 17]))
        suppressWarnings(outcomes[, 23] <- as.numeric(outcomes[, 23]))
        
        ## Create a vector of the state abbreviations
        stateList <- outcomes[, 7]
        
        ## Create a state checker
        checkState <- state %in% stateList
        
        ## If state is not valid stop the function
        if(checkState == FALSE) {
                stop('invalid state')
        }
        
        ## Create vector to store mort by outcome 
        subMort <- numeric()
        
        ## If outcome is valid args, then subset outcomes by outcome
        if(outcome == 'pneumonia') {
                subMort <- outcomes[, 23]
        } else if(outcome == 'heart failure') {
                subMort <- outcomes[, 17]
        } 
        else if(outcome == 'heart attack') {
                subMort <- outcomes[, 11]
        } else {
                stop('invalid outcome')
        }
        
        ## Find the index's for the state and return it as a vector
        numState <- which(stateList == state)
        
        ## Subset subMort by proper state
        subMortState <- subMort[numState]
        
        ## If num = best then run the best function.....
        if(num == 'best') {
                ## Find the min value for the state
                minMort <- min(subMortState, na.rm= TRUE)
                
                ## Find the index for the lowest rate of the outcome
                whichhosp <- which(subMortState == minMort)
                
                ## Subset mortRates by Hospital name
                hospName <- outcomes[, 2]
                
                ##
                subhosp <- hospName[numState]
                
                ## Return the hospital name
                sort(subhosp[whichhosp])
        } else if(num == 'worst') {
                ## Find the min value for the state
                maxMort <- max(subMortState, na.rm= TRUE)
                
                ## Find the index for the lowest rate of the outcome
                whichhosp <- which(subMortState == maxMort)
                
                ## Subset mortRates by Hospital name
                hospName <- outcomes[, 2]
                
                ##
                subhosp <- hospName[numState]
                
                ## Return the hospital name
                sort(subhosp[whichhosp])       
        } 
        else if(num > length(subMortState)) {
                print(NA)
        } else {
                
                ## Make outcomes a subset of itself, where the State column == state
                ## and only provide the Hospital.Name column
                outcomes <- subset(outcomes, State == state, Hospital.Name)
                
                ## Column bind hospital names with their corresponding mortality rate
                outcomes <- cbind(outcomes, subMortState)
                
                ## Make outcomes reorder itself based on the asecending order of
                ## mortality rates
                outcomes <- outcomes[order(outcomes$subMortState),]
                
                ## Provide the hospital name, in outcomes, where the row is equal to
                ## num
                outcomes$Hospital.Name[num]
        }        
}