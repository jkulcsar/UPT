/*
 * Read the contents of the FILE *fp, write each line to the
 * stream socket (to the server process), then read a line back from
 * the socket and write it to the standard output.
 *
 * Return to caller when an EOF is encountered on the input file.
 */

#include	<stdio.h>
#include 	"err.h"
#define	MAXLINE	512


str_cli(FILE *fp, int sockfd)
{
	int	n, n1;
	char	sendline[MAXLINE], recvline[MAXLINE + 1];

	while (fgets(sendline, MAXLINE, fp) != NULL) {
		n = strlen(sendline);
		
		if (write(sockfd, sendline, n) !=n )
		      err_sys("\n write error");
		      
		

		/*
		 * Now read twice from socket
                 * the server's answer and write it to
		 * our standard output.
		 */
		
		n = read(sockfd, recvline, MAXLINE);
		if (n < 0)
			err_sys("\n read error");

		n1 = read(sockfd, recvline + n, MAXLINE);
		if (n1 < 0)
			err_sys("\n read error");
	
		recvline[n + n1] = 0;	/* null terminate */
		fputs(recvline, stdout);
	}

	if (ferror(fp))
		err_sys("str_cli: error reading file");
	
}

