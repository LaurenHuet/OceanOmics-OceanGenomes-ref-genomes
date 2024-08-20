process PAIRTOOLS_DEDUP {
    tag "$meta.id"
    label 'process_high'

    // Pinning numpy to 1.23 until https://github.com/open2c/pairtools/issues/170 is resolved
    // Not an issue with the biocontainers because they were built prior to numpy 1.24
    conda "${moduleDir}/environment.yml"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'docker.io/sawtooth01/pairtools:v1.1.0':
        'biocontainers/pairtools:1.1.0--py310hb45ccb3_0' }"

    input:
    tuple val(meta), path(input)
    val(tempdir)

    output:
    tuple val(meta), path("*.pairs")  , emit: pairs
    tuple val(meta), path("*.pairs.stat"), emit: stat
    path "versions.yml"                  , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    export PATH=$PATH:/opt/conda/envs/pairtools/bin
    pairtools dedup \\
        $args \\
        -o ${prefix}_dedup.pairs \\
        --output-stats ${prefix}_dedup.pairs.stat \\
        $input

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        pairtools: \$(pairtools --version 2>&1 | tr '\\n' ',' | sed 's/.*pairtools.*version //' | sed 's/,\$/\\n/')
    END_VERSIONS
    """
}
