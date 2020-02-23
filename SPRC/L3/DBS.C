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
#include <limits.h>
 
#include "err.h"
#include "map.h"
#include "db.h"
#define	 MAXLINE	512

static char g_path[PATH_MAX] = "/tmp";
CMap	map[MAP_COUNT];

str_echo(int sockfd)
{
	int 	i, n;
	HCMD	hcmd;
	HMSG	hmsg;

	char	sID[MAX_STR];
	int	id;
	char	key[MAX_STR];
	char	value[MAX_STR];
	char*  endptr;
	POSITION pos;
 	
	n = read(sockfd, &hcmd , sizeof(hcmd));
	if (n <= 0)
		err_sys("<0> str_echo: read error");
	
	hcmd = ntohs(hcmd);
	switch(hcmd)
	{
		case cmdPUT:
			SafeRead(sockfd, sID,   MAX_STR);
			id = strtol(sID, &endptr, 10);
			if(*endptr!=0)
				id = -1;
		
			SafeRead(sockfd, key,   MAX_STR);
			SafeRead(sockfd, value, MAX_STR);
			
			printf("request: Put(%d,%s,%s)\n", id, key, value);

			if(id<0 || id>=MAP_COUNT)
				hmsg = msgWRONG_ID;
			else
				if(!MapSetAt(map[id], key, value))
					hmsg = msgNO_MEM;
				else
					hmsg = msgNOERROR;

			hmsg = htons(hmsg);
			n = sizeof(HMSG);
			if(write(sockfd, &hmsg, n)!=n)
			{
				err_sys("write error");
			}
			break;

		case cmdGET:
			SafeRead(sockfd, sID, MAX_STR);
			id = strtol(sID, &endptr, 10);
			if(*endptr!=0)
				id = -1;
			SafeRead(sockfd, key, MAX_STR);
			
			printf("request Get(%d,%s)\n", id, key);
			
			if(id<0 || id>=MAP_COUNT)
				hmsg = msgWRONG_ID;
			else
				if(!MapGetAt(map[id], key, value))
					hmsg = msgNO_KEY;
				else
					hmsg = msgNOERROR;

			hmsg = htons(hmsg);
			n = sizeof(HMSG);
			if(write(sockfd, &hmsg, n)!=n)
			{
				err_sys("write error");
			}

			if(hmsg == msgNOERROR)
				SafeWrite(sockfd, value, strlen(value)); 
			break;

		case cmdDEL:
			SafeRead(sockfd, sID, MAX_STR);
			id = strtol(sID, &endptr, 10);
			if(*endptr!=0)
				id = -1;
			SafeRead(sockfd, key, MAX_STR);
			
			
			printf("request Del(%d,%s)\n", id, key);


			
			if(id<0 || id>=MAP_COUNT)
				hmsg = msgWRONG_ID;
			else
				if(!MapRemoveKey(map[id], key))
					hmsg = msgNO_KEY;
				else
					hmsg = msgNOERROR;

			hmsg = htons(hmsg);
			n = sizeof(HMSG);
			if(write(sockfd, &hmsg, n)!=n)
			{
				err_sys("write error");
			}
			break;

		case cmdENUM:
			n = SafeRead(sockfd, sID, MAX_STR);
			id = strtol(sID, &endptr, 10);
			if(*endptr!=0)
				id = -1;


			printf("request Enum(%d)\n", id);
			
			if(id<0 || id>=MAP_COUNT)
				hmsg = msgWRONG_ID;
			else
				hmsg = msgNOERROR;

			hmsg = htons(hmsg);
			n = sizeof(HMSG);
			if(write(sockfd, &hmsg, n)!=n)
			{
				err_sys("write error");
			}

			if(hmsg == msgNOERROR)
			{
				pos = MapGetStartPos(map[id]);
				while(pos)
				{
					MapGetNextAssoc(map[id], &pos, key, value);
					SafeWrite(sockfd, key, strlen(key));
					SafeWrite(sockfd, value, strlen(value));
/*					printf("Assoc %s <-> %s\n", key, value);*/
				}
				SafeWrite(sockfd, "", 0);
			}
			break;

		default:
			printf("request: Unknown command\n");
	}
}


