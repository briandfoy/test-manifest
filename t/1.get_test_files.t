# $Id$
BEGIN { $| = 1; print "1..4\n"; }
END   {print "not ok\n" unless $loaded;}

# Test it loads
use Test::Manifest qw(get_t_files);
$loaded = 1;
print "ok\n";

my $test_manifest = "t/test_manifest";
my @tests = ();

eval {
	die "cannot open $test_manifest! $!"
		unless open my $in, $test_manifest;

	while( <$in> )
		{
		chomp;
		push @tests, $_;
		}
	
	my $expected = join " ", map { "t/$_" } @tests;
	
	my $string = get_t_files();
	
	die "Got [$string]\nExpected [$expected]"
		unless $expected eq $string;
	};
print STDERR $@ if $@;
print $@ ? 'not ' : '', "ok\n";
	
eval {
	die "cannot open $test_manifest! $!"
		unless open my $in, $test_manifest;
	
	my @array = get_t_files();
	
	foreach my $index ( 0 .. $#array )
		{
		die "Got [$array[$i]]\nExpected [t/$tests[$i]]"
			unless $array[$i] eq "t/$tests[$i]";
		}

	};
print STDERR $@ if $@;
print $@ ? 'not ' : '', "ok\n";

eval {
	local %SIG;
	
	$SIG{__WARN__} = sub { 1 };
	
	die "cannot remove $test_manifest! $!"
		unless unlink $test_manifest;
	
	my $string = get_t_files();
	
	die "Got [$string]\nExpected [t/*.t]"
		unless $string eq "t/*.t";

	my @array = get_t_files();
	
	die "Got [$array[0]]\nExpected [t/*.t]"
		unless $array[0] eq "t/*.t";

	};
print STDERR $@ if $@;
print $@ ? 'not ' : '', "ok\n";
