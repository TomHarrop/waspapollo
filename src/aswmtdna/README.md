# *Listronotus bonarienses* mitochondrial genome data generation pipeline

1. Fix the FASTA file

sed "s/^>.*/>Scaffold2/" raw_data/aswmtdna/Scaffold2.fasta \
    > processed_data/aswmtdna/aswmtDNA.fasta

2. Fix the mitOS BED file

src/aswmtdna/fix_mitos_bed.R

3. Fix the Pilon BED file

src/aswmtdna/fix_pilon_bed.R

4. Subsample the BAM file



5. Convert coverage wig to bigwig

src/aswmtdna/convert_pilon_wig_to_bigwig.R

6. Prepare the apollo files

src/aswmtdna/prepare_apollo_data

