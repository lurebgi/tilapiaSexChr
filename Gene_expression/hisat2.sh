#!/bin/bash

#SBATCH --job-name=hisat2
#SBATCH --partition=basic
#SBATCH --cpus-per-task=4
#SBATCH --mem=48000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=hisat2-%j.out
#SBATCH --error=hisat2-%j.err

module load hisat2

spe=$1
read1=$2
read2=$3
sample=$4

hisat2-build $spe.fa $spe.fa.idx

cp $spe.fa.idx* $TMPDIR

hisat2 -x $TMPDIR/$spe.fa.idx -p 4 -1 $read1 -2 $read2 -S $TMPDIR/$sample.sam -k 4 --max-intronlen 100000 --min-intronlen 30

samtools sort  $TMPDIR/$sample.sam  -@ 4 -O BAM -o $TMPDIR/$sample.sort.bam

mv $TMPDIR/$sample.sort.bam .
samtools index $sample.sort.bam
