#!/bin/bash

#SBATCH --job-name=pilon
#SBATCH --partition=himem
#SBATCH --cpus-per-task=24
#SBATCH --mem=380000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=depth-%j.out
#SBATCH --error=depth-%j.err

module load pilon bwa

genome=flye.30k.racon2.fasta
#genome=flye.30k.racon2.fasta.pilon2.fasta
size=frag
#bam=bj.FINAL.fasta.bj_hap.sorted.bam

cp $genome $TMPDIR/$genome.fa

bwa index $TMPDIR/$genome.fa

bwa mem -t 24  $TMPDIR/$genome.fa <(zcat /proj/luohao/Fish/data/XX/XX-200_L*_1_clean.fq.gz) <(zcat /proj/luohao/Fish/data/XX/XX-200_L*_2_clean.fq.gz) |  samtools sort -@ 24 -O BAM -o $TMPDIR/$genome.200.sorted.bam  -
samtools index $TMPDIR/$genome.200.sorted.bam &


#mv $TMPDIR/$genome.$size.sorted.bam $TMPDIR/$genome.$size.sorted.bam.bai .

java -Xmx358G  -jar /apps/pilon/1.22/pilon-1.22.jar  --genome $TMPDIR/$genome.fa --frags $TMPDIR/$genome.200.sorted.bam   --output $genome.pilon2 --changes --threads 24 --minmq 10 --diploid --fix bases #--mindepth 20
#java -Xmx358G  -jar /apps/pilon/1.22/pilon-1.22.jar  --genome $TMPDIR/$genome.fa --frags $TMPDIR/$genome.$size.sorted.bam --output $genome.pilon3 --changes --threads 40 --minmq 30 --mindepth 30
