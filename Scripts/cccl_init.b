#!/bin/csh -f
setenv IMAGIC_BATCH 1
echo "!  "
echo "! -------------------- IMAGIC ACCUMULATE FILE-------------------- "
echo "! "
echo "! IMAGIC-PROGRAM : stand:append.e "
echo "! "
echo "! "
echo "! IMAGIC-PROGRAM : stand:copyim.e "
echo "! "
$3/stand/copyim.e <<EOF
$2
all_$1
EOF
$3/stand/append.e <<EOF
$2,$1
all_$1
EOF
