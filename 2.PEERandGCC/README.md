Basic processing of data
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
