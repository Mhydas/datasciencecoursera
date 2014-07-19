# Load ggplot2 package
library(ggplot2)

# This script answer the following question:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from
# 1999–2008 for Baltimore City? Which have seen increases in emissions from 
# 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

# Read in the PM2.5 data.
NEI <- readRDS("summarySCC_PM25.rds")

# This data is not needed for this plot.
# SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI to be just Baltimore City data.
data <- NEI[NEI$fips == 24510,]

# Create blank data frame for final resting place of plot data
sub_data <- data.frame()

# Subset data by type 'point'
point_data <- data[data$type == 'POINT',]

# Subset data by type 'nonpoint'
nonpoint_data <- data[data$type == 'NONPOINT',]

# Subset data by type 'onroad'
onroad_data <- data[data$type == 'ON-ROAD',]

# Subset data by type 'nonroad'
nonroad_data <- data[data$type == 'NON-ROAD',]

# Begin adding yearly totals to sub_data for type 'point'
sub_data <- aggregate(point_data$Emissions, list(point_data$year), sum)

# Continue building sub_data by adding yearly totals for type 'nonpoint'
sub_data <- rbind(sub_data,aggregate(nonpoint_data$Emissions, list(nonpoint_data$year), sum))

# Continue building sub_data by adding yearly totals for type 'onroad'
sub_data <- rbind(sub_data,aggregate(onroad_data$Emissions, list(onroad_data$year), sum))

# Continue building sub_data by adding yearly totals for type 'nonroad'
sub_data <- rbind(sub_data,aggregate(nonroad_data$Emissions, list(nonroad_data$year), sum))

# Add the place holders for each type and its data so the plot works out properly
sub_data <- cbind(sub_data, c(rep('POINT',4), rep('NONPOINT',4), rep('ON-ROAD',4), rep('NON-ROAD',4)))

# Name the columns in sub_data for simpler calling in the plot function
names(sub_data) <- c('Year','Emissions','Type')

# Plot the yearly totals for emissions by type as a line graph, with points. Set the title
# and the y-axis label
print(qplot(Year,Emissions, data = sub_data, facets = .~Type, geom = c('smooth', 'point')
      , main = 'Baltimore City Emissions per Year by Type', ylab = expression(Total~PM[2.5]~(tons))))

# Open the PNG device and create a file with the given name and dimensions.
png('plot3.png',height = 480, width = 600, units = 'px')

# Plot the graph, as above
print(qplot(Year,Emissions, data = sub_data, facets = .~Type, geom = c('smooth', 'point')
            , main = 'Baltimore City Emissions per Year by Type', ylab = expression(Total~PM[2.5]~(tons))))

# Close the PNG device and recieve our file.
dev.off()
