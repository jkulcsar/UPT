/*
 * Example of server using TCP protocol.
 */
#include 	"miki.h"
#include	"inet.h"
#include 	"err.h"
#include	"map.h"
#include 	"db.h"
#include 	<sys/wait.h>

extern CMap map[MAP_COUNT];
main(int argc, char* argv[])
{
	int i;
	int			sockfd, newsockfd, clilen, childpid;
	struct sockaddr_in	cli_addr, serv_addr;

 	for(i=0; i<MAP_COUNT; i++)
		MapInit(map[i]);
	pname = argv[0];

	/*
	 * Open a TCP socket (an Internet stream socket).
	 */

	if ( (sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0)
		err_sys("server: can't open stream socket");

	/*
	 * Bind our local address so that the client can send to us.
	 */

	bzero((char *) &serv_addr, sizeof(serv_addr));
	serv_addr.sin_family      = AF_INET;
	serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
	serv_addr.sin_port        = htons(SERV_TCP_PORT);

	if (bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0)
		err_sys("server: can't bind local address");

	listen(sockfd, 5);

	for ( ; ; ) {
		clilen = sizeof(cli_addr);
		newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr,
								     &clilen);
		if (newsockfd < 0)
			err_sys("server: accept error");

		printf("\nClient  request accepted.\n");
		str_echo(newsockfd);	
		close(newsockfd);	
		printf("End of client transaction.\n");
	}
}
