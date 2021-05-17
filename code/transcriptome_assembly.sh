#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J trinity_transcriptome_Assembly
 
module load bioinfo-tools trinity/2014-07-17
module load java/sun_jdk1.7.0_25

#--samples_file trinity_input.txt \

#forward paired reads (NOT USED)
F=\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719013.trim_1P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719014.trim_1P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719015.trim_1P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719016.trim_1P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719017.trim_1P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719018.trim_1P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719204.trim_1P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719206.trim_1P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719207.trim_1P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719208.trim_1P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719209.trim_1P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719211.trim_1P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719212.trim_1P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719213.trim_1P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719214.trim_1P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719241.trim_1P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719242.trim_1P.fastq.gz

#reverse paired reads (NOT USED)
R=\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719013.trim_2P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719014.trim_2P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719015.trim_2P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719016.trim_2P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719017.trim_2P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719018.trim_2P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719204.trim_2P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719206.trim_2P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719207.trim_2P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719208.trim_2P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719209.trim_2P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719211.trim_2P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719212.trim_2P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719213.trim_2P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719214.trim_2P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719241.trim_2P.fastq.gz,\
/home/milenatr/private/genome_analysis_data/rna_s1_trim/sel1_SRR1719242.trim_2P.fastq.gz

OUT=/home/milenatr/private/genome_analysis_data/trinity

Trinity \
--seqType fq \
--JM 10G \
--left $F \
--right $R \
--SS_lib_type RF \
--CPU 2 \
--no_bowtie \
--output /home/milenatr/private/genome_analysis_data/trinity


echo "finished transcriptome assembly"