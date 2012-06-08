#!/bin/csh -f

set imagicpath="/sw/imagic-070119/"

setenv IMAGIC_BATCH 1
echo "!  "
echo "! -------------------- IMAGIC ACCUMULATE FILE-------------------- "
echo "! "
echo "! IMAGIC-PROGRAM : threed:fft3d.e "
echo "! "
$imagicpath/threed/fft3d.e <<EOF
FILTER
$1
$1_filt
junkscr
SOFT
$2
.1
EOF

echo "!  "
echo "! -------------------- IMAGIC ACCUMULATE FILE-------------------- "
echo "! "
echo "! IMAGIC-PROGRAM : stand:em2em.e "
echo "! "
$imagicpath/stand/em2em.e <<EOF
IMAGIC
SPI
SINGLE_FILE
3D
$1_filt
$1_filt.spi
Linux
YES
EOF
