# do this if you call gvcf for each chromosome individually
sample=$1

/apps/java/1.8u152/bin/java -jar /apps/picard_tools/2.14.0/picard.jar GatherVcfs I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG7.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG9.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG13.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG19.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG2.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG23.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG14.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG22.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG20.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG11.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG10.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG4.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG15.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG12.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG18.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG17.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG5.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG6.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG8.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG16.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG3.g.vcf.gz I=ZZ.fa.$sample.dedup.bam.gvcf.out/LG1.g.vcf.gz O=$TMPDIR/gvcf.gz

mv $TMPDIR/gvcf.gz .

#tabix -p vcf ZZ.fa.$sample.dedup.bam.ZZ.fa.$sample.dedup.bam.gvcf.out.sample/$line.gvcf.gz
