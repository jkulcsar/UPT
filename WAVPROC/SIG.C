#include "wavproc.h"
#include<stdio.h>
#include<math.h>

void main(void)
{	register int i;
	float f, sig[1024];
	FILE *fis;
	fis=fopen("sig.dat", "wb");
	f=-Ncuante_SIG/2.*cuanta_SIG;  // zero (0) e numar pozitiv aici !!!
	for(i=0;i<Ncuante_SIG;i++)
	{	sig[i]=255/(1+exp(-BETA*f));// (2/(1+exp(-BETA*f))-1+1)*255/2
		f+=cuanta_SIG;
		fputc((int)sig[i], fis);
	}
	fclose(fis);
}