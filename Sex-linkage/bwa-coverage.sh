# example: sh bwa-coverage.sh ZZ.fa read1.fq.gz read2.fq.gz GZ_OA

module load bwa
genome0=$1
read1=$2
read2=$3
size=$4
cpu=8

genome=$(echo ${genome0##*/})


if [ ! -f ${genome0}.bwt ] ; then
bwa index $genome0 #-p $genome
fi


bwa mem -t $cpu -R $(echo "@RG\tID:$size\tSM:$id"_"$size\tLB:$size"_"$size\tPL:ILLUMINA")  $genome $read1 $read2  |  samtools sort -@ $cpu  -O BAM -o $genome.$size.sorted.bam  -
samtools index $genome.$size.sorted.bam

# entire contig
#samtools faidx $genome0
cut -f 1,2 $genome0.fai > $genome.fai.g
#cut -f 1,2 $genome.fai | awk '{print $1"\t1\t"$2}' > $genome.fai.bed
#samtools depth -m 300 -Q 59 $genome.$size.sorted.bam  | awk '{print $1"\t"$2-1"\t"$2"\t"$3}' |  bedtools map -a $genome.fai.bed -g $genome.fai.g -b - -c 4 -o median,mean,count  > $genome.$size.sorted.bam.depth.g

#50k
bedtools makewindows -g $genome0.fai.g -w 50000 > $genome.scf-len.50k-win
samtools depth -m 180 -Q 59 $genome.$size.sorted.bam  | awk '{print $1"\t"$2-1"\t"$2"\t"$3}' |  bedtools map -a  $genome.scf-len.50k-win -b - -c 4 -o median,mean,count -g $genome.fai.g  > $genome.$size.sorted.bam.depth.bed.50k-win
