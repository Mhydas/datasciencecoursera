# This script answer the following question:
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == 06037). Which city has seen greater changes over time in motor 
# vehicle emissions?

# Read in the PM2.5 data.
NEI <- readRDS("summarySCC_PM25.rds")

# Read in the source classification code data
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI to be just Baltimore City data.
balt_data <- NEI[NEI$fips == 24510,]

# Subset NEI to be just LOs Angeles County data.
la_data <- NEI[NEI$fips == '06037',]

# Get the row indices of the vehicle related SCC numbers
vehicle <- grep('[Vv][Ee][Hh]',SCC$Short.Name)

# Get the SCC numbers associated with those indices
scc_veh <- SCC$SCC[vehicle]

# Subset the Baltimore City data by the SCC numbers that exists in scc_veh
balt_motor_vehicles <- balt_data[balt_data$SCC %in% scc_veh,]

# Subset the Baltimore City data by the SCC numbers that exists in scc_veh
la_motor_vehicles <- la_data[la_data$SCC %in% scc_veh,]

# Subset data by year and then sum the emissions for Baltimore City.
balt_sub_data <- aggregate(balt_motor_vehicles$Emissions, list(balt_motor_vehicles$year), sum)

# Subset data by year and then sum the emissions for Los Angeles County.
la_sub_data <- aggregate(la_motor_vehicles$Emissions, list(la_motor_vehicles$year), sum)

# Set the parameters for the native device to be 1 row of 2 columns with a slightly larger
# top margin, which we will later use for the main title
par(mfcol = c(1,2), oma = c(0,0,2,0))

# Plot year on the x axis and total on the y. Make the plot a line type, set the title,
# and then set the x and y axis titles. We are also ensuring there are no tick marks on the
# x axis, so we can set them with the axis command.
plot(balt_sub_data$Group.1, balt_sub_data$x, type = 'l', xaxt = 'n', main = 'Baltimore City',
     xlab = '', ylab = expression(Total~PM[2.5]~(tons)))

# Add the labels and draw points for the x axis tick marks.
axis(1,labels = balt_sub_data$Group.1, at = balt_sub_data$Group.1)

# Plot year on the x axis and total on the y. Make the plot a line type, set the title,
# and then set the x and y axis titles. We are also ensuring there are no tick marks on the
# x axis, so we can set them with the axis command.
plot(la_sub_data$Group.1, la_sub_data$x, type = 'l', xaxt = 'n', main = 'Los Angeles',
     xlab = '', ylab = expression(Total~PM[2.5]~(tons)))

# Add the labels and draw points for the x axis tick marks.
axis(1,labels = la_sub_data$Group.1, at = la_sub_data$Group.1)

# Add the main title to the entire image
mtext('Motor Vehicle Related Emissions per Year', outer = T)

# Open the PNG device and create a file with the given name and dimensions.
png('plot6.png',height = 480, width = 480, units = 'px')

# Set the paramters for the PNG device, the same way we did above
par(mfcol = c(1,2), oma = c(0,0,2,0))

# Plot the first graph, same as above
plot(balt_sub_data$Group.1, balt_sub_data$x, type = 'l', xaxt = 'n', main = 'Baltimore City',
     xlab = '', ylab = expression(Total~PM[2.5]~(tons)))

# Adjust the x axis ticks, as above.
axis(1,labels = balt_sub_data$Group.1, at = balt_sub_data$Group.1)

# Plot the second graph, same as above
plot(la_sub_data$Group.1, la_sub_data$x, type = 'l', xaxt = 'n', main = 'Los Angeles',
     xlab = '', ylab = expression(Total~PM[2.5]~(tons)))

# Adjust the x axis ticks, as above.
axis(1,labels = la_sub_data$Group.1, at = la_sub_data$Group.1)

# Add the main title, same as above
mtext('Motor Vehicle Related Emissions per Year', outer = T)

# Close the PNG device and recieve our file.
dev.off()