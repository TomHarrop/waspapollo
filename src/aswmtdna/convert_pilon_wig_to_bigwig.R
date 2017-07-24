#!/usr/bin/env Rscript
library(GenomicRanges)

wig <- rtracklayer::import.wig(
    "raw_data/aswmtdna/Scaffold2PhysicalCoverage.wig")

seqlengths(wig) <- length(wig)

rtracklayer::export(object = wig,
                    con = "processed_data/aswmtdna/Scaffold2PhysicalCoverage.bw",
                    format = "BigWig")
