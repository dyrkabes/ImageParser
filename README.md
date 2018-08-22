# ImageParser

## Description.
### The description is not ready yet. It's a bit messy

Image parser easies the work with the image packs. It creates an enum containing all of the image names and UIImage initializations from designers' resource pack. 

There usual usage flow looks something like this:

0. Download and run the project :) And feel free to adjust it to your needs in the code if the needed option is not implemented yet.
1. Download the resources pack from your designer.
2. Drag and drop the folder to the text field near the path label.
3. Hit "Make names" button.
4. Copy all the code from the large text view on top,
5. Create an AppImages file in your project and paste it there (you could name it whatever you want of course :) ).
6. Don't forget to drag and drop the folder with the images to your assets

### Additional options.
#### Bundle mode. 
For now it's also possible to use not only the default UIImage(named:) initializer but a more specific one. It was implemented for the case your app consists of more than one project or framework. One of them could be considered as a base one and the other, the child one could possibly override the images (for instance ic_cancel in the base project could be gray and in the child project it could have a different form-factor and be red). Then a following solution is provided. Function `UIImage.getImageFromBundles(named:)` which you could find after the end of the created AppImages enum seeks for an image first in the main bundle and then in the common one which identifier you should provide. 

### Note.
You should come to an agreement with your designers about the prefered format to reduce the import issues. For now there're few recommendations:
0. 
1. The images should be in a folder. Subfolders are perfectly allowed. Import from other sources is not implemented yet.
2. The images should not have spaces in their names. (will be fixed in a future update)
3. Each exported image name should be unique or, at least 
3.1. The same names should point to the same resources. (as the duplicating images will be purged during the importing in one of the next updates)

## TODO. 

Add feature to fix corrupted names and to show related notifications with different fixing politics.
Add whitelist feature.
Add remove duplicates option.
Add custom name.
Fix error label is going further than the end of the view.

Move the files processing to a background thread.

Add tests.

Make a web version.

## Contribution.
### Is welcome :) As well as any type of advice and feature request.
