#' title: The best title
#' author: You
#' date: YYYY-MM-DD
#' ---

# Source Scripts -------

source("./rscripts/functions.R")
source("./rscripts/data.R")

# Analysis -----

#Use createplot to output our two finished plots. 
g1<-createplot(x = mpg$displ, y = mpg$hwy)

g2<-createplot(x = mpg$displ, y = mpg$cty)

## arrange these two plots side by side so we can compare differences between the plots. 
g<-ggarrange(plotlist = list(g1, g2),
             nrow=1, ncol = 2)

# *** Save Outputs -----

#Save your plot so you can use and find it later. 
counter<-0
counter<-counter + 1
filename = paste0(counter, "_TestAnalysis_Graph.png")
ggsave(filename = paste0(outputfolder, filename), plot = g)
g