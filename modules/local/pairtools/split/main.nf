process PAIRTOOLS_SPLIT {
    tag "$meta.id"
    label 'process_low'

    conda "${moduleDir}/environment.yml"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'docker.io/sawtooth01/pairtools:v1.1.0':
        'biocontainers/pairtools:1.1.0--py310hb45ccb3_0' }"

    input:
    tuple val(meta), path(pairs)
    val(tempdir)

    output:
    tuple val(meta), path("*.unsorted.bam"), emit: bam
    tuple val(meta), path("*.mapped.pairs"), emit: pairs
    path "versions.yml"                    , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    export PATH=$PATH:/opt/conda/envs/pairtools/bin
    pairtools \\
        split \\
        $args \\
        --output-pairs "${prefix}.mapped.pairs" \\
        --output-sam "${prefix}.unsorted.bam" \\
        $pairs

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        pairtools: \$(pairtools --version 2>&1 | tr '\\n' ',' | sed 's/.*pairtools.*version //' | sed 's/,\$/\\n/')
    END_VERSIONS
    """
}
