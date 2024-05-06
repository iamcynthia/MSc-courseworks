# --
# 2c.py -- Detect edges in each image.
# --

import numpy
import imageio
import matplotlib . pyplot as plt 
import skimage.color as color 
import skimage.filters as filters
import skimage.feature as feature

edge = []
edge1 = []
edge2 = []
DATA_DIR = 'img/'
DATA_FILES = ['plantA_23.jpg', 'plantA_39.jpg', 'plantB_26.jpg', 'plantB_51.jpg', 'plantC_15.jpg', 'plantC_44.jpg']
#-read images from a file into image object (named 'im')
for ( j, myfile ) in zip( range( len( DATA_FILES )), DATA_FILES ):
    im = imageio.imread(DATA_DIR + myfile)
#-convert the image to greyscale for canny edge detection
    img = color.rgb2gray( im )
#-detect edges using Canny algorithm for two values of sigma
    edges = feature.canny( img, sigma=1 ) #a_39, b_26, b_51
    edges1 = feature.canny(img, sigma=0.8) # c_15
    edges2 = feature.canny(img, sigma = 0) # a_23 , c_44
    edge.append(edges)
    edge1.append(edges1)
    edge2.append(edges2)

#-plot the results
fig, ((ax0, ax1, ax2), (ax3, ax4, ax5)) = plt.subplots( nrows=2, ncols=3, figsize=(8,5), sharex=True, sharey=True )

ax0.imshow(edge2[0], cmap=plt.cm.gray, interpolation='nearest')
ax0.axis( 'off' )
ax0.set_title( 'plantA_23, $\sigma=0$' )

ax1.imshow(edge[1], cmap=plt.cm.gray, interpolation='nearest')
ax1.axis( 'off' )
ax1.set_title( 'plantA_39, $\sigma=1$' )

ax2.imshow(edge[2], cmap=plt.cm.gray, interpolation='nearest')
ax2.axis( 'off' )
ax2.set_title( 'plantB_26, $\sigma=1$' )

ax3.imshow(edge[3], cmap=plt.cm.gray, interpolation='nearest')
ax3.axis( 'off' )
ax3.set_title( 'plantB_51, $\sigma=1$' )

ax4.imshow(edge1[4], cmap=plt.cm.gray, interpolation='nearest')
ax4.axis( 'off' )
ax4.set_title( 'plantC_15, $\sigma=0.8$' )

ax5.imshow(edge2[5], cmap=plt.cm.gray, interpolation='nearest')
ax5.axis( 'off' )
ax5.set_title( 'plantC_44, $\sigma=0$' )

fig.tight_layout()

plt.savefig( 'edge.png' )
plt.show()