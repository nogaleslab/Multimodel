#!/bin/csh -f

#example: ./msa.b eIF3-IRES_mra_class_2 2


set grp=$4

setenv IMAGIC_BATCH 1
echo "!  "
echo "! -------------------- IMAGIC ACCUMULATE FILE-------------------- "
echo "! "
echo "! IMAGIC program: copyim -----------------------------------------------"
echo "! "
/opt/qb3/imagic-070813/stand/copyim.e <<EOF
mask,${grp}
mask2
EOF
echo "! "
echo "! IMAGIC-PROGRAM : msa:msa.e "
echo "! "
$3/msa/msa.e <<EOF
FRESH_MSA
MODULATION
$1
NO
mask2
msa_eigenim
msa_pixcoos
msa_eigenpix
50
69
0.8
msa
EOF
echo "! "
echo "! IMAGIC-PROGRAM : msa:classify.e "
echo "! "
$3/msa/classify.e <<EOF
IMAGES
$1
0
4
YES
$2
msa_classes
EOF
echo "! "
echo "! IMAGIC-PROGRAM : msa:classum.e "
echo "! "
$3/msa/classum.e <<EOF
$1
msa_classes
msa_sums
YES
NONE
0
EOF
