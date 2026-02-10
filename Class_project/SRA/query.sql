SELECT
	acc, bioproject, organism--, attributes
FROM
	nih-sra-datastore.sra.metadata
WHERE
	consent = "public"
        AND acc IS NOT NULL
	AND bioproject IS NOT NULL
	AND assay_type = "WGS"
	AND platform = "ILLUMINA"
	AND librarysource = "GENOMIC"
	AND organism != "Homo sapiens"
	AND organism != "unidentified"
	AND not organism LIKE '%metagenom%'
	AND NOT EXISTS (SELECT 1 FROM UNNEST(attributes) AS a WHERE LOWER(a.k) LIKE '%host%')
    AND EXISTS (
        SELECT 1
        FROM UNNEST(attributes) AS a
        WHERE LOWER(a.k) LIKE '%lat%' AND LOWER(a.v) NOT IN ('na', 'not provided', '', 'unknown', 'not applicable') AND a.v IS NOT NULL
    )
    AND EXISTS (
        SELECT 1
        FROM UNNEST(attributes) AS a
        WHERE LOWER(a.k) LIKE '%lon%' AND LOWER(a.v) NOT IN ('na', 'not provided', '', 'unknown', 'not applicable') AND a.v IS NOT NULL
    )
--LIMIT 1000;
