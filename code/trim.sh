#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:20:00
#SBATCH -J fastQC

module load bioinfo-tools trimmomatic/0.36
module load java/sun_jdk1.8.0_151

F=(/home/milenatr/private/genome_analysis_data/rna_s1_trim/trimmed/*1P.fastq.gz)
#forward paired reads
R=(/home/milenatr/private/genome_analysis_data/rna_s1_trim/trimmed/*2P.fastq.gz)
#reverse paired reads

OUT_DIR="/home/milenatr/private/genome_analysis_2021_git/documents/trim"

for i in ${!R[*]}
do  
    OUT_P1="$OUT_DIR${F:69:12}_P1.fastq"
    OUT_P2="$OUT_DIR${R:69:12}_P2.fastq"
    OUT_U1="$OUT_DIR${F:69:12}_U1.fastq"
    OUT_U2="$OUT_DIR${R:69:12}_u2.fastq"
    echo ${F[$i]}
    echo ${R[$i]}
    echo $OUT_P1
    echo $OUT_P2
    echo $OUT_U1
    echo $OUT_U2
    echo "\n"

done


echo 'Finished'