# This script answer the following question:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
# plot answering this question.


# Read in the PM2.5 data.
NEI <- readRDS("summarySCC_PM25.rds")

# This data is not needed for this plot.
# SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI to be just Baltimore City data.
data <- NEI[NEI$fips == 24510,]

# Subset data by year and then sum the emissions.
sub_data <- aggregate(data$Emissions, list(data$year), sum)

# Plot year on the x axis and total on the y. Make the plot a line type, set the title,
# and then set the x and y axis titles. We are also ensuring there are no tick marks on the
# x axis, so we can set them with the axis command. 
plot(sub_data$Group.1, sub_data$x, type = 'l', xaxt = 'n', main = expression(Baltimore~City~PM[2.5]~Emissions~per~Year),
     xlab = '', ylab = expression(Total~PM[2.5]~(tons)))

# Add the labels and draw points for the x axis tick marks.
axis(1,labels = sub_data$Group.1, at = sub_data$Group.1)

# Open the PNG device and create a file with the given name and dimensions.
png('plot2.png',height = 480, width = 480, units = 'px')

# Plot the same graph as above.
plot(sub_data$Group.1, sub_data$x, type = 'l', xaxt = 'n', main = expression(Baltimore~City~PM[2.5]~Emissions~per~Year),
     xlab = '', ylab = expression(Total~PM[2.5]~(tons)))

# Adjust the x axis ticks, as above.
axis(1,labels = sub_data$Group.1, at = sub_data$Group.1)

# Close the PNG device and recieve our file.
dev.off()
