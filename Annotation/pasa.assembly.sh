#!/bin/bash

#SBATCH --job-name=pasa.ZZ
#SBATCH --partition=basic
#SBATCH --cpus-per-task=4
#SBATCH --mem=18000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=depth-%j.out
#SBATCH --error=depth-%j.err
#SBATCH --nice=3000

module load sqlite3
module load gmap ucsc blat
export PATH=/scratch/luohao/software/fasta-36.3.8g/bin:$PATH

trinity=ZZ.Trinity.fasta
/scratch/luohao/software/PASApipeline-v2.3.3/bin/seqclean $trinity


/scratch/luohao/software/PASApipeline-v2.3.3/Launch_PASA_pipeline.pl -c alignAssembly.conf -C -R -g ZZ.pilon3.10k.fa  -t $trinity.clean  -T -u $trinity    --ALIGNERS gmap --CPU 4 --stringent_alignment_overlap 30 --PASACONF ../PASA_WW/conf.txt --TRANSDECODER

