#!/bin/bash

#SBATCH --job-name=interproscan
#SBATCH --partition=basic
#SBATCH --cpus-per-task=4
#SBATCH --mem=40000
#SBATCH --mail-type=FAIL
#SBATCH --output=interproscan.%j.o
#SBATCH --error=interproscan.%j.e
#SBATCH --constraint=localmirror

split=$(sed -n ${SLURM_ARRAY_TASK_ID}p XX.protein.fa.list)

/localmirror/monthly/interpro/interproscan-5.39-77.0/interproscan.sh -i XX.protein.fa.split/$split -b $split -cpu 4 -f GFF3 -goterms -iprlookup  -t p -T $TMPDIR
