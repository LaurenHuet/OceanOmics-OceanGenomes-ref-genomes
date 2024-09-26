// TODO nf-core: If in doubt look at other nf-core/subworkflows to see how we are doing things! :)
//               https://github.com/nf-core/modules/tree/master/subworkflows
//               You can also ask for help via your pull request or on the #subworkflows channel on the nf-core Slack workspace:
//               https://nf-co.re/join
// TODO nf-core: A subworkflow SHOULD import at least two modules

include { CAT_FASTQ                                      } from '../../../modules/nf-core/cat/fastq/main'
include { MINIMAP2_ALIGN                                 } from '../../..modules/nf-core/minimap2/align/main'
include { SAMTOOLS_SORT as SAMTOOLS_SORT_DUAL            } from '../../..modules/nf-core/samtools/sort/main'
include { BEDTOOLS_GENOMECOV                             } from '../../..modules/nf-core/bedtools/genomecov/main'

workflow COVERAGE_TRACKS {

    take:
    // TODO nf-core: edit input (take) channels
    ch_coverage_tracks_in    //channel: [val(meta), [reads] [assembly] ] 

    main:

    ch_versions = Channel.empty()
    ch_hic_read = ch_coverage_tracks_in
        .map {
            meta, reads, assembly ->
                return [ meta, reads ]
        }
    ch_assembly = ch_coverage_tracks_in
        .map {
            meta, reads, assembly ->
                return [ meta, assembly ]
        }
    ch_versions = Channel.empty()

    // TODO nf-core: substitute modules here for the modules of your subworkflow

    CAT_FASTQ (ch_hic_read)
    ch_versions = ch_versions.mix(CAT_FASTQ.out.versions.first())

    ch_minimap_in = (CAT_FASTQ.out.cat_hifi).join(ch_assembly)        
        .map {
            meta, reads, assembly ->
                return [ meta, reads, assembly ]
        }
    
    MINIMAP2_ALIGN (
        ch_minimap_in,
        true,
        false,
        false,
        false
    )
    ch_versions = ch_versions.mix(MINIMAP2_ALIGN.out.versions.first())
  
    //SAMTOOLS_SORT_DUAL ( 
    //    MINIMAP2_ALIGN.out.bam_dual_hap,
    //    "${meta.sample}.dual.hap.mapped.bam"
    //)  
    //ch_versions = ch_versions.mix(SAMTOOLS_SORT_DUAL.out.versions.first())

    BEDTOOLS_GENOMECOV (MINIMAP2_ALIGN.out.bam )
    ch_versions = ch_versions.mix(BEDTOOLS_GENOMECOV.out.versions.first())



    emit:
    // TODO nf-core: edit emitted channels
    bam      = MINIMAP2_ALIGN.out.bam_dual_hap           // channel: [ val(meta), [ bam ] ]
    bam      = SAMTOOLS_SORT_DUAL.out.bam               // channel: [ val(meta), [ bai ] ]
    bed      = BEDTOOLS_GENOMECOV.out.bedgraphs          // channel: [ val(meta), [ bed ] ]

    versions = ch_versions                     // channel: [ versions.yml ]
}
