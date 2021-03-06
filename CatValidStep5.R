####
####Validation of categorical maps####
###
###Step 5 - Checking for introduced bias
###
##User to set the following...

#Working directory
wd <- "C://Temp//Validation"

#Place all of the following files into working directory
#File names of surfaces to be validated
surface1fn <- "FI_LAN_DSM_EROD_SURFACE_90M_R.tif"
surface2fn <- "FI_LAN_DSM_EROD_SUBSOIL_90M_R.tif"

#File name of random points shapefile generated in Step 3
rpshape <- "FSE_random_points" #Excluding file extension
#File name of adjusted random points shapefile
apshape <- "AdjustedRandomPoints" #Excluding file extension

##Processing begins here
library(rgdal)
library(sm)
setwd(wd)

#Import Data
surface1 <- raster(surface1fn)
surface2 <- raster(surface2fn)
rp <- readOGR(dsn=wd, layer=rpshape)
ap <- readOGR(dsn=wd, layer=apshape)

#Surface1 - Extract predicted values at random and actual points
rpsurf1 <- extract(surface1, rp)
apsurf1 <- extract(surface1, ap)
rd <- density(rpsurf1, na.rm=TRUE)
ad <- density(apsurf1, na.rm=TRUE)

#Plot results for surface1
png("AnalysisOfBias.png")
par(mfrow=c(2,2))
plot(density(rpsurf1, bw = ((rd$bw+ad$bw)/2), na.rm=TRUE), main ="Surface stability, random sites", xlim = c(0,4), ylim = c(0,1))
plot(density(apsurf1, bw = ((rd$bw+ad$bw)/2), na.rm=TRUE), main ="Surface stability, actual sites", xlim = c(0,4), ylim = c(0,1))

#Surface2- Extract predicted values at random and actual points
rpsurf2 <- extract(surface2, rp)
apsurf2 <- extract(surface2, ap)
rd <- density(rpsurf2, na.rm=TRUE)
ad <- density(apsurf2, na.rm=TRUE)

#Plot results for surface2
plot(density(rpsurf2, bw = ((rd$bw+ad$bw)/2), na.rm=TRUE),main ="Subsoil dispersibility, random sites", xlim = c(0,8), ylim = c(0,0.3))
plot(density(apsurf2, bw = ((rd$bw+ad$bw)/2), na.rm=TRUE),main ="Subsoil dispersibility, actual sites", xlim = c(0,8), ylim = c(0,0.3))
dev.off() 

###End of script