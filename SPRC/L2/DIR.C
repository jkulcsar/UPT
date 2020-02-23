#include <sys/types.h>
#include <dirent.h>
#include "err.h"
#include "miki.h"

static char g_path[PATH_MAX] = "/tmp";

BOOL sdir(char* sz, int length)
{
	sz[0] = 0;
	DIR* pDir;
	struct dirent* pDirent;
	pDir = opendir(g_path);	
	if(!pDir)
	{
		TRACE("Failed to open directory.\n");
		return FALSE;
	}
	while (	pDirent = readdir(pDir))
	{
		if(strlen(sz)+1+strlen(pDirent->d_name < length)
		{
			strcat(sz, pDirent->d_name);
			strcat(sz, "\n");
		}
		else
		{
			TRACE("Buffer much too short in sdir.\n");
			return;
		}
	}
}