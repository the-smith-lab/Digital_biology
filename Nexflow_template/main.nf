params.each { k, v -> 
    println "- $k = $v"
}
println "=============================\n"


workflow {
    total_indices = 10
    chan = Channel.of( 1..total_indices )
    dls = Download(chan)
    trims = Trim(dls)
}


process Download {

    // resources
    memory '1 GB'
    time '1h'

    // misc. settings
    conda "${params.condadir}"
    tag "${rep}"
    debug true

    input:
    val(rep)

    output:
    tuple val(rep), file("download_${rep}.txt")

    script:
    """
    echo Done. > download_${rep}.txt
    """
}


process Trim {

    // resources
    memory '1 GB'
    time '1h'

    // misc. settings
    publishDir "${params.pubdir}/Pipeline_outputs/", pattern: "trim_*.txt", mode: 'copy'
    conda "${params.condadir}"
    tag "${rep}"
    debug true

    input:
    tuple val(rep), file("download_${rep}.txt")

    output:
    tuple val(rep), file("trim_${rep}.txt")

    script:
    """
    cat download_${rep}.txt | rev > trim_${rep}.txt
    """
}



