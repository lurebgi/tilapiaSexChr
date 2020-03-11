#!/bin/bash

#SBATCH --job-name=seqcluster
#SBATCH --partition=basic,himem
#SBATCH --cpus-per-task=12
#SBATCH --mem=21000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nucmer-%j.out
#SBATCH --error=nucmer-%j.err
#aSBATCH --constraint=array-8core

source activate  /scratch/luohao/software/seqcluster
module load bowtie

seqcluster collapse -f Mi5dXX3_clean.fq.gz_1.trimmed.fq.gz  -o XX_collapse
seqcluster collapse -f Mi-5dxy3_clean.fq.gz_1.trimmed.fq.gz -o XY_collapse

seqcluster prepare -c file_w_samples -o res --minl 17 --minc 2 --maxl 45

bowtie -a --best --strata -m 100 --phred64-quals XX.fa res/seqs.fastq -S  |  samtools sort - -O BAM -o seqs.sort.bam

seqcluster cluster -a seqs.sort.bam  -m res/seqs.ma   -o res/cluster -ref XX.fa --db XXXY

/apps/prokka/1.14/binaries/linux/cmscan --cpu 12 --rfam --fmt 2  --clanin Rfam.clanin --tblout res/seqs.fastq.fa.blout  Rfam.cm res/seqs.fastq.fa  >  res/seqs.fastq.fa.cmscan
