#!/bin/csh -f

# Run job through csh shell
#$ -S /bin/csh

# The following is for reporting only. It is not really needed
# to run the job. It will show up in your output file.
#

# use current working directory
#$ -cwd

# change to working directory
# cd $SGE_O_WORKDIR



setenv IMAGIC_BATCH

foreach fin ($1)
echo "!  "
echo "! -------------------- IMAGIC ACCUMULATE FILE-------------------- "
echo "! "
echo "! IMAGIC-PROGRAM : angrec:euler.e "
echo "! "
$2/angrec/euler.e <<EOF
C1
SINO
${fin:r}
${fin:r}_sino
YES
0.9
EOF

echo "!  "
echo "! -------------------- IMAGIC ACCUMULATE FILE-------------------- "
echo "! "
echo "! IMAGIC-PROGRAM : stand:subfile.e "
echo "! "
$2/stand/subfile.e <<EOF
${fin:r}_sino
${fin:r}_sino_sub
CENTER
360,100
EOF


echo "! "
echo "! IMAGIC-PROGRAM : angrec:euler.e "
echo "! "
$2/angrec/euler.e <<EOF
C1
SINE
GENERAL
${fin:r}_sino_sub
${fin:r}_sine
EOF
echo "! "
echo "! IMAGIC-PROGRAM : stand:subfile.e "
echo "! "
$2/stand/subfile.e <<EOF
${fin:r}_sine
${fin:r}_sine_cut
APERIODIC
14,14
index
EOF
#rm ${fin:r}_sine.*
#rm ${fin:r}_sino.*
echo "! "
echo "! IMAGIC-PROGRAM : stand:survey.e "
echo "! "
$2/stand/survey.e <<EOF
${fin:r}_sine_cut
LOCAL
UP
EOF
end

echo "!  "
echo "! -------------------- IMAGIC ACCUMULATE FILE-------------------- "
echo "! "
echo "! IMAGIC-PROGRAM : stand:headers.e "
echo "! "
$2/stand/headers.e <<EOF
${fin:r}_sine_cut
PLT
INDEX
22
YES
${fin:r}_sine_cut
EOF
