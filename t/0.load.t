# $Id$

use lib qw(./blib/lib);

print "1..1\n";

local( $@, $! );

eval <<USE;
package main;
require Test::Manifest;
Test::Manifest->import;
USE

print "bail out! Test::Manifest could not compile.\n$@\n"
	if $@;

print "ok - Test::Manifest compiles\n";
