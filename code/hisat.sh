#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:00:00
#SBATCH -J map_HISAT

module load bioinfo-tools HISAT2/2.2.1 samtools/1.10
module load python/3.8.7

OUT=/home/milenatr/private/genome_analysis_data/mapping/hisat_results
INDEX=/home/milenatr/private/genome_analysis_data/mapping/hisat_index/ht2_index
REFDIR=/home/milenatr/private/genome_analysis_data/example_scaffold/sel1_NW_015504190.fna

F=(/home/milenatr/private/genome_analysis_data/rna_s1_trim/*1P.fastq.gz)
#forward paired reads
R=(/home/milenatr/private/genome_analysis_data/rna_s1_trim/*2P.fastq.gz)
#reverse paired reads

for i in ${!R[*]}
do  
    echo '------------currently mapping: '
    echo ${F[i]}
    echo ${R[i]}
    echo 'to: '
    echo $OUT/${F[i]:60:10}

    hisat2 \
    -q -p 2 --mp 1,3.75 --no-softclip --rna-strandness RF --no-unal \
    -x $INDEX -1 ${F[i]} -2 ${R[i]} \
    | samtools view -u \
    | samtools sort -n -o $OUT/${F[i]:60:10} -@ 20

    echo '-------------------------------------------------------------'
done

echo "finish map hisat"