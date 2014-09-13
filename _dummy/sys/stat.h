#ifndef _DUMMY_STAT_H_
#define _DUMMY_STAT_H_

#include "sys/types.h"

/* Dummy */
struct stat {
	mode_t st_mode;
};

#define S_ISREG(m)  0
#define S_ISDIR(m)  0
#define S_ISBLK(m)  0
#define S_ISCHR(m)  0
#define S_ISFIFO(m) 0

FILE *fopen(const char *path, const char *mode);
int stat(const char *pathname, struct stat *buf);

#endif /* !_DUMMY_STAT_H_ */
