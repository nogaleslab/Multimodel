#!/bin/csh -f
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
/opt/qb3/imagic-070813/incore/excopy.e <<EOF
EXTRACT
subclasses_mask
cluster1
PLT
cluster1
EOF
echo "! "
echo "! IMAGIC program: true3d -----------------------------------------------"
echo "! "
/opt/qb3/imagic-070813/threed/true3d.e <<EOF
C1
YES
cluster1
ANGREC_HEADER_VALUES
cluster1reco
cluster1reco_repro
cluster1reco_repro_err
NO
0.75
0.8
EOF
echo "! "
echo "! IMAGIC program: em2em ------------------------------------------------"
echo "! "
/opt/qb3/imagic-070813/stand/em2em.e <<EOF
IM
SPI
SINGLE_FILE
3
cluster1reco
cluster1reco.spi
LINUX
YES
EOF
