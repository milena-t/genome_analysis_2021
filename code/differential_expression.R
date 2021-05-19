### Differential expression analysis ###

## The student manual suggests DESeq2, but the installation does not work, there is some error with the versions, I think
if (FALSE){
  if (!requireNamespace("BiocManager", quietly = TRUE)){
    install.packages("BiocManager")
    BiocManager::install(version = '3.12')
    BiocManager::install("DESeq2", version = "3.12")
  }
  library(DESeq2)
}
# The installation does not work, there is some error with the versions
# For this reason I will use EdgeR for differential expression analysis

library(edgeR)



samples_STAR<- c("RR1719013_","RR1719014_","RR1719015_",
            "RR1719016_","RR1719017_","RR1719018_",
            "RR1719204_","RR1719206_","RR1719207_",
            "RR1719208_","RR1719209_","RR1719211_",
            "RR1719212_","RR1719213_","RR1719214_",
            "RR1719241_","RR1719242_")
samples_HISAT<- c("SRR1719013","SRR1719014","SRR1719015",
            "SRR1719016","SRR1719017","SRR1719018",
            "SRR1719204","SRR1719206","SRR1719207",
            "SRR1719208","SRR1719209","SRR1719211",
            "SRR1719212","SRR1719213","SRR1719214",
            "SRR1719241","SRR1719242")
#for some reason RR1719266 is missing?
# Sample classification: developmental stage, limb, replicate
conditions <- c("CS15_F1", "CS15_F2", "CS15_F3",
                "CS15_H1", "CS15_H2", "CS15_H3", 
                "CS16_F1", "CS16_F2", "CS16_F3",
                "CS17_F1", "CS17_F2", "CS17_F3",
                "CS16_H1", "CS17_H1", "CS16_H2",
                "CS17_H2", "CS16_H3")
non_rep_conditions <- c("15_F", "15_F", "15_F",
                        "15_H", "15_H", "15_H", 
                        "16_F", "16_F", "16_F",
                        "17_F", "17_F", "17_F",
                        "16_H", "17_H", "16_H",
                        "17_H", "16_H")

# Choose one of the two! (the files are not in github, only on my local computer)
setwd("/home/milena/bioinformatics/genome_analysis_git/htseq_count/HISAT_count/HISAT_count")
counts <- readDGE(samples_HISAT) # 370315 genes
counts <- calcNormFactors(counts, method = 'TMM')

setwd("/home/milena/bioinformatics/genome_analysis_git/htseq_count")
counts <- readDGE(samples_STAR) # 370315 genes
counts <- calcNormFactors(counts, method = 'TMM')
dim(counts)

#annotate the reads 
colnames(counts) <- conditions
traits <- as.factor(non_rep_conditions)
counts$samples$group <- traits

#convert to CPM values for comparative differential expression analysis
cpm_counts <- cpm(counts)
lcpm<- cpm(counts, log=TRUE)

# remove lowly expressed genes
keep.exprs <- filterByExpr(counts, group=traits)
counts <- counts[keep.exprs,, keep.lib.sizes=FALSE]
dim(counts)
# adjust library size after filtering
noint<-rownames(counts) %in% c("__no_feature", "__ambiguous", "__too_low_aQual", "__not_aligned", "__alignment_not_unique")
counts<-counts[!noint,]
counts$samples$lib.size <- colSums(counts$counts)

# MDS plot
library(RColorBrewer)
dev_stage <- as.factor(c(rep("CS15", 6), rep("CS16", 3), rep("CS17", 3), "CS16", "CS17", "CS16", "CS17", "CS16")) 
limb <- as.factor(c(rep("F", 3), rep("H", 3), rep("F", 6), rep("H", 5)))
lcpm<- cpm(counts, log=TRUE)

par(mfrow=c(1,2))
col.group <- dev_stage #assign colors to mating regimes
levels(col.group) <- brewer.pal(nlevels(col.group),"Set1")
col.group <- as.character(col.group)
col.lane <- limb #assign colors to genders
levels(col.lane) <- brewer.pal(nlevels(col.lane),"Set1")
col.lane <- as.character(col.lane)

plotMDS(lcpm,labels=dev_stage,col=col.group, dim = c(1,2))
title(main="A. Dev. Stage")
plotMDS(lcpm,labels=limb,col=col.lane, dim=c(1,2))
title(main="B. Limb")

lcpm_pca <- prcomp(lcpm)
summary(lcpm_pca)









