#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J htseq_count

F=(/home/milenatr/private/genome_analysis_data/mapping/results/*.bam)
OUT=/home/milenatr/private/genome_analysis_data/htseq_counting
GFF=/home/milenatr/private/genome_analysis_data/gff_annotation/GCF_001595765.1_Mnat.v1_genomic.gff

for i in ${!F[*]}
do  
    echo '------------currently counting: '
    echo ${F[i]}
    echo 'to: '
    echo $OUT/${F[i]:61:10}

    htseq-count \
    -f bam \
    -r pos \
    -s yes \
    -a 10 \
    -i gene_id \
    ${F[i]} \
    $GFF \
    >$OUT/${F[i]:61:10}

    echo '-------------------------------------------------------------'
done

echo 'finished count'

#from research training

# potentially try: -s reverse 
# potentially -i locus_tag 
 
