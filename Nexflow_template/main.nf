params.each { k, v -> 
    println "- $k = $v"
}
println "=============================\n"



workflow {

    // sims
    totalsims = 100
    chan = Channel.of( 1..totalsims )
    sims = Simulate(chan)
    muts = Preprocess(sims)
}



process Simulate {

    // resources
    memory '1 GB'
    time '1m'

    // misc. settings
    conda "${params.condadir}"
    tag "${rep}"
    debug true

    input:
    val(rep)

    output:
    tuple val(rep), file("ms_out_${rep}.txt")

    script:
    """
    n=10
    t=100
    ms \$n 1 -t \$t -seeds ${rep} ${rep} ${rep} > ms_out_${rep}.txt
    """
}



process Preprocess {

    // resources
    memory '1 GB'
    time '1m'

    // misc. settings
    publishDir "${params.pubdir}/Preprocessed_outputs/", pattern: "prep_*.txt", mode: 'copy'
    conda "${params.condadir}"
    tag "${rep}"
    debug true

    input:
    tuple val(rep), file(msfile)

    output:
    file("prep_${rep}.txt")

    script:
    """
    n=10
    tail -\$n $msfile > prep_${rep}.txt
    """
}
