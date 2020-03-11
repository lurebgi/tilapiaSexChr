#!/bin/bash

#SBATCH --job-name=purge_haplotig
#SBATCH --partition=basic
#SBATCH --cpus-per-task=1
#SBATCH --mem=19000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=canu-%j.out
#SBATCH --error=canu-%j.err

#source activate /scratch/luohao/software/pacbio/
#export PATH=/scratch/luohao/software/pacbio/bin/:$PATH
#source activate /scratch/luohao/software/purge_haplotigs
cpu=8

#/scratch/luohao/software/pacbio/bin/minimap2  -t $cpu -x map-ont -a flye.30k.racon2.fasta.pilon2.fasta.pilon2.fasta <(zcat zcat /proj/luohao/Fish/data/XX_nanopore/*.gz)  | samtools view -hF 256 - |  samtools sort -m 2G -@ $cpu  -O BAM -o $TMPDIR/flye.30k.racon2.fasta.pilon1.fasta.pilon2.fasta.bam
#samtools index $TMPDIR/flye.30k.racon2.fasta.pilon1.fasta.pilon2.fasta.bam
#mv $TMPDIR/flye.30k.racon2.fasta.pilon1.fasta.pilon2.fasta.bam $TMPDIR/flye.30k.racon2.fasta.pilon1.fasta.pilon2.fasta.bam.bai .

#mv $TMPDIR/XX.contigs.fasta.bam $TMPDIR/XX.contigs.fasta.bam.bai .
#/apps/perl/5.28.0/bin/perl /scratch/luohao/software/purge_haplotigs/bin/purge_haplotigs   readhist  -b flye.30k.racon2.fasta.pilon1.fasta.pilon2.fasta.bam  -g flye.30k.racon2.fasta.pilon2.fasta.pilon2.fasta  -t $cpu

/apps/perl/5.28.0/bin/perl /scratch/luohao/software/purge_haplotigs/bin/purge_haplotigs contigcov  -i flye.30k.racon2.fasta.pilon1.fasta.pilon2.fasta.bam.gencov  -l 20 -m 60 -h 150 -o coverage_stats.csv -j 80  -s 80 

/apps/perl/5.28.0/bin/perl /scratch/luohao/software/purge_haplotigs/bin/purge_haplotigs purge  -g flye.30k.racon2.fasta.pilon2.fasta.pilon2.fasta  -c coverage_stats.csv -t $cpu -d -b flye.30k.racon2.fasta.pilon1.fasta.pilon2.fasta.bam -a 60 -limit_io 10 -wind_min 10000 
