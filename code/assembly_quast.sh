#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:10:00
#SBATCH -J assembly_quality_control_mummer
 
module load python
module load bioinfo-tools quast/5.0.2

#OUT = '/home/milenatr/private/genome_analysis_2021_git/files/assembly_quality_results'
# reference = /home/milenatr/private/genome_analysis_data/example_scaffold/sel1_NW_015504190.fna.gz
# query = /home/milenatr/private/genome_analysis_data/soap_assembly/assembly_test.contig

python /sw/bioinfo/quast/5.0.2/snowy/bin/quast.py -o /home/milenatr/private/genome_analysis_2021_git/files/assembly_quality_results \
-r /home/milenatr/private/genome_analysis_data/example_scaffold/sel1_NW_015504190.fna.gz \
--min-contig 50 -t 2 --eukaryote \
/home/milenatr/private/genome_analysis_data/soap_assembly/assembly_test.contig

echo 'finished assembly'