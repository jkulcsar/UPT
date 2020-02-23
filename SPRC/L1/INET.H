/*
 * Definitions for TCP and UDP client/server programs.
 */

#include	<stdio.h>
#include	<sys/types.h>
#include	<sys/socket.h>
#include	<netinet/in.h>
#include	<arpa/inet.h>

#define	SERV_UDP_PORT	6000
#define	SERV_TCP_PORT	6097
#define	SERV_HOST_ADDR	"127.0.0.1"	/* host addr for server : tempus4*/

char	*pname;
void err_sys(char* );
