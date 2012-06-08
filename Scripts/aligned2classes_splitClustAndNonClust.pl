#!/usr/bin/perl

use strict;

my $imagicpath="/opt/qb3/imagic-070813/";


#Example: aligned2classes.pl aligned 2 30 30 ang.plt mask
#expected files: aligned.img/hed and aligned.plt with proj_match
#class_* produced with EXTRACT-ALIGNED-IMAGES
#
#2 - number of classes
#40 - minimum size of a class
#15 - minimum size of a subclass
#
#mask - img file with binary mask

use FindBin;

my $home="$FindBin::Bin";

my $numclass=$ARGV[1];
my $minnumForClass=$ARGV[2];
my $minnumForSubClass=$ARGV[3];


if(! -e "$ARGV[0].img"){
  print "File $ARGV[0] doesn't exist\n";
  exit(0);
}
if(! -e "$ARGV[0].plt"){
  print "File $ARGV[0].plt doesn't exist\n";
  exit(0);
}
if(! -e $ARGV[4]){
  print "File $ARGV[4] doesn't exist\n";
  exit(0);
} 
if(! -e "$ARGV[5].img"){
  print "File $ARGV[5] doesn't exist\n";
  exit(0);
} 

open FILE , $ARGV[4];

my @ang=();
while(<FILE>){
  push @ang, $_;
}

print "Total number of angles read: ",$#ang+1,"\n\n\n";

my @out_angles=();
my @out_angles_notclust=();

my %map=(); #counts how many images are mapped to a template image

open FILE , "$ARGV[0].plt";

my $counter_diff_classes=0;
my $i=1;
while(<FILE>){
  my (undef,undef,undef,undef,$ref)= split;

  $ref+=0;

  if ($ref==0){
    next;
  }
  $map{$ref}=$map{$ref}+1;
  #print "$i $ref\n";
  ++$i;
}


# foreach my $class (keys %map){
  
#   if($map{$class} >= $minnumForClass){
#     print "Class: $class size: $map{$class}\n";
#   }
# }
# exit(0);


foreach my $class (sort {$a <=> $b} keys %map){
  my $ok=0;

  if($map{$class} >=$minnumForSubClass*$numclass){
    $ok=1;
    print "Class: $class size: $map{$class}\n";
    `$home/msa.b class_$class $numclass $imagicpath > junk`;

    
    my @out=`grep \"Class number\" msa_classes.lis`;
    foreach my $out_str (@out){
      my (undef, $size)=split /has the following/, $out_str;
      $size+=0;
      print "   Subclass size: $size\n";
      if($size<$minnumForSubClass){
	$ok=0;
	last;
      }
    }
    
    if($ok!=0){ 
      ++$counter_diff_classes;
      print "Taking classes\n";
      for(my $i=0;$i<$numclass;++$i){	
	push @out_angles, $ang[$class - 1];
      }
      
      if (-e "subclasses.img"){
	my $in1="msa_sums
subclasses
";
	runProg("$imagicpath/stand/append.e", $in1);
      }else{
	`cp msa_sums.hed subclasses.hed`;
	`cp msa_sums.img subclasses.img`;
      }   
    }
    
    #exit(0);
  }

  if($ok==0){ #don't make subclasses, create one average and make $numclass copies
    #next;
    print "Making copies of averages for $class\n";
    my $in1="$ARGV[0]
tmp
NO
$class
TOTAL_SUM
NO
";
      
    runProg("$imagicpath/align/alisum.e",$in1);
      
    if (-e "subclassesnotclust.img"){
      my $in1="tmp
subclassesnotclust
";
      runProg("$imagicpath/stand/append.e", $in1);
    }else{
      `cp tmp.hed subclassesnotclust.hed`;
      `cp tmp.img subclassesnotclust.img`;
    }   
    push @out_angles_notclust, $ang[$class - 1];
      
    unlink "tmp.img";unlink "tmp.hed";
  }
}

open FILE, ">subclasses.plt";
print FILE @out_angles;
close FILE;

my $in1="subclasses
WRITE
EUL
FILE
subclasses.plt
NO
NO
";
runProg("$imagicpath/stand/headers.e",$in1);


open FILE, ">subclassesnotclust.plt";
print FILE @out_angles_notclust;
close FILE;

my $in1="subclassesnotclust
WRITE
EUL
FILE
subclassesnotclust.plt
NO
NO
";
runProg("$imagicpath/stand/headers.e",$in1);


print "Number of non-zero diff classes: $counter_diff_classes\n";

exit(0);

sub runProg{
  my $prog=$_[0];
  my $param=$_[1];

  open FILE, ">_tmp_params";

  print FILE $param;

  `$prog < _tmp_params`;

  unlink "_tmp_params";
}
