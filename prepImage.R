# Initial

# source("http://bioconductor.org/biocLite.R")
# biocLite()
# biocLite("EBImage")


# library("dplyr")

library("EBImage")
library(e1071)
library(stringr)

# library(spatstat)
# 
# Image <- readImage('./train/1_4.tif')
# Mask <- readImage('./train/1_4_mask.tif')


# display(Image[289:1547, 669:1406,])
# x <- as.vector(imageData(Image))
# y <- as.vector(imageData(Mask))

# x <- as.im(imageData(Image))
# y <- as.im(imageData(Mask))
# z <- as.im(imageData(Image)*imageData(Mask))
# rslt <- convolve.im(x, z, reflectX=TRUE)
# plot(rslt > max(rslt) *0.95)

#model <- svm(x, y)
#
# pred <- predict(model, x)

# display(Image)

# list.files("./train/")

library(dplyr)


# for (i in 1:length(files))
i <- 1
 {
   ImageFiles <- list.files("./train/", paste("^", as.character(i), "_[1234567890]+.tif", sep=""))
   MaskFiles <- list.files("./train/", paste("^", as.character(i), "_[1234567890]+_mask.tif", sep=""))
   
   if (length(ImageFiles) != length(MaskFiles))
   {
     print("Error: Processing halted -- Images and Mask files count don't matches")
     break
   }
    
   for (j in 1:length(ImageFiles))
   #j <- 1
   {
     Image <- readImage(paste("./train/", as.character(i), "_", as.character(j), ".tif", sep=""))
     Mask <- readImage(paste("./train/", as.character(i), "_", as.character(j), "_mask.tif", sep=""))
     
     emptyMask = "_empty"
     if (max(Mask) > 0) emptyMask = "";
     
     z <- Image * Mask
     writeImage(z, paste("./temp/out_", as.character(i), "_", as.character(j), emptyMask, ".tif", sep=""))
     
   }
 
}