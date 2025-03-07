#!usr/bin/perl -w
use strict;

my $INPUT = $ARGV[0];
my $OUTPUT = $ARGV[1];
$INPUT =~ /(\w+).sig.ps/;
my $GNAME = $1;
open(IN,"$INPUT") or die;
open(OUT,">>$OUTPUT") or die;

my $FL = readline IN;
my ($ID1,$PV1) = (split "\t",$FL)[0,2];
$ID1 =~ /(chr\d+).[a-z]_(\d+)/;
my ($CHR,$P1) = ($1,$2);
chomp($PV1);
my ($start,$end);
$start = $P1;$end = $P1;my $n = 1;my $range = 0;
while(<IN>){
	chomp;
	my ($ID,$PV) = (split "\t",$_)[0,2];
	$ID =~ /(chr\d+).[a-z]_(\d+)/;
	my ($chr,$pos) = ($1,$2);
	if($chr eq $CHR){
		if ($pos - $P1 <= 30000){
			$n++;
			$P1 = $pos;
			$end = $pos;
			if($PV < $PV1){
				$PV1 = $PV;
				$ID1 = $ID;
			}
		}else{
			$range = $end - $start;
			if ($n >=5){
				print OUT "$GNAME\t$CHR\t$start\t$end\t$range\t$ID1\t$PV1\t$n\n";
			}
			$P1 = $pos;
			$n = 1;
			$start = $pos;
			$end = $pos;
			$PV1 = $PV;
			$ID1 = $ID;
		}
	}else{
		$range = $end - $start;
		if ($n>=5){
			print OUT "$GNAME\t$CHR\t$start\t$end\t$range\t$ID1\t$PV1\t$n\n";
		}
		$P1 = $pos;
		$CHR = $chr;
		$n = 1;
		$start = $pos;
		$end = $pos;
		$PV1 = $PV;
		$ID1 = $ID;
	}
}
$range = $end - $start;
if ($n>=5){
	print OUT "$GNAME\t$CHR\t$start\t$end\t$range\t$ID1\t$PV1\t$n\n";
}
close IN;
close OUT;
