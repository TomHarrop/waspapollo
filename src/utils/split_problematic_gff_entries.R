#!/usr/bin/env Rscript

library(GenomicRanges)
library(data.table)

gff <- rtracklayer::import.gff3("apollo_annotations/apollo_annotations.gff3")

# manually find children
# REPEAT UNTIL LENGTH DOESN'T CHANGE
# FIXME: WRITE LOOP
mc <- as.data.table(mcols(gff))
problem_ids <- c("aaea5d20-0ab0-4460-9e1a-98c2f3684bf6",
                 "5e115df1-a343-4591-9aca-ea43c1d5a850")
child_ids <- mc[Parent %in% problem_ids, unique(ID)] 
problem_ids <- unique(c(problem_ids, child_ids))
length(problem_ids)

# split problematic entries
gff_excluded <- gff[gff$ID %in% problem_ids]
gff_filtered <- gff[!gff$ID %in% problem_ids]

# write gff
rtracklayer::export.gff3(gff_excluded,
                         "apollo_annotations/apollo_annotations_excluded.gff3")

rtracklayer::export.gff3(gff_filtered,
                         "apollo_annotations/apollo_annotations_filtered.gff3")
