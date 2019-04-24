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



Installation: Installation is the next section in an effective README. Tell other users how to install your project locally. Optionally, include a gif to make the process even more clear for other people.

Usage: The next section is usage, in which you instruct other people on how to use your project after they’ve installed it. This would also be a good place to include screenshots of your project in action.

Contributing: Larger projects often have sections on contributing to their project, in which contribution instructions are outlined. Sometimes, this is a separate file. If you have specific contribution preferences, explain them so that other developers know how to best contribute to your work. To learn more about how to help others contribute, check out the guide for setting guidelines for repository contributors.

Credits: Include a section for credits in order to highlight and link to the authors of your project.

License: Finally, include a section for the license of your project. For more information on choosing a license, check out GitHub’s licensing guide!
