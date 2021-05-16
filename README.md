# Bioinformatics MSc, Genome Analysis
## Spring 2021

The course deals with replicating genomic analyses from a scientific paper. 
The paper chosen here is *"Transcriptomic and epigenomic characterization of the developing bat wing"* by Eckalbar et al. in Nature Genetics (2016), Paper 2 from the list.

### short summary
Bats are the only mammals that have evolved the ability to fly. To do so, their forelimbs experienced important adaptations that differentiate them from the hindlimbs. Previous studies have focused on understanding certain parts of the wing-formation process (differentially expressed genes, certain regulatory regions...), but there is not a comprehensive understanding of the elements involved in this process. This study aims to understand the process of wing formation in bats in a comprehensive way that includes understanding both the regulatory elements and the genes and signaling processes involved.

### Main analyses involved in the project
The whole dataset used in this paper is too large and calculations would too long for this project, so a subsample is used.
- Obtaining a draft genome of *Miniopterus natalensis* using Illumina reads (subsampled)
- Transcriptomics of forelimbs and hindlimbs at 3 developmental stages (CS15, CS16, CS17)
- ChIP-seq of H3K27me3 (active regions) and H3K27ac (repressed regions) histone modification at the three stages

# Results
All results and output files are saved in my uppmax directory. They have not been synchronized with GitHub to save storage space. The standard output for all files is in the code directory, named according to the program or step that generated it with the .out file ending. All results are in a directory called genome_analysis_data outside the git directory, where they are sorted into accordingly named subfolders.
