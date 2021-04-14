#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 04:00:00
#SBATCH -J assembly quality control
 
module load python
module load bioinfo-tools MUMmer/4.0.0rc1

#OUT = '/home/milenatr/private/genome_analysis_2021_git/files/assembly_quality_results'
# contig= /home/milenatr/private/genome_analysis_data/soap_assembly/




echo 'finished assembly'