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
#include <vauth.h>

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
    OUTPUT:
        RETVAL
