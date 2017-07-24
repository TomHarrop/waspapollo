#!/usr/bin/env Rscript
library(GenomicRanges)
library(data.table)

# load the bedfile
pilon_bed_file = "raw_data/aswmtdna/Scaffold2Pilon.bed"
pilon_bed <- rtracklayer::import.bed(pilon_bed_file)

# make a copy of mcols
mtdna_mcols <- as.data.table(mcols(pilon_bed))

# fix weird pilon names
mtdna_mcols[name == "?", name := "pilon_Q"]
mtdna_mcols[name == "X", name := "pilon_X"]
mtdna_mcols[name == "Copy#", name := "Copy_no"]

# set source etc
setnames(mtdna_mcols, "name", "Name")
mtdna_mcols[, ID := Name]
mtdna_mcols[, type := Name]
mtdna_mcols[, source := "Pilon"]

# replace mcols with modified version
mcols(pilon_bed) <- data.frame(mtdna_mcols)

# write output to gff3
rtracklayer::export(object = pilon_bed,
                    con = "processed_data/aswmtdna/pilon_fixed.gff3",
                    format = "gff3",
                    version = "3")
