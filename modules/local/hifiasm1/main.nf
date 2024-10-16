process HIFIASM1 {
    tag "$meta.id"
    label 'process_high'

    conda "${moduleDir}/environment.yml"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/hifiasm:0.19.8--h43eeafb_0' :
        'biocontainers/hifiasm:0.19.8--h43eeafb_0' }"

    input:
    tuple val(meta), path(reads)
    val (asmversion)

    output:
    tuple val(meta), path("*.r_utg.gfa")       , emit: raw_unitigs
    tuple val(meta), path("*.ec.bin")          , emit: corrected_reads
    tuple val(meta), path("*.ovlp.source.bin") , emit: source_overlaps
    tuple val(meta), path("*.ovlp.reverse.bin"), emit: reverse_overlaps
    tuple val(meta), path("*.bp.p_ctg.gfa")    , emit: processed_contigs, optional: true
    tuple val(meta), path("*.p_utg.gfa")       , emit: processed_unitigs, optional: true
    tuple val(meta), path("*.p_ctg.gfa")       , emit: primary_contigs  , optional: true
    tuple val(meta), path("*.a_ctg.gfa")       , emit: alternate_contigs, optional: true
    tuple val(meta), path("*.hap1.p_ctg.gfa")  , emit: paternal_contigs , optional: true
    tuple val(meta), path("*.hap2.p_ctg.gfa")  , emit: maternal_contigs , optional: true
    tuple val(meta), path("*.log")             , emit: log
    path  "versions.yml"                       , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"

        """
        hifiasm \\
            $args \\
            -o ${prefix}.${asmversion} \\
            -t $task.cpus \\
            $reads \\
            2> >( tee ${prefix}.stderr.log >&2 )

        cat <<-END_VERSIONS > versions.yml
        "${task.process}":
            hifiasm: \$(hifiasm --version 2>&1)
        END_VERSIONS
        """

        stub:
        def args = task.ext.args ?: ''
        def prefix = task.ext.prefix ?: "${meta.id}"
        """
        touch ${prefix}.${asmversion}.r_utg.gfa
        touch ${prefix}.${asmversion}.ec.bin
        touch ${prefix}.${asmversion}.ovlp.source.bin
        touch ${prefix}.${asmversion}.ovlp.reverse.bin
        touch ${prefix}.${asmversion}.bp.p_ctg.gfa
        touch ${prefix}.${asmversion}.p_utg.gfa
        touch ${prefix}.${asmversion}.p_ctg.gfa
        touch ${prefix}.${asmversion}.a_ctg.gfa
        touch ${prefix}.${asmversion}.hap1.p_ctg.gfa
        touch ${prefix}.${asmversion}.hap2.p_ctg.gfa
        touch ${prefix}.stderr.log

        cat <<-END_VERSIONS > versions.yml
        "${task.process}":
            hifiasm: \$(hifiasm --version 2>&1)
        END_VERSIONS
        """

}