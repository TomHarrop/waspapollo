#!/usr/bin/env Rscript

library(GenomicRanges)
library(data.table)

# load the gff1
mitos_gff_file = "raw_data/vvulmtdna/VvulGU207861repc1bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.gff"
mitos_gff1 <- rtracklayer::import.gff1(mitos_gff_file)

# fix chromosome names
seqlevels(mitos_gff1) <- "Vvul-mtDNA"

# make a copy of mcols
mtdna_mcols <- as.data.table(mcols(mitos_gff1))

# move the "type" field to ID and Name
mtdna_mcols[, ID := as.character(type)]
mtdna_mcols[, Name := as.character(type)]

# parse the MITOS gene names for sequence type
mtdna_mcols[grep("^trn", type), new_type := "tRNA"]
mtdna_mcols[grep("^rrn", type), new_type := "rRNA"]
mtdna_mcols[is.na(new_type), new_type := "exon"]

# overwrite type with new_type and delete new_type
mtdna_mcols[, type := new_type][, new_type := NULL]

# replace mcols with modified version
mcols(mitos_gff1) <- data.frame(mtdna_mcols)

# write output to gff3
rtracklayer::export(object = mitos_gff1,
                    con = "processed_data/vvulmtdna/vvul_mitos_fixed.gff",
                    format = "gff3",
                    version = "3")
