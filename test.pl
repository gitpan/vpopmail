# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..1\n"; }
END {print "not ok 1\n" unless $loaded;}
use vpopmail;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

#
if ( ( adddomain('vpopmail.com' ) ) == 0 ) {
  print "adddomain() ok\n";
}

#
if ( ( vadduser('username', 'vpopmail.com', 'p@ssw0rd', 'Test User', 0 ) ) == 0 ) {
    print "vadduser() ok\n";
}

#
if ( vauth_user('username', 'vpopmail.com', 'p@ssw0rd', undef)) {
    print "vauth_user() ok\n";
}

#
if ( ( vsetuserquota('username', 'vpopmail.com', '5M') ) == 0 ) {
	print "vsetuserquota() ok\n";
}

#
if ( ( vdeluser('username', 'vpopmail.com') ) == 0 ) {
    print "vdeluser() ok\n";
}

#
if ( ( vdeldomain('vpopmail.com') ) == 0 ) {
    print "vdeldomain() ok\n";
}
