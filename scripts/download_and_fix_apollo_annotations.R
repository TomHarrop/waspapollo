#!/usr/bin/env Rscript

library(httr)
library(GenomicRanges)

if (Sys.getenv("APOLLO_USERNAME") != "") {
    apollo_username <- Sys.getenv("APOLLO_USERNAME")
} else {
    stop("Set environment variable APOLLO_USERNAME")
}

if (Sys.getenv("APOLLO_URL") != "") {
    apollo_url <- Sys.getenv("APOLLO_USERNAME")
} else {
    stop("Set environment variable APOLLO_USERNAME")
}

path <- "/IOService/write"

# download annotations from apollo
gff_response <- httr::POST(
    url = paste0(apollo_url, path),
    encode = "json",
    body = list(
        username = apollo_username,
        password = "password",
        type = "GFF3",
        seqType = "genomic",
        format = "text",
        organism = "Vespula vulgaris",
        output = "text"))

gff_text <- content(gff_response, as = "text")

# write to a temp file
tmp <- tempfile(fileext = ".gff3")
writeChar(gff_text, tmp, eos = NULL)

# load into GRanges object
gff <- rtracklayer::import.gff3(tmp)

# remove pipe character
seqlevels(gff) <- gsub("\\|.*$", "", seqlevels(gff))

# write gff
rtracklayer::export.gff3(gff, "apollo_annotations/apollo_annotations.gff3")
