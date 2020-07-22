#' ---
#' title: The best title
#' author: You
#' date: YYYY-MM-DD
#' ---

library(ggplot2) # Makes pretty plots
library(ggpubr) # Arranges multiple ggplots on the same page

# Import Data -----

# Download data describing Fuel economy data from 1999 to 2008 for 38 popular models of cars. 
# This data is built into the ggplot2 library. Use "?mpg" to learn more about this dataset. 
data(mpg)
#Columns of interest include: 
## "displ" = engine displacement, in litres
## "cty" = city miles per gallon
## "hwy" = highway miles per gallon

# Functions -------

createplot<-function(x, y) {
  #Createplot is a function for calculating the Pearson correlation coefficient and plotting two variables (x and y) against each other 
  
  #Find the Pearson correlation coefficient
  cor_<-cor(x, y)
  
  #Create plots displaying data points, a smooth linear model trend line (note 'method = lm'), and a useful title. 
  g<-ggplot(mpg, aes(x, y)) +
    geom_point() + # plots points
    geom_smooth(method = "lm") + #plots trend line using a linear model
    ggtitle(paste0("Pearson correlation coefficient = ", round(cor_, digits = 2))) + # displays title with Pearson correlation coefficient
    ylim(5, 45) # standardizes the hieght of the y-axis
  
  #return outputs our graph from the function. 
  return(g)
}

# Analysis -----

# *** Visualizations ------

#Use createplot to output our two finished plots. 
g1<-createplot(x = mpg$displ, y = mpg$hwy)

g2<-createplot(x = mpg$displ, y = mpg$cty)

## arrange these two plots side by side so we can compare differences between the plots. 
g<-ggarrange(plotlist = list(g1, g2),
             nrow=1, ncol = 2)

# *** Save Outputs -----

#Save your plot so you can use and find it later. 
ggsave(filename = "graph.png", plot = g)
g