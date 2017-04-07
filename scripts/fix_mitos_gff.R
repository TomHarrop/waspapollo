#!/usr/bin/env Rscript

library(GenomicRanges)
library(data.table)

# load the gff1
mitos_gff_file = "dataraw/vvmtdna/VvulGU207861repc1bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.gff"
mitos_gff1 <- rtracklayer::import.gff1(mitos_gff_file)

# fix chromosome names
seqlevels(mitos_gff1) <- "Vvul-mtDNA"

# move type to ID
mcols(mitos_gff1)$ID <- mcols(mitos_gff1)$type

# fix mcols
mtdna_mcols <- as.data.table(mcols(mitos_gff1))

mtdna_mcols[, ID := as.character(type)]
mtdna_mcols[, Name := as.character(type)]

mtdna_mcols[grep("^trn", type), new_type := "tRNA"]
mtdna_mcols[grep("^rrn", type), new_type := "rRNA"]
mtdna_mcols[is.na(new_type), new_type := "exon"]

mtdna_mcols[, type := new_type][, new_type := NULL]

# insert fixed mcols
mcols(mitos_gff1) <- data.frame(mtdna_mcols)

rtracklayer::export(object = mitos_gff1,
                    con = "dataraw/vvmtdna/vvul_mitos_fixed.gff",
                    format = "gff3",
                    version = "3")
