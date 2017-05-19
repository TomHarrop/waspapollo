#!/usr/bin/env python3

from Bio import SeqIO
import re

sorted_scaffolds = 'processed_data/vvul/scaffolds_sorted.fasta'
renamed_scaffolds = 'processed_data/vvul/scaffolds_renamed.fasta'

# read the fasta file
with open(sorted_scaffolds, 'r') as handle:
    fasta_records = SeqIO.parse(handle, 'fasta')
    records = [x for x in fasta_records]

# fix the ids
id_regex = r'^(?P<SCAFFOLD>.+)\|.*$'
for record in records:
    new_id = re.sub(id_regex, r'\g<SCAFFOLD>', record.id)
    record.id = new_id
    record.name = new_id
    record.description = new_id

# write fixed records in back to disk
SeqIO.write(sequences=records,
            handle=renamed_scaffolds,
            format='fasta')
