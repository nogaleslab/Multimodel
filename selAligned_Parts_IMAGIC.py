#!/usr/bin/env python

# usage:  selAligned_Parts_IMAGIC.py [projMatchOut].plt [stdDevCutoff]

#positive stdDev cutoff --> less particles
#negative stDev cutoff --> more particles included

import sys
import math
file = sys.argv[1]
file=open(file,'r')
cutoff = float(sys.argv[2])

i=1
sum=0

for line in file:
	
	tmp=line.split()
	CC = float(tmp[3])
	
	sum=sum+CC
	#print ('%s	1	%s' %(i,CC))
			
	i=i+1

file.close()
i=i-1

#print ("Total number of particles = %s" %(i))

avg=sum/i

#print ("Average CC = %s" %(avg))

#calculate std dev for dataset
file=sys.argv[1]
file=open(file,'r')

std=0

for line in file: 
	
        tmp=line.split()
        CC = float(tmp[3])

  	std1=(CC-avg)*(CC-avg)
	std=std+std1

    
file.close()
div=std/i
stdDev=math.sqrt(div)

#print ("Standard deviation of CC = %s" %(stdDev))

cut = avg+(cutoff*stdDev)

#print ("CC cutoff = %s" %(cut))

file=sys.argv[1]
file=open(file,'r')

k=1 

for line in file:

	tmp=line.split()

	CC = float(tmp[3])

	if CC > cut:
		
		print k
		
	k=k+1

file.close()


