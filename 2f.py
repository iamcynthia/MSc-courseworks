# --
# 2f.py -- Detect straight lines in each image using the Hough transform.
# --

import imageio
import matplotlib . pyplot as plt 
import skimage.color as color 
import skimage.transform as transform
import skimage.feature as feature

line = []
line1 = []
line2 = []
DATA_DIR = 'img/'
DATA_FILES = ['plantA_23.jpg', 'plantA_39.jpg', 'plantB_26.jpg', 'plantB_51.jpg', 'plantC_15.jpg', 'plantC_44.jpg']
# read an image from a f i l e into an image object (named ’im ’)
for ( j, myfile ) in zip( range( len( DATA_FILES )), DATA_FILES ):
    im = imageio.imread(DATA_DIR + myfile)
#-convert the image to greyscale for canny edge detection
    img = color.rgb2gray( im )
#-detect edges using Canny algorithm for two values of sigma
    edges = feature.canny( img, sigma=1 ) 
#-apply classic straight-line Hough transform
    lines = transform.probabilistic_hough_line( edges, threshold=10, line_length=5, line_gap=3 )
    line.append(lines)

#-plot the results
fig, ((ax0, ax1, ax2), (ax3, ax4, ax5)) = plt.subplots( nrows=2, ncols=3, figsize=(10, 5), sharex=True, sharey=True )

for line_ in line[0]:
    p0, p1 = line_
    ax0.plot(( p0[0], p1[0] ), ( p0[1], p1[1] ))
ax0.set_xlim(( 0, img.shape[1] ))
ax0.set_ylim(( img.shape[0], 0 ))
ax0.set_title( 'plantA_23' )

for line_ in line[1]:
    p0, p1 = line_
    ax1.plot(( p0[0], p1[0] ), ( p0[1], p1[1] ))
ax1.set_xlim(( 0, img.shape[1] ))
ax1.set_ylim(( img.shape[0], 0 ))
ax1.set_title( 'plantA_39' )

for line_ in line[2]:
    p0, p1 = line_
    ax2.plot(( p0[0], p1[0] ), ( p0[1], p1[1] ))
ax2.set_xlim(( 0, img.shape[1] ))
ax2.set_ylim(( img.shape[0], 0 ))
ax2.set_title( 'plantB_26' )

for line_ in line[3]:
    p0, p1 = line_
    ax3.plot(( p0[0], p1[0] ), ( p0[1], p1[1] ))
ax3.set_xlim(( 0, img.shape[1] ))
ax3.set_ylim(( img.shape[0], 0 ))
ax3.set_title( 'plantB_51' )

for line_ in line[4]:
    p0, p1 = line_
    ax4.plot(( p0[0], p1[0] ), ( p0[1], p1[1] ))
ax4.set_xlim(( 0, img.shape[1] ))
ax4.set_ylim(( img.shape[0], 0 ))
ax4.set_title( 'plantC_15' )

for line_ in line[5]:
    p0, p1 = line_
    ax5.plot(( p0[0], p1[0] ), ( p0[1], p1[1] ))
ax5.set_xlim(( 0, img.shape[1] ))
ax5.set_ylim(( img.shape[0], 0 ))
ax5.set_title( 'plantC_44' )

fig.tight_layout()

plt.savefig( 'line.png' )
plt.show()