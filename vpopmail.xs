#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#ifdef __cplusplus
}
#endif

#include <vpopmail.h>
#include <vpopmail_config.h>
#include <vauth.h>
#include <pwd.h>


static int
not_here(s)
char *s;
{
    croak("%s not implemented on this architecture", s);
    return -1;
}

static double
constant(name, arg)
char *name;
int arg;
{
    errno = 0;
    switch (*name) {
    }
    errno = EINVAL;
    return 0;

not_there:
    errno = ENOENT;
    return 0;
}


MODULE = vpopmail		PACKAGE = vpopmail		


double
constant(name,arg)
	char *		name
	int		arg

int
vadddomain(domain, dir, uid, gid)
	char *		domain
	char *		dir
	int		uid
	int		gid

int
vdeldomain(domain)
	char *		domain
    OUTPUT:
        RETVAL

int
vadduser(username, domain, password, gecos, apop )
	char *		username
	char *		domain
	char *		password
	char *		gecos
	int		apop
    OUTPUT:
        RETVAL

int
vdeluser(user, domain)
	char *		user
	char *		domain
    OUTPUT:
        RETVAL

int
vpasswd(user, domain, password, apop)
        char *		user
        char *		domain
        char *		password
        int		apop
    OUTPUT:
        RETVAL

int
vsetuserquota(user, domain, quota)
        char *		user
        char *		domain
        char *		quota
    OUTPUT:
        RETVAL

int
vauth_user(user, domain, password, apop)
        char *		user
        char *		domain
        char *		password
        char *		apop


SV *
vauth_getpw(user, domain)
        char *  user
        char *  domain
	PREINIT:
	HV * h;
	char name[100];
	SV **ssv;
	SV *svval;
    CODE:
	struct passwd * pwd = vauth_getpw(user, domain);
	if ( pwd == NULL ) {
		XSRETURN_UNDEF;
	}
	h = newHV(); /* allocate new hash */
	RETVAL = newRV_inc( (SV *) h ); /* return a ref to the hash */
	SvREFCNT_dec( h ); /* free the hash whenever the ref is gone */

	/* SET HASH->{pw_name} */
	if (pwd->pw_name != NULL) {
		svval = newSVpv( pwd->pw_name, strlen(pwd->pw_name) );
		/* make the string that will be the key */
		strcpy( name, "pw_name");
		ssv = hv_store( h, name, strlen( name ), svval, 0 );
		if ( ssv == NULL ) {
			croak( "oops: key %s not stored", name );
		}
	}

	/* SET HASH->{pw_passwd} */
	if (pwd->pw_passwd != NULL) {
		/* warn("pw_passwd = %s\n", pwd->pw_passwd); */
		svval = newSVpv( pwd->pw_passwd, strlen(pwd->pw_passwd) );
		/* make the string that will be the key */
		strcpy( name, "pw_passwd");
		ssv = hv_store( h, name, strlen( name ), svval, 0 );
		if ( ssv == NULL ) {
			croak( "oops: key %s not stored", name );
		}
	}


	/* SET HASH->{pw_gecos} */
	if (pwd->pw_gecos != NULL) {
		/* warn("pw_gecos = %s\n", pwd->pw_gecos); */
		svval = newSVpv( pwd->pw_gecos, strlen(pwd->pw_gecos) );
		/* make the string that will be the key */
		strcpy( name, "pw_gecos");
		ssv = hv_store( h, name, strlen( name ), svval, 0 );
		if ( ssv == NULL ) {
			croak( "oops: key %s not stored", name );
		}
	}

	/* SET HASH->{pw_dir} */
	/* warn("pw_dir = %s\n", pwd->pw_dir); */
	if (pwd->pw_dir != NULL) {
		/* warn("pw_dir = %s\n", pwd->pw_dir); */
		svval = newSVpv( pwd->pw_dir, strlen(pwd->pw_dir) );
		/* make the string that will be the key */
		strcpy( name, "pw_dir");
		ssv = hv_store( h, name, strlen( name ), svval, 0 );
		if ( ssv == NULL ) {
			croak( "oops: key %s not stored", name );
		}
	}
    OUTPUT:
        RETVAL

SV *
vauth_getall(domain, first, sort_it)
        char *  domain
	int first
	int sort_it
	PREINIT:
	HV * h;
	char name[100];
	SV **ssv;
	SV *svval;
    CODE:
	struct passwd * pwd = vauth_getall(domain, first, sort_it);
	if ( pwd == NULL ) {
		XSRETURN_UNDEF;
	}
	h = newHV(); /* allocate new hash */
	RETVAL = newRV_inc( (SV *) h ); /* return a ref to the hash */
	SvREFCNT_dec( h ); /* free the hash whenever the ref is gone */

	/* SET HASH->{pw_name} */
	if (pwd->pw_name != NULL) {
		svval = newSVpv( pwd->pw_name, strlen(pwd->pw_name) );
		/* make the string that will be the key */
		strcpy( name, "pw_name");
		ssv = hv_store( h, name, strlen( name ), svval, 0 );
		if ( ssv == NULL ) {
			croak( "oops: key %s not stored", name );
		}
	}

	/* SET HASH->{pw_passwd} */
	if (pwd->pw_passwd != NULL) {
		/* warn("pw_passwd = %s\n", pwd->pw_passwd); */
		svval = newSVpv( pwd->pw_passwd, strlen(pwd->pw_passwd) );
		/* make the string that will be the key */
		strcpy( name, "pw_passwd");
		ssv = hv_store( h, name, strlen( name ), svval, 0 );
		if ( ssv == NULL ) {
			croak( "oops: key %s not stored", name );
		}
	}


	/* SET HASH->{pw_gecos} */
	if (pwd->pw_gecos != NULL) {
		/* warn("pw_gecos = %s\n", pwd->pw_gecos); */
		svval = newSVpv( pwd->pw_gecos, strlen(pwd->pw_gecos) );
		/* make the string that will be the key */
		strcpy( name, "pw_gecos");
		ssv = hv_store( h, name, strlen( name ), svval, 0 );
		if ( ssv == NULL ) {
			croak( "oops: key %s not stored", name );
		}
	}

	/* SET HASH->{pw_dir} */
	/* warn("pw_dir = %s\n", pwd->pw_dir); */
	if (pwd->pw_dir != NULL) {
		/* warn("pw_dir = %s\n", pwd->pw_dir); */
		svval = newSVpv( pwd->pw_dir, strlen(pwd->pw_dir) );
		/* make the string that will be the key */
		strcpy( name, "pw_dir");
		ssv = hv_store( h, name, strlen( name ), svval, 0 );
		if ( ssv == NULL ) {
			croak( "oops: key %s not stored", name );
		}
	}
    OUTPUT:
        RETVAL

SV *
QMAILDIR()
	CODE:
	RETVAL = newSVpv( QMAILDIR, strlen(QMAILDIR) );
    OUTPUT:
        RETVAL

SV *
VPOPMAILDIR()
	CODE:
	RETVAL = newSVpv( VPOPMAILDIR, strlen(VPOPMAILDIR) );
    OUTPUT:
        RETVAL

SV *
VPOPUSER()
	CODE:
	RETVAL = newSVpv( VPOPUSER, strlen(VPOPUSER) );
    OUTPUT:
        RETVAL

SV *
VPOPGROUP()
	CODE:
	RETVAL = newSVpv( VPOPGROUP, strlen(VPOPGROUP) );
    OUTPUT:
        RETVAL

SV *
VPOPMAILUID()
	CODE:
	RETVAL = newSViv( VPOPMAILUID );
    OUTPUT:
        RETVAL

SV *
VPOPMAILGID()
	CODE:
	RETVAL = newSViv( VPOPMAILGID );
    OUTPUT:
        RETVAL

SV *
vgetversion()
	CODE:
	RETVAL = newSVpv( VERSION, strlen(VERSION) );
    OUTPUT:
        RETVAL

SV *
vgetatchars()
	CODE:
	RETVAL = newSVpv( ATCHARS, strlen(ATCHARS) );
    OUTPUT:
        RETVAL


int vadddotqmail(alias, domain)
	char	*	alias
	char	*	domain
OUTPUT:
	RETVAL

int vdeldotqmail(alias, domain)
	char	*	alias
	char	*	domain
OUTPUT:
	RETVAL
