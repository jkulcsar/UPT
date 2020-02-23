#ifndef __NETRW_H__
#define __NETRW_H__
int	SafeWrite(int sockfd, char* buf, size_t count);
int	SafeRead(int sockfd, char* buf, size_t count);

#endif
