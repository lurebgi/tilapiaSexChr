#!/bin/bash

#SBATCH --job-name=Trinity
#SBATCH --partition=himem
#SBATCH --cpus-per-task=48
#SBATCH --mem=500000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nucmer-%j.out
#SBATCH --error=nucmer-%j.err



module load trinityrnaseq
module load bowtie2 bowtie samtools

sample=$1


Trinity --workdir $TMPDIR/trinity --max_memory 900G --seqType fq --normalize_reads --output $TMPDIR/$sample.trinity.out  --CPU 48 --verbose   --min_glue 10 --path_reinforcement_distance 30   --samples_file $sample.sample.list --min_contig_length 300

mv $TMPDIR/$sample.trinity.out/*.fasta $sample.Trinity.fasta
