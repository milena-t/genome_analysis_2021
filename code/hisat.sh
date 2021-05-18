#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:00:00
#SBATCH -J map_HISAT

OUT=/home/milenatr/private/genome_analysis_data/mapping/hisat_results
REFDIR=/home/milenatr/private/genome_analysis_data/example_scaffold/sel1_NW_015504190.fna