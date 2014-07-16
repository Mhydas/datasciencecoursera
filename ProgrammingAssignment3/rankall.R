rankall <- function(outcome, num = "best") {
        ## Read in outcomes data .csv
        outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## If outcome is valid args, then subset outcomes by outcome
        if(outcome == 'pneumonia') {
                outcomes <- outcomes[, c(2, 7, 23)]
        } else if(outcome == 'heart failure') {
                outcomes <- outcomes[, c(2, 7, 17)]
        } 
        else if(outcome == 'heart attack') {
                outcomes <- outcomes[, c(2, 7, 11)]
        } else {
                stop('invalid outcome')
        }
        
        ## Create a state list for the counter and as reference in coming for loop
        stateList <- sort(unique(outcomes[,2]))
        
        ## Create a blank data frame
        rankResult <- data.frame()
        
        ## For loop
        for(i in 1:length(stateList)) {                      
                ## Subset outcomes data frame by the corresponding state
                newoutcomes <- subset(outcomes, outcomes$State == stateList[i])
                
                ## Make column 3 numeric
                newoutcomes[, 3] <- as.numeric(newoutcomes[,3])
                
                ## Order outcomes by rank of the mortality rate
                newoutcomes <- newoutcomes[order(newoutcomes[, 3], newoutcomes[, 1], decreasing= FALSE), ]
                
                
                ## Remove incomplete cases
                newoutcomes <- newoutcomes[complete.cases(newoutcomes),]
                
                ## Drop the mortality rate column
                newoutcomes <- newoutcomes[, c(1, 2)]
                
                ## If statement for num
                if(num == 'best') {
                        ## rbind row = num to rankResult
                        rankResult <- rbind(rankResult, newoutcomes[1, ])  
                } else if(num == 'worst') {
                        ## rbind the last row to rankResult
                        rankResult <- rbind(rankResult, newoutcomes[length(newoutcomes[, 1]), ])
                } else if(num > length(outcomes[, 1])) {
                        ## Manufacture a row with the state and NA
                        newrow <- c('<NA>', stateList[i])
                        ## rbind a manufactured row to rankResult
                        rankResult <- rbind(rankResult, newrow)
                } else {
                        ## rbind the row dictated by num to rankResult
                        rankResult <- rbind(rankResult, newoutcomes[num, ])
                }
        }
        rankResult <- cbind(rankResult, state = stateList)
        rankResult <- rankResult[, c(1, 3)]
        names(rankResult) <- c('hospital', 'state')
        return(rankResult)
}
