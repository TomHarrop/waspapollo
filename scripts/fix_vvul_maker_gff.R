#!/usr/bin/env Rscript

library(GenomicRanges)

# load the gff1
rutils::GenerateMessage("Loading GFF")
vvul_gff_file = "dataraw/vvul/waspass.all.vvul.gff"
vvul_gff3 <- rtracklayer::import.gff3(vvul_gff_file)

# subset feature
rutils::GenerateMessage("Subsetting")
keep_features <- c("gene", "mRNA", "exon", "CDS")
filtered_gff <- vvul_gff3[vvul_gff3$type %in% keep_features]

# export result
rutils::GenerateMessage("Writing filtered GFF3")
rtracklayer::export.gff3(filtered_gff, "dataraw/vvul/maker_filtered.gff3")
