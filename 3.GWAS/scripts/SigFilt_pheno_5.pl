#!usr/bin/perl -w
use strict;

my $INPUT = $ARGV[0];
my $OUTPUT = $ARGV[1];

open (IN,"$INPUT") or die;
open (OUT,">$OUTPUT") or die;
readline(IN);
while (<IN>){
	chomp;
	my ($pv) = (split "\t")[2];
	if ($pv <= 1/100000){
		print OUT "$_\n";
	}
}
close IN;
close OUT;
