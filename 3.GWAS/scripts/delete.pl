#!/usr/bin/perl -w
use strict;
die "usage: perl $0 in1 in2 out1\n", if (@ARGV != 3);

my $in1=shift;
my $in2=shift;
my $out1=shift;

my %hash;
open IN1,"$in1";
open IN2,"$in2";
open OUT1,">$out1";

my @l1;
my @l2;
while(<IN1>){
        chomp;
        @l1=split(/\t/,$_);
        $hash{$l1[0]}=$_;
}
while(<IN2>){
        chomp;
        @l2=split(/\t/,$_);
        if(!exists $hash{$l2[0]}){
        print OUT1 "$_\n";
        }
}

close IN1;
close IN2;
close OUT1;
