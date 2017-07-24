#!/usr/bin/env Rscript
library(GenomicRanges)
library(data.table)

# load the bedfile
mitos_bed_file = "raw_data/aswmtdna/asw_mtdna_meraculous_pilon.bed"
mitos_bed <- rtracklayer::import.bed(mitos_bed_file)

# fix chromosome names
seqlevels(mitos_bed) <- "Scaffold2"

# make a copy of mcols
mtdna_mcols <- as.data.table(mcols(mitos_bed))

# parse the MITOS gene names for sequence type
mtdna_mcols[grep("^trn", name), type := "tRNA"]
mtdna_mcols[grep("^rrn", name), type := "rRNA"]
mtdna_mcols[grep("^OH", name), type := "rep_origin"]
mtdna_mcols[is.na(type), type := "gene"]

# rename columns for better GFF3 parsing
setnames(mtdna_mcols, "name", "Name")
mtdna_mcols[, ID := Name]
mtdna_mcols[, source := "mitos2beta"]

# replace mcols with modified version
mcols(mitos_bed) <- data.frame(mtdna_mcols)

# write output to gff3
rtracklayer::export(object = mitos_bed,
                    con = "processed_data/aswmtdna/mitos_fixed.gff3",
                    format = "gff3",
                    version = "3")
