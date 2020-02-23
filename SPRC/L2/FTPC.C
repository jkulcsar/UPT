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
#include 	"netrw.h"
#include	<netinet/in.h>

#include	<ctype.h>
#include 	"err.h"
#include 	"ftp.h"

#define	MAXLINE		512
#define MAXPARAMS	5
#define _EXIT		"exit"
#define _DIR		"dir"
#define _GET		"get"
#define _HELP		"help"

static char g_serr[][MAXLINE] = 
	{"No error", "Failed to open file", "Failed to parse directory"};

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


str_cli(FILE *fp, int sockfd)
{
	int	n, n1;
	char	sendline[MAXLINE], recvline[MAXLINE + 1];
	int 	i, count;
	char	argv[MAXPARAMS][MAXLINE];
	HCMD	hcmd;
	HMSG	hmsg;
	
	/*cmdDir*/
	char filename[MAXLINE];
	PFILE	file;
	char szBuffer[2048];
	

	while (fgets(sendline, MAXLINE, fp) != NULL) 
	{
		count=parse_str(sendline, argv, MAXPARAMS);
		if(!strcmp(argv[0], _EXIT))
		{
			hcmd  = cmdEXIT;
		}
		if(!strcmp(argv[0], _DIR))
		{
			hcmd = cmdDIR;
			count = 1;
		}
		if(!strcmp(argv[0], _GET))
		{
			hcmd = cmdGET;
			if(count<2)
			{
				printf("Syntax Error: No file specified.\n");
				return;
			}
			count = 2;
		}
		
		switch(hcmd)
		{
			case cmdEXIT:
				hcmd = htons(hcmd);
				if(write(sockfd, &hcmd, sizeof(HCMD))!=sizeof(HCMD))
				{
					err_sys("\n <21>write error");
				}
				return;
				break;
				
			case cmdDIR:
				hcmd = htons(hcmd);
				if(write(sockfd, &hcmd, sizeof(HCMD))!=sizeof(HCMD))
				{
					err_sys("\n<22> write error");
				}
				/*read and print the directory entries*/
				
				if(read(sockfd, &hmsg, sizeof(HMSG))!=sizeof(HMSG))
				{
					err_sys("\n<23> read error");
				}
				hmsg  = ntohs(hmsg);
				
				if(hmsg!=msgNOERROR)
				{
					printf("%s\n", g_serr[hmsg]);
					return;
				}
				
				while(1)
				{
					HCOUNT hcount;
					n = read(sockfd, &hcount, sizeof(HCOUNT));
					if(n<0)
					{
						err_sys("\n<24> read error");
					}
					hcount = ntohs(hcount);

					n = read(sockfd, filename, hcount);
					if(n<0)
					{
						err_sys("\n<24> read error");
					}
					if(filename[0]=='*')
					{
						break;
					}
					printf("%s\n", filename);
				}
				break;
			case cmdGET:
				hcmd = htons(hcmd);
				/*write command*/
				if(write(sockfd, &hcmd, sizeof(HCMD))!=sizeof(HCMD))
				{
					err_sys("\n<25> write error");
				}

				/*write filename*/
				n = strlen(argv[1])+1;
				if(write(sockfd, argv[1], n)!=n)
				{
					err_sys("\n<26> write error");
				}
				/*read answer, OK ?*/
				if(read(sockfd, &hmsg, sizeof(HMSG))!=sizeof(HMSG))
				{
					err_sys("\n<27> read error");
					return;
				}
				hmsg  = ntohs(hmsg);
				if(hmsg!=msgNOERROR)
				{
					printf("%s\n", g_serr[hmsg]);
					break;
				}
				/*receive the file*/
				file = creat(argv[1], USHRT_MAX);
				if(file<0)
				{
					printf("Failed to create file on local machine.\n");
					break;
				}
				do
				{
					n = SafeRead(sockfd, szBuffer, 2048);
					if(n)
					{
						printf("%d bytes received\n", n);
						if(write(file, szBuffer, n)!=n)
							err_sys("\n<29> write error");
					}
				}while(n);
				
				close(file);
				
				break;				
			default:
				printf("Error, unknown command.\n");
				break;
		}
				
		printf("__done.\n");
				
						
			
					
	}

	if (ferror(fp))
		err_sys("str_cli: error reading file");
	
}

