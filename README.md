# FASTA-tools

This package contains Perl programs/scripts that perform frequently
needed operations on FASTA format files. Such as adjusting the line
length to a uniform length, reverse complementing sequences,
identifying entries with identical sequences, etc.

The executable files are located in the [bin](bin) folder.


------------------------------------
## Programs:

### [fasta_reversecomplement](bin/fasta_reversecomplement)

A tool to reverse complement the entries of FASTA format files.

### [fasta_length](bin/fasta_length)

A tool to get sequence length information for FASTA files.

### [fasta_extract](bin/fasta_extract)

A tool to extract selected entries from a multi FASTA file
using regular expression(s) to identify entries.

### [fasta_remove](bin/fasta_remove)

A tool to remove selected entries from a multi FASTA file
using regular expression(s) to identify entries.

### [fasta_similarity](bin/fasta_similarity)

A tool to measure sequence similarity of aligned sequences in multi
FASTA format files.

### [fasta_variability](bin/fasta_variability)

A tool to measure sequence variability of aligned sequences in multi
FASTA format files.

### [fasta_sub](bin/fasta_sub)

A tool to extract a part of the sequences from FASTA files.

### [fasta_shift](bin/fasta_shift)

A tool to shift circular FASTA sequences using 
a reference FASTA file or a position.

### [fasta_find](bin/fasta_find)

A tool to reporting exact sequence matches of entries in a reference
FASTA file in a target FASTA file.

Example:

    fasta_find gene.fas chr.fas

### [fasta_unique](bin/fasta_unique)

A tool to remove duplicate sequence from FASTA format files and
print the groups to STDERR.

Example:

    fasta_unique input.fas >unique.fas 2>unique.tab

### [fasta_deunique](bin/fasta_deunique)

A tool to format FASTA file to replace names from duplicate removal
by fasta_unique. Using the produced fasta file and the names table.

Example:

     fasta_deunique -i unique.fas -tab unique.tab >deunique.fas


### fasta\_pretty

A tool to format FASTA files to uniform column width (60).

#### Synopsis

    fasta_pretty [OPTIONS] [FILE]...

#### Options

- __\-h__ | __\--help__

    Print the help message; ignore other arguments.

#### Input

STDIN and/or FASTA files.
The extention of the files is irrelevant.

#### Output

The output is FASTA format with 60 line length for the sequence. 
The program prints to STDOUT.
This can be captured in a file by using the `>` or `>>` operator.

#### Examples

Format a single file (`input.fas`) and save it to a file (`output.fas`).

    fasta_pretty input.fas >output.fas
    cat input.fas | fasta_pretty >output.fas
    cat input.fas | fasta_pretty - >output.fas

Format and concatenate three FASTA files from the current directory
(`input1.fas`, `input2.fas` and `input3.fas`) and save it to a file (`output.fas`).

    fasta_pretty input1.fas input2.fas input3.fas >output.fas
    fasta_pretty input*.fas >output.fas
    cat input2.fas | fasta_pretty input1.fas - input3.fas >output.fas

### fasta\_dealign

A tool to format FASTA files to remove gap character states and format
to uniform column width (60).

#### Synopsis

    fasta_dealign [OPTIONS] [FILE]...

#### Options

- __\-h__ | __\--help__

    Print the help message; ignore other arguments.

#### Input

STDIN and/or FASTA files.
The extention of the files is irrelevant.

#### Output

The output is FASTA format with 60 line length for the sequence.
The program prints to STDOUT.
This can be captured in a file by using the `>` or `>>` operator.

#### Examples

Format a single file (`input.fas`) and save it to a file
(`output.fas`).

    fasta_dealign input.fas >output.fas
    cat input.fas | fasta_dealign >output.fas
    cat input.fas | fasta_dealign - >output.fas

Format and concatenate three FASTA files from the current directory
(`input1.fas`, `input2.fas` and `input3.fas`) and save it to a file
(`output.fas`).

    fasta_dealign input1.fas input2.fas input3.fas >output.fas
    fasta_dealign input*.fas >output.fas
    cat input2.fas | fasta_dealign input1.fas - input3.fas >output.fas

### [fasta_assembly_statistics](bin/fasta_assembly_statistics)

A tool to calulate assembly statistics for FASTA files.

It calculates the following statistics:
- number of contigs
- total size (bp)
- N50 (bp)
- L50: smallest number of contigs whose length sum produces N50
- mean contig size (bp)
- longest contig (bp)
- third quartile (bp)
- median (bp)
- first quartile (bp)
- shortest contig (bp)
- number of Ns
- number of gaps (/N+/): number of N-stretches in the sequences
- number of other IUPACs: IUPAC bases are nucleotide ambiguity codes (YRWSKMDVHB)
