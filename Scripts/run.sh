#!/bin/csh
#
# Name of job
#$ -N RNAP_multi

# Merge the standard out and standard error to one file
##$ -j y

# Run job through csh shell
#$ -S /bin/csh

# The following is for reporting only. It is not really needed
# to run the job. It will show up in your output file.
#

# use current working directory
#$ -cwd

# change to working directory
# cd $SGE_O_WORKDIR
/usr/local/spiderweb-16.04/spider/bin/spider_linux_mpfftw_opt64 spi/spi @refine_w_apmq_MR << EOF
../all_norm_bpf_mask
../all_norm_bpf
10000
2
vol
./Res
/scratch/temp
EOF

