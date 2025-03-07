#!/usr/bin/perl -w
use strict;
die "usage: perl $0 in out\n", if (@ARGV != 2);

my $in=shift;
my $out=shift;

open BAM,"$in";
open OUT,">$out";

my(@array,$flag,$length,$coordinate,$pos,$m1,$m2,$m3,$n,$n1,$n2,$s1,$s2);
while(<BAM>){
	chomp;
	@array = split /\s+/;
	$flag = $array[5];
	$length = length($array[9]);
	if($array[1] == 0){
		if($flag =~ m/^[0-9]+M$/i){
			if($length == 25){
				$coordinate = $array[3] + 12;
				print OUT "@array\t$coordinate\n";
			}elsif($length == 26){
				$coordinate = $array[3] + 13;
				print OUT "@array\t$coordinate\n";
			}elsif($length == 27){
				$coordinate = $array[3] + 14;
				print OUT "@array\t$coordinate\n";
			}elsif($length == 28 or $length == 29){
				$coordinate = $array[3] + 15;
				print OUT "@array\t$coordinate\n";
			}else{print OUT "@array\tRmvLen\n";
			}
		}elsif($flag =~ m/^[0-9]+S[0-9]+M$/i){
			($pos) = (split(/[SMN]/,$flag))[1];
			if($pos == 25){
				$coordinate = $array[3] + 12;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 26){
				$coordinate = $array[3] + 13;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 27){
				$coordinate = $array[3] + 14;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 28 or $pos == 29){
				$coordinate = $array[3] + 15;
				print OUT "@array\t$coordinate\n";
			}else{print OUT "@array\tRmvLen\n";
			}
		}elsif($flag =~ m/^[0-9]+M[0-9]+S$/i){
			($pos) = (split(/[SMN]/,$flag))[0];
			if($pos == 25){
				$coordinate = $array[3] + 12;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 26){
				$coordinate = $array[3] + 13;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 27){
				$coordinate = $array[3] + 14;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 28 or $pos == 29){
				$coordinate = $array[3] + 15;
				print OUT "@array\t$coordinate\n";
			}else{print OUT "@array\tRmvLen\n";
			}
		}elsif($flag =~ m/^[0-9]+S[0-9]+M[0-9]+S$/i){
			($pos) = (split(/[SMN]/,$flag))[1];
			if($pos == 25){
				$coordinate = $array[3] + 12;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 26){
				$coordinate = $array[3] + 13;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 27){
				$coordinate = $array[3] + 14;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 28 or $pos == 29){
				$coordinate = $array[3] + 15;
				print OUT "@array\t$coordinate\n";
			}else{print OUT "@array\tRmvLen\n";
			}
		}elsif($flag =~ m/^[0-9]+M[0-9]+N[0-9]+M$/i){
			($m1,$n,$m2) = (split(/[SMN]/,$flag))[0,1,2];
			$pos = $m1 + $m2;
			if($pos == 25){
				if($m1 >= 13){
					$coordinate = $array[3] + 12;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 <13){
					$coordinate = $array[3] + $n + 12;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 26){
				if($m1 >= 14){
					$coordinate = $array[3] + 13;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 <14){
					$coordinate = $array[3] + $n + 13;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 27){
				if($m1 >= 15){
					$coordinate = $array[3] + 14;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 <15){
					$coordinate = $array[3] + $n + 14;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 28 or $pos == 29){
				if($m1 >= 16){
					$coordinate = $array[3] + 15;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 <16){
					$coordinate = $array[3] + $n + 15;
					print OUT "@array\t$coordinate\n";
				}
			}else{print OUT "@array\tRmvLen\n";
			}
		}elsif($flag =~ m/^[0-9]+S[0-9]+M[0-9]+N[0-9]+M$/i){
			($s1,$m1,$n,$m2) = (split(/[SMN]/,$flag))[0,1,2,3];
			$pos = $m1 + $m2;
			if($pos == 25){
				if($m1 >= 13){
					$coordinate = $array[3] + 12;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 <13){
					$coordinate = $array[3] + $n + 12;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 26){
				if($m1 >= 14){
					$coordinate = $array[3] + 13;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 <14){
					$coordinate = $array[3] + $n + 13;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 27){
				if($m1 >= 15){
					$coordinate = $array[3] + 14;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 <15){
					$coordinate = $array[3] + $n + 14;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 28 or $pos == 29){
				if($m1 >= 16){
					$coordinate = $array[3] + 15;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 <16){
					$coordinate = $array[3] + $n + 15;
					print OUT "@array\t$coordinate\n";
				}
			}else{print OUT "@array\tRmvLen\n";
			}
		}elsif($flag =~ m/^[0-9]+M[0-9]+N[0-9]+M[0-9]+S$/i){
			($m1,$n,$m2,$s2) = (split(/[SMN]/,$flag))[0,1,2,3];
			$pos = $m1 + $m2;
			if($pos == 25){
				if($m1 >= 13){
					$coordinate = $array[3] + 12;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 <13){
					$coordinate = $array[3] + $n + 12;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 26){
				if($m1 >= 14){
					$coordinate = $array[3] + 13;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 <14){
					$coordinate = $array[3] + $n + 13;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 27){
				if($m1 >= 15){
					$coordinate = $array[3] + 14;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 <15){
					$coordinate = $array[3] + $n + 14;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 28 or $pos == 29){
				if($m1 >= 16){
					$coordinate = $array[3] + 15;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 <16){
					$coordinate = $array[3] + $n + 15;
					print OUT "@array\t$coordinate\n";
				}
			}else{print OUT "@array\tRmvLen\n";
			}
		}elsif($flag =~ m/^[0-9]+S[0-9]+M[0-9]+N[0-9]+M[0-9]+S$/i){
			($s1,$m1,$n,$m2,$s2) = (split(/[SMN]/,$flag))[0,1,2,3,4];
			$pos = $m1 + $m2;
			if($pos == 25){
				if($m1 >= 13){
					$coordinate = $array[3] + 12;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 <13){
					$coordinate = $array[3] + $n + 12;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 26){
				if($m1 >= 14){
					$coordinate = $array[3] + 13;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 <14){
					$coordinate = $array[3] + $n + 13;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 27){
				if($m1 >= 15){
					$coordinate = $array[3] + 14;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 <15){
					$coordinate = $array[3] + $n + 14;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 28 or $pos == 29){
				if($m1 >= 16){
					$coordinate = $array[3] + 15;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 <16){
					$coordinate = $array[3] + $n + 15;
					print OUT "@array\t$coordinate\n";
				}
			}else{print OUT "@array\tRmvLen\n";
			}
		}elsif($flag =~ m/^[0-9]+M[0-9]+N[0-9]+M[0-9]+N[0-9]+M$/i){
			($m1,$n1,$m2,$n2,$m3) = (split(/[SMN]/,$flag))[0,1,2,3,4];
			$pos = $m1 + $m2 + $m3;
			if($pos == 25){
				if($m1 >= 13){
					$coordinate = $array[3] + 12;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 + $m2 >= 13){
					$coordinate = $array[3] + $n1 + 12;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 + $m2 < 13){
					$coordinate = $array[3] + $n1 +$n2 + 12;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 26){
				if($m1 >= 14){
					$coordinate = $array[3] + 13;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 + $m2 >= 14){
					$coordinate = $array[3] + $n1 + 13;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 + $m2 < 14){
					$coordinate = $array[3] + $n1 +$n2 + 13;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 27){
				if($m1 >= 15){
					$coordinate = $array[3] + 14;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 + $m2 >= 15){
					$coordinate = $array[3] + $n1 + 14;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 + $m2 < 15){
					$coordinate = $array[3] + $n1 +$n2 + 14;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 28 or $pos == 29){
				if($m1 >= 16){
					$coordinate = $array[3] + 15;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 + $m2 >= 16){
					$coordinate = $array[3] + $n1 + 15;
					print OUT "@array\t$coordinate\n";
				}elsif($m1 + $m2 < 16){
					$coordinate = $array[3] + $n1 +$n2 + 15;
					print OUT "@array\t$coordinate\n";
				}
			}else{print OUT "@array\tRmvLen\n";
			}
		}else{print OUT "@array\tRmvFlg\n";
		}
	}elsif($array[1] == 16){
		if($flag =~ m/^[0-9]+M$/i){
			if($length == 25){
				$coordinate = $array[3] + $length - 13;
				print OUT "@array\t$coordinate\n";
			}elsif($length == 26){
				$coordinate = $array[3] + $length - 14;
				print OUT "@array\t$coordinate\n";
			}elsif($length == 27){
				$coordinate = $array[3] + $length - 15;
				print OUT "@array\t$coordinate\n";
			}elsif($length == 28 or $length == 29){
				$coordinate = $array[3] + $length - 16;
				print OUT "@array\t$coordinate\n";
			}else{print OUT "@array\tRmvLen\n";
			}
		}elsif($flag =~ m/^[0-9]+S[0-9]+M$/i){
			($pos) = (split(/[SMN]/,$flag))[1];
			if($pos == 25){
				$coordinate = $array[3] + $pos - 13;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 26){
				$coordinate = $array[3] + $pos - 14;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 27){
				$coordinate = $array[3] + $pos - 15;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 28 or $pos == 29){
				$coordinate = $array[3] + $pos - 16;
				print OUT "@array\t$coordinate\n";
			}else{print OUT "@array\tRmvLen\n";
			}
		}elsif($flag =~ m/^[0-9]+M[0-9]+S$/i){
			($pos) = (split(/[SMN]/,$flag))[0];
			if($pos == 25){
				$coordinate = $array[3] + $pos - 13;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 26){
				$coordinate = $array[3] + $pos - 14;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 27){
				$coordinate = $array[3] + $pos - 15;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 28 or $pos == 29){
				$coordinate = $array[3] + $pos - 16;
				print OUT "@array\t$coordinate\n";
			}else{print OUT "@array\tRmvLen\n";
			}
		}elsif($flag =~ m/^[0-9]+S[0-9]+M[0-9]+S$/i){
			($pos) = (split(/[SMN]/,$flag))[1];
			if($pos == 25){
				$coordinate = $array[3] + $pos - 13;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 26){
				$coordinate = $array[3] + $pos - 14;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 27){
				$coordinate = $array[3] + $pos - 15;
				print OUT "@array\t$coordinate\n";
			}elsif($pos == 28 or $pos == 29){
				$coordinate = $array[3] + $pos - 16;
				print OUT "@array\t$coordinate\n";
			}else{print OUT "@array\tRmvLen\n";
			}
		}elsif($flag =~ m/^[0-9]+M[0-9]+N[0-9]+M$/i){
			($m1,$n,$m2) = (split(/[SMN]/,$flag))[0,1,2];
			$pos = $m1 + $m2;
			if($pos == 25){
				if($m2 >= 13){
					$coordinate = $array[3] + $m1 + $n + $m2 - 13;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 < 13){
					$coordinate = $array[3] + $m1 + $m2 - 13;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 26){
				if($m2 >= 14){
					$coordinate = $array[3] + $m1 + $n + $m2 - 14;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 < 14){
					$coordinate = $array[3] + $m1 + $m2 - 14;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 27){
				if($m2 >= 15){
					$coordinate = $array[3] + $m1 + $n + $m2 - 15;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 < 15){
					$coordinate = $array[3] + $m1 + $m2 - 15;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 28 or $pos == 29){
				if($m2 >= 16){
					$coordinate = $array[3] + $m1 + $n + $m2 - 16;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 < 16){
					$coordinate = $array[3] + $m1 + $m2 - 16;
					print OUT "@array\t$coordinate\n";
				}
			}else{print OUT "@array\tRmvLen\n";
			}
		}elsif($flag =~ m/^[0-9]+S[0-9]+M[0-9]+N[0-9]+M$/i){
			($s1,$m1,$n,$m2) = (split(/[SMN]/,$flag))[0,1,2,3];
			$pos = $m1 + $m2;
			if($pos == 25){
				if($m2 >= 13){
					$coordinate = $array[3] + $m1 + $n + $m2 - 13;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 < 13){
					$coordinate = $array[3] + $m1 + $m2 - 13;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 26){
				if($m2 >= 14){
					$coordinate = $array[3] + $m1 + $n + $m2 - 14;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 < 14){
					$coordinate = $array[3] + $m1 + $m2 - 14;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 27){
				if($m2 >= 15){
					$coordinate = $array[3] + $m1 + $n + $m2 - 15;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 < 15){
					$coordinate = $array[3] + $m1 + $m2 - 15;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 28 or $pos == 29){
				if($m2 >= 16){
					$coordinate = $array[3] + $m1 + $n + $m2 - 16;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 < 16){
					$coordinate = $array[3] + $m1 + $m2 - 16;
					print OUT "@array\t$coordinate\n";
				}
			}else{print OUT "@array\tRmvLen\n";
			}
		}elsif($flag =~ m/^[0-9]+M[0-9]+N[0-9]+M[0-9]+S$/i){
			($m1,$n,$m2,$s2) = (split(/[SMN]/,$flag))[0,1,2,3];
			$pos = $m1 + $m2;
			if($pos == 25){
				if($m2 >= 13){
					$coordinate = $array[3] + $m1 + $n + $m2 - 13;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 < 13){
					$coordinate = $array[3] + $m1 + $m2 - 13;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 26){
				if($m2 >= 14){
					$coordinate = $array[3] + $m1 + $n + $m2 - 14;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 < 14){
					$coordinate = $array[3] + $m1 + $m2 - 14;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 27){
				if($m2 >= 15){
					$coordinate = $array[3] + $m1 + $n + $m2 - 15;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 < 15){
					$coordinate = $array[3] + $m1 + $m2 - 15;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 28 or $pos == 29){
				if($m2 >= 16){
					$coordinate = $array[3] + $m1 + $n + $m2 - 16;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 < 16){
					$coordinate = $array[3] + $m1 + $m2 - 16;
					print OUT "@array\t$coordinate\n";
				}
			}else{print OUT "@array\tRmvLen\n";
			}
		}elsif($flag =~ m/^[0-9]+S[0-9]+M[0-9]+N[0-9]+M[0-9]+S$/i){
			($s1,$m1,$n,$m2,$s2) = (split(/[SMN]/,$flag))[0,1,2,3,4];
			$pos = $m1 + $m2;
			if($pos == 25){
				if($m2 >= 13){
					$coordinate = $array[3] + $m1 + $n + $m2 - 13;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 < 13){
					$coordinate = $array[3] + $m1 + $m2 - 13;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 26){
				if($m2 >= 14){
					$coordinate = $array[3] + $m1 + $n + $m2 - 14;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 < 14){
					$coordinate = $array[3] + $m1 + $m2 - 14;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 27){
				if($m2 >= 15){
					$coordinate = $array[3] + $m1 + $n + $m2 - 15;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 < 15){
					$coordinate = $array[3] + $m1 + $m2 - 15;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 28 or $pos == 29){
				if($m2 >= 16){
					$coordinate = $array[3] + $m1 + $n + $m2 - 16;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 < 16){
					$coordinate = $array[3] + $m1 + $m2 - 16;
					print OUT "@array\t$coordinate\n";
				}
			}else{print OUT "@array\tRmvLen\n";
			}
		}elsif($flag =~ m/^[0-9]+M[0-9]+N[0-9]+M[0-9]+N[0-9]+M$/i){
			($m1,$n1,$m2,$n2,$m3) = (split(/[SMN]/,$flag))[0,1,2,3,4];
			$pos = $m1 + $m2 + $m3;
			if($pos == 25){
				if($m3 >= 13){
					$coordinate = $array[3] + $m1 + $n1 + $m2 + $n2 + $m3 - 13;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 + $m3 >= 13){
					$coordinate = $array[3] + $m1 + $n1 + $m2 + $m3 - 13;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 + $m3 < 13){
					$coordinate = $array[3] + $m1 + $m2 + $m3 - 13;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 26){
				if($m3 >= 14){
					$coordinate = $array[3] + $m1 + $n1 + $m2 + $n2 + $m3 - 14;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 + $m3 >= 14){
					$coordinate = $array[3] + $m1 + $n1 + $m2 + $m3 - 14;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 + $m3 < 14){
					$coordinate = $array[3] + $m1 + $m2 + $m3 - 14;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 27){
				if($m3 >= 15){
					$coordinate = $array[3] + $m1 + $n1 + $m2 + $n2 + $m3 - 15;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 + $m3 >= 15){
					$coordinate = $array[3] + $m1 + $n1 + $m2 + $m3 - 15;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 + $m3 < 15){
					$coordinate = $array[3] + $m1 + $m2 + $m3 - 15;
					print OUT "@array\t$coordinate\n";
				}
			}elsif($pos == 28 or $pos == 29){
				if($m3 >= 16){
					$coordinate = $array[3] + $m1 + $n1 + $m2 + $n2 + $m3 - 16;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 + $m3 >= 16){
					$coordinate = $array[3] + $m1 + $n1 + $m2 + $m3 - 16;
					print OUT "@array\t$coordinate\n";
				}elsif($m2 + $m3 < 16){
					$coordinate = $array[3] + $m1 + $m2 + $m3 - 16;
					print OUT "@array\t$coordinate\n";
				}
			}else{print OUT "@array\tRmvLen\n";
			}
		}else{print OUT "@array\tRmvFlg\n";
		}
	}
}


close BAM;
close OUT;