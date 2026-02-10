-- SELECT
-- 	bioproject, organism, attributes
-- FROM
-- 	nih-sra-datastore.sra.metadata
-- WHERE
-- 	consent = "public"
-- 	AND bioproject IS NOT NULL
-- 	AND assay_type = "WGS"
-- 	AND platform = "ILLUMINA"
-- 	AND librarysource = "GENOMIC"
-- 	AND organism != "Homo sapiens"
-- 	AND organism != "unidentified"
-- 	AND not organism LIKE '%metagenom%'
-- 	AND NOT EXISTS (SELECT 1 FROM UNNEST(attributes) AS a WHERE a.k LIKE '%host%')
-- LIMIT 1000000;


SELECT
	acc, bioproject, organism
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
	AND NOT EXISTS (SELECT 1 FROM UNNEST(attributes) AS a WHERE a.k LIKE '%host%')


