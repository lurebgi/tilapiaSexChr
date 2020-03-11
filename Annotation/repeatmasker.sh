#!/bin/bash

#SBATCH --job-name=repeatMasker
#SBATCH --partition=himem,basic
#SBATCH --cpus-per-task=16
#SBATCH --mem=13000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nucmer-%j.out
#SBATCH --error=nucmer-%j.err


spe=$1
module load repeatmasker

mkdir ${spe}.v2_RM_output_dir

RepeatMasker -xsmall -a -gccalc  -pa 16  -e ncbi -gff -excln  -lib  ../RepeatMasker.fish.lib.YY -dir ${spe}.v2_RM_output_dir XX.fa
