#!/bin/sh

GNAME=$1

perl SigFilt_pheno_5.pl ./output/${GNAME}_filted.ps ./eqtl2sig/${GNAME}.sig.ps

perl SNP_merge_filt.pl ./eqtl2sig/${GNAME}.sig.ps ./eqtl2sig/${GNAME}.snp_merge.5.txt

awk '{print $6}' ./eqtl2sig/${GNAME}.snp_merge.5.txt > ./eqtl2sig/${GNAME}.peak.snp.list

plink --file 200filted_snpandindel_i --extract ./eqtl2sig/${GNAME}.peak.snp.list --r2 --ld-window 9999999 --ld-window-r2 0.1 --ld-window-kb 99999999 --threads 1 --memory 20000 --out ./eqtl2sig/${GNAME}

perl -pi -e 's/ +/\t/g' ./eqtl2sig/${GNAME}.ld
perl -pi -e 's/^\t//g' ./eqtl2sig/${GNAME}.ld

awk '{print $2":"$3-1"-"$4"\t"$0}' ./eqtl2sig/${GNAME}.snp_merge.5.txt > ./eqtl2sig/${GNAME}.snp_merge.5.txt1
sort -g -k8 ./eqtl2sig/${GNAME}.snp_merge.5.txt1 > ./eqtl2sig/${GNAME}.snp_merge.5.txt2

perl independent_eqtl_sig.pl ./eqtl2sig/${GNAME}.ld ./eqtl2sig/${GNAME}.snp_merge.5.txt2 ./eqtl2sig/${GNAME}.snp_merge.5.txt2.shoulddelete

perl delete.pl ./eqtl2sig/${GNAME}.snp_merge.5.txt2.shoulddelete ./eqtl2sig/${GNAME}.snp_merge.5.txt1 ./eqtlfinalsig/${GNAME}.snp_merge.5.txt.final

rm ./eqtl2sig/${GNAME}.sig.ps ./eqtl2sig/${GNAME}.peak.snp.list ./eqtl2sig/${GNAME}.ld ./eqtl2sig/${GNAME}.snp_merge.5.txt1 ./eqtl2sig/${GNAME}.snp_merge.5.txt2 ./eqtl2sig/${GNAME}.snp_merge.5.txt2.shoulddelete
