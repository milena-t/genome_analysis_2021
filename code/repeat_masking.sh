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
module load RepeatScout/1.0.6

MASKING=/home/milenatr/private/genome_analysis_data/repeat_masking
DATA=/home/milenatr/private/genome_analysis_data/example_scaffold

build_lmer_table -$DATA/sel1_NW_015504190.fna.gz -freq $MASKING/genome.freq
echo 'finished build_lmer_table'

RepeatScout -sequence $DATA/sel1_NW_015504190.fna.gz -output $MASKING/genome.repseq.fa -freq $MASKING/genome.freq
echo 'finished repeat scout'

cat $MASKING/genome.repseq.fa | filter-stage-1.prl > $MASKING/genome.repseq.f1.fa
echo 'finished remove repeats that are too short or too simple'

RepeatMasker $DATA/sel1_NW_015504190.fna.gz -e ncbi -lib $MASKING/genome.repseq.f1.fa -dir $MASKING
echo 'finished repeat masking'

cat $MASKING/genome.repseq.f1.fa | filter-stage-2.prl --cat=$MASKING/genome.fa.out > $MASKING/genome.repseq.f2.fa
grep -c ">" $MASKING/genome.repseq.fa $MASKING/genome.repseq.f1.fa $MASKING/genome.repseq.f2.fa
echo 'finish filter out repeats that do not occur often enough'

RepeatMasker $DATA/sel1_NW_015504190.fna.gz -e ncbi -lib $MASKING/genome.repseq.f2.fa -dir $MASKING -xsmall  # takes ~1m
mv $MASKING/genome.fa.masked $MASKING/genome.fa.softmasked
echo 'finish making softmasked genome'