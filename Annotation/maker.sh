#!/bin/bash

#SBATCH --job-name=maker_zz
#SBATCH --partition=basic
#SBATCH -N 2
#SBATCH --ntasks-per-node=11
#SBATCH --ntasks-per-core=1
#SBATCH --mem=9000
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=luohao.xu@univie.ac.at
#SBATCH --output=maker-%j.out
#SBATCH --error=maker-%j.err


module load maker
#/apps/maker/2.31.10/bin/cufflinks2gff3 bb.gtf > bb.gtf.gff

unset  AUGUSTUS_CONFIG_PATH 
export AUGUSTUS_CONFIG_PATH=/scratch/luohao/Fish/annotation/augustus/config

chr=$(sed -n ${SLURM_ARRAY_TASK_ID}p chr.list)
#srun -n 16  maker -base run3 -fix_nucleotides --ignore_nfs_tmp  maker_opts.run3.ctl  maker_bopts.ctl  maker_exe.ctl
#srun -n 20  maker -base run0 -fix_nucleotides --ignore_nfs_tmp  maker_opts.run0.ctl  maker_bopts.ctl  maker_exe.ctl
#srun -n 20  maker -base run2 -fix_nucleotides --ignore_nfs_tmp  maker_opts.run2.ctl  maker_bopts.ctl  maker_exe.ctl

#srun -n 2  maker -base run2.chr14 -fix_nucleotides --ignore_nfs_tmp maker_opts.run2.chr14.ctl maker_bopts.ctl  maker_exe.ctl
#srun -n 2  maker -base run3.chr14-isoseq -fix_nucleotides --ignore_nfs_tmp maker_opts.run3.chr14-isoseq.ctl maker_bopts.ctl  maker_exe.ctl
#srun -n 8  maker -base run3 -fix_nucleotides --ignore_nfs_tmp  maker_opts.run3.ctl  maker_bopts.ctl  maker_exe.ctl
#srun -n 20  maker -base run3-v2 -fix_nucleotides --ignore_nfs_tmp  maker_opts.run3-v2.ctl  maker_bopts.ctl  maker_exe.ctl
#srun -n 2  maker -base run3-v2.chr14 -fix_nucleotides --ignore_nfs_tmp  maker_opts.run3-v2.chr14.ctl  maker_bopts.ctl  maker_exe.ctl
#srun -n 2  maker -base run4.chr14-v2 -fix_nucleotides --ignore_nfs_tmp maker_opts.run4.chr14.ctl maker_bopts.ctl  maker_exe.ctl
#srun -n 20  maker -base run4.genome -fix_nucleotides --ignore_nfs_tmp maker_opts.run4.ctl maker_bopts.ctl  maker_exe.ctl

# maker -base run5.$chr -fix_nucleotides run5.ctl/$chr.ctl  maker_bopts.ctl  maker_exe.ctl

#srun -n 20  maker -base embryo  -fix_nucleotides --ignore_nfs_tmp maker_opts.embryo.ctl maker_bopts.ctl  maker_exe.ctl
srun -n 22  maker -base XX  -fix_nucleotides --ignore_nfs_tmp maker_opts.ctl maker_bopts.ctl  maker_exe.ctl

