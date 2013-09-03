/*
 */

#include <errno.h>

int symlink(const char *oldpath, const char *newpath)
{
    errno = EPERM;
    return -1;
}

