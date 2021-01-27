#!/usr/bin/env perl
use strict;

# MRTGBits
# Initial Release
# It works!
# Need to add
# 
# warning and critical levels defined by user or default to 0
# check to make sure warning is always lower than critical
# install guide
# auto build nagios config based on MRTG logs
#

# Set to the MRTG Log file
my $file = $ARGV[0];
my $warning = 100000; # change to ARGV[1]
my $critical = 500000; # change to ARGV[2]
my $status = 0;

# Pull the first two lines only
my @output = qx\head -2 $file\;


# Split the line into Data,Bytes in, Bytes out
my ($date,$in,$out,$report) = (split / /, $output[1])[0,1,2]; # define report to be used later

# Push array
@output = (); # recycling array
push @output,$in;
push @output,$out;
$file = 0; # recycling variable

foreach $_(@output) {
	$_ = $_ * 8;
	if (($_ >= $warning)&&($status != 2)) { $status = 1; }
	if ($_ >= $critical) { $status = 2 ; } 
	if (length($_) <= 3) { print "$_ BITS\n"; }
	elsif (length($_) =~ m/(4|5|6)/) { $_ = $_ / 1000 ; $_ = sprintf("%.2f",$_) ; $_ = "$_ Kilobits " ; }
	elsif (length($_) =~ m/(7|8|9)/) { $_ = $_ / 10000 ; $_ = sprintf("%.2f",$_) ; $_ = "$_ Megabits " ; }
	else { $_ = $_ / 100000 ; $_ = sprintf("%.2f",$_) ; $_ = "$_ Gigabits " ; }
	if ($file == 0) { $report = $_."In " ; $file++ ; }
	else { $report = $report.$_."Out"; }
}



if ($status == 1) {
	print $report." Over $status threshold";
	exit($status);
}
elsif ($status == 2) {
	        print $report." Over $status threshold";
		        exit($status);
		} 
else { print $report ; exit($status); }
