#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:00:00
#SBATCH -J map_STAR

# all modules required for braker
module load bioinfo-tools
module load star/2.7.2b

REFDIR=/home/milenatr/private/genome_analysis_data/example_scaffold/sel1_NW_015504190.fna
INDEX=/home/milenatr/private/genome_analysis_data/mapping/index
OUT=/home/milenatr/private/genome_analysis_data/mapping/results



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
    echo $OUT/${F[i]:61:10}

    STAR --genomeDir $INDEX \
    --runThreadN 2 \
    --readFilesIn ${F[i]} ${R[i]}\
    --readFilesCommand zcat 
    --outFileNamePrefix $OUT/${F[i]:61:10}_ \
    --outTmpDir $SNIC_TMP
    --outSAMtype BAM SortedByCoordinate \
    --outSAMunmapped Within \
    --outSAMattributes Standard 
    echo '-------------------------------------------------------------'
done

echo 'finished mapping'