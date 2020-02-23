// Aplica coeficienti Hanning (daca nu are parametru de intrare!)
// la NRFER ferestre*WIDTH esantioane din fisiere *.WAV gasite in
// directoare cu nume <n>.WAV. Calculeaza DFT in 64 puncte
// scoate NRFRECV frecv. cu melscale dat de sirul MEL[]!
#include "wp.h"
#include<dir.h>
#include<math.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define NEGLI		1	// neglijez la inceput atatea freq
#define SCAL_RI	5	// scalare prin deplasare la dreapta long sa incapa in int

int sinus[WIDTH], cosinus[WIDTH];

int *do_dft(int es[WIDTH])
{
	register int i, j;
	int k, temp;
	long real, imag, power[WIDTH/2];
	int powi[WIDTH/2];

// Freq 0 ignorata !!!
	for(j=NEGLI;j<WIDTH/2+NEGLI;j++)
	{
		real=es[0];
		imag=0;
		k=0;
		for(i=1;i<WIDTH;i++)
		{
			k=(k+j)%WIDTH;
			real+=(long)cosinus[k]*es[i];
			imag-=(long)sinus[k]*es[i];
		}
		real>>=16;
		imag>>=16;
		power[j]=real*real+imag*imag;
	}
// Scalare ca sa incapa intr-un int, fara sa pierd rezolutie:
	for(i=0;i<=WIDTH/2;i++)
	{
		temp=(int)(power[i+NEGLI]>>(16+SCAL_RI));
		if(temp) powi[i]=0x7FFF;
		else powi[i]=(int)(power[i+NEGLI]>>SCAL_RI);
	}
	return(powi);
}

int main(int nparm)	// daca exista parametru, NU aplic hanning !!!
{
	struct ffblk ffblk;
	char dirs[NO][6], dummy[20], fname[20], nrcls;
	int esant[WIDTH];
	float han[WIDTH], temp;
	float cuanta, x;
	int *dft;
	register int i, j, k, l, m;
	int done;
	RIFFheader inhead[1];
	BINheader outhead;
	FILE *inf, *outf;
	long pos, curpos;
// Generez tablou coeficienti Hanning
	if(nparm==1)
		for(i=0; i<WIDTH; i++)
			han[i]=(0.5-0.5*cos(2*M_PI*i/(WIDTH-1)));
	else
		for(i=0; i<WIDTH; i++)
			han[i]=1;
// Generez tabel de sin si cos
	cuanta=2*M_PI/WIDTH;
	for(i=0, x=0; i<WIDTH; i++, x+=cuanta)
	{
		sinus[i]=32767*sin(x);
		cosinus[i]=32767*cos(x);
	}
// Caut directoare cu nume din cel mult 1 cifra cu ext 'WAV' ('0.wav' etc)
	for(i=0, j=0;i<NO;i++)
	{
		itoa(i, dummy, 10);
		strcat(dummy, ".wav");
		if(!chdir(dummy))
		{  strcpy(dirs[j++], dummy);
			chdir("..");
		}
	}
	if(!(nrcls=j))
	{
		printf("\nEROARE: Nu este nimic de facut!");
		exit(1);
	}
	for(i=0;i<nrcls;i++)
	{
		dummy[0]=dirs[i][0];
		dummy[1]='\0';
		if(!(outf=fopen(dummy, "r+b")))
			if(!(outf=fopen(dummy, "w+b")))
			{
				printf("\nEROARE: Nu pot deschide (creea) fisierul '%s'!", dummy);
				exit(1);
			}
		outhead.Nvect=0;
		outhead.sp1=' ';
		outhead.Ni=NRFER*NRFRECV;
		outhead.sp2=' ';
		outhead.crlf[0]=0x0d;
		outhead.crlf[1]=0x0a;
		fseek(outf, 0, SEEK_END);	// pozitionez la sfirsit
		pos=ftell(outf);
		fseek(outf, 0, SEEK_SET);	// pozitionez la inceput
		if(pos)							// exista ? (ftell()!=0)
		{
			fread(&outhead, sizeof(outhead), 1, outf);
			if(outhead.Ni!=NRFER*NRFRECV)
			{
				printf("\nEROARE: Fisierul '%s' are vectori pt %d intrari, in loc de %d!", dummy, outhead.Ni, NRFER*NRFRECV);
				exit(1);
			}
		}
		else
			fwrite(&outhead, sizeof(outhead), 1, outf);
		fseek(outf, 0, SEEK_END);	// pozitionez la sfirsit
		strcpy(dummy, dirs[i]);
		strcat(dummy, "\\");
		strcpy(fname, dummy);
		strcat(dummy, "*.wav");		// formez nume fisier intrare ("1.wav\da.wav")
		done=findfirst(dummy,&ffblk,0);
		if(done)
			printf("\nATENTIE: Directorul '%s' nu contine fisiere WAVE!", dirs[i]);
		while(!done)
		{
			strcpy(fname, dirs[i]);
			strcat(fname, "\\");
			strcat(fname, ffblk.ff_name);
			printf("\nProcesez '%s'...", fname);
			if(!(inf=fopen(fname, "rb")))
			{
				printf("\nEROARE: Nu pot deschide fisierul '%s'!", fname);
				exit(1);
			}
			if((fread(inhead, sizeof(RIFFheader), 1, inf))!=1)
			{
			  printf("\nEROARE: '%s' nu este un fisier wav!", fname);
				exit(1);
			}
			else
				if(!(strcmp(inhead->rId,"RIFF")||strcmp(inhead->wId,"WAVE")))
				{
					printf("\nEROARE: '%s' nu este un fisier wav!", fname);
					exit(1);
				}
			if(inhead->wFormatTag!=1)
			{
				printf("\nEROARE: '%s' este un tip de wav necunoscut!", fname);
				exit(1);
			}
			if(fseek(inf,(long)sizeof(RIFFheader),SEEK_SET)||inhead->dLen<NRFER*DEPL)
			{
				printf("\nEROARE: '%s' are %d esantioane in loc de %d!", fname, inhead->dLen, NRFER*DEPL);
				exit(1);
			}
//			if(!(spec=(int *)malloc(NRFRECV/2*sizeof(int))))
//			{	printf("\nEROARE: Memorie insuficienta!");
//				exit(1);
//			}				// VALIDEZ AICI PENTRU INSPECTARE !!!!!!!!!!!!!!!!!!!!!
			outhead.Nvect++;
			for(j=0;j<NRFER;j++)
			{
				curpos=ftell(inf);	// salvez pozitia in fisier
				for(k=0;k<WIDTH;k++)
				{
					temp=han[k]*(getc(inf)-0x7f); // aplic hanning (daca am)
					esant[k]=(int)temp;
				}
				fseek(inf, curpos+DEPL, SEEK_SET);// deplasez fereastra
				dft=do_dft(esant);
				for(k=0, m=firstFQ; k<NRFRECV; k++)
				{
					temp=0;
	// aici fac melscale !!!!!!!!!!!!!!!!!!!!!!!!!!!!
					for(l=0; l<MEL[k] ;l++, m++) temp+=dft[m];
					temp/=MEL[k];
					fputc((int)temp, outf);		// LSB dft
					fputc((int)temp>>8, outf);	// MSB dft
				}
			}
			if(fclose(inf))
			{
				printf("\nEROARE: Inchiderea fisierului '%s' !", fname);
				exit(1);
			}
			printf("\tOK!");
			done=findnext(&ffblk);
		}
		if(fseek(outf, 0, SEEK_SET))		// pozitionez la inceput
		{
			printf("\nEROARE: Pozitionare inceput fisier iesire!");
			exit(1);
		}
		fwrite(&outhead, sizeof(outhead), 1, outf);
		if(fclose(outf))
		{
			printf("\nEROARE: Inchiderea fisierului de iesire!");
			exit(1);
		}
		printf("\n...out file OK!");
	}
	return 0;
}
