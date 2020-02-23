// Achizitie N esantioane de la Sound Blaster
//	scrie in fisiere numexx, cu xx succesive
//	detecteaza zgomotul la inceput
//	compenseaza offset

#include <stdio.h>
#include <conio.h>
#include <dos.h>
#include <dir.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "sb.h"

#define N 3000			// samples to get from SB
#define N_z 8000		// #samples detectie zgomot
#define ENTER 13

 FILE *fp;

 char s[14];
 unsigned SbIOaddr;
 unsigned SbIRQ;
 unsigned SbDMAchan;
 int	SbType;

 int count_fis;

 int rind;
 char result[N_z];		// Buffer pentru achizitie (N_z > N !)
 char medie;			// offset
 char pragN, pragP;		// prag declansare negativ, pozitiv

 static void far interrupt (*OldIRQ)(void);
 void interrupt SBHandler();

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

int dsp_reset(void)
{
  outportb(0x226, 1);             //DSP_RESET
  delay(10);                      //0x22e = DSP_DATA_AVAIL
  outportb(0x226, 0);             //0x22a = DSP_READ_DATA
  delay(10);
  if( (inportb(0x22e) && 0x80 == 0x80) && (inportb(0x22a) == 0xAA) )
		return 1;
	  else
		return 0;
}

static void far interrupt SBHandler()
{
	   result[rind] = inportb(0x22a) - 0x7f - medie;
	   rind++;
	   outportb(0x22c, 0x20);         // start conversie?
	   OldIRQ();
}

void deschide(char name[14])
{
	if(( fp = fopen( name,"wb")) == NULL)
	{
		printf("\n Eroare la deschidere fisier");
		exit(1);
	}

}


char *form_nume(void)
{
struct ffblk ffblk;
char yes, sr[3], sir[3]="0";
char op;
if(strlen(s) > 3) s[3] = '\0';
	if(count_fis == 0)
	{
		strcat(s,"01.dat");
		if( ! findfirst(s, &ffblk, 0) )
		{
			printf("\n Vrei sa suprascrii fisierele %s ??\n",s);
			yes = getch();
			if(yes == 'y')
			{
			   count_fis++;
			   return s;
			}
			else
				count_fis ++;
				return NULL;
		}
		count_fis ++;
		return s;

	}
	else
	{
		itoa((int)count_fis, sr, 10);
		if(atoi(sr) < 10)
			strcat(s, sir);

		strcat(s, sr);
		strcat(s, ".dat");

		count_fis ++;
		return s;
	}
}

void init_intr(void){
		rind=0;
		disable();
		OldIRQ = getvect (0x08);		// PC Timer INT
		setvect (0x08, SBHandler);	// instalare intrerupere
		outportb(0x43, 0x34);		// 8253 mod
		outportb(0x40, 0x95);		// 83 micro sec -> 8 kHz
		outportb(0x40, 0);
		enable();
}

void rest_intr(void){
	disable();
	outportb(0x43, 0x34);
	outportb(0x40, 0xFF);		// DOS wanted
	outportb(0x40, 0xFF);
	setvect (0x08, OldIRQ);       // revenire la vechea rutina
	enable();
}

void achizitie(void)
{
	char r, ch;

	r = inportb(0x22A) - 0x7f - medie;
	while( r < pragP && r > pragN)
	{
		outportb(0x22c, 0x20);         // start conversie?
		delay (1);
		r = inportb(0x22A) - 0x7f - medie;

		if (kbhit())
			{
				ch = getch();
				if (ch == 'd')
				{
					printf("\nOK! Fisierul anterior salvat se sterge.");
					count_fis--;
				 }
				 else
					exit(0);
			}
	}
	init_intr();
	while(rind < N);
	rest_intr();
}

void achiz_z(void)
{
	char r;

	medie = 0;
	sleep(1);
	outportb(0x22c, 0x20);         // start conversie?
	delay(1);
	init_intr();
	while(rind < N_z);
	rest_intr();
}

void calcul_medie(int OVER)
{
	int i;
	char min, max;
	float sum;

	sum = 0;
	min = 127; max = -128;
	for( i=0; i<N_z; i++)
	{
		sum += result[i];
		if( max < result[i] ) max = result[i];
		if( min > result[i] ) min = result[i];
	}
	medie = sum / N_z;

	if (min == 0) min = -2;
	pragN = min - OVER;
	if (max == 0) max = 2;
	pragP = max + OVER;
	printf("\nZgomot:\n");
	printf("\tNivel maxim = %d /127 \n\tNivel minim = %d /-128\n\tOffset = %d\n", max, min, medie);
}

void main()
{
	int i, r, p;
	char c;
	char ch, opt;
	char sTemp[5];

	clrscr();
	if(Sb_Get_Params())
	{
		printf("Variabila de mediu BLASTER nu e setata.\n");
		exit(1);
	}

	printf("\nGrad de sensibilitate 1..10 (1-maxim, recomandat-5) = ");
	scanf("%d", &p);

	printf("\n Detectie nivel de zgomot. Liniste ! apoi Preseaza cheia Any\n");
	getch();

	achiz_z();
	calcul_medie(p);
	printf("\n Acceptabil ? ( n / Anything)");
	c = toupper(getch());

	while (c == 'N')
	{
		achiz_z();
		calcul_medie(p);
		printf("\n Acceptabil ? (n / Anything)");
		c = toupper(getch());
	}

	// citirea 'radacinii' numelui fisierului

	printf("\n\n 'd' pentru a sterge unul sau mai multe fisiere.\n");

	printf("\nSalvez in [tmp] : ");
	ch = getche();
	if( ch == ENTER ) strcpy( s, "tmp" );
		else
			{
				s[0] = ch;
				scanf("%s", sTemp);
				strcat(s, sTemp);
			}

	strcpy(s, form_nume());

	while(!kbhit())
	{
		achizitie();
		strcpy(s, form_nume());
		deschide( s );
		printf("\nAm salvat fisierul %s", s);
		for(i=0; i < N; i++)
			fprintf(fp, "%c", result[i] + 0x7f);
		fclose(fp);
	}

	dsp_reset();

	getch();
}