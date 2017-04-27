#!/usr/bin/env Rscript

library(GenomicRanges)
library(data.table)

# load the gff1
vvul_gff_file = "dataraw/vvul/waspass.all.vvul.gff"
vvul_gff3 <- rtracklayer::import.gff3(vvul_gff_file)

# subset feature
unique(vvul_gff3$type)
keep_features <- c("gene", "mRNA", "exon", "CDS")
filtered_gff <- vvul_gff3[vvul_gff3$type %in% keep_features]

# export result
rtracklayer::export.gff3(filtered_gff, "dataraw/vvul/filtered.gff3")
