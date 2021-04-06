#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:20:00
#SBATCH -J fastQC

module load bioinfo-tools trimmomatic/0.36
module load java/sun_jdk1.8.0_151

F = /home/milenatr/private/genome_analysis_data/rna_s1_trim/trimmed/*1P.fastq.gz
#forward paired reads
R = /home/milenatr/private/genome_analysis_data/rna_s1_trim/trimmed/*2P.fastq.gz
#reverse paired reads
echo 'Forward'
echo $F 
echo 'Reverse'
echo $R 

echo 'Finished'