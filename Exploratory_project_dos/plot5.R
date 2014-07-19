

# This script answer the following question:
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Read in the PM2.5 data.
NEI <- readRDS("summarySCC_PM25.rds")

# Read in the source classification code data
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI to be just Baltimore City data.
data <- NEI[NEI$fips == 24510,]

# Get the row indices of the vehicle related SCC numbers
vehicle <- grep('[Vv][Ee][Hh]',SCC$Short.Name)

# Get the SCC numbers associated with those indices
scc_veh <- SCC$SCC[vehicle]

# Subset the Baltimore City data by the SCC numbers that exists in scc_veh
motor_vehicles <- data[data$SCC %in% scc_veh,]

# Subset data by year and then sum the emissions.
sub_data <- aggregate(motor_vehicles$Emissions, list(motor_vehicles$year), sum)

# Plot year on the x axis and total on the y. Make the plot a line type, set the title,
# and then set the x and y axis titles. We are also ensuring there are no tick marks on the
# x axis, so we can set them with the axis command.
plot(sub_data$Group.1, sub_data$x, type = 'l', xaxt = 'n', main = 'Baltimore City Motor Vehicle Related Emissions per Year',
     xlab = '', ylab = expression(Total~PM[2.5]~(tons)))

# Add the labels and draw points for the x axis tick marks.
axis(1,labels = sub_data$Group.1, at = sub_data$Group.1)

# Open the PNG device and create a file with the given name and dimensions.
png('plot5.png',height = 480, width = 480, units = 'px')

# Plot the same graph as above.
plot(sub_data$Group.1, sub_data$x, type = 'l', xaxt = 'n', main = 'Baltimore City Motor Vehicle Related Emissions per Year',
     xlab = '', ylab = expression(Total~PM[2.5]~(tons)))

# Adjust the x axis ticks, as above.
axis(1,labels = sub_data$Group.1, at = sub_data$Group.1)

# Close the PNG device and recieve our file.
dev.off()
