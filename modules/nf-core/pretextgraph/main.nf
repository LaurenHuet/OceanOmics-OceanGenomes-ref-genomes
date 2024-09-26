process PRETEXTGRAPH {
    tag "$meta.id"
    label 'process_low'

    conda "${moduleDir}/environment.yml"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/pretextgraph:0.0.6--h4ac6f70_3':
        'biocontainers/pretextgraph:0.0.6--h4ac6f70_3' }"

    input:
    tuple val(meta), path(bedgraph), path(pretext_map)

    output:

    tuple val(meta), path("*.pretext")  , emit: pretext_graph
    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"

    """
    cat $bedgraph | \\
    PretextGraph \\
        -i $pretext_map \\
        $args

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        pretextgraph: \$(samtools --version |& sed '1!d ; s/samtools //')
    END_VERSIONS
    """

    stub:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"

    """
    touch ${prefix}.bam

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        pretextgraph: \$(pretextgraph --version |& sed '1!d ; s/pretextgraph //')
    END_VERSIONS
    """
}
