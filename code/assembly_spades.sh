#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 7-00:00:00
#SBATCH -J assembly
 
module load bioinfo-tools spades/3.14.1

#OUT = '/home/milenatr/private/genome_analysis_data/soap_assembly/assembly_test'

spades.py --only-assembler --dataset read_library.yaml -t 16 --tmp-dir $SNIC_TMP -k 49 \
-o /home/milenatr/private/genome_analysis_data/spades_assembly

echo 'finished assembly'