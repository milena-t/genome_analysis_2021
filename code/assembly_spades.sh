#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 5-00:00:00
#SBATCH -J assembly_spades
 
module load bioinfo-tools spades/3.14.1

#OUT = '/home/milenatr/private/genome_analysis_data/soap_assembly/assembly_test'

rnaspades.py --only-assembler -t 2 -m 14.9 --tmp-dir $SNIC_TMP -k 49 \
--pe1-1 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819794_P1.fastq \
--pe1-2 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819794_P2.fastq \
--pe2-1 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819795_P1.fastq \
--pe2-2 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819795_P2.fastq \
--pe3-1 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819796_P1.fastq \
--pe3-2 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819796_P2.fastq \
--pe4-1 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819797_P1.fastq \
--pe4-2 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819797_P2.fastq \
--pe5-1 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819798_P1.fastq \
--pe5-2 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819798_P2.fastq \
--pe6-1 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819799_P1.fastq \
--pe6-2 /home/milenatr/private/genome_analysis_data/trim_by_me/SRR5819799_P2.fastq \
-o /home/milenatr/private/genome_analysis_data/spades_assembly

echo 'finished assembly'