#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 04:00:00
#SBATCH -J assembly quality control
 
module load python
module load bioinfo-tools quast/5.0.2

#OUT = '/home/milenatr/private/genome_analysis_2021_git/files/quast_results'
# contig= /home/milenatr/private/genome_analysis_data/soap_assembly/

python quast.py -o /home/milenatr/private/genome_analysis_2021_git/files/quast_results \
/home/milenatr/private/genome_analysis_data/soap_assembly/assembly_test.contig


echo 'finished assembly'