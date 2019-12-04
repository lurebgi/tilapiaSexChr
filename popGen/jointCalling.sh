#!/bin/bash



module load htslib
#tabix -p vcf gvcf.gz

sample=$1
gvcf=$2
# join variant colling, here is the case for WL_OA
/apps/java/1.8u152/bin/java -jar /apps/gatk/3.8.0/GenomeAnalysisTK.jar -R ZZ.fa -T GenotypeGVCFs -nt 1 --variant WL_OA_1_T.gvcf.gz --variant WL_OA_2_T.gvcf.gz --variant WL_OA_3_T.gvcf.gz --variant WL_OA_4_T.gvcf.gz --variant WL_OA_5_T.gvcf.gz -o $TMPDIR/$sample.raw.vcf.gz


# variant filtering
/apps/java/1.8u152/bin/java -jar /apps/gatk/3.8.0/GenomeAnalysisTK.jar -R ZZ.fa -T SelectVariants -V $TMPDIR/$sample.raw.vcf.gz -selectType SNP -o $TMPDIR/temp.vcf
/apps/java/1.8u152/bin/java -jar /apps/gatk/3.8.0/GenomeAnalysisTK.jar -R ZZ.fa -T VariantFiltration -V $TMPDIR/temp.vcf --logging_level ERROR -window 15 -cluster 3  --filterExpression " QD < 2.0 || FS > 60.0 || MQRankSum < -12.5 || RedPosRankSum < -8.0 || SOR > 3.0 || MQ < 40.0 " --filterName "my_snp_filter" -o $TMPDIR/temp.filter.vcf
/apps/java/1.8u152/bin/java -jar /apps/gatk/3.8.0/GenomeAnalysisTK.jar -R ZZ.fa -T SelectVariants -V $TMPDIR/temp.filter.vcf --excludeFiltered -o $TMPDIR/temp.final.vcf.gz
mv $TMPDIR/temp.final.vcf.gz ZZ.fa.$sample.dedup.bam.final.vcf.gz
mv $TMPDIR/temp.final.vcf.gz.tbi ZZ.fa.$sample.dedup.bam.final.vcf.gz.tbi

# filtering for indels
#/apps/java/1.8u152/bin/java -jar /apps/gatk/3.8.0/GenomeAnalysisTK.jar -R WW.fa -T SelectVariants -V All.raw.vcf.gz -selectType INDEL -o $TMPDIR/ZW.indel.vcf
#/apps/java/1.8u152/bin/java -jar /apps/gatk/3.8.0/GenomeAnalysisTK.jar -R WW.fa -T VariantFiltration -V $TMPDIR/ZW.indel.vcf --logging_level ERROR --filterExpression " QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0 " --filterName "my_indel_filter" -o $TMPDIR/ZW.indel.filter.vcf
#/apps/java/1.8u152/bin/java -jar /apps/gatk/3.8.0/GenomeAnalysisTK.jar -R WW.fa -T SelectVariants -V $TMPDIR/ZW.indel.filter.vcf --excludeFiltered -o $TMPDIR/ZW.indel.final.vcf.gz
#mv $TMPDIR/ZW.indel.final.vcf.gz* .
