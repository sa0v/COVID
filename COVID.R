# Plot the total cases and deaths due to COVID-19 over time, for the
# province of Newfoundland and Labrador, Canada.

library(tidyverse)
library(ggthemes)

# Disable the display of scientific notation.
options(scipen=999)

# Read a publicly available data set provided by Health Canada.
data <- read_csv("https://health-infobase.canada.ca/src/data/covidLive/covid19-download.csv")

# Transform!
data <- transform(data, totalcases = as.numeric(totalcases))
data <- data[data$totalcases >= 0 & data$numdeaths >= 0,]
data <- data[data$prname == "Newfoundland and Labrador",]

# Tidy!
data <- na.omit(data)

# Visualize!
ggplot(data=data, mapping=aes(x=date,y=totalcases)) +
  geom_line(mapping=aes(color="Cases"),linewidth=1) + 
  geom_line(mapping=aes(x=date,y=numdeaths,color="Deaths"),linewidth=1) +
  scale_y_continuous(trans="log10") +
  labs(x="Date",y="Total Count (Log. Scale)", title="Total COVID-19 Cases and Deaths") + 
  facet_wrap(~prname) +
  scale_colour_colorblind(name="Legend")