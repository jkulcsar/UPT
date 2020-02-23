/*
 * Read a stream socket one line at a time, and write each line back
 * to the sender.
 *
 * Return when the connection is terminated.
 */
#include "err.h"
#define	MAXLINE	512

str_echo(int sockfd)
{
	int	n;
	char	line[MAXLINE];

	for ( ; ; ) {
		n = read(sockfd, line, MAXLINE);
		if (n == 0)
			return;		/* connection terminated */
		else if (n < 0)
			err_sys("str_echo: read error");

		if (write(sockfd, "server answer: ", 15) != 15)
			err_sys("str_echo: write error");
		if (write(sockfd, line, n) != n)
			err_sys("str_echo: write error");
	}
}
