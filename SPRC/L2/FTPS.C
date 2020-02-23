/*
 * Read a stream socket one line at a time, and write each line back
 * to the sender.
 *
 * Return when the connection is terminated.
 */
#include "miki.h"
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <dirent.h> 
#include "netrw.h"
#include <limits.h>
#include <netinet/in.h>
 
#include "err.h"
#include "ftp.h"
#define	MAXLINE	512

static char g_path[PATH_MAX] = "/tmp";

str_echo(int sockfd)
{
	int i;
	int	n;
	char	line[MAXLINE];
	HCMD	hcmd;
	HMSG	hmsg;

	/*cmdDir*/
	DIR*	pDir;
	struct dirent* pDirent;
	char   filename[PATH_MAX];
	HCOUNT hcount;
	
	/*cmdGet*/
	PFILE file;
	char stmp[PATH_MAX];
	char sBuffer[2050];
	
	for ( ; ; ) 
	{
		n = read(sockfd, &hcmd , MAXLINE);
		if (n <= 0)
			err_sys("<0> str_echo: read error");
		hcmd = ntohs(hcmd);
		switch(hcmd)
		{
			case cmdEXIT:
				TRACE("cmdEXIT received.\n");
				return;
				
			case cmdDIR:
				TRACE("cmdDIR received.\n");
				pDir = opendir(g_path);
				if(!pDir)
				{
					hmsg  = htons(msgOPEN_DIR_ERROR);
					printf("Failed to open directory \"%s\".\n", g_path);					
					if (write(sockfd, &hmsg, sizeof(HMSG)) != sizeof(HMSG))
						err_sys("<1> str_echo: write error");
					break;
				}
				else
				{
					hmsg  = htons(msgNOERROR);
					if (write(sockfd, &hmsg, sizeof(HMSG)) != sizeof(HMSG))
						err_sys("<1> str_echo: write error");
				}
				
				
				/*iterate*/
				while(pDirent = readdir(pDir))
				{
					n = strlen(pDirent->d_name)+1;
					
					hcount  = htons(n);
					if (write(sockfd,&hcount, sizeof(HCOUNT)) != sizeof(HCOUNT))
						err_sys("<2> str_echo: write error");				
					
					if (write(sockfd, pDirent->d_name, n) != n)
						err_sys("<3> str_echo: write error");				
				}			
				
				/* send the ending character*/	
				hcount  = htons((HCOUNT)2);
				if (write(sockfd,&hcount, sizeof(HCOUNT)) != sizeof(HCOUNT))
					err_sys("<4> str_echo: write error");				
				if (write(sockfd, "*", 2) != 2)
					err_sys("<5>str_echo: write error");
				break; /*cmdDir*/
				
			case cmdGET:
				TRACE("cmdGET received.\n");
				/*read filename*/
				
				TRACE("Reading filename from client...\n");
				n = read(sockfd, filename, PATH_MAX); 
				filename[n] = 0;

				if (n <= 0)
					err_sys("<6> str_echo: read error");
					
				strcpy(stmp, filename);
				sprintf(filename, "%s/%s", g_path, stmp);
				TRACE("Trying to open file %s...", filename);
				file = open(filename, O_RDONLY);
				if(file<0)
				{
					TRACE("failure\n");
					
					hmsg  = htons(msgFILE_OPEN_ERROR);
					if (write(sockfd, &hmsg, sizeof(HMSG)) != sizeof(HMSG))
						err_sys("<7> str_echo: write error");
					break;
				}
				TRACE("ok\n");
				hmsg  = htons(msgNOERROR);
				if (write(sockfd, &hmsg, sizeof(HMSG)) != sizeof(HMSG))
					err_sys("<8> str_echo: write error");
				/*do transmit the file*/				
				while(1)
				{				
					
					n = read(file, sBuffer, 2048);
					if(n==-1 )
						err_sys("<9> str_echo: read error");
					if(n==0)
						break;
				
					SafeWrite(sockfd, sBuffer, n);
					printf("%d bytes sended \n", n);
				}
				SafeWrite(sockfd, "", 0);
				
				close(file);
				printf("Transmition over.\n");
				break; /*cmdGET*/
		}
	}
}

