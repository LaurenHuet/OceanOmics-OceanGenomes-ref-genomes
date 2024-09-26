//
    // Collect HIFIADAPTERFILT files for rclone
    //
    ch_rclone_in = ch_rclone_in.mix(
        HIFIADAPTERFILT.out.reads
            .map {
                meta, reads ->
                    return [ meta, "hifiadapterfilt_reads", reads, "${params.rclonedest}/${meta.sample}/${meta.id}/hifiadapterfilt" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        HIFIADAPTERFILT.out.stats
            .map {
                meta, stats ->
                    return [ meta, "hifiadapterfilt_stats", stats, "${params.rclonedest}/${meta.sample}/${meta.id}/hifiadapterfilt/qc_stats" ]
            }
    )

    //
    // Collect MERYL files for rclone
    //
    TAR (
        MERYL_COUNT.out.meryl_db,
        "meryldb.tar.gz"
    )
    ch_versions = ch_versions.mix(TAR.out.versions.first())

    ch_rclone_in = ch_rclone_in.mix(
        TAR.out.tar_file
            .map {
                meta, meryl_db ->
                    return [ meta, "meryl_tar_file", meryl_db, "${params.rclonedest}/${meta.sample}/${meta.id}/meryl" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERYL_HISTOGRAM.out.hist
            .map {
                meta, hist ->
                    return [ meta, "meryl_hist", hist, "${params.rclonedest}/${meta.sample}/${meta.id}/meryl" ]
            }
    )

    //
    // Collect GENOMESCOPE2 files for rclone
    //
    ch_rclone_in = ch_rclone_in.mix(
        GENOMESCOPE2.out.linear_plot_png
            .map {
                meta, linear_plot_png ->
                    return [ meta, "genomescope2_linear_plot_png", linear_plot_png, "${params.rclonedest}/${meta.sample}/${meta.id}/genomescope2" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        GENOMESCOPE2.out.transformed_linear_plot_png
            .map {
                meta, transformed_linear_plot_png ->
                    return [ meta, "genomescope2_transformed_linear_plot_png", transformed_linear_plot_png, "${params.rclonedest}/${meta.sample}/${meta.id}/genomescope2" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        GENOMESCOPE2.out.log_plot_png
            .map {
                meta, log_plot_png ->
                    return [ meta, "genomescope2_log_plot_png", log_plot_png, "${params.rclonedest}/${meta.sample}/${meta.id}/genomescope2" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        GENOMESCOPE2.out.transformed_log_plot_png
            .map {
                meta, transformed_log_plot_png ->
                    return [ meta, "genomescope2_transformed_log_plot_png", transformed_log_plot_png, "${params.rclonedest}/${meta.sample}/${meta.id}/genomescope2" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        GENOMESCOPE2.out.model
            .map {
                meta, model ->
                    return [ meta, "genomescope2_model", model, "${params.rclonedest}/${meta.sample}/${meta.id}/genomescope2" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        GENOMESCOPE2.out.summary
            .map {
                meta, summary ->
                    return [ meta, "genomescope2_summary", summary, "${params.rclonedest}/${meta.sample}/${meta.id}/genomescope2" ]
            }
    )

    //
    // Collect HIFIASM files for rclone
    //
    ch_rclone_in = ch_rclone_in.mix(
        HIFIASM.out.raw_unitigs
            .map {
                meta, raw_unitigs ->
                    return [ meta, "hifiasm_raw_unitigs", raw_unitigs, "${params.rclonedest}/${meta.sample}/${meta.id}/hifiasm" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        HIFIASM.out.corrected_reads
            .map {
                meta, corrected_reads ->
                    return [ meta, "hifiasm_corrected_reads", corrected_reads, "${params.rclonedest}/${meta.sample}/${meta.id}/hifiasm" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        HIFIASM.out.source_overlaps
            .map {
                meta, source_overlaps ->
                    return [ meta, "hifiasm_source_overlaps", source_overlaps, "${params.rclonedest}/${meta.sample}/${meta.id}/hifiasm" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        HIFIASM.out.reverse_overlaps
            .map {
                meta, reverse_overlaps ->
                    return [ meta, "hifiasm_reverse_overlaps", reverse_overlaps, "${params.rclonedest}/${meta.sample}/${meta.id}/hifiasm" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        HIFIASM.out.processed_unitigs
            .map {
                meta, processed_unitigs ->
                    return [ meta, "hifiasm_processed_untigs", processed_unitigs, "${params.rclonedest}/${meta.sample}/${meta.id}/hifiasm" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        HIFIASM.out.hap1_contigs
            .map {
                meta, hap1_contigs ->
                    return [ meta, "hifiasm_hap1_logs", hap1_contigs, "${params.rclonedest}/${meta.sample}/${meta.id}/hifiasm" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        HIFIASM.out.hap2_contigs
            .map {
                meta, hap2_contigs ->
                    return [ meta, "hifiasm_hap2_logs", hap2_contigs, "${params.rclonedest}/${meta.sample}/${meta.id}/hifiasm" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        HIFIASM.out.log
            .map {
                meta, log ->
                    return [ meta, "hifiasm_log", log, "${params.rclonedest}/${meta.sample}/${meta.id}/hifiasm" ]
            }
    )

    //
    // Collect GFASTATS files for rclone
    //
    ch_rclone_in = ch_rclone_in.mix(
        GFASTATS_HAP1.out.assembly
            .map {
                meta, assembly ->
                    return [ meta, "gfastats_hap1_assembly", assembly, "${params.rclonedest}/${meta.sample}/${meta.id}/gfastats" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        GFASTATS_HAP2.out.assembly
            .map {
                meta, assembly ->
                    return [ meta, "gfastats_hap2_assembly", assembly, "${params.rclonedest}/${meta.sample}/${meta.id}/gfastats" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        GFASTATS_HAP1.out.assembly_summary
            .map {
                meta, assembly_summary ->
                    return [ meta, "gfastats_hap1_assembly_summary", assembly_summary, "${params.rclonedest}/${meta.sample}/${meta.id}/gfastats" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        GFASTATS_HAP2.out.assembly_summary
            .map {
                meta, assembly_summary ->
                    return [ meta, "gfastats_hap2_assembly_summary", assembly_summary, "${params.rclonedest}/${meta.sample}/${meta.id}/gfastats" ]
            }
    )

    //
    // Collect BUSCO files for rclone
    //
    ch_rclone_in = ch_rclone_in.mix(
        BUSCO_BUSCO.out.batch_summary
            .map {
                meta, batch_summary ->
                    return [ meta, "busco_batch_summary", batch_summary, "${params.rclonedest}/${meta.sample}/${meta.id}/busco" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        BUSCO_BUSCO.out.short_summaries_txt
            .map {
                meta, short_summaries_txt ->
                    return [ meta, "busco_short_summaries_txt", short_summaries_txt, "${params.rclonedest}/${meta.sample}/${meta.id}/busco" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        BUSCO_BUSCO.out.short_summaries_json
            .map {
                meta, short_summaries_json ->
                    return [ meta, "busco_short_summaries_json", short_summaries_json, "${params.rclonedest}/${meta.sample}/${meta.id}/busco" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        BUSCO_BUSCO.out.busco_dir
            .map {
                meta, busco_dir ->
                    return [ meta, "busco_busco_dir", busco_dir, "${params.rclonedest}/${meta.sample}/${meta.id}/busco" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        BUSCO_GENERATEPLOT.out.png
            .map {
                meta, png ->
                    return [ meta, "busco_png", png, "${params.rclonedest}/${meta.sample}/${meta.id}/busco" ]
            }
    )

    //
    // Collect MERQURY files for rclone
    //
   // ch_rclone_in = ch_rclone_in.mix(
   //     MERQURY.out.assembly_only_kmers_bed
   //         .map {
   //             meta, assembly_only_kmers_bed ->
   //                 return [ meta, "merqury_assembly_only_kmers_bed", assembly_only_kmers_bed, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury/${meta.tolid}_png" ]
    //        }
   // )
    //ch_rclone_in = ch_rclone_in.mix(
   //     MERQURY.out.assembly_only_kmers_wig
   //         .map {
   //             meta, assembly_only_kmers_wig ->
   //                 return [ meta, "merqury_assembly_only_kmers_wig", assembly_only_kmers_wig, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury/${meta.tolid}_png" ]
   //         }
   // )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY.out.stats
            .map {
                meta, stats ->
                    return [ meta, "merqury_stats", stats, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY.out.dist_hist
            .map {
                meta, dist_hist ->
                    return [ meta, "merqury_dist_hist", dist_hist, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY.out.spectra_cn_fl_png
            .map {
                meta, spectra_cn_fl_png ->
                    return [ meta, "merqury_spectra_cn_fl_png", spectra_cn_fl_png, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY.out.spectra_cn_hist
            .map {
                meta, spectra_cn_hist ->
                    return [ meta, "merqury_spectra_cn_hist", spectra_cn_hist, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY.out.spectra_cn_ln_png
            .map {
                meta, spectra_cn_ln_png ->
                    return [ meta, "merqury_spectra_cn_ln_png", spectra_cn_ln_png, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY.out.spectra_cn_st_png
            .map {
                meta, spectra_cn_st_png ->
                    return [ meta, "merqury_spectra_cn_st_png", spectra_cn_st_png, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY.out.spectra_asm_fl_png
            .map {
                meta, spectra_asm_fl_png ->
                    return [ meta, "merqury_spectra_asm_fl_png", spectra_asm_fl_png, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY.out.spectra_asm_hist
            .map {
                meta, spectra_asm_hist ->
                    return [ meta, "merqury_spectra_asm_hist", spectra_asm_hist, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY.out.spectra_asm_ln_png
            .map {
                meta, spectra_asm_ln_png ->
                    return [ meta, "merqury_spectra_asm_ln_png", spectra_asm_ln_png, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY.out.spectra_asm_st_png
            .map {
                meta, spectra_asm_st_png ->
                    return [ meta, "merqury_spectra_asm_st_png", spectra_asm_st_png, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY.out.assembly_qv
            .map {
                meta, assembly_qv ->
                    return [ meta, "merqury_assembly_qv", assembly_qv, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY.out.scaffold_qv
            .map {
                meta, scaffold_qv ->
                    return [ meta, "merqury_scaffold_qv", scaffold_qv, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY.out.read_ploidy
            .map {
                meta, read_ploidy ->
                    return [ meta, "merqury_read_ploidy", read_ploidy, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury/${meta.tolid}_png" ]
            }
    )

    //
    // Collect OMNIC files for rclone
    //
    ch_rclone_in = ch_rclone_in.mix(
        OMNIC_HAP1.out.fai
            .map {
                meta, fai ->
                    return [ meta, "omnic_hap1_fai", fai, "${params.rclonedest}/${meta.sample}/${meta.id}/omnic" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        OMNIC_HAP2.out.fai
            .map {
                meta, fai ->
                    return [ meta, "omnic_hap2_fai", fai, "${params.rclonedest}/${meta.sample}/${meta.id}/omnic" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        OMNIC_HAP1.out.bam
            .map {
                meta, bam ->
                    return [ meta, "omnic_hap1_bam", bam, "${params.rclonedest}/${meta.sample}/${meta.id}/omnic" ]
            }
    )
    MD5SUM_OMNICS_HAP1(
        OMNIC_HAP1.out.bam
            .map {
                meta, bam ->
                    return [ meta, "omnic_hap1_bam", bam ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MD5SUM_OMNICS_HAP1.out.txt
            .map {
                meta, txt ->
                    return [ meta, "omnic_hap1_bam_md5sum", txt, "${params.rclonedest}/${meta.sample}/${meta.id}/omnic" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        OMNIC_HAP2.out.bam
            .map {
                meta, bam ->
                    return [ meta, "omnic_hap2_bam", bam, "${params.rclonedest}/${meta.sample}/${meta.id}/omnic" ]
            }
    )
    MD5SUM_OMNICS_HAP2(
        OMNIC_HAP2.out.bam
            .map {
                meta, bam ->
                    return [ meta, "omnic_hap2_bam", bam ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MD5SUM_OMNICS_HAP2.out.txt
            .map {
                meta, txt ->
                    return [ meta, "omnic_hap2_bam_md5sum", txt, "${params.rclonedest}/${meta.sample}/${meta.id}/omnic" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        OMNIC_HAP1.out.bai
            .map {
                meta, bai ->
                    return [ meta, "omnic_hap1_bai", bai, "${params.rclonedest}/${meta.sample}/${meta.id}/omnic" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        OMNIC_HAP2.out.bai
            .map {
                meta, bai ->
                    return [ meta, "omnic_hap2_bai", bai, "${params.rclonedest}/${meta.sample}/${meta.id}/omnic" ]
            }
    )

    //
    // Collect YAHS files for rclone
    //
    ch_rclone_in = ch_rclone_in.mix(
        YAHS_HAP1.out.scaffolds_fasta
            .map {
                meta, scaffolds_fasta ->
                    return [ meta, "yahs_hap1_scaffolds_fasta", scaffolds_fasta, "${params.rclonedest}/${meta.sample}/${meta.id}/yahs" ]
            }
    )
    MD5SUM_YAHS_HAP1(
        YAHS_HAP1.out.scaffolds_fasta
            .map {
                meta, scaffolds_fasta ->
                    return [ meta, "yahs_hap1_scaffolds_fasta", scaffolds_fasta ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MD5SUM_YAHS_HAP1.out.txt
            .map {
                meta, txt ->
                    return [ meta, "yahs_hap1_scaffolds_fasta_md5sum", txt, "${params.rclonedest}/${meta.sample}/${meta.id}/yahs" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        YAHS_HAP2.out.scaffolds_fasta
            .map {
                meta, scaffolds_fasta ->
                    return [ meta, "yahs_hap2_scaffolds_fasta", scaffolds_fasta, "${params.rclonedest}/${meta.sample}/${meta.id}/yahs" ]
            }
    )
    MD5SUM_YAHS_HAP2(
        YAHS_HAP2.out.scaffolds_fasta
            .map {
                meta, scaffolds_fasta ->
                    return [ meta, "yahs_hap2_scaffolds_fasta", scaffolds_fasta ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MD5SUM_YAHS_HAP2.out.txt
            .map {
                meta, txt ->
                    return [ meta, "yahs_hap2_scaffolds_fasta_md5sum", txt, "${params.rclonedest}/${meta.sample}/${meta.id}/yahs" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        YAHS_HAP1.out.scaffolds_agp
            .map {
                meta, scaffolds_agp ->
                    return [ meta, "yahs_hap1_scaffolds_agp", scaffolds_agp, "${params.rclonedest}/${meta.sample}/${meta.id}/yahs" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        YAHS_HAP2.out.scaffolds_agp
            .map {
                meta, scaffolds_agp ->
                    return [ meta, "yahs_hap2_scaffolds_agp", scaffolds_agp, "${params.rclonedest}/${meta.sample}/${meta.id}/yahs" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        YAHS_HAP1.out.binary
            .map {
                meta, binary ->
                    return [ meta, "yahs_hap1_binary", binary, "${params.rclonedest}/${meta.sample}/${meta.id}/yahs" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        YAHS_HAP2.out.binary
            .map {
                meta, binary ->
                    return [ meta, "yahs_hap2_binary", binary, "${params.rclonedest}/${meta.sample}/${meta.id}/yahs" ]
            }
    )

    //
    // Collect FCSGX files for rclone
    //
    ch_rclone_in = ch_rclone_in.mix(
        FCS_FCSGX_HAP1.out.fcs_gx_report
            .map {
                meta, fcs_gx_report ->
                    return [ meta, "fcsgx_hap1_gx_report", fcs_gx_report, "${params.rclonedest}/${meta.sample}/${meta.id}/fcsgx" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        FCS_FCSGX_HAP2.out.fcs_gx_report
            .map {
                meta, fcs_gx_report ->
                    return [ meta, "fcsgx_hap2_gx_report", fcs_gx_report, "${params.rclonedest}/${meta.sample}/${meta.id}/fcsgx" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        FCS_FCSGX_HAP1.out.taxonomy_report
            .map {
                meta, taxonomy_report ->
                    return [ meta, "fcsgx_hap1_taxonomy_report", taxonomy_report, "${params.rclonedest}/${meta.sample}/${meta.id}/fcsgx" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        FCS_FCSGX_HAP2.out.taxonomy_report
            .map {
                meta, taxonomy_report ->
                    return [ meta, "fcsgx_hap2_taxonomy_report", taxonomy_report, "${params.rclonedest}/${meta.sample}/${meta.id}/fcsgx" ]
            }
    )

    //
    // Collect TIARA files for rclone
    //
    ch_rclone_in = ch_rclone_in.mix(
        TIARA_TIARA_HAP1.out.classifications
            .map {
                meta, classifications ->
                    return [ meta, "tiara_hap1_classifications", classifications, "${params.rclonedest}/${meta.sample}/${meta.id}/tiara" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        TIARA_TIARA_HAP2.out.classifications
            .map {
                meta, classifications ->
                    return [ meta, "tiara_hap2_classifications", classifications, "${params.rclonedest}/${meta.sample}/${meta.id}/tiara" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        TIARA_TIARA_HAP1.out.log
            .map {
                meta, log ->
                    return [ meta, "tiara_hap1_log", log, "${params.rclonedest}/${meta.sample}/${meta.id}/tiara" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        TIARA_TIARA_HAP2.out.log
            .map {
                meta, log ->
                    return [ meta, "tiara_hap2_log", log, "${params.rclonedest}/${meta.sample}/${meta.id}/tiara" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        TIARA_TIARA_HAP1.out.fasta
            .map {
                meta, fasta ->
                    return [ meta, "tiara_hap1_fasta", fasta, "${params.rclonedest}/${meta.sample}/${meta.id}/tiara" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        TIARA_TIARA_HAP2.out.fasta
            .map {
                meta, fasta ->
                    return [ meta, "tiara_hap2_fasta", fasta, "${params.rclonedest}/${meta.sample}/${meta.id}/tiara" ]
            }
    )

    //
    // Collect concatenated BBMAP_FILTERBYNAME files for rclone
    //
    ch_rclone_in = ch_rclone_in.mix(
        CAT_SCAFFOLDS.out.cat_file
            .map {
                meta, cat_file ->
                    return [ meta, "cat_scaffolds_hap1_hap2_scaffold", cat_file, "${params.rclonedest}/${meta.sample}/${meta.id}/bbmap" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        CAT_SCAFFOLDS.out.hap1_scaffold
            .map {
                meta, hap1_scaffold ->
                    return [ meta, "cat_scaffolds_hap1_scaffold", hap1_scaffold, "${params.rclonedest}/${meta.sample}/${meta.id}/bbmap" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        CAT_SCAFFOLDS.out.hap2_scaffold
            .map {
                meta, hap2_scaffold ->
                    return [ meta, "cat_scaffolds_hap2_scaffold", hap2_scaffold, "${params.rclonedest}/${meta.sample}/${meta.id}/bbmap" ]
            }
    )

    //
    // Collect final GFASTATS files for rclone
    //
    ch_rclone_in = ch_rclone_in.mix(
        GFASTATS_FINAL.out.assembly
            .map {
                meta, assembly ->
                    return [ meta, "gfastats_final_assembly", assembly, "${params.rclonedest}/${meta.sample}/${meta.id}/gfastats_final" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        GFASTATS_FINAL.out.assembly_summary
            .map {
                meta, assembly_summary ->
                    return [ meta, "gfastats_final_assembly_summary", assembly_summary, "${params.rclonedest}/${meta.sample}/${meta.id}/gfastats_final" ]
            }
    )

    //
    // Collect final BUSCO files for rclone
    //
    ch_rclone_in = ch_rclone_in.mix(
        BUSCO_BUSCO_FINAL.out.batch_summary
            .map {
                meta, batch_summary ->
                    return [ meta, "busco_final_batch_summary", batch_summary, "${params.rclonedest}/${meta.sample}/${meta.id}/busco_final" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        BUSCO_BUSCO_FINAL.out.short_summaries_txt
            .map {
                meta, short_summaries_txt ->
                    return [ meta, "busco_final_short_summaries_txt", short_summaries_txt, "${params.rclonedest}/${meta.sample}/${meta.id}/busco_final" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        BUSCO_BUSCO_FINAL.out.short_summaries_json
            .map {
                meta, short_summaries_json ->
                    return [ meta, "busco_final_short_summaries_json", short_summaries_json, "${params.rclonedest}/${meta.sample}/${meta.id}/busco_final" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        BUSCO_BUSCO_FINAL.out.busco_dir
            .map {
                meta, busco_dir ->
                    return [ meta, "busco_final_busco_dir", busco_dir, "${params.rclonedest}/${meta.sample}/${meta.id}/busco_final" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        BUSCO_GENERATEPLOT_FINAL.out.png
            .map {
                meta, png ->
                    return [ meta, "busco_final_png", png, "${params.rclonedest}/${meta.sample}/${meta.id}/busco_final" ]
            }
    )

    //
    // Collect final MERQURY files for rclone
    //
   // ch_rclone_in = ch_rclone_in.mix(
    //    MERQURY_FINAL.out.assembly_only_kmers_bed
     //       .map {
      //          meta, assembly_only_kmers_bed ->
      //              return [ meta, "merqury_final_assembly_only_kmers_bed", assembly_only_kmers_bed, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury_final/${meta.tolid}_png" ]
      //      }
   // )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY_FINAL.out.assembly_only_kmers_wig
            .map {
                meta, assembly_only_kmers_wig ->
                    return [ meta, "merqury_final_assembly_only_kmers_wig", assembly_only_kmers_wig, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury_final/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY_FINAL.out.stats
            .map {
                meta, stats ->
                    return [ meta, "merqury_final_stats", stats, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury_final/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY_FINAL.out.dist_hist
            .map {
                meta, dist_hist ->
                    return [ meta, "merqury_final_dist_hist", dist_hist, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury_final/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY_FINAL.out.spectra_cn_fl_png
            .map {
                meta, spectra_cn_fl_png ->
                    return [ meta, "merqury_final_spectra_cn_fl_png", spectra_cn_fl_png, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury_final/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY_FINAL.out.spectra_cn_hist
            .map {
                meta, spectra_cn_hist ->
                    return [ meta, "merqury_spectra_cn_hist", spectra_cn_hist, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury_final/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY_FINAL.out.spectra_cn_ln_png
            .map {
                meta, spectra_cn_ln_png ->
                    return [ meta, "merqury_final_spectra_cn_ln_png", spectra_cn_ln_png, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury_final/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY_FINAL.out.spectra_cn_st_png
            .map {
                meta, spectra_cn_st_png ->
                    return [ meta, "merqury_final_spectra_cn_st_png", spectra_cn_st_png, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury_final/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY_FINAL.out.spectra_asm_hist
            .map {
                meta, spectra_asm_hist ->
                    return [ meta, "merqury_final_spectra_hist", spectra_asm_hist, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury_final/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY_FINAL.out.spectra_asm_ln_png
            .map {
                meta, spectra_asm_ln_png ->
                    return [ meta, "merqury_final_spectra_asm_ln_png", spectra_asm_ln_png, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury_final/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY_FINAL.out.assembly_qv
            .map {
                meta, assembly_qv ->
                    return [ meta, "merqury_final_assembly_qv", assembly_qv, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury_final/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY_FINAL.out.scaffold_qv
            .map {
                meta, scaffold_qv ->
                    return [ meta, "merqury_final_scaffold_qv", scaffold_qv, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury_final/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MERQURY_FINAL.out.read_ploidy
            .map {
                meta, read_ploidy ->
                    return [ meta, "merqury_final_read_ploidy", read_ploidy, "${params.rclonedest}/${meta.sample}/${meta.id}/merqury_final/${meta.tolid}_png" ]
            }
    )
    ch_rclone_in = ch_rclone_in.mix(
        MULTIQC.out.report
            .map {
                meta, report ->
                    return [ meta, "multiqc", report, "${params.rclonedest}/${meta.sample}/${meta.id}/multiqc" ]
            }
    )

    //
    // MODULE: Run rclone
    //
   // RCLONE (
  //      ch_rclone_in
  //  )
  //  ch_versions = ch_versions.mix(RCLONE.out.versions.first())