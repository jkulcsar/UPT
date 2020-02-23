// Aplica coeficienti Hanning (daca nu are parametru de intrare!)
// la NRFER ferestre*WIDTH esantioane din fisiere *.WAV gasite in
// directoare cu nume <n>.WAV. Calculeaza DFT in WIDTH puncte
// scoate NRFRECV frecv. cu melscale dat de sirul MEL[]!
// float DFT si normalizare pe intregul vector
// SQRT spectral amplitudes
// LOG(mel)


#include<dir.h>
#include<math.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#define NRFER   20      // numar total de ferestre achizitionate (si B2A si WAVPROC)
#define NRFRECV 12      // numar de frecvente/fereastra-spectru (si B2A si WAVPROC)
#define WIDTH   128     // numar de esantioane/fereastra-timp (latime fer)
#define DEPL    96      // numarul de esantioane cu care plimb fereastra
#define NO      5      // numar de neuroni/output layer (clase)
#define NEGLI 1       // neglijez la inceput atatea freq
#define CHTOF 127	// signed char to float convertion constant

float sinus [WIDTH], cosinus [WIDTH];
float power [WIDTH/2];
float es [WIDTH];

void do_dft (void)
{
		register int i, j;
		int k;
		float real, imag;

		for(j=NEGLI;j<WIDTH/2;j++)		// Only WIDTH/2 reserved !
		{
				real=es[0];
				imag=0;
				k=0;
				for(i=1;i<WIDTH;i++)
				{
						k=(k+j)%WIDTH;
						real += cosinus[k] * es[i];
						imag -= sinus[k] * es[i];
				}
				power[j-NEGLI] = sqrt (real*real+imag*imag);
		}
}

void main(void)
{
	int MEL[NRFRECV]={2,2,3,3,4,3,3,3,4,7,13,14};
	typedef struct
	{
				char rId[4];                  // "RIFF"
				unsigned long rLen;           // lungime fisier-(len(rId)+len(rLen))
				char wId[4];                  // "WAVE"         \________  ________/
				char fId[4];                  // "fmt "                  \/
				unsigned long fLen;           // lungime format (10)     (8)
				unsigned int wFormatTag;      // 8b samples uncompressed
				unsigned int nChannels;       // 1=mono : 2=stereo
				unsigned long nSamplesPerSec; // 0x00002b11
				unsigned long nAvgBytesPerSec;// nChannels*nSamplesPerSec*(nBitsPer_Sample/8)
				unsigned int nBlockAlign;     // nChannels*(nBitsPerSample/8)
				unsigned int FormatSpecific;
				char dId[4];                  // "data"
				unsigned long dLen;           // lungime date
	}RIFFheader;   // (folosit si in WARP_EXT)

		struct ffblk ffblk;
		char dirs[NO][6], dummy[20], fname[20], nrcls;
		float han[WIDTH];
		float cuanta, x;
		float fou[ NRFER*NRFRECV];
		float flotmp, max, abstmp;
		register int i, j, k, l, m;
		int done, cont_vect=1;
		int nrvect;
		RIFFheader inhead[1];
		FILE *inf, *fp;
		long pos, curpos;

		if(!(fp=fopen("training.dat","w+"))){
					printf("Nu pot deschide fisierul training.dat!!!");
				}
		fprintf(fp,"%d %d %d %d\n\n\n", 0, 0, 0, 0);	//scriere falsa, ocup loc pt. header

// Generez tablou coeficienti Hanning
		for(i=0; i<WIDTH; i++) han[i]=(0.5-0.5*cos(2*M_PI*i/(WIDTH-1)));
// Generez tabel de sin si cos
		cuanta=2*M_PI/WIDTH;
		for(i=0, x=0; i<WIDTH; i++, x+=cuanta)
		{
				sinus[i] = sin(x);
				cosinus[i] = cos(x);
		}
// Caut directoare cu nume din cel mult 1 cifra cu ext 'WAV' ('0.wav' etc)
		for(i=0, j=0;i<NO;i++)
		{       itoa(i, dummy, 10);
				strcat(dummy, ".wav");
				if(!chdir(dummy))
				{  strcpy(dirs[j++], dummy);
						chdir("..");
				}
		}
		if(!(nrcls=j))
		{       printf("\nEROARE: Nu este nimic de facut!");
				exit(1);
		}

		for(i=0;i<nrcls;i++)
		{
				nrvect=0;
				strcpy(dummy, dirs[i]);
				strcat(dummy, "\\");
				strcpy(fname, dummy);
				strcat(dummy, "*.wav");         // formez nume fisier intrare ("1.wav\da.wav")
				done=findfirst(dummy,&ffblk,0);
				if(done) printf("\nATENTIE: Directorul '%s' nu contine fisiere WAVE!", dirs[i]);
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
						else if(!(strcmp(inhead->rId,"RIFF")||strcmp(inhead->wId,"WAVE")))
						{
								printf("\nEROARE: '%s' nu este un fisier wav!", fname);
								exit(1);
						}
						if(inhead->wFormatTag!=1)
						{  printf("\nEROARE: '%s' este un tip de wav necunoscut!", fname);
								exit(1);
						}
						if(fseek(inf,(long)sizeof(RIFFheader),SEEK_SET)||inhead->dLen<NRFER*DEPL)
						{  printf("\nEROARE: '%s' are %d esantioane in loc de %d!", fname, inhead->dLen, NRFER*DEPL);
								exit(1);
						}
						nrvect++;

						max=0;
						for(j=0;j<NRFER;j++)
						{
							curpos=ftell(inf);      // salvez pozitia in fisier
							for(k=0;k<WIDTH;k++)
								es[k] = han[k]*(getc(inf)-0x7f)/CHTOF; // aplic hanning
							fseek(inf, curpos+DEPL, SEEK_SET);// deplasez fereastra
							do_dft();

// melscale float
							for(k=0, m=0; k<NRFRECV; k++)
							{
								flotmp = 0;
								for(l=0; l<MEL[k] ;l++, m++) flotmp += power[m];
								flotmp = log (flotmp/MEL[k]);
								if (flotmp < 0)
									abstmp = flotmp * (-1.0);
								else
									abstmp = flotmp;
								if (max < abstmp) max = abstmp;

								fou[j*NRFRECV+k] = flotmp;
							}
						}
						fprintf(fp,"\n%d ",cont_vect++);
// normalizare pe integul vector, apoi write in file
						for( k=0; k<NRFRECV*NRFER; k++)
						{
							fou[k] /= max;
							fprintf(fp,"%4.3f ", fou[k]);
						}

						if(fclose(inf))
						{  printf("\nEROARE: Inchiderea fisierului '%s' !", fname);
								exit(1);
						}
						fprintf(fp,"%c\n",dummy[0]);       //acum scriu clasa
						done=findnext(&ffblk);
				}
		}
		fseek(fp, 0, SEEK_SET);
		fprintf(fp, "%d %d %d %d", --cont_vect, 0, NRFRECV * NRFER, nrcls);
		fclose(fp);
}
