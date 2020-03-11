#!/bin/bash

#SBATCH --job-name=trim
#SBATCH --partition=basic,himem
#SBATCH --cpus-per-task=1
#SBATCH --mem=1000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nucmer-%j.out
#SBATCH --error=nucmer-%j.err

read=$1


java -jar /apps/trimmomatic/0.36/trimmomatic-0.36.jar SE -phred64 ${read}   $TMPDIR/${read}_1.trimmed.fq.gz  ILLUMINACLIP:adapter:2:30:7  MINLEN:18

mv $TMPDIR/*trimmed.fq.gz test.trimmed.fq.gz
