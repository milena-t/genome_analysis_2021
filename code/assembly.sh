#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:20:00
#SBATCH -J fastQC

module load bioinfo-tools trimmomatic/0.36
module load java/sun_jdk1.8.0_151

F=(/home/milenatr/private/genome_analysis_data/trim_by_me*1P.fastq.gz)
#forward paired reads
R=(/home/milenatr/private/genome_analysis_data/trim_by_me*2P.fastq.gz)
#reverse paired reads

OUT_DIR="/home/milenatr/private/genome_analysis_data/trim_by_me"

for i in ${!R[*]}
do  
    OUT_P1="$OUT_DIR/${F[i]:69:10}_P1.fastq"
    OUT_P2="$OUT_DIR/${F[i]:69:10}_P2.fastq"
    OUT_U1="$OUT_DIR/${F[i]:69:10}_U1.fastq"
    OUT_U2="$OUT_DIR/${F[i]:69:10}_u2.fastq"
    echo ${F[$i]}
    echo ${R[$i]}

    
    echo 'finished assembly'

done


echo 'Finished'