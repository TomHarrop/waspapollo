library(httr)
library(GenomicRanges)

my_email <- ""

base_url <- "http://thehive.otago.ac.nz:8080/apollo-2.0.6"
path <- "/IOService/write"

# download annotations from apollo
gff_response <- httr::POST(url = paste0(base_url, path),
           encode = "json",
           body = list(
             username = my_email,
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
