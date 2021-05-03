#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:00:00
#SBATCH -J index_Star

# all modules required for braker
module load bioinfo-tools
module load star/2.7.2b

REFDIR=/home/milenatr/private/genome_analysis_data/example_scaffold
INDEX=/home/milenatr/private/genome_analysis_data/mapping/index

STAR --runThreadN 2 \
--runMode genomeGenerate \
--genomeDir $INDEX \
--genomeFastaFiles $REFDIR/sel1_NW_015504190.fna \
#--sjdbOverhang 99


echo 'finished mapping'