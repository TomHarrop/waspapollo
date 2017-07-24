# *Listronotus bonarienses* mitochondrial genome data generation pipeline

1. Fix the FASTA file

sed "s/^>.*/>Scaffold2/" raw_data/aswmtdna/Scaffold2.fasta \
    > processed_data/aswmtdna/aswmtDNA.fasta

2. Fix the mitOS BED file

src/aswmtdna/fix_mitos_bed.R

3. Prepare the apollo files