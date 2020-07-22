Best Scripting Practices in an R Script
=======================================

Basic rules
-----------

This R Markdown is organized a little differently than I would organize
a script, but as you read through you’ll notice that all of the code
blocks are what would be in an R Script. This document, however, is a
good example of how I might organize an R Markdown document.

Below I list a few commandments of R scripting that will guide us
through this lesson. Future you and all those around you will sing your
praises if you follow these.

1.  Conform to a set and predictable script structure
2.  Never repeat code (that is what functions or loops are for!)
3.  Annotate your code
4.  Name files with predictable and helpful names
5.  Predictable folder structure
6.  Save scripts in an “R Project”

1. Conform to a set and predictable script structure
----------------------------------------------------

First, so you can see exactly what you are building, we are going to
open the document outline in R Studio. To open the document outline,
either:

-   Press `Control` + `Shift`+ `O`

-   Click the ‘outline’ button in the most upper right corner of your
    text editor window.

Outlines are available for a document types, including R Markdown and R
Scripts. You’ll notice in this R Markdown document that different
sections headers are listed in the outline for this document. You can
click on those to navigate this document.

In the case of an R script, we would follow a slightly different basic
structure by providing your metadata about the document and subsection
headers.

### 1.1. Provide your metadata about the document (not required, but helpful)

    #' ---
    #' title: The best title
    #' author: You
    #' date: YYYY-MM-DD
    #' ---

### 1.2. Add your subsections

You can view subsections in your document outline. This structure is up
to the user, but, personally, I use the following.

    # Libraries ---------

    # Import Data -----

    # Functions -------

    # Analysis

    # *** Correlation ---------

    # *** Visualizations ------

    # *** Save Outputs -----

In the above example, I use “\# \*\*\* \[text\]” in an attempt to make a
level down subsection. Consider, “Correlation”, “Visualizations”, and
“Save Outputs” are all part of doing an analysis. You can use anything
to take the space of the asterisk (\*) but I think asterisks look best.

These headers work the same as if I wrote them as .

Below is a short example of a reasonably organized R script that we will
build on that uses the above structure.

    #' ---
    #' title: The best title
    #' author: You
    #' date: YYYY-MM-DD
    #' ---

    # Libraries ---------

    library(ggplot2)
    library(ggpubr)

    # Import Data -----

    data(mpg)

    # Functions -------

    # Analysis -----

    # *** Correlation ---------

    cor_hwy<-cor(mpg$displ, mpg$hwy)

    cor_cty<-cor(mpg$displ, mpg$cty)

    # *** Visualizations ------

    g1<-ggplot(mpg, aes(displ, hwy)) +
      geom_point() + 
      geom_smooth(method = "lm") + 
      ggtitle(paste0("Pearson correlation coefficient = ", round(cor_hwy, digits = 2))) +
      ylim(5, 45)

    g2<-ggplot(mpg, aes(displ, cty)) +
      geom_point() + 
      geom_smooth(method = "lm") + 
      ggtitle(paste0("Pearson correlation coefficient = ", round(cor_cty, digits = 2))) +
      ylim(5, 45)

    g<-ggarrange(plotlist = list(g1, g2),
                   nrow=1, ncol = 2)

    ## `geom_smooth()` using formula 'y ~ x'
    ## `geom_smooth()` using formula 'y ~ x'

    # *** Save Outputs -----

    ggsave(filename = "graph.png", plot = g)

    ## Saving 7 x 5 in image

    g

![](README_files/figure-markdown_strict/unnamed-chunk-3-1.png)

This is a great start! Get ready, there are a few more things to do!

2. Annotate
-----------

So, what is actually happening in this script? I just wrote it, so I
know, in this moment, exactly what is going on. But will “future me”
know? They are pretty forgetful and like quick answers. As to not upset
them, it might be best to write them a few notes in the document right
now. We can easily do that with a single hash mark (\#) before comment
text. See below how I integrate it into the script we just wrote.

Admittedly, I don’t usually write this many comments, but for the
purposes of this example I want to be extra explicit.

    #' ---
    #' title: The best title
    #' author: You
    #' date: YYYY-MM-DD
    #' ---

    # Libraries ---------

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

    # There are currently no functions for this script. 

    # Analysis -----

    # *** Correlation ---------

    #Find the Pearson correlation coefficient for:
    ## engine displacement (litres) ~ highway mpg
    cor_hwy<-cor(mpg$displ, mpg$hwy) 

    ## engine displacement (litres) ~ city mpg
    cor_cty<-cor(mpg$displ, mpg$cty)

    # *** Visualizations ------

    #Create plots displaying data points, a smooth linear model trend line (note 'method = lm'), and a useful title. 

    ## engine displacement (litres) ~ highway mpg
    g1<-ggplot(mpg, aes(displ, hwy)) +
      geom_point() + 
      geom_smooth(method = "lm") + 
      ggtitle(paste0("Pearson correlation coefficient = ", round(cor_hwy, digits = 2))) +
        ylim(5, 45)

    ## engine displacement (litres) ~ city mpg
    g2<-ggplot(mpg, aes(displ, cty)) +
      geom_point() + 
      geom_smooth(method = "lm") + 
      ggtitle(paste0("Pearson correlation coefficient = ", round(cor_cty, digits = 2))) +
        ylim(5, 45)

    ## arrange these two plots side by side so we can compare differences between the plots. 
    g<-ggarrange(plotlist = list(g1, g2),
                   nrow=1, ncol = 2)

    ## `geom_smooth()` using formula 'y ~ x'
    ## `geom_smooth()` using formula 'y ~ x'

    # *** Save Outputs -----

    #Save your plot so you can use and find it later. 
    ggsave(filename = "graph.png", plot = g)

    ## Saving 7 x 5 in image

    g

![](README_files/figure-markdown_strict/unnamed-chunk-4-1.png)

3. Never repeat code
--------------------

I see a lot of redundancy in this code. What if I told you I could
remove a third of the content in this script with one simple function?
Repeating code to do the same thing over and over again will inevitably
lead to issues and typos. Further, what if we suddenly decided we wanted
all graphs to have a new title or change the colors? We would have to
change that in each plot individually.

Thought this is a small example, I am sure you can see how that could
become a massive problem in a long script you have been working
tirelessly on.

For the sake of saving our work, I’ll call this file “analysis.R”

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

    ## `geom_smooth()` using formula 'y ~ x'
    ## `geom_smooth()` using formula 'y ~ x'

    # *** Save Outputs -----

    #Save your plot so you can use and find it later. 
    ggsave(filename = "graph.png", plot = g)

    ## Saving 7 x 5 in image

    g

![](README_files/figure-markdown_strict/unnamed-chunk-5-1.png)

4. Name files with predictable and helpful names
------------------------------------------------

“graph.png” is not a terribly helpful name for any file. A few questions
immediately come to mind:

-   What analysis does this plot belong to?
-   At what part of the analysis was this output created? e.g., order?
-   Why do I care about this analysis? e.g., a more descriptive name?
-   What run is this analysis from? e.g., date? (something to think
    about but skipping this for now. We’ll get to it next.)

I usually try to keep all of my files to similar naming structure like
this one.

`"[Order]_[AnalysisName]_[Description].filetype"`

A few rules:

-   No spaces. You can use ThisLetterCasing to separate words
-   Underscores (\_) or dashes (-) can be used to separate ideas so it
    can be easy to read.
-   Names should be kept as short as possible. Some applications
    (including R, though it varies by action and file type) have a
    letter count limit on file names.

With this in mind, I might change:

    ggsave(filename = "graph.png", plot = g)

    ## Saving 7 x 5 in image

To `1_TestAnalysis_Graph.png` by using the below code:

    counter<-0
    counter<-counter + 1
    filename = paste0(counter, "_TestAnalysis_Graph.png")
    ggsave(filename = filename, plot = g)

    ## Saving 7 x 5 in image

5. Predictable folder structure
-------------------------------

Let’s say that you are working on this analysis over the course of
several months and you don’t want to overwrite anything you’ve done or
get lost in a sea of files. It’s a little complicated to set up, but I
suggest the following:

### 5.1. Set up three new folders

-   “rscripts”, where you will save all of your rscripts, including this
    script we have been working on.
-   “data” (not really relevant here, but when you have your own data,
    it will be!)
-   “output”, where results from your analysis will go.

<!-- -->

    dir.create(path = "./rscripts")
    dir.create(path = "./data")
    dir.create(path = "./output")

### 5.2. Create a folder for that data run

For each day’s run of your analysis, you might like to set up a new file
to save everything in. Within that folder, you might also like to keep a
copy of what you used to create this file. I recommend automatically
creating folders within this new output folder for your rscripts,
rawdata, figures, etc.

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

### 5.3. In a world where your analyses are a bit more complicated, I find that it is good to split your code into the following files:

-   “functions.R”, this file will be where all of the funcitons used to
    run your analysis.
-   “data.R”, this file will load all of your data and edit it for your
    analysis. Never hand edit data from a source. If you can, always
    manipulate it so you never destroy your original data copy.
-   “run.R”, this file will source the other files you created and run
    the analysis. We want this to have the bare-bones of what we need
    for our analysis.

Such that your new files would look like this and would all be saved in
the “rscripts” folder:

#### “functions.R”

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

#### “data.R”

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

#### “run.R”

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

    ## `geom_smooth()` using formula 'y ~ x'
    ## `geom_smooth()` using formula 'y ~ x'

    # *** Save Outputs -----

    #Save your plot so you can use and find it later. 
    ggsave(filename = "graph.png", plot = g)

    ## Saving 7 x 5 in image

    g

![](README_files/figure-markdown_strict/unnamed-chunk-12-1.png)

6. Save scripts in an “R Project”
---------------------------------

You can find more information about projects here:
<a href="https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects" class="uri">https://support.rstudio.com/hc/en-us/articles/200526207-Using-Projects</a>

R projects are important for:

-   organizing your, well, projects
-   sharing your projects to Git Hub
-   so you can establish a ‘relative’ directory (as opposed to a local
    directory that requires a specific address in your computer)
-   creating R Shiny apps, packages, etc. (beyond the scope of this
    example)

To create a project for this work, click File&gt;New Project&gt;Existing
Directory

We selected “Existing Directory” since we already have one. It is known
as our parent directory and what I have been referring to as “./” in the
directory name.

Projects manifest themselves, more or less, as fancy folders where R has
automatically deposited the following files:

-   Creates a project file (with an .Rproj extension) within the project
    directory. This file contains various project options (discussed
    below) and can also be used as a shortcut for opening the project
    directly from the filesystem.
-   Creates a hidden directory (named .Rproj.user) where
    project-specific temporary files (e.g. auto-saved source documents,
    window-state, etc.) are stored. This directory is also automatically
    added to .Rbuildignore, .gitignore, etc. if required.

Now, the project is loaded into RStudio and the name is displayed in the
Projects toolbar (which is located on the far right side of the main
toolbar). Additionally, the project (and all progress on the files) will
be easily loadable from File&gt;Recent Projects.

If you want access to this R Project on GitHub, for example, you can
access it with the below code.

    # library(usethis) # Automate package and project setup tasks that are otherwise performed manually.
    # usethis::use_course('https://github.com/emilyhmarkowitz/BestScriptingPractices/archive/master.zip')

By the way…
-----------

This repository is a scientific product and is not official
communication of the National Oceanic and Atmospheric Administration, or
the United States Department of Commerce. All NOAA GitHub project code
is provided on an ‘as is’ basis and the user assumes responsibility for
its use. Any claims against the Department of Commerce or Department of
Commerce bureaus stemming from the use of this GitHub project will be
governed by all applicable Federal law. Any reference to specific
commercial products, processes, or services by service mark, trademark,
manufacturer, or otherwise, does not constitute or imply their
endorsement, recommendation or favoring by the Department of Commerce.
The Department of Commerce seal and logo, or the seal and logo of a DOC
bureau, shall not be used in any manner to imply endorsement of any
commercial product or activity by DOC or the United States Government.
