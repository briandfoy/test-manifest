# $Id$
BEGIN { $| = 1; print "1..2\n"; }
END   {print "not ok\n" unless $loaded;}

# Test it loads
use Test::Manifest;
$loaded = 1;
print "ok\n";

my $test_manifest = 'test_manifest';

eval {
	die "cannot open $test_manifest! $!"
		unless open my $in, $test_manifest;
		
	die "cannot open $test_manifest! $!"
		unless open my $out, "> t/$test_manifest";
		
	while( <$in> ) { print $out $_ };
	};
print STDERR $@ if $@;
print $@ ? 'not ' : '', "ok\n";
	
