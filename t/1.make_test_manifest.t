# $Id$
BEGIN { $| = 1; print "1..3\n"; }
END   {print "not ok\n" unless $loaded;}

# Test it loads
use Test::Manifest qw(make_test_manifest);
$loaded = 1;
print "ok\n";

my $test_manifest = 't/test_manifest';

eval {
	unlink $test_manifest;
	die "$test_manifest still exists!" if -e $test_manifest;

	make_test_manifest();
	
	die "$test_manifest doesn't exist!" unless -e $test_manifest;
	};
print STDERR $@ if $@;
print $@ ? 'not ' : '', "ok\n";

eval {
	require Text::Diff;
	
	my $diff = Text::Diff::diff( 'test_manifest', $test_manifest );
	
	die "Files are different! [$diff]" if $diff;
	};
print STDERR $@ if $@;
print $@ ? 'not ' : '', "ok\n";

unlink $test_manifest;
