#' title: The best title
#' author: You
#' date: YYYY-MM-DD
#' ---

library(ggplot2) # Makes pretty plots
library(ggpubr) # Arranges multiple ggplots on the same page


# Directories -------
outputfolder<-paste0("./output/TestAnalysis_", Sys.Date(), "/")
dir.create(path = outputfolder) # Create folder for today's analysis run

dir.create(path = paste0(outputfolder, "rawdata"))
dir.create(path = paste0(outputfolder, "figures"))
dir.create(path = paste0(outputfolder, "rscripts"))
listfiles<-list.files(path = "./rscripts/") #Find all files in "./rscripts"
for (i in 1:length(listfiles)){ # Save all of those files to the rscripts folder in the output folder
  file.copy(from = paste0("./rscripts/", listfiles[i]), 
            to = paste0("./",outputfolder,"/rscripts/", listfiles[i]), 
            overwrite = T)
}

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