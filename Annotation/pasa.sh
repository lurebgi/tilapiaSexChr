#!/bin/bash

#SBATCH --job-name=pasa.ZZ
#SBATCH --partition=basic
#SBATCH --cpus-per-task=1
#SBATCH --mem=18000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=depth-%j.out
#SBATCH --error=depth-%j.err
#SBATCH --nice=3000
#SBATCH --constraint=array-4core

module load sqlite3
module load gmap ucsc blat
export PATH=/scratch/luohao/software/fasta-36.3.8g/bin:$PATH

trinity=ZZ.Trinity.fasta
chr=$(sed -n ${SLURM_ARRAY_TASK_ID}p chr.list)

cp ../PASA_WW/alignAssembly.conf    $TMPDIR
sed -i -e   "s#/scratch/luohao/Fish/annotation/PASA_WW#$TMPDIR#" -e 's/WW.sqlite.v2/ZZ.sqlite/'  $TMPDIR/alignAssembly.conf

cp ZZ.sqlite  $TMPDIR/ZZ.sqlite


cp ../PASA_WW/annotationCompare.conf    $TMPDIR
sed -i -e   "s#/scratch/luohao/Fish/annotation/PASA_WW#$TMPDIR#" -e 's/WW/ZZ/'  $TMPDIR/annotationCompare.conf

mkdir  gff3_split/$chr.out
cd gff3_split/$chr.out

/scratch/luohao/software/PASApipeline-v2.3.3/scripts/Load_Current_Gene_Annotations.dbi -c $TMPDIR/alignAssembly.conf -g ../../ZZ.pilon3.10k.fa  -P ../$chr.gff3

/scratch/luohao/software/PASApipeline-v2.3.3/Launch_PASA_pipeline.pl -c $TMPDIR/annotationCompare.conf -A -g ../../ZZ.pilon3.10k.fa  -t  ../..//$trinity.clean --CPU 1 --PASACONF ../../../PASA_WW/conf.txt --stringent_alignment_overlap 30 --gene_overlap 50
