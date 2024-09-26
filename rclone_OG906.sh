#!/bin/bash --login
#SBATCH --account=pawsey0812
#SBATCH --job-name=OG906
#SBATCH --partition=work
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --export=NONE
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=lauren.huet@uwa.edu.au
#-----------------
#Loading the required modules


rclone copy /scratch/pawsey0812/lhuet/GalGale/02-assembly pawsey0812:oceanomics-assemblies/OG906/OG906_hifi1/assembly/OG906_hic1.0.hifiasm.hap1.p_ctg.fasta
rclone copy /scratch/pawsey0812/lhuet/GalGale/02-assembly pawsey0812:oceanomics-assemblies/OG906/OG906_hifi1/assembly/OG906_hic1.0.hifiasm.hap2.p_ctg.fasta
rclone copy /scratch/pawsey0812/lhuet/GalGale/02-assembly pawsey0812:oceanomics-assemblies/OG906/OG906_hifi1/assembly/OG906_hic1.0.hifiasm.hap1.p_ctg.gfa
rclone copy /scratch/pawsey0812/lhuet/GalGale/02-assembly pawsey0812:oceanomics-assemblies/OG906/OG906_hifi1/assembly/OG906_hic1.0.hifiasm.hap2.p_ctg.gfa
rclone copy /scratch/pawsey0812/lhuet/GalGale/02-assembly/qc/gfastats/ pawsey0812:oceanomics-assemblies/OG906/OG906_hifi1/assembly/gfastats