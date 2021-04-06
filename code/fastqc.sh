#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:20:00
#SBATCH -J fastQC

module load bioinfo-tools FastQC/0.11.9
fastqc -o /home/milenatr/private/genome_analysis_2021/documents/fastQC_first -f fastq -t 2 /home/milenatr/private/genome_analysis_data/rna_s1_trim/trimmed/*.fastq.gz
multiqc /home/milenatr/private/genome_analysis_2021/documents/fastQC_first

echo 'Finished'