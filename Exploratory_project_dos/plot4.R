# Load ggplot2 package
library(ggplot2)

# This script answer the following question:
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

# Read in the PM2.5 data.
NEI <- readRDS("summarySCC_PM25.rds")

# Read in the source classification code data
SCC <- readRDS("Source_Classification_Code.rds")

# Create blank data frame for final resting place of plot data
sub_data <- data.frame()

# Merge the two data frames by SCC number. Both columns have the same exact name
# so this worked out.
mergedDF <- merge(NEI, SCC, by = 'SCC')

# Get the row indices of the coal combustion related SCC numbers
coal <- grep('[Cc][Oo][Aa][Ll]',SCC$EI.Sector)

# Get the SCC numbers associated with those indices
scc_coal <- SCC$SCC[coal]

# Subset the mergedDF by the SCC numbers that exists in scc_coal
coalDF <- mergedDF[mergedDF$SCC %in% scc_coal,]

# Subset coalDF for Electric Generation
elecgen <- coalDF[coalDF$EI.Sector == 'Fuel Comb - Electric Generation - Coal',]

# Subset coalDF for Industrial Boilers, ICEs
boilice <- coalDF[coalDF$EI.Sector == 'Fuel Comb - Industrial Boilers, ICEs - Coal',]

# Subset coalDF for Comm/Institutional
comminst <- coalDF[coalDF$EI.Sector == 'Fuel Comb - Comm/Institutional - Coal',]

# Begin adding yearly totals to sub_data for type Electric Generation
sub_data <- aggregate(elecgen$Emissions, list(elecgen$year), sum)

# Continue building sub_data by adding yearly totals for type Industrial Boilers, ICEs
sub_data <- rbind(sub_data,aggregate(boilice$Emissions, list(boilice$year), sum))

# Continue building sub_data by adding yearly totals for type Comm/Institutional
sub_data <- rbind(sub_data,aggregate(comminst$Emissions, list(comminst$year), sum))

# Add the place holders for each EI.Sector and its data so the plot works out properly
sub_data <- cbind(sub_data, c(rep('Electric Generation',4), rep('Industrial Boilers, ICEs',4), rep('Comm/Institutional',4)))

# Name the columns in sub_data for simpler calling in the plotting function
names(sub_data) <- c('Year','Emissions','EI.Sector')

# Plot the yearly totals for emissions by type as a line graph, with points. Set the title
# and the y-axis label
print(qplot(Year,Emissions, data = sub_data, facets = .~EI.Sector, geom = c('smooth', 'point')
            , main = 'US Coal Combustion Related Emissions per Year by EI.Sector', ylab = expression(Total~PM[2.5]~(tons))))

# Open the PNG device and create a file with the given name and dimensions.
png('plot4.png',height = 480, width = 600, units = 'px')

# Plot the graph, as above
print(qplot(Year,Emissions, data = sub_data, facets = .~EI.Sector, geom = c('smooth', 'point')
            , main = 'US Coal Combustion Related Emissions per Year by EI.Sector', ylab = expression(Total~PM[2.5]~(tons))))

# Close the PNG device and recieve our file.
dev.off()