#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 5-00:00:00
#SBATCH -J assembly
 
module load bioinfo-tools spades/3.14.1

#OUT = '/home/milenatr/private/genome_analysis_data/soap_assembly/assembly_test'

rnaspades.py --only-assembler -t 16 --tmp-dir $SNIC_TMP -k 49 \
-pe1-1 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819794_P1.fastq \
-pe1-2 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819794_P2.fastq \
-pe2-1 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819795_P1.fastq \
-pe2-2 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819795_P2.fastq \
-pe3-1 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819794_P1.fastq \
-pe3-2 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819794_P2.fastq \
-o /home/milenatr/private/genome_analysis_data/spades_assembly

echo 'finished assembly'