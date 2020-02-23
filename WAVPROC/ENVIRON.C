#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "sb.h"

int Sb_Get_Params(void)
{
    char *t, *blaster;

    /* Set arguments to reasonable values (Soundblaster defaults) */
    SbIOaddr = 0x220;
    SbIRQ = 7;
    SbDMAchan = 1;

    /* Attempt to read environment variable */
    t = getenv("BLASTER");

    /* Is the environment variable set? */
    if(t == NULL)
	return 1;

    /* Duplicate the string so that we don't trash our environment */
    blaster = strdup(t);

    /* Now parse the BLASTER variable */
    t = strtok(blaster," \t");
    while(t)
    {
	switch(toupper(t[0]))
	{
	    case 'A':                               /* I/O address */
		SbIOaddr = (int)strtol(t+1,NULL,16);
		break;
	    case 'I':                               /* Hardware IRQ */
		SbIRQ = atoi(t+1);
		break;
	    case 'D':                               /* DMA channel */
		SbDMAchan = atoi(t+1);
		break;
	    case 'T':                               /* Soundblaster type */
		SbType = atoi(t+1);
		break;
	    default:
		printf("Unknown BLASTER option %c\n",t[0]);
		break;
	}
	t = strtok(NULL," \t");
    }
    free(blaster);
    return 0;
}
