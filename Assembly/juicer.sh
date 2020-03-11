#!/bin/bash

#SBATCH --job-name=juicer_bb
#SBATCH --partition=basic
#SBATCH --cpus-per-task=16
#SBATCH --mem=7800
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=canu-%j.out
#SBATCH --error=canu-%j.err

module load juicer bwa

spe=$1

/apps/python2/2.7.14/bin/python  /scratch/luohao/amphioxus/hic/bbbf_bb/generate_site_positions.bj.py DpnII  $spe.fa $spe.fa

bwa index $spe.fa
cp $spe.fa* $TMPDIR
samtools faidx $spe.fa; cut -f 1,2 $spe.fa.fai > $spe.fa.sizes

juicer_script.sh -t 16 -g $spe -s DpnII -D /apps/juicer/1.7.6 -y $spe.fa_DpnII.txt  -z $TMPDIR/$spe.fa -p $spe.fa.sizes
