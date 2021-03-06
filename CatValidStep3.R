####Validation of categorical maps####
###
###Step 3 - Generation of an indepentent random set of validation points
###
##User to set the following...

#Number of validation sites (Minimum: 3 X Number of categories)
nrp <- 50

#Working directory
wd <- "C://Temp//Validation"

#Place all of the following files into working directory
#File name of project area shapefile
boundfn <- "Bound_Fitzroy_NRM"

#File names of surfaces to be validated
surface1fn <- "FI_LAN_DSM_EROD_SURFACE_90M_R.tif"
surface2fn <- "FI_LAN_DSM_EROD_SUBSOIL_90M_R.tif"

##Processing starts here
setwd(wd)
library(sp)
library(rgdal)

#Input data
bound <- readOGR(dsn = wd, layer = boundfn)
rp <- spsample(bound, n=nrp, type="random")
surface1 <- raster(surface1fn)
surface2 <- raster(surface2fn)

## Create a set of independent validation sites
Surf1Pred <- as.data.frame(extract(surface1, rp))
Surf1Pred <- setNames(object = Surf1Pred, c("Surf1Pred"))
Surf2Pred <- as.data.frame(extract(surface2, rp))
Surf2Pred <- setNames(object = Surf2Pred, c("Surf2Pred"))
SiteID <- as.data.frame(1:nrp)
SiteID <- setNames(object = SiteID, c("SiteID"))
data <- as.data.frame(cbind(SiteID, Surf1Pred, Surf2Pred))
rp <- SpatialPointsDataFrame(coords = rp@coords, data = as.data.frame(data))
writeOGR(obj = rp, dsn = wd, layer = "RandomPoints", driver="ESRI Shapefile",check_exists = TRUE, overwrite_layer = TRUE) #Save a shapefile for later reference
write.csv(as.data.frame(rp), file = "RandomPoints.csv", row.names = FALSE) #Save a csv for later reference

###End of script