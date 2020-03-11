#!/bin/bash

#SBATCH --job-name=featureCounts
#SBATCH --partition=basic
#SBATCH --cpus-per-task=1
#SBATCH --mem=800
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=hisat2-%j.out
#SBATCH --error=hisat2-%j.err


module load subread

bam=$1
/apps/subread/1.6.2/bin/featureCounts -C --tmpDir $TMPDIR -M  -F GTF -p  -a pasa.function.rmRepeat.gtf  -T 2 -o $bam.gene.M.count  $bam
