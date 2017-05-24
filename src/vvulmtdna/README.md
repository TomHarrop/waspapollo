# *Vespula vulgaris* mitochondrial genome data generation pipeline

1. Fix the FASTA file

sed "s/^>.*/>Vvul-mtDNA/" raw_data/vvmtdna/Vvul_longest_quick_scaffold-it12_noIUPAC.fasta \
    > processed_data/vvulmtdna/Vvul-mtDNA.fasta

2. Fix the mitOS gff1 file

src/vvulmtdna/fix_mitos_gff.R

3. Map the vvul RNAseq reads against the fixed gff/fasta (Vvul_longest_quick_scaffold-it12_noIUPAC.fasta == Vvul-mtDNA.fasta)

src/vvulmtdna/map_mtdna_reads_bwamem

4. Run apollo data generations scripts

src/vvulmtdna/prepare_data_files

7. Manually edit apollo_data/vvul/trackList.json to convert BAM tracks to canvas features. Add the following to the json section for the bamfile:

"overridePlugins" : "true"
