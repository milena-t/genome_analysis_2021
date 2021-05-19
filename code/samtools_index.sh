#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J samtools_index

module load bioinfo-tools samtools/1.12

F=(/home/milenatr/private/genome_analysis_data/mapping/hisat_results/*)


for i in ${!F[*]}
do  
    echo '------------currently: indexing'
    echo ${F[i]}

    samtools index ${F[i]}

    echo '-------------------------------------------------------------'
done

echo "done indexing"