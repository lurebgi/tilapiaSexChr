#!/bin/bash

#SBATCH --job-name=racon
#SBATCH --partition=himem
#SBATCH --cpus-per-task=40
#SBATCH --mem=19000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=canu-%j.out
#SBATCH --error=canu-%j.err

#module load racon

genome=$1

zcat /proj/luohao/Fish/data/XX_nanopore/*.gz > $TMPDIR/read.fa
/scratch/luohao/software/pacbio/bin/minimap2  -t 40  -x map-ont --secondary=no flye.30k.fasta $TMPDIR/read.fa  > $TMPDIR/flye.30k.fasta.paf
/scratch/luohao/software/racon/bin/racon -t 40  $TMPDIR/read.fa  $TMPDIR/flye.30k.fasta.paf flye.30k.fasta  > flye.30k.racon.fasta

/scratch/luohao/software/pacbio/bin/minimap2  -t 40  -x map-ont --secondary=no flye.30k.racon.fasta $TMPDIR/read.fa  > $TMPDIR/flye.30k.fasta.paf
/scratch/luohao/software/racon/bin/racon -t 40  $TMPDIR/read.fa  $TMPDIR/flye.30k.fasta.paf flye.30k.racon.fasta > flye.30k.racon2.fasta
