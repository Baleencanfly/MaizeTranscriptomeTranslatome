![image](https://github.com/user-attachments/assets/1b260e55-d564-48d1-9c49-d548bf0df2d3)Basic processing of data
===

Remove batch effects
---

```
library(peer)
expr<-read.table("200sample_hisat2stringtie_uqPE_FPKM_rna.txt",row.names=1)  
texpr<-as.data.frame(t(expr))  
model = PEER()  
PEER_setPhenoMean(model,as.matrix(texpr))  
PEER_setNk(model,10)  
PEER_getNk(model)  
PEER_update(model)  
factors = PEER_getX(model)  
residuals = PEER_getResiduals(model)  
write.table(factors,"peer_default_10factors.txt",row.names=F,col.names=F,sep="\t",quote=F)  
write.table(residuals,"peer_residuals.txt",row.names=F,col.names=F,sep="\t",quote=F)  
```

Calculate gini correlation between mRNA and RPF
---

```
library(rsgcc)  
corr<-read.table("merged_matrix.txt",row.names=1)  
datar<-data.frame()  
for(i in 1:18338){  
	rgcc<-gcc.corfinal(cor.pair(c(i,i+18338), GEMatrix = corr, rowORcol = "col",cormethod = "GCC", pernum = 0,sigmethod = "two.sided"))$gcc.fcor  
	mid<-cbind(as.data.frame(colnames(corr)[i]),as.data.frame(colnames(corr)[i+6145]),as.data.frame(rgcc))  
	datar<-rbind(datar,mid)  
}  
write.table(datar,"mRNA_RPF_GCC.txt",row.names=F,col.names=F,sep="\t",quote=F)    
```
