#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 04:00:00
#SBATCH -J fastQC

module load bioinfo-tools soapdenovo/2.04-r240

OUT = '/home/milenatr/private/genome_analysis_data/soap_assembly/assembly_test'

./sw/bioinfo/SOAPdenovo/2.04-r240/snowy/bin/2013 SOAPdenovo-63mer all -s soapdenovo.config \
-K 49 -p 2 -o $OUT

echo 'finished assembly'