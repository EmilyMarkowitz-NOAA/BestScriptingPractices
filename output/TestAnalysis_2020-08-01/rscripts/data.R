#' title: The best title
#' author: You
#' date: YYYY-MM-DD
#' ---

library(ggplot2) # Makes pretty plots

# Import Data -----

# Download data describing Fuel economy data from 1999 to 2008 for 38 popular models of cars. 
# This data is built into the ggplot2 library. Use "?mpg" to learn more about this dataset. 

data(mpg)

#Save the rawdata you used for an analysis (if you want to)

write.csv(x = data.frame(mpg), file = paste0(outputfolder, "rawdata/mpg.csv"))

#Columns of interest include: 
## "displ" = engine displacement, in litres
## "cty" = city miles per gallon
## "hwy" = highway miles per gallon
