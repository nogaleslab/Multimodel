#!/usr/bin/perl


use strict;

if(! -f $ARGV[0]){
  print "File $ARGV[0] does not exist\n";
  exit(0);
}
if(! -f $ARGV[1]){
  print "File $ARGV[1] does not exist\n";
  exit(0);
}


#my $num_images=150;

#my $value=-1;#-999999999;
my $value=-999999999;
#my $value=-2;

#read angle files
my %map_angle_2_index=();


open FILE1, $ARGV[0];

my $i=0;
while(<FILE1>){
  chomp;

  my ($a1, $a2, $a3)=split;

  push @{$map_angle_2_index{"$a1 $a2 $a3"}}, $i;

  ++$i;
}


#foreach(keys %map_angle_2_index){
#  if($#{$map_angle_2_index{$_}}>=2){
#    print "$_ ::: @{$map_angle_2_index{$_}} \n";
#  }
#}
#exit(0);

#parse common line file

my @cl=(); #matrix of common lines
open FILE, $ARGV[1];
while(<FILE>){
  chomp;
  my @tmp=split;
  #print "$#tmp\n";
  push @cl, [ @tmp ];
}


foreach(keys %map_angle_2_index){
  my @ids=@{$map_angle_2_index{$_}};
  for(my $i=0;$i<=$#ids;++$i){
    for(my $j=$i+1;$j<=$#ids;++$j){
      #print $cl[$ids[$i]][$ids[$j]], " ";
      $cl[$ids[$i]][$ids[$j]]=$value;
      $cl[$ids[$j]][$ids[$i]]=$value;
    }
  }
  #print "\n";
}
for(my $i=0;$i<=$#cl;++$i){
  print "@{$cl[$i]}\n";
}

