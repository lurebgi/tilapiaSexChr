# example: sh gvcf.sh GZ_OA


module unload java
module load java/1.8u152

spe=ZZ
sample=$1
# preparation of genomic data
samtools faidx $spe.fa
/apps/java/1.8u152/bin/java -jar /apps/picard_tools/2.14.0/picard.jar CreateSequenceDictionary R=$spe.fa O=$spe.dict

# gatk
/apps/java/1.8u152/bin/java -jar /apps/gatk/nightly-2017-12-12/GenomeAnalysisTK.jar  -R $spe.fa -T HaplotypeCaller -ERC GVCF -I $spe.fa.$sample.dedup.bam  -o $sample.g.vcf.gz -nct 4

#/apps/gatk/4.0.3.0/gatk HaplotypeCaller   -R $TMPDIR/bb.fa -ERC GVCF -I /scratch/LiuJing/Luohao/$sample.reheader.bam -O $TMPDIR/$sample.g.vcf.gz
