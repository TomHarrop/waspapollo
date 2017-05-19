#!/usr/bin/env python3

from Bio import SeqIO

scaffolds_file = 'raw_data/vvul/genome/waspass.fasta'
sorted_scaffolds = 'processed_data/vvul/scaffolds_sorted.fasta'

# make a sorted list of tuples of scaffold name and sequence length
length_id_unsorted = ((len(rec), rec.id) for
                      rec in SeqIO.parse(scaffolds_file, 'fasta'))
length_and_id = sorted(length_id_unsorted)

# get a shortest-to-longest iterator of scaffolds > 1 kb
scaffolds_over_1kb = reversed([
    id for (length, id) in length_and_id
    if length > 999])

# release scaffolds_file from memory
del(length_and_id)

# build an index of the fasta file
record_index = SeqIO.index(scaffolds_file, 'fasta')

# write selected records in correct order to disk
selected_records = (record_index[id] for id in scaffolds_over_1kb)
SeqIO.write(sequences=selected_records,
            handle=sorted_scaffolds,
            format='fasta')
