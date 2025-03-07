Quantification of gene expression
===

Quantification of gene transcriptipon
---

module load TrimGalore/0.6.6
module load hisat2/2.1.0
module load StringTie/1.3.0-foss-2016b

trim_galore --phred33 --fastqc --fastqc_args "--noextract --outdir ./fastqc" -o ./fastqc --paired ./rawdata/${sample}_1.fq.gz ./rawdata/${sample}_2.fq.gz\<br>
hisat2 -p 4 --dta -x Zea_mays.B73_RefGen_v4_tran -1 ./fastqc/${sample}_1_val_1.fq.gz -2 ./fastqc/${sample}_2_val_2.fq.gz -S ./bamfile/${sample}.sam\<br>
samtools view -@ 4 -b -f 0x0002 -q 50 ./bamfile/${sample}.sam | samtools sort -@ 4 -o ./bamfile/${sample}_uq_sortp.bam\<br>
stringtie ./bamfile/${sample}_uq_sortp.bam -p 4 -G Zea_mays.B73_RefGen_v4.45.gtf -e -A ./stringtie/${sample}_uq_gene_abund.tab\<br>

Quantification of gene translation
---

module load hisat2/2.1.0
module load SAMtools/1.7
module load RiboCode/1.2.11

hisat2 -p 2 --dta -x Zea_mays.B73_RefGen_v4_tran -U ${sample}.clean.fq.gz -S ./bamfile/${sample}.sam\<br>
samtools view -@ 2 -b -q 50 ./bamfile/${sample}.sam | samtools sort -@ 2 -o ./bamfile/${sample}_uq_sortp.bam\<br>
ORFcount -g Zea_mays.B73_RefGen_v4.45_mergedCDS.gtf -r ${sample}_uq_sortp.bam -f 15 -l 5 -e 100 -m 25 -M 29 -o ./ribocode/${sample}_uq_orfcount\<br>
