# *Vespula vulgaris* data generation pipeline

Run all scripts on thehive unless specified.

1. Filter the maker GFF, remove pipe characters and output to GFF3

src/vvul/fix_vvul_maker_gff.R

2. Sort the Celera fasta file and remove contigs < 1 kb

src/vvul/remove_short_scaffolds.py

3. Remove pipe characters from the sorted FASTA file

src/vvul/rename_scaffolds.py

4. Run tblastn queries for Apis mellifera and Polistes dominula (use biochemcompute)

src/vvul/tblastn_peptides

5. Map RNAseq reads against Vvul genome (use biochemcompute)

src/vvul/star_index
src/vvul/star_pass1
src/vvul/star_pass2
src/vvul/merge_bam_files

5a. Symlink the bamfiles to the data directory

6. Run apollo data generation scripts

src/vvul/prepare_data_files

7. Manually edit apollo_data/vvul/trackList.json to convert BAM tracks to canvas features. Add the following to the json section for each bamfile:

"overridePlugins" : "true"

8. If using HTML features for BAM files, specify css for RNAseq reads to colour them by strand. This is not needed for CanvasFeatures. Add the following to apollo_data/vvul/trackList.json:

"css" : "data/css/stranded_rnaseq.css"

9. Load the organism into apollo
**FIXME** API call for this
