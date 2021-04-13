#! /bin/bash
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 04:00:00
#SBATCH -J assembly

module load bioinfo-tools soapdenovo/2.04-r240

#OUT = '/home/milenatr/private/genome_analysis_data/soap_assembly/assembly_test'

SOAPdenovo-63mer all -s soapdenovo.config -K 49 -p 2 -o /home/milenatr/private/genome_analysis_data/soap_assembly/assembly_test 


echo 'finished assembly'