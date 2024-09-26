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






