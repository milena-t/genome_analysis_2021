#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J repeat_masking

# OUT: /home/milenatr/private/genome_analysis_data/repeat_masking

module load bioinfo-tools
module load RepeatMasker/4.1.0
module load braker/2.1.1_Perl5.24.1
module load augustus/3.2.3_Perl5.24.1
module load bamtools/2.5.1
module load blast/2.9.0+
module load GenomeThreader/1.7.0
module load samtools/1.8
module load GeneMark/4.33-es_Perl5.24.1

build_lmer_table -/home/milenatr/private/genome_analysis_data/example_scaffold/sel1_NW_015504190.fna.gz \
-freq /home/milenatr/private/genome_analysis_data/repeat_masking/genome.freq

echo 'finished build_lmer_table'

RepeatScout -sequence /home/milenatr/private/genome_analysis_data/example_scaffold/sel1_NW_015504190.fna.gz \
-output  /home/milenatr/private/genome_analysis_data/repeat_masking/genome.repseq.fa \
-freq  /home/milenatr/private/genome_analysis_data/repeat_masking/genome.freq

echo 'finished repeat scout'

cat /home/milenatr/private/genome_analysis_data/repeat_masking/genome.repseq.fa | filter-stage-1.prl > /home/milenatr/private/genome_analysis_data/repeat_masking/genome.repseq.f1.fa

echo 'finished remove repeats that are too short or too simple'

RepeatMasker da/home/milenatr/private/genome_analysis_data/example_scaffoldta/genome.fa -e ncbi \
-lib /home/milenatr/private/genome_analysis_data/repeat_masking/genome.repseq.f1.fa \
-dir /home/milenatr/private/genome_analysis_data/repeat_masking

echo 'finished repeat masking'

cat /home/milenatr/private/genome_analysis_data/repeat_masking/genome.repseq.f1.fa | filter-stage-2.prl \
--cat=/home/milenatr/private/genome_analysis_data/repeat_masking/genome.fa.out > /home/milenatr/private/genome_analysis_data/repeat_masking/genome.repseq.f2.fa
grep -c ">" /home/milenatr/private/genome_analysis_data/repeat_masking/genome.repseq.fa masking/genome.repseq.f1.fa /home/milenatr/private/genome_analysis_data/repeat_masking/genome.repseq.f2.fa

echo 'finish filter out repeats that do not occur often enough'