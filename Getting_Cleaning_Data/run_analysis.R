## Create a place for the tidy data frame
tidy <- data.frame()

## Read in all the test subject data
testdata <- cbind(read.table('test//subject_test.txt'), 
                       read.table('test//y_test.txt'),
                       read.table('test//x_test.txt'))

## Read in all the training subject data
traindata <- cbind(read.table('train//subject_train.txt'), 
                  read.table('train//y_train.txt'),
                  read.table('train//x_train.txt'))

## Combine the training and test sets
alldata <- rbind(testdata, traindata)

## Remove all columns that are not mean() or std()
alldata <- alldata[,c(1,2,3,4,5,6,7,8,43,44,45,46,47,48,83,84,84,85,86,87,123,
          124,125,126,127,128,163,164,165,166,167,168,203,204,215
          ,216,229,230,242,243,255,256,268,269,270,271,272,273,347
          ,348,349,350,351,352,426,427,428,429,430,431,505,506,
          518,519,531,532,544,545)]

## Get the column names for the selected variables into an object
alldatanames <- read.table('features.txt')

## Filter the column names to only those columns selected in
alldatanames <- as.vector(alldatanames[c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,
                                         122,123,124,125,126,161,162,163,164,165,166,201,202,
                                         214,215,227,228,240,241,253,254,266,267,268,269,270,
                                         271,345,346,347,348,349,350,424,425,426,427,428,429
                                         ,503,504,516,517,529,530,542,543),2])


## Set the column names for alldata
names(alldata) <- c('Subject','Activity', alldatanames)

## for loop to get the mean for each subject for each activity and rbind it to the tidy data set
for(i in levels(factor(alldata$Subject))) {
        tidy <- rbind(tidy, apply(subset(alldata, Subject == i & Activity == 1),2,mean))
        tidy <- rbind(tidy, apply(subset(alldata, Subject == i & Activity == 2),2,mean))
        tidy <- rbind(tidy, apply(subset(alldata, Subject == i & Activity == 3),2,mean))
        tidy <- rbind(tidy, apply(subset(alldata, Subject == i & Activity == 4),2,mean))
        tidy <- rbind(tidy, apply(subset(alldata, Subject == i & Activity == 5),2,mean))
        tidy <- rbind(tidy, apply(subset(alldata, Subject == i & Activity == 6),2,mean))
        }

## Name the columns in the tidy data set
names(tidy) <- c('Subject','Activity', alldatanames)

## Add the actvity names to the levels of that column so we can change them later
levels(tidy$Activity) <- c(1:6, 'Walking', 'Walking UpStairs', 'Walking Downstairs', 'Sitting', 'Standing', 'Laying')

## Replace the Activity numbers with the proper Activity name
tidy$Activity[tidy$Activity == 1] <- 'Walking'
tidy$Activity[tidy$Activity == 2] <- 'Walking Upstairs'
tidy$Activity[tidy$Activity == 3] <- 'Walking Downstairs'
tidy$Activity[tidy$Activity == 4] <- 'Sitting'
tidy$Activity[tidy$Activity == 5] <- 'Standing'
tidy$Activity[tidy$Activity == 6] <- 'Laying'

## Removing unnecessary, building block, objects from the environment
rm(alldata)
rm(testdata)
rm(traindata)
rm(alldatanames)
rm(i)

## Print the tidy data set
print(tidy)

## Write the file to upload for the course project
## write.csv(tidy, file = 'tidyData.csv', col.names =T, row.names = F)
