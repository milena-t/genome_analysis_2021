#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:00:00
#SBATCH -J convert_gff_to_fasta

#unzip .gff file:
# gzip -d -c /proj/g2021012/2_Eckalbar_2016/additional_data/GCF_001595765.1_Mnat.v1_genomic.gff.gz > /home/milenatr/private/genome_analysis_data/gff_annotation/GCF_001595765.1_Mnat.v1_genomic.gff

module load bioinfo-tools cufflinks/2.2.1

GFF=/home/milenatr/private/genome_analysis_data/gff_annotation/GCF_001595765.1_Mnat.v1_genomic.gff
GENOME=/home/milenatr/private/genome_analysis_data/example_scaffold/sel1_NW_015504190.fna
OUT=/home/milenatr/private/genome_analysis_data/gff_annotation/gff_protein.fasta

gffread -w $OUT -g $GENOME $GFF

##error
#Warning: couldn't find fasta record for 'NW_015503911.1'!
#Warning: getSpliced(NULL,.. ) called!

#copy files to local computer to run eggnogmapper:
#rsync -azP milenatr@rackham.uppmax.uu.se:/home/milenatr/private/genome_analysis_data/gff_annotation/gff_protein.fasta 