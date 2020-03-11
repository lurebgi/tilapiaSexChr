#!/bin/bash

#SBATCH --job-name=flye
#SBATCH --partition=himem
#SBATCH --cpus-per-task=40
#SBATCH --mem=35000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=canu-%j.out
#SBATCH --error=canu-%j.err

#module load flye
source activate /scratch/luohao/software/pacbio

flye --nano-raw /proj/luohao/Fish/data/XX_nanopore/*.gz   --genome-size 1g --out-dir $TMPDIR  --threads 40
mv $TMPDIR/* .
