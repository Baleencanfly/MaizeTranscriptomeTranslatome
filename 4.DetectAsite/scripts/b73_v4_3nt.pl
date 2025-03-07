#!/usr/bin/perl
use strict;

die usage() if @ARGV == 0;
my ($gene_FPKM,$uniq,$GFF) = @ARGV;

my %hash_gene_list;
open NEW,"$gene_FPKM" or die;
while(<NEW>){
	chomp;
	my @array = split /\s+/;
	if($array[1] >= 1){
		$hash_gene_list{$array[0]} = $array[1];
	}
}
close NEW;

my %hash_uniq_read;
open NEW,"$uniq" or die;
while(<NEW>){
	chomp;
	next if ($_ =~ /^@/);
	my @array = split /\s+/;
#	my $length = length($array[9]);
#	if($length == $read_length){
		if($array[1] == 0){
			my $target = "$array[2]"."-"."$array[3]";
			$hash_uniq_read{$target}++;
		}
		elsif($array[1] == 16){
			my $length = length($array[9]);
			my $position = $array[3] + $length -1;
			my $target = "$array[2]"."-"."$position";
			$hash_uniq_read{$target}++;
#		}
	}
}
close NEW;

my %hash_gene_CDS;
open NEW,"$GFF" or die;
while(<NEW>){
	chomp;
	my @array = split /\s+/;
#	if($array[2] eq "mRNA" and $array[6] eq "+"){
#		if($_ =~ /ID=(\w+_\w+);Parent/ or $_ =~ /ID=(\w+\.\d_\w+);Parent/){
#			my $transcript = $1;
#		}
#	}
	if($array[2] eq "CDS"){
		if($_ =~ /Parent=transcript:(\w+)_\w+;protein/){
			my $gene = $1;
			my $target = "$array[0]"."&"."$gene"."&"."$array[6]";
			if(exists $hash_gene_list{$gene}){
#				print "$target\n";
				push @{$hash_gene_CDS{$target}},$array[3];
				push @{$hash_gene_CDS{$target}},$array[4];
			}
		}
	}
}
close NEW;

my %hash_result_start;
my %hash_result_stop;
foreach my $key(keys %hash_gene_CDS){
	my @aa = split /&/,$key;
	my $chromosome = $aa[0];
	my $gene = $aa[1];
	my $direction = $aa[2];
	my @sorted = sort {$a<=>$b} @{$hash_gene_CDS{$key}};
	my $start;
	my $end;
	if($direction eq "+"){
		$start = $sorted[0];
		$end = $sorted[-1];
		my $cal1 = -30;
		for(my $number1=$start - 30;$number1<=$start + 50;$number1++){
			my $target = "$chromosome"."-"."$number1";
			if(exists $hash_uniq_read{$target}){
				$hash_result_start{$cal1} += $hash_uniq_read{$target};
			}
			else{
				$hash_result_start{$cal1} += 0;
			}
			$cal1++;
		}
		my $cal2 = -40;
		for(my $number2=$end - 40;$number2<=$end + 10;$number2++){
			my $target = "$chromosome"."-"."$number2";
			if(exists $hash_uniq_read{$target}){
				$hash_result_stop{$cal2} += $hash_uniq_read{$target};
			}
			else{
				$hash_result_stop{$cal2} += 0;
			}
			$cal2++;
		}
	}
	else{
		$start = $sorted[-1];
		$end = $sorted[0];
		my $cal1 = 50;
		for(my $number1=$start - 50;$number1<=$start + 30;$number1++){
			my $target = "$chromosome"."-"."$number1";
			if(exists $hash_uniq_read{$target}){
				$hash_result_start{$cal1} += $hash_uniq_read{$target};
			}
			else{
				$hash_result_start{$cal1} += 0;
			}
			$cal1--;
		}
		my $cal2 = 10;
		for(my $number2=$end - 10;$number2<=$end + 40;$number2++){
			my $target = "$chromosome"."-"."$number2";
			if(exists $hash_uniq_read{$target}){
				$hash_result_stop{$cal2} += $hash_uniq_read{$target};
			}
			else{
				$hash_result_stop{$cal2} += 0;
			}
			$cal2--;
		}
	}
}

open NEW1,">./read_number_at_CDS_start" or die;
print NEW1 "position\tread_number\n";
foreach my $line1(sort {$a<=>$b} keys %hash_result_start){
	print NEW1 "$line1\t$hash_result_start{$line1}\n";
}
close NEW1;

open NEW2,">./read_number_at_CDS_stop" or die;
print NEW2 "position\tread_number\n";
foreach my $line2(sort {$a<=>$b} keys %hash_result_stop){
	print NEW2 "$line2\t$hash_result_stop{$line2}\n";
}
close NEW2;

sub usage{
	my $die =<<DIE;
	usage: perl *.pl gene.fpkm_tracking uniq_map_accepted_hits.bam ZmB73_5a_FGS_chr.GFF
DIE
}
