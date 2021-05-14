#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:00:00
#SBATCH -J convert_gff_to_fasta

module load bioinfo-tools cufflinks/2.2.1
GFF = /home/milenatr/private/genome_analysis_data/gff_annotation/GCF_001595765.1_Mnat.v1_genomic.gff.gz
GENOME = /home/milenatr/private/genome_analysis_data/example_scaffold/sel1_NW_015504190.fna
OUT = /home/milenatr/private/genome_analysis_data/gff_annotation/gff_protein.fasta

gffread -w $OUT -g $GENOME $GFF