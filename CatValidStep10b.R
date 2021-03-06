####Validation of categorical maps####
###
###Step 10 - Statistical anaylsis of validation data 
###
##User to set the following...

wd <- "C://Temp//Validation"

#Place all of the following files into working directory

#Step10a - save this file (wtdKappa.R) to the working directory
#File names of surfaces to be validated
surface1fn <- "FI_LAN_DSM_EROD_SURFACE_90M_R.tif"
surface2fn <- "FI_LAN_DSM_EROD_SUBSOIL_90M_R.tif"

#File name of csv with validation data
#CSV can have any number of columns but must have these columns as a minimum
# Longitude Latitude  Surf1Actual	Surf2Actual
# 148.77052	-21.89588	1           2
vdatafn <- "ValidationData.csv"

##Code begins here
setwd(wd)
library(sp)
library(ithir)

##Prepare data
#Import Data
surface1 <- raster(surface1fn)
surface2 <- raster(surface2fn)
vdata <- read.csv(vdatafn, header = TRUE, sep = ",")

#Create spatialpoints of actual validation sites
coords <- subset(vdata, select = c('Longitude','Latitude'))
ap <- SpatialPointsDataFrame(coords, vdata, proj4string=CRS("+proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs 
                                                            "))  

#Extract predicted values at actual validation sites and add to vdata
Surf1Pred <- as.data.frame(extract(surface1, ap))
Surf1Pred <- setNames(object = Surf1Pred, c("Surf1Pred"))
Surf2Pred <- as.data.frame(extract(surface2, ap))
Surf2Pred <- setNames(object = Surf2Pred, c("Surf2Pred"))
apdf <-as.data.frame(ap)
vdata2 <- cbind(apdf, Surf1Pred, Surf2Pred)
vdata <- subset(vdata2, select = c("SiteID", "Longitude", "Latitude", "Surf1Actual", "Surf2Actual", "Surf1Pred", "Surf2Pred"))

#Overwrite category 8 with 0 in subsurface dispersibility - to ensure actual number represents true position in ordinal range (Omit if not validating soil erodibility data)
vdata$Surf2Pred[which(vdata$Surf2Pred == 8)] <- 0
vdata$Surf2Actual[which(vdata$Surf2Actual == 8)] <- 0

##Conduct Kappa test Scripted by Tom Orton
#Prepare functions & data
source(paste(wd,"//wtdKappa.R", sep = "")) #Author of method, scripted by Tom Orton

#Calculate error matrices.
errorMat_SURF1 <- calcErrorMat(pred = vdata$Surf1Pred , obs = vdata$Surf1Actual , allCats = seq(4))
errorMat_SURF2 <- calcErrorMat(pred = vdata$Surf2Pred , obs = vdata$Surf2Actual , allCats = c(seq(0,4)))

#Calculate Kappa for Nominal surface stability (Surface1) and weighted kappa (Surface2) according to the Agresti weights for Ordinal subsurface dispersibility
kappa <- calcWeightedKappa(errorMat_SURF1 , weights.method = "None")
print(kappa)
write.csv(kappa, file = "Surface1Validation_NominalKappa.csv")
kappa <- calcWeightedKappa(errorMat_SURF2 , weights.method = "Ag")
print(kappa)
write.csv(kappa, file = "Surface2Validation_WeightedKappa.csv")

#Save confusion matrix, Producer and User Accuracy and nominal Kappa test (not taking into account size of difference between predicted and actual values) Scripted by Peter Zund
#Surface1 map validation
result <- goofcat(conf.mat = errorMat_SURF1, imp = TRUE)
write.csv(result, file = "Surface1Validation.csv")

#Surface2 map validation
result <- goofcat(conf.mat = errorMat_SURF2, imp = TRUE)
write.csv(result, file = "Surface2Validation.csv")

#End of code