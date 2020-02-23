/*
 * Definitions for TCP and UDP client/server programs.
 */

#include	<stdio.h>
#include	<sys/types.h>
#include	<sys/socket.h>
#include	<netinet/in.h>
#include	<arpa/inet.h>

#define	SERV_UDP_PORT	6001
#define	SERV_TCP_PORT	6098

#ifdef	_ACASA
#define	SERV_HOST_ADDR	"127.0.0.1"	/* loopback */
#else
#define	SERV_HOST_ADDR	"193.226.9.20"	/* host addr for server : tempus4*/
#endif

char	*pname;
void err_sys(char* );
