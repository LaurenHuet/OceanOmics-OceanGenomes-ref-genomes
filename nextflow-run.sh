module load nextflow/23.10.0

nextflow run /scratch/pawsey0812/lhuet/OceanGenomes-refgenomes/main.nf -profile singularity --input samplesheet.csv --outdir  /scratch/pawsey0812/lhuet/OG107/ --buscodb /scratch/references/busco_db/actinopterygii_odb10 --gxdb /scratch/pawsey0812/lhuet/NCBI/gxdb --rclonedest huet --binddir /scratch -c pawsey_profile.config -resume --tempdir $MYSCRATCH