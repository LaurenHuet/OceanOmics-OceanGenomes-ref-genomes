#!/bin/bash --login
#SBATCH --account=pawsey0812
#SBATCH --job-name=ocean-genomes
#SBATCH --partition=work
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --export=NONE
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=lauren.huet@uwa.edu.au
#-----------------
#Loading the required modules

OG=$1
asm_ver=$2


##back up kmer profilling (genomescope and meryl)
rclone copy ${OG}/02-kmer-profiling/genomescope2/ pawsey0812:oceanomics-assemblies/${OG}/genomescope -checksum --progress
rclone copy ${OG}/02-kmer-profiling/meryl/ pawsey0812:oceanomics-assemblies/${OG}/meryl --checksum --progress

#Back up hifiasm assemblies and qc (gfa stats, merqury, BUSCO)
# 1.Assemblies
rclone copy ${OG}/03-assembly/gfastats/${OG}_${asm_ver}.0.hifiasm.hap1.fasta  pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/assembly
rclone copy ${OG}/03-assembly/gfastats/${OG}_${asm_ver}.0.hifiasm.hap2.fasta pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/assembly
rclone copy ${OG}/03-assembly/hifiasm/${OG}_${asm_ver}.hic.hap1.p_ctg.gfa pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/assembly
rclone copy ${OG}/03-assembly/hifiasm/${OG}_${asm_ver}.hic.hap2.p_ctg.gfa pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/assembly

#gfastats 
rclone copy ${OG}/03-assembly/hifiasm/gfastats/${OG}_${asm_ver}.0.hifiasm.hap1.assembly_summary.txt pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/gfastats
rclone copy ${OG}/03-assembly/hifiasm/gfastats/${OG}_${asm_ver}.0.hifiasm.hap2.assembly_summary.txt pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/gfastats

#merqury 
rclone copy ${OG}/03-assembly/merqury pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/merqury

# Busco 
rclone copy ${OG}/03-assembly/busco pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/busco

#Back up hifi-hic scaffolded bam files from OMNIC pipeline

rclone copy ${OG}/04-scaffolding/omnic/${OG}_${asm_ver}.hap1.hic.mapped.contigs.bam pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/bam
rclone copy ${OG}/04-scaffolding/omnic/${OG}_${asm_ver}.hap1.hic.mapped.contigs.bam.bai pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/bam

rclone copy ${OG}/04-scaffolding/omnic/${OG}_${asm_ver}.hap2.hic.mapped.contigs.bam pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/bam
rclone copy ${OG}/04-scaffolding/omnic/${OG}_${asm_ver}.hap2.hic.mapped.contigs.bam.bai pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/bam


# back up YAHS scaffoled files

rclone copy ${OG}/04-scaffolding/yahs/${OG}_${asm_ver}.1.yahs.hap1_scaffolds_final.fa pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/assembly
rclone copy ${OG}/04-scaffolding/yahs/${OG}_${asm_ver}.1.yahs.hap2_scaffolds_final.fa pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/assembly


# Back up decontamination results and QC stats

rclone copy ${OG}/05-decontamination/busco pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/busco
rclone copy ${OG}/05-decontamination/gfastats pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/gfastats

rclone copy ${OG}/05-decontamination/NCBI/out pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/decontamination/NCBI
rclone copy ${OG}/05-decontamination/tiara pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/decontamination/tiara

#final decontaminated fasta
rclone copy ${OG}/05-decontamination/final-fastas/ pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/assembly

## back up coverage tracks, bedgraph files

rclone copy ${OG}/06-coverage-tracks/${OG}_${asm_ver}.dual.hap.gaps.bedgraph pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/bedgraph
rclone copy ${OG}/06-coverage-tracks/${OG}_${asm_ver}.dual.hap.bedgraph pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/bedgraph
rclone copy ${OG}/07-telomers/${OG}_${asm_ver}_sorted_telomeric_locations.bedgraph pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/bedgraph

# back up pretext snapshots and maps
rclone copy ${OG}/08-pretext/snapshot/OG820_v240501.hic1..dualFullMap.png pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/pretext
rclone copy ${OG}/08-pretext/snapshot/OG820_v240501.hic1..hap1FullMap.png pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/pretext
rclone copy ${OG}/08-pretext/snapshot/OG820_v240501.hic1..hap2FullMap.png pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/pretext


rclone copy ${OG}/08-pretext/OG820_v240501.hic1.dual.pretext pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/pretext
rclone copy ${OG}/08-pretext/G820_v240501.hic1.hap1.pretext pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/pretext
rclone copy ${OG}/08-pretext/OG820_v240501.hic1.hap2.pretext pawsey0812:oceanomics-assemblies/${OG}/${OG}_${asm_ver}/pretext











