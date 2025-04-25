#!/usr/bin/perl
use warnings;
use strict;

use Bio::SeqIO;

my $fasta;

my @keep;
for (@ARGV) {
    if (/^--?f(asta)?$/) {
	$fasta++;
    } elsif (/^--?h(elp)?$/) {
	print "USAGE:\n\t$0 [options] > <clusters.tsv> [ 2> <clusters.fas> ]\n";
	print "Description:\n\tThis script reads from specified files or STDIN and clusters sequences based on exact sequence match.\n";
	print "\tOutput to STDOUT iin TSV format:\n";
	print "\t\t1) representative ID\n";
	print "\t\t2) sequence entry ID\n";
	print "\t\t3) mapping within representative sequence\n";
	print "\t\t3) length of the representative sequence\n";
	print "OPTIONS:\n\t-h | --help\n\t\tPrints this help message\n";
	print "\t-f | --fasta\n\t\tPrints FASTA data of the cluster represntatives to STDERR\n";
	exit;
    }else {
	push @keep, $_;
    }
}
@ARGV = @keep;

my $stream = Bio::SeqIO->newFh(-format => 'Fasta',
			       -fh     => \*ARGV);
# read from standard input or the input filenames

my %pos;
my %seq2id;
my %seq;
# Sequence -> hash
#  -> id (id of sequence)
#  -> before (positions not covered by sequence)
#  -> after (positions not covered by sequence)


while ( my $s = <$stream> ) {
    # do something with $seq
    my $ss = $s->seq();
    my %e = ('id' => $s->id(),
	     'before' => 0,
	     'after' => 0);
    if ($seq{$ss}) {
	push @{ $seq{$ss} }, \%e;
    } else {
	my $len = length($ss);
	my $match;
	for (sort grep{length($_) > $len} keys %seq) {
	    if (/(.*)$ss(.*)/) {
		$e{'before'} = length $1;
		$e{'after'} = length $2;
		push @{ $seq{$_} }, \%e;
		$match++;
		last;
	    }
	}
	unless ($match) {
	    # Check if any previous matches it
	    my $match;
	    for (sort grep{length($_) < $len} keys %seq) {
		if ($ss =~ /(.*)$_(.*)/) {
		    $match = {
			'id' => $seq2id{$_},
			'before' => length $1,
			'after' => length $2,
			'seq' => $_    
		    };
		    last;
		}
	    }
	    # Add to clusters
	    $seq2id{$ss} = $e{'id'};
	    $seq{$ss} = [ \%e ];
	    my $p = 0;
	    if ($match) {
		my $old = $match->{'seq'};
		my @list = @{ $seq{ $old } };
		for (@list) {
		    # Update positions
		    $_->{'before'} += $match->{'before'};
		    $_->{'after'} += $match->{'after'};
		}
		# Lump old ones in
		push @{ $seq{$ss} }, @list;
		# Remove old one
		delete $seq{$old};
		delete $seq2id{$old};
		$p = delete $pos{$old};
	    }
	    if ($p) {
		$pos{$ss} = $p;
	    } else {
		$pos{$ss} = scalar( keys %pos ) + 1;
	    }
	}
    }
}

# Print results
for my $s (sort{ $pos{$a}<=>$pos{$b} } keys %seq) {
    my $id = $seq2id{$s};
    my $len = length $s;
    for ( @{ $seq{$s} } ) {
	print join("\t", $id, $_->{'id'}, $_->{'before'} . '..' . ($len - $_->{'after'}), $len), "\n";
    }
    if ($fasta) {
	print STDERR ">$id\n$s\n";
    }
}
