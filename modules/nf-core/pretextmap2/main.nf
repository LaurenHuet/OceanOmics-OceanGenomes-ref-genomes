
process PRETEXTMAP2 {
    tag "$meta.id"

    conda "${moduleDir}/environment.yml"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/mulled-v2-f3591ce8609c7b3b33e5715333200aa5c163aa61%3A44321ab4d64f0b6d0c93abbd1406369d1b3da684-0':
        'biocontainers/mulled-v2-f3591ce8609c7b3b33e5715333200aa5c163aa61:44321ab4d64f0b6d0c93abbd1406369d1b3da684-0' }"

    input:
    tuple val(meta), path(bam)
    val (hap)
    val (asmversion)

    output:
    tuple val(meta), path("*.pretext")  , emit: pretext_map_highres
    path "versions.yml"                 , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args        = task.ext.args     ?: ''
    def prefix      = task.ext.prefix   ?: "${meta.id}"

    """
        samtools \\
            view \\
            -h \\
            $bam | PretextMap \\
            $args \\
            -o ${prefix}.${asmversion}.${hap}.pretext

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        pretextmap: \$(PretextMap | grep "Version" | sed 's/PretextMap Version //g')
        samtools: \$(echo \$(samtools --version 2>&1) | sed 's/^.*samtools //; s/Using.*\$//' )
    END_VERSIONS
    """

    stub:
    def prefix      = task.ext.prefix ?: "${meta.id}"
    """
    touch ${prefix}.pretext

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        pretextmap: \$(PretextMap | grep "Version" | sed 's/PretextMap Version //g')
        samtools: \$(echo \$(samtools --version 2>&1) | sed 's/^.*samtools //; s/Using.*\$//')
    END_VERSIONS
    """
}