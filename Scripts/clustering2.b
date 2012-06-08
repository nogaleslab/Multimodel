#!/bin/csh -f

set imagicpath="/opt/qb3/imagic-070813"


setenv IMAGIC_BATCH 1
echo "! "
echo "! "
echo "! ====================== "
echo "! IMAGIC ACCUMULATE FILE "
echo "! ====================== "
echo "! "
echo "! "
echo "! IMAGIC program: excopy -----------------------------------------------"
echo "! "
$imagicpath/incore/excopy.e <<EOF
EXTRACT
subclasses_mask
cluster2
PLT
cluster2
EOF
echo "! "
echo "! IMAGIC program: true3d -----------------------------------------------"
echo "! "
$imagicpath/threed/true3d.e <<EOF
C1
YES
cluster2
ANGREC_HEADER_VALUES
cluster2reco
cluster2reco_repro
cluster2reco_repro_err
NO
0.75
0.8
EOF
echo "! "
echo "! IMAGIC program: em2em ------------------------------------------------"
echo "! "
$imagicpath/stand/em2em.e <<EOF
IM
SPI
SINGLE_FILE
3
cluster2reco
cluster2reco.spi
LINUX
YES
EOF
