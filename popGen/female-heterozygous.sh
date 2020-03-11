bcftools view -H -i 'DP>10 && AF=0.5' ZZ.fa.aroZW.dedup.bam.final.vcf.gz > ZZ.fa.aroZW.dedup.bam.final.vcf.gz.het
bcftools view -i 'DP>20 && AF>0.45 && AF<0.55' -H kocherZW.v2_somatic_final.snvs.vcf.gz | cut -f 1 | grep LG > kocherZW.v2_somatic_final.snvs.vcf.gz.het
cat ZZ.fa.aroZW.dedup.bam.final.vcf.gz.het | awk '{a[$1"_"$2]=3}END{while(getline < "kocherZW.v2_somatic_final.snvs.vcf.gz.het"){if(a[$1"_"$2]==3){print }}}' > kocherZW.v2_somatic_final.snvs.vcf.gz.het.aro

bcftools view -H -i 'AF=0.5 & DP>10' ZZ.fa.WX-OA-ZW-1.dedup.bam.final.vcf.gz | awk 'BEGIN{while(getline < "kocherZW.v2_somatic_final.snvs.vcf.gz.het.aro"){a[$1"_"$2]=3}}{if(a[$1"_"$2]==3){print }}' > kocherZW.v2_somatic_final.snvs.vcf.gz.het.aro.ZZ.fa.WX-OA-ZW-1
