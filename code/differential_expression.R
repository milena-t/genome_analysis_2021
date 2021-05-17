### Differential expression analysis ###

## The student manual suggests DESeq2
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

setwd("/home/milena/bioinformatics/genome_analysis_git/htseq_count")

samples<- c("RR1719013_","RR1719014_","RR1719015_",
            "RR1719016_","RR1719017_","RR1719018_",
            "RR1719204_","RR1719206_","RR1719207_",
            "RR1719208_","RR1719209_","RR1719211_",
            "RR1719212_","RR1719213_","RR1719214_",
            "RR1719241_","RR1719242_")
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

counts <- readDGE(samples) # 370315 genes

colnames(counts) <- conditions
traits <- as.factor(non_rep_conditions)
counts$samples$group <- traits

#convert to CPM values for comparative differential expression analysis
cpm_counts <- cpm(counts)
lcpm<- cpm(counts, log=TRUE)

# remove lowly expressed genes
keep.exprs <- filterByExpr(counts, group=traits)
counts <- counts[keep.exprs,, keep.lib.sizes=FALSE]
dim(counts) ## only 12 are left??
# adjust library size after filtering
noint<-rownames(counts) %in% c("__no_feature", "__ambiguous", "__too_low_aQual", "__not_aligned", "__alignment_not_unique")
counts<-counts[!noint,]
counts$samples$lib.size <- colSums(counts$counts)












