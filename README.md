# Validation-of-categorical-maps
A validation method to validate categorical maps using an independent validation dataset.

## Summary
This method uses *Weighted Kappa coefficents* to determine the reliability of *categorical maps*. The method was orginally used to validate the *Vunerability to soil erosion mapping* conducted in the Fitzroy NRM region, specfically the *Surface soil stability* map and the *Subsoil dispersibility map*. The results are documented in the *Technical Report*. This generic workflow has been written for validing two *surfaces* (Raster or Vector) at once. It can be used to validation of polygonal soil class maps, polygonal limitation subclass maps, raster categorical soil attribute maps and any other categorical maps.

To asist with the task, a workflow has been defined, necessary detail provided to complete each step including background info and R code has been scripted to automate some of the tasks.

## Workflow
1.  Define what is to be validated.
1.  Determine minimum number of validation sites for a statistically adequate validation.
1.  Randomly generate validation sites.
1.  Adjust random sites to improve field work efficiency.
1.  Determine if unaccepatble bias has been introduced to adjusted validation sites.
1.  Readjust sites if necessary and recheck for bias.
1.  Determine data required at validation sites so as to be able to validate maps.
1.  Conduct field work.
1.  Collate field data and determine actual categorical values at actual validation sites visited.
1.  Conduct statistical anaylsis.



Installation: Create a valdiation directory on your temp drive (C://Temp/Validation). Copy required files (Noted in associated scripts) to this folder. Once finished, zip and copy folder to a backup drive for furtue reference. Scripts written in RStudio Version 1.1.453 connected to R 3.5.1

Usage: This project is wriiten to assist with validating categorical class maps, both vector and raster type.

Contributing: If you can see improvements that can be made, please do a pull request.

Credits: This is an implementation of the model validation method described in Section 6.1 Using R for Digital Soil Mapping (Malone *et al.* 2017) and is based on Congalton (1991). Tom Orton (UQ) provided advice and an *R function* to calculate a weighted Kappa based on methods by Agresti (2002c) and Spitzer *et al.* (1967). Implementation by Peter Zund (DES).

License: Free to use with acknowledgement.
