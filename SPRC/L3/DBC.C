/*
 * Read the contents of the FILE *fp, write each line to the
 * stream socket (to the server process), then read a line back from
 * the socket and write it to the standard output.
 *
 * Return to caller when an EOF is encountered on the input file.
 */

#include 	"miki.h"
#include	<stdio.h>
#include	<sys/types.h>
#include 	<sys/stat.h>
#include	<fcntl.h>
#include 	<limits.h>

#include	<ctype.h>
#include 	"err.h"
#include 	"inet.h"
#include 	"db.h"
#include 	"map.h"

#define	MAXLINE		512
#define MAXPARAMS	5

#define _EXIT		"exit"
#define _PUT		"put"
#define _GET		"get"
#define _DEL		"delete"
#define _ENUM		"enum"

static char g_serr[][MAXLINE] = {
	"No error", 
	"Key not found", 
	"Server out of memory", 
	"Wrong database ID"};

#define _ARG_ERR	"Error: %d argument(s) required.\n"

/* breaks source in words separated by spaces*/
int parse_str(char* source, char dest[MAXPARAMS][MAXLINE], int dest_length)
{
	int crt_item = 0;		/*1st index in dest[crt_item][]*/
	int j=0;			/*2nd index in dest[][j]*/
	BOOL is_new_item = TRUE;		/*we expect a new item to construct*/
	char c[1];
	char buffer[MAXLINE];
	int i;
	int n, n1;
	
	for(i=0; source[i]; i++)	
	{
		if(isspace(source[i]))
		{
			if(is_new_item)
			{
				continue;
			}
			else
			{/*we have just finished the previous word*/
				dest[crt_item][j] = 0;
				is_new_item = TRUE;
				crt_item++;
				j=0;
				
				/*test for over_flow*/
				if(crt_item==dest_length)
				{
					return crt_item;
				}
			}
		}
		else
		{
			is_new_item = FALSE;
			dest[crt_item][j++]  = source[i];
		}
	}
	
	if(!is_new_item)
	{
		dest[crt_item][j]=0;
		crt_item++;
	}
	return crt_item;
	
}




int OpenConnection()
{
	int sockfd;
	struct sockaddr_in serv_addr;
	bzero((char*)&serv_addr, sizeof(serv_addr));
	
	serv_addr.sin_family 	 = AF_INET;
	serv_addr.sin_addr.s_addr = inet_addr(SERV_HOST_ADDR);
	serv_addr.sin_port	 = htons(SERV_TCP_PORT);
	
	if((sockfd = socket(AF_INET, SOCK_STREAM, 0))<0)
		err_sys("client: can't open socket\n");
	
	if(connect(sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr))<0)
		err_sys("client: can't connect to server\n");
	
	return sockfd;
}




str_cli(FILE *fp)
{
	int	n, n1;
	char	sendline[MAXLINE], recvline[MAXLINE + 1];
	int 	i, count;
	char	argv[MAXPARAMS][MAXLINE];
	HCMD	hcmd, hcmdn;
	HMSG	hmsg;
	
	int	sockfd;
	char	key[MAX_STR];
	char	value[MAX_STR];
	

	while (fgets(sendline, MAXLINE, fp) != NULL) 
	{
		count=parse_str(sendline, argv, MAXPARAMS);
		if(count==0)
			continue;
			
		hcmd = cmdERROR;
		if(!strcmp(argv[0], _EXIT))
		{
			hcmd  = cmdEXIT;
			return;
		}

		if(!strcmp(argv[0], _PUT))
		{
			hcmd = cmdPUT;
			if(count != 4)
			{
				printf(_ARG_ERR, 3);
				continue;
			}
		}
		
		if(!strcmp(argv[0], _GET))
		{
			hcmd = cmdGET;
			if(count!=3)
			{
				printf(_ARG_ERR, 2);
				continue; 
			}
		}
		if(!strcmp(argv[0], _DEL))
		{
			hcmd = cmdDEL;
			if(count!=3)
			{
				printf(_ARG_ERR, 2);
				continue;
			}
		}
		if(!strcmp(argv[0], _ENUM))
		{
			hcmd = cmdENUM;
			if(count!=2)
			{
				printf(_ARG_ERR, 1);
				continue;
			}
		}
		if(hcmd == cmdERROR)
		{
			printf("Error, unknown command\n");
		}
	
		/*create a scocket + connect*/	
		sockfd = OpenConnection();
		/*send the command ID*/
		
		hcmdn  = htons(hcmd);
		if(write(sockfd, &hcmdn, sizeof(HCMD))!=sizeof(HCMD))
		{
			err_sys("\n write error");
		}
		switch(hcmd)
		{
			case cmdPUT:
				for(i=0; i<3; i++)
					SafeWrite(sockfd, argv[i+1], strlen(argv[i+1]) );
				
				n = sizeof(HMSG);
				if(read(sockfd, &hmsg, n)<0)
				{
					err_sys("read error");
				}
				hmsg = ntohs(hmsg);
				if(hmsg!=msgNOERROR)
				{
					printf("%s\n", g_serr[hmsg]);
					break;
				}
				
				break;
			case cmdGET:
				for(i=0; i<2; i++)
					SafeWrite(sockfd, argv[i+1], strlen(argv[i+1]));

				n = sizeof(HMSG);
				if(read(sockfd, &hmsg, n)<0)
				{
					err_sys("read error");
				}
				hmsg = ntohs(hmsg);
				if(hmsg!=msgNOERROR)
				{
					printf("%s\n", g_serr[hmsg]);
					break;
				}
				
				SafeRead(sockfd, value, MAX_STR);
				printf("Value= %s\n", value);
				break;
			case cmdDEL: 
				for(i=0; i<2; i++)
					SafeWrite(sockfd, argv[i+1], strlen(argv[i+1]));

				n = sizeof(HMSG);
				if(read(sockfd, &hmsg, n)<0)
				{
					err_sys("read error");
				}
				hmsg = ntohs(hmsg);
				if(hmsg!=msgNOERROR)
				{
					printf("%s\n", g_serr[hmsg]);
					break;
				}
				break;
			case cmdENUM:
				for(i=0; i<1; i++)
					SafeWrite(sockfd, argv[i+1], strlen(argv[i+1]));

				n = sizeof(HMSG);
				if(read(sockfd, &hmsg, n)<0)
				{
					err_sys("read error");
				}
				hmsg = ntohs(hmsg);
				if(hmsg!=msgNOERROR)
				{
					printf("%s\n", g_serr[hmsg]);
					break;
				}
				while(SafeRead(sockfd, key, MAX_STR))	
				{
					SafeRead(sockfd, value, MAX_STR);
					printf("%s\t<->\t%s\n", key, value);
				}
				break;
			default:
				printf("Error in program .\n");
				break;
		}
		close(sockfd);				
		printf("__done.\n");
	}

	if (ferror(fp))
		err_sys("str_cli: error reading file");
	
}

