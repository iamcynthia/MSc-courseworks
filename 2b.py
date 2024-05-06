# --
# 2b.py -- Generate a black-and-white version of each image.
# --

import numpy
import imageio
import matplotlib . pyplot as plt 
import skimage.color as color 
import skimage.filters as filters

binary = []
DATA_DIR = 'img/'
DATA_FILES = ['plantA_23.jpg', 'plantA_39.jpg', 'plantB_26.jpg', 'plantB_51.jpg', 'plantC_15.jpg', 'plantC_44.jpg']
#-read images from a file into image object (named 'im')
for ( j, myfile ) in zip( range( len( DATA_FILES )), DATA_FILES ):
    im = imageio.imread(DATA_DIR + myfile)
#-convert the image to greyscale for canny edge detection
    img = color.rgb2gray( im )
#-convert the image to B&W
    threshold = filters.threshold_otsu( img )
    binary_img = img > threshold
    binary.append(binary_img)  # store it as a list

#-plot the results
fig, ((ax0, ax1, ax2), (ax3, ax4, ax5)) = plt.subplots( nrows=2, ncols=3, figsize=(8, 5), sharex=True, sharey=True )

ax0.imshow(binary[0], cmap=plt.cm.gray, interpolation='nearest')
ax0.axis( 'off' )
ax0.set_title( 'plantA_23' )

ax1.imshow(binary[1], cmap=plt.cm.gray, interpolation='nearest')
ax1.axis( 'off' )
ax1.set_title( 'plantA_39' )

ax2.imshow(binary[2], cmap=plt.cm.gray, interpolation='nearest')
ax2.axis( 'off' )
ax2.set_title( 'plantB_26' )

ax3.imshow(binary[3], cmap=plt.cm.gray, interpolation='nearest')
ax3.axis( 'off' )
ax3.set_title( 'plantB_51' )

ax4.imshow(binary[4], cmap=plt.cm.gray, interpolation='nearest')
ax4.axis( 'off' )
ax4.set_title( 'plantC_15' )

ax5.imshow(binary[5], cmap=plt.cm.gray, interpolation='nearest')
ax5.axis( 'off' )
ax5.set_title( 'plantC_44' )

fig.tight_layout()

plt.savefig( 'binary.png' )
plt.show()