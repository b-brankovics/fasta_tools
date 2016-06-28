# FASTA-tools

This package contains Perl programs/scripts that perform frequently
needed operations on FASTA format files. Such as adjusting the line
length to a uniform length, reverse complementing sequences,
identifying entries with identical sequences, etc.

The executable files are located in the [bin](bin) folder.

------------------------------------
## Programs:

### [fasta_pretty](bin/fasta_pretty)

A tool to format fasta files to uniform column width (60).

------------------------------------
### [fasta_reversecomplement](bin/fasta_reversecomplement)

A tool to reverse complement the entries of FASTA format files.

------------------------------------
### [fasta_length](bin/fasta_length)

A tool to get sequence length information for FASTA files.

------------------------------------
### [fasta_similarity](bin/fasta_similarity)

A tool to measure sequence similarity of aligned sequences in multi
FASTA format files.

------------------------------------
### [fasta_variability](bin/fasta_variability)

A tool to measure sequence variability of aligned sequences in multi
FASTA format files.

------------------------------------
### [fasta_unique](bin/fasta_unique)

A tool to remove duplicate sequence from FASTA format files and
print the groups to STDERR.

Example:

     fasta_unique input.fas >unique.fas 2>unique.tab

------------------------------------
### [fasta_deunique](bin/fasta_deunique)

A tool to format FASTA file to replace names from duplicate removal
by fasta_unique. Using the produced fasta file and the names table.

Example:

     fasta_deunique -i unique.fas -tab unique.tab >deunique.fas
