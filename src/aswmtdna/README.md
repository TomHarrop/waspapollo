# *Listronotus bonarienses* mitochondrial genome data generation pipeline

1. Fix the FASTA file

sed "s/^>.*/>mt/" raw_data/aswmtdna/assembly_rotated.fasta \
    > processed_data/aswmtdna/aswmtDNA.fasta

2. Fix the mitOS BED file

src/aswmtdna/fix_mitos_bed.R

3. Fix the Pilon BED file

src/aswmtdna/fix_pilon_bed.R

4. Subsample the BAM file

src/aswmtdna/subsample_sr_bam_file
src/aswmtdna/subsample_lr_bam_file

5. Convert coverage wig to bigwig

src/aswmtdna/convert_pilon_wig_to_bigwig.R

6. Prepare the apollo files

src/aswmtdna/prepare_apollo_data

