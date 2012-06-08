#!/usr/bin/perl

use strict;

my $imagicpath="/opt/qb3/imagic-070813/";

use FindBin;

my $home="$FindBin::Bin";

my $fnm=$ARGV[0];
my $num=$ARGV[1];

`cp ${fnm}.img all.img`;
`cp ${fnm}.hed all.hed`;

$fnm="all";

#first, compute PRED (coordinates in SINE) for all images

my $index_plt=1;
open FILE_INDEX, ">index.plt";

for (my $i=1;$i<=$num;$i++){
  print "Processing $i\n";
  
  #Step 1
  `$home/cccl_init.b $i $fnm $imagicpath`;
  
  #Step 2
  `$home/cccl_pred_plt.b all_${i}.img $imagicpath`;
  
  open FILE, "all_${i}.plt";

  for(my $j=1;$j<=$i;++$j){
    my $line=<FILE>;
    my (undef,$c1,$c2,$index)=split /\s+/,$line;

    #print "$c1 $c2 $index\n";
    print FILE_INDEX "$c2 $c1 $index_plt\n";
    ++$index_plt;

    $line=<FILE>; #read next, the opposite direction
  }

  close FILE;
  
  `rm all_${i}.img all_${i}.hed all_${i}.plt`;
}

close FILE_INDEX;


#Step 3
print "cccl_sino.b\n";
`$home/cccl_sino.b ${fnm}.img $imagicpath`;
  
#Step 4, create a matrix
open FILE, "${fnm}_sine_cut.plt";

my $c=0;
my $r=0;
my @cccl=();
while(<FILE>){
  chomp;
  my ($index, $cccl)=split;

  print "$index : $cccl : $r $c\n";
  $cccl[$r][$c]=$cccl[$c][$r]=$cccl;

  ++$c;
  if($c>$r){
    $c=0;
    ++$r;
  }
}
close FILE;

open FILE, ">cccl_matrix.txt";

for (my $i=0;$i<=$#cccl;$i++){
  my @tmp=@{$cccl[$i]};
  print FILE "@tmp\n";
}
