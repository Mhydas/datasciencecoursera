# This script answer the following question:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

# Read in the PM2.5 data.
NEI <- readRDS("summarySCC_PM25.rds")

# This data is not needed for this plot.
# SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI by year and then sum the emissions.
data <- aggregate(NEI$Emissions, list(NEI$year), sum)

# Plot year on the x axis and total on the y. Make the plot a line type, set the title,
# and then set the x and y axis titles. We are also ensuring there are no tick marks on the
# x axis, so we can set them with the axis command. This plot definintely takes a few seconds
# to complete.
plot(data$Group.1, data$x, type = 'l', xaxt = 'n', main = expression(PM[2.5]~Emissions~per~Year),
     xlab = '', ylab = expression(Total~PM[2.5]~(tons)))

# Add the labels and draw points for the x axis tick marks.
axis(1,labels = data$Group.1, at = data$Group.1)

# Open the PNG device and create a file with the given name and dimensions.
png('plot1.png',height = 480, width = 480, units = 'px')

# Plot the same graph as above.
plot(data$Group.1, data$x, type = 'l', xaxt = 'n', main = expression(PM[2.5]~Emissions~per~Year),
     xlab = '', ylab = expression(Total~PM[2.5]~(tons)))

# Adjust the x axis ticks, as above.
axis(1,labels = data$Group.1, at = data$Group.1)

# Close the PNG device and recieve our file.
dev.off()