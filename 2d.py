# --
# 2d.py -- Detect contours in each image.
# --

import numpy
import imageio
import matplotlib . pyplot as plt 
import skimage.color as color 
import skimage.filters as filters
import skimage.measure as measure

greyscale=[]
contour = []
DATA_DIR = 'img/'
DATA_FILES = ['plantA_23.jpg', 'plantA_39.jpg', 'plantB_26.jpg', 'plantB_51.jpg', 'plantC_15.jpg', 'plantC_44.jpg']
#-read images from a file into image object (named 'im')
for ( j, myfile ) in zip( range( len( DATA_FILES )), DATA_FILES ):
    im = imageio.imread(DATA_DIR + myfile)
#-convert the image to greyscale for canny edge detection
    img = color.rgb2gray( im )
    greyscale.append(img)
#-convert the image to B&W
    threshold = filters.threshold_otsu( img )
#-find contours at the threshold value found above
    contours = measure.find_contours( img, threshold )
    contour.append(contours)

#-plot the results
fig, ((ax0_, ax0, ax1_, ax1), (ax2_, ax2, ax3_, ax3), (ax4_, ax4, ax5_, ax5)) = plt.subplots( nrows=3, ncols=4, figsize=(15, 9), sharex=True, sharey=True )

ax0_.imshow(greyscale[0], plt.cm.gray)
for n, contour_ in enumerate( contour[0] ):
    ax0.plot( contour_[:,1], contour_[:,0], 'k-.', linewidth=1 )
ax0.set_title( 'plantA_23' )

ax1_.imshow(greyscale[1],plt.cm.gray)
for n, contour_ in enumerate( contour[1] ):
    ax1.plot( contour_[:,1], contour_[:,0], 'k-.', linewidth=1 )
ax1.set_title( 'plantA_39' )

ax2_.imshow(greyscale[2],plt.cm.gray)
for n, contour_ in enumerate( contour[2] ):
    ax2.plot( contour_[:,1], contour_[:,0], 'k-.', linewidth=1 )
ax2.set_title( 'plantB_26' )

ax3_.imshow(greyscale[3],plt.cm.gray)
for n, contour_ in enumerate( contour[3] ):
    ax3.plot( contour_[:,1], contour_[:,0], 'k-.', linewidth=1 )
ax3.set_title( 'plantB_51' )

ax4_.imshow(greyscale[4],plt.cm.gray)
for n, contour_ in enumerate( contour[4] ):
    ax4.plot( contour_[:,1], contour_[:,0], 'k-.', linewidth=1 )
ax4.set_title( 'plantC_15' )

ax5_.imshow(greyscale[5],plt.cm.gray)
for n, contour_ in enumerate( contour[5] ):
    ax5.plot( contour_[:,1], contour_[:,0], 'k-.', linewidth=1 )
ax5.set_title( 'plantC_44' )

fig.tight_layout()

plt.savefig( 'contour.png' )
plt.show()