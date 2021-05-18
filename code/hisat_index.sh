#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:00:00
#SBATCH -J index_HISAT


module load bioinfo-tools HISAT2/2.2.1
module load python/3.8.7

OUT=/home/milenatr/private/genome_analysis_data/mapping/hisat_index/ht2_index
REF=/home/milenatr/private/genome_analysis_data/example_scaffold/sel1_NW_015504190.fna

hisat2-build -f $REF $OUT