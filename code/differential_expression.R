### Differential expression analysis ###

## The student manual suggests DESeq2, but the installation does not work, there is some error with the versions, I think

# For this reason I will use EdgeR for differential expression analysis

library(edgeR)


#sample names
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

# the HISAT result did not improve, so the star mapping will be used here

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

#check the expression of the annotated genes
ann_genes <- c("rna3158", "rna3163", "gene2144", "gene2145", "gene2147", "rna3175", "gene2151")
match(ann_genes, rownames(counts$counts)) #are not present in the data

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
par(mfrow=c(1,1))

# Principal component analysis
lcpm_pca <- prcomp(lcpm)
summary(lcpm_pca)


### Differential expression analysis ###

trait <- as.factor(non_rep_conditions)
design <- model.matrix(~0+trait)  # The 0 means that the intercept is not included
colnames(design)<-gsub("group","",colnames(design))
design

# the comparison between the different samples as described in the paper

#difference between forelimb and hindlimb
contr.matrix_l<-makeContrasts( #compare fore and hindlimbs
  limb = (trait15_F-trait16_F-trait17_F) - (trait15_H-trait16_H-trait17_H),
  levels=colnames(design))
contr.matrix_l
 
# difference between two consequential developmental stages
contr.matrix_cs<-makeContrasts( #pairwise compare developmental stages
  CS15_CS16 = (trait15_F-trait15_H) - (trait16_F-trait16_H),
  CS16_CS17 = (trait16_F-trait16_H) - (trait17_F-trait17_H),
  levels=colnames(design))
contr.matrix_cs

#compare forelimb and hindlimb in each developmental stage
contr.matrix_cs.l<-makeContrasts( #compare limbs within dev. stage
  CS15 = trait15_F - trait15_H,
  CS16 = trait16_F - trait16_H,
  CS17 = trait17_F - trait17_H,
  levels=colnames(design))
contr.matrix_cs.l

v <- voom(counts, design, plot = FALSE)

#fitting linear models for comparisons of interest
vfit <- lmFit(v, design)
vfit <- contrasts.fit(vfit,
                      contrasts=contr.matrix_cs.l) #exchange with contract matrix that you want to analyze
efit <- eBayes(vfit)

summary(decideTests(efit)) 
dt <- decideTests((efit)) #genes with -1 are downregulated, genes with +1 are upregulated

## Heatmap

#assuming dt is based on contr.matrix_cs.l!
#dt: gene expression: -1 significantly lower, 0 no sig. difference, 1 significantly higher
#dt[,1]!=0: only look at significantly differentially expressed genes
cs15 <- length(which(dt[,1]!=0))
cs16 <- length(which(dt[,2]!=0))
cs17 <- length(which(dt[,3]!=0))

library(gplots)
heatmap_de <- function(trait, title, m){
  trait.topgenes <- rownames(trait[1:8,]) #ranked by p-value
  i <- which(rownames(v$E) %in% trait.topgenes)
  mycol <- colorpanel(1000, 'blue', 'white', 'red')
  
  heatmap.2(lcpm[i,], scale = 'row',
            labRow = substr(rownames(v$E), 8, 200), #remove numbers from the beginning of rownames
            labCol = trait,
            col = mycol,
            trace = 'none',
            density.info = 'none',
            margin = c(8,6),
            lhei = c(2,10),
            dendrogram = 'column',
            main = title,
            margins = m)
}
# careful! does not work when figure window is too small
m <- c(7, 21) #adjust margins to show full protein names
lcpm<- cpm(counts, log=TRUE)
heatmap_de(cs15, 'CS15: forelimb vs. hindlimb', m)
heatmap_de(cs16, 'CS16: forelimb vs. hindlimb', m)
heatmap_de(cs17, 'CS17: forelimb vs. hindlimb', m)






