#!/usr/bin/env Rscript

library(GenomicRanges)

# load the gff1
rutils::GenerateMessage("Loading GFF")
vvul_gff_file = "raw_data/vvul/annotation/waspass.all.vvul.gff"
vvul_gff3 <- rtracklayer::import.gff3(vvul_gff_file)

# subset feature
rutils::GenerateMessage("Subsetting")
keep_features <- c("gene", "mRNA", "exon", "CDS")
filtered_gff <- vvul_gff3[vvul_gff3$type %in% keep_features]

# remove pipe character
seqlevels(filtered_gff) <- gsub("\\|.*$", "", seqlevels(filtered_gff))

# export result
rutils::GenerateMessage("Writing filtered GFF3")
rtracklayer::export.gff3(filtered_gff, "processed_data/vvul/maker_filtered.gff3")
