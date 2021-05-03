#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:00:00
#SBATCH -J annotation_braker

# all modules required for braker
module load bioinfo-tools
module load braker/2.1.1_Perl5.24.1
module load augustus/3.2.3_Perl5.24.1
module load bamtools/2.5.1
module load blast/2.9.0+
module load GenomeThreader/1.7.0
module load samtools/1.8
module load GeneMark/4.33-es_Perl5.24.1

# change directory to save output there
cd /home/milenatr/private/genome_analysis_data/braker_annotation 

braker.pl \
--genome /home/milenatr/private/genome_analysis_data/example_scaffold/sel1_NW_015504190.fna.gz \
--cores 2 \
--AUGUSTUS_CONFIG_PATH=/home/milenatr/private/genome_analysis_2021/code/augustus_config \
--AUGUSTUS_BIN_PATH=/sw/bioinfo/augustus/3.4.0/snowy/bin \
--AUGUSTUS_SCRIPTS_PATH=/sw/bioinfo/augustus/3.4.0/snowy/scripts \
--GENEMARK_PATH=/sw/bioinfo/GeneMark/4.33-es/snowy


echo 'finished annotation'