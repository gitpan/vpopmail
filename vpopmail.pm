package vpopmail;

use strict;
use Carp;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK $AUTOLOAD);

require Exporter;
require DynaLoader;

# Change this to the username you installed 'vpopmail' to run as
use constant VPOPMAIL_UNAME => 'vpopmail';


@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(

	BOUNCE_MAIL
	NO_DIALUP
	NO_IMAP
	NO_PASSWD_CHNG
	NO_POP
	NO_RELAY
	NO_WEBMAIL
	USE_APOP
	USE_POP
	adddomain
	vdeldomain
	vadduser
	vdeluser
	vpasswd
	vsetuserquota
	vauth_user
	
);
$VERSION = '0.03';

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.  If a constant is not found then control is passed
    # to the AUTOLOAD in AutoLoader.

    my $constname;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    my $val = constant($constname, @_ ? $_[0] : 0);
    if ($! != 0) {
	if ($! =~ /Invalid/) {
	    $AutoLoader::AUTOLOAD = $AUTOLOAD;
	    goto &AutoLoader::AUTOLOAD;
	}
	else {
		croak "Your vendor has not defined vpopmail macro $constname";
	}
    }
    eval "sub $AUTOLOAD { $val }";
    goto &$AUTOLOAD;
}

bootstrap vpopmail $VERSION;

# Preloaded methods go here.

sub adddomain {
  my ($domain, $dir, $uid, $gid) = @_;
  if (scalar(@_) < 4 ) {
    my ($vuid, $vgid, $vhome) = (getpwnam(VPOPMAIL_UNAME))[2,3,7];
    return vadddomain($domain, $vhome, $vuid, $vgid);
  } else {
    vadddomain(@_);
  }
}
# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is the stub of documentation for this module.

=head1 NAME

vpopmail - Perl extension for the vpopmail package 

=head1 SYNOPSIS

	use vpopmail;

	adddomain('vpopmail.com');

	vadduser('username', 'vpopmail.com', 'p@ssw0rd', 'Test User', 0 );

	if ( vauth_user('username', 'vpopmail.com', 'p@ssw0rd', undef) ) {
		print 'auth ok';
	}

	vsetuserquota('username', 'vpopmail.com', '5M');

	vdeluser('username', 'vpopmail.com') );

	vdeldomain('vpopmail.com');


=head1 DESCRIPTION

Perl extension for the vpopmail package
 [ http://www.inter7.com/vpopmail ]


=head1 AUTHOR

Sean P. Scanlon <sps@shore.net>

=head1 SEE ALSO

perl(1), [ http://www.inter7.com/vpopmail ].

=cut




