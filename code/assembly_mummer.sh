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
# reference = /home/milenatr/private/genome_analysis_data/example_scaffold/sel1_NW_015504190.fna.gz
# query = /home/milenatr/private/genome_analysis_data/soap_assembly/assembly_test.contig

mummer /home/milenatr/private/genome_analysis_data/example_scaffold/sel1_NW_015504190.fna.gz \
/home/milenatr/private/genome_analysis_data/soap_assembly/assembly_test.contig \
1>/home/milenatr/private/genome_analysis_2021_git/files/assembly_quality_results/mummer.out


echo 'finished assembly'