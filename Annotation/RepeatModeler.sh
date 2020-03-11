#!/bin/bash

#SBATCH --job-name=repMasWW
#SBATCH --partition=basic
#SBATCH --cpus-per-task=8
#SBATCH --mem=3000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=nucmer-%j.out
#SBATCH --error=nucmer-%j.err



~/soft/RepeatModeler-open-1.0.9.fish/BuildDatabase -name XX.repeat_modeler -dir ./
~/soft/RepeatModeler-open-1.0.9.fish/RepeatModeler -database XX.repeat_modeler -pa 8
