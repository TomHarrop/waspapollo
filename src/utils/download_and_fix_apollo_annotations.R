#!/usr/bin/env Rscript

library(httr)
library(GenomicRanges)

if (Sys.getenv("APOLLO_USERNAME") != "") {
    apollo_username <- Sys.getenv("APOLLO_USERNAME")
} else {
    stop("Set environment variable APOLLO_USERNAME")
}

if (Sys.getenv("APOLLO_URL") != "") {
    apollo_url <- Sys.getenv("APOLLO_URL")
} else {
    stop("Set environment variable APOLLO_URL")
}

if (Sys.getenv("APOLLO_PASSWORD") != "") {
    apollo_password <- Sys.getenv("APOLLO_PASSWORD")
} else {
    stop("Set environment variable APOLLO_PASSWORD")
}

path <- "/IOService/write"

# download annotations from apollo
gff_response <- httr::POST(
    url = paste0(apollo_url, path),
    encode = "json",
    body = list(
        username = apollo_username,
        password = apollo_password,
        type = "GFF3",
        seqType = "genomic",
        format = "text",
        organism = "Vespula vulgaris",
        output = "text"))

gff_text <- content(gff_response, as = "text")

# write to a temp file
gff_text_file <- "apollo_annotations/gff_response.gff3"
writeChar(gff_text, gff_text_file, eos = NULL)

# load into GRanges object
gff <- rtracklayer::import.gff3(gff_text_file)

# remove pipe character
seqlevels(gff) <- gsub("\\|.*$", "", seqlevels(gff))

# write gff
rtracklayer::export.gff3(gff, "apollo_annotations/apollo_annotations.gff3")
