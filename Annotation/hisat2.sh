#!/bin/bash

#SBATCH --job-name=hisat2
#SBATCH --partition=basic,himem
#SBATCH --cpus-per-task=16
#SBATCH --mem=68000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=hisat2-%j.out
#SBATCH --error=hisat2-%j.err

module load hisat2

spe=$1
hisat2-build $spe.fa $spe.fa

cp $spe.fa* $TMPDIR

hisat2 -x $TMPDIR/$spe.fa -p 16 -1 /proj/luohao/Fish/data/RNAseq/ZW/ZW10-1_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW10-2_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW1-1_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW1-2_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW4-1_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW4-2_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW6-1_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW6-2_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW9-1_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW9-2_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZZ10-1_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZZ10-2_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZZ4-1_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZZ4-2_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZZ6-1_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZZ6-2_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZZ9-1_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZZ9-2_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/Oreochromis_aureus_ZW_1.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/Oreochromis_aureus_ZZ_1.trimmed.fq.gz -2 /proj/luohao/Fish/data/RNAseq/ZW/ZW10-1_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW10-2_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW1-1_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW1-2_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW4-1_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW4-2_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW6-1_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW6-2_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW9-1_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZW9-2_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZZ10-1_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZZ10-2_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZZ4-1_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZZ4-2_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZZ6-1_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZZ6-2_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZZ9-1_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/ZZ9-2_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/Oreochromis_aureus_ZW_2.trimmed.fq.gz,/proj/luohao/Fish/data/RNAseq/ZW/Oreochromis_aureus_ZZ_2.trimmed.fq.gz  -S $TMPDIR/$spe.sam -k 4 --max-intronlen 100000 --min-intronlen 30

samtools sort  $TMPDIR/$spe.sam  -@ 16 -O BAM -o $TMPDIR/$spe.sort.bam

mv $TMPDIR/$spe.sort.bam .
samtools index $spe.sort.bam


