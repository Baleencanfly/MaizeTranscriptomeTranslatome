GWAS
===

EMMAX
---

`emmax -v -d 10 -t 200filted_snpandindel_i -p expr_${GNAME}.txt -k 200filted_snpandindel_i.hIBS.kinf -c admixture_200_structure_2line10PCs.txt -o ${GNAME}`  
`awk '{if ($3<=1/1000) print}' ${GNAME}.ps > ${GNAME}_filted.ps`  

Merge eQTL
---

`bash eQTL_identified_fltLD.sh ${GNAME}`  
