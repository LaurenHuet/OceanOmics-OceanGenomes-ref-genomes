process PAIRTOOLS_SORT {
    tag "$meta.id"
    label 'process_high'
//'docker://sawtooth01/pairtools:v1.1.0':
 //export MPLCONFIGDIR=$tempdir
    // Pinning numpy to 1.23 until https://github.com/open2c/pairtools/issues/170 is resolved
    // Not an issue with the biocontainers because they were built prior to numpy 1.24
    conda "${moduleDir}/environment.yml"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'docker.io/sawtooth01/pairtools:v1.1.0':
        'biocontainers/pairtools:1.0.2--py39h2a9f597_0' }"

    input:
    tuple val(meta), path(input)
    val(tempdir)

    output:
    tuple val(meta), path("*.pairs"), emit: sorted
    path "versions.yml"                , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    def buffer = task.memory.toGiga()
    """
    if [[ -n $tempdir ]]; then
        temp=$tempdir
    fi
    
    export PATH=$PATH:/opt/conda/envs/pairtools/bin
    pairtools \\
        sort \\
        $args \\
        --nproc $task.cpus \\
        --tmpdir=$tempdir \\
        --memory ${buffer}G \\
        -o ${prefix}.pairs \\
        $input > log.txt

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        pairtools: \$(pairtools --version 2>&1 | tr '\\n' ',' | sed 's/.*pairtools.*version //' | sed 's/,\$/\\n/')
    END_VERSIONS
    """
}
