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
echo "! "
echo "! IMAGIC-PROGRAM : angrec:euler.e "
echo "! "
$2/angrec/euler.e <<EOF
C1
PRED
${fin:r}
${fin:r}
EOF
