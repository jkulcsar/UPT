#include "inet.h"

#include "netrw.h"
#include "db.h"
#include "err.h"

int SafeWrite(int sockfd, char* buf, size_t count)
{
	HCOUNT hcount;
	hcount  = htons(count);
	if(write(sockfd, &hcount, sizeof(HCOUNT))< sizeof(HCOUNT))
	{
		err_sys("write error");
	}

	if(count)	
	{
		if(write(sockfd, buf, count)!=count)
		{
			err_sys("write error");
		}
	}
	
	
	return 0;
}

int SafeRead(int sockfd, char* buf, size_t count)
{
	HCOUNT hcount;
	int n, n1;
	n = 0;
	while(n<sizeof(HCOUNT))
	{
		n1 = read(sockfd, (&hcount)+n, sizeof(HCOUNT)-n);
		if(n1==-1)
			err_sys("read error");
		n+=n1;
	}
	hcount = ntohs(hcount);
	
	if(count<hcount)
	{
		printf("read buffer is to small\n");
		exit(0);
	}

	n = 0;
	while(n<hcount)
	{
		n1 = read(sockfd, buf+n, hcount-n);
		if(n1==-1)
			err_sys("read error");
		n+=n1;
	};
	buf[hcount] = '\0';
/*	printf("SR: %d bytes read, %s\n", hcount, buf);*/
	return hcount;
}