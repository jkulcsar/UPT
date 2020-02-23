// feed-forward, fixed point calculations
// one hidden layer
// statistics:	#recognized: one output over PRAG, others negative, desired match
//		#incert: one output positive (but under PRAG)...
//		#wrong: otherwise

// LARGE

#include<stdio.h>
#include<math.h>
#include<conio.h>
#include<ctype.h>
#include<stdlib.h>

#define NI 256		// max numar de intrari
#define NO 16		// max numar de neuroni output layer
#define NTS 127		// max #test vectors

#define NH 5		// numar de hidden units (max 63)
#define TEMPER 1.25	// Temperture

#define ONE 1023	// Q10
#define SHL 10
#define SCAL 13		// 2*SHL + (1+logSIGB) - logNSIG
#define PRAG 0.5*ONE
/*
#define ONE 4095	// Q12
#define SHL 12
#define SCAL 17		// 12(long_to_int) + 12(Q12) + (1+logSIGB) - logNSIG
 */
/*
#define NSIG 512	// bipolar sigmoid table number of words
#define SIGB 4.		// sig below, minus of start of table sig horizontal
#define NSIG2 256
#define NSIG1 511
#define SCAL 24		// 15(long_to_int) + 15(Q15) + (1+logSIGB) - logNSIG
 */
#define NSIG 1024	// bipolar sigmoid table number of words
#define SIGB 4.		// sig below, minus of start of table sig horizontal
#define NSIG2 512
#define NSIG1 1023


char *namets= "testing.dat\0                                    ";
char *namew = "pon100\0                                ";
FILE *fp;

static int far wi[NH][NI];
static int far wo[NO][NH];
int th[NH];
int to[NO];		/* biasuri */
int ah[NH];
int o[NO];		/* activÜri*/

static int far ts[NTS][NI];		// test vector
//int d[NTS][NO];			// desired output
int d[NTS][4];
int bipsig [NSIG];	// bipolar sigmoid table

int ni, no;
int nh;
int nts;
float T;
int incerti=0, nerec=0, recun=0;


void config(void)				/* CONFIGURARE RETEA */
{char c;
 int go=0;

 do{
 printf("\n\n\n");
 printf("\nCONFIGURATIE INITIALè APPROXIMATOR :\n");
// printf("\t[H]idden units:        (%d)\n",nh);
 printf("\ttempert[U]re:            (%4.2f)\n",T);
 printf("\t[T]est file:             (%s)\n",namets);
 printf("\t[W]eights file:          (%s)\n",namew);
 printf("\t[A]farÜ !");
 printf("\n\t[N]o more changes\n");
 printf("\n\tYour option here: ");
 c=toupper(getche());
 switch( c)
 {
 case 'U':printf("\nTemperture: ");
	  scanf("%f",&T);
	  break;
 case 'T':printf("\nNumele fisierului de test: ");
	  scanf("%s",namets);
	  break;
 case 'W':printf("\nNumele fisierului de ponderi: ");
	  scanf("%s",namew);
	  break;

 case 'A':exit(0);
 case 'N':go=1;
	  break;
 } /* switch */
 } /* do */
 while(!go);
}

void verif(int tr_vect){
	int i, neg=0;
	int poz_d=0, poz_o=0, max_d=d[tr_vect][0] , max_o=o[0];
	for(i=1; i<no; i++){
		if(max_d<d[tr_vect][i]) {
			max_d=d[tr_vect][i];
			poz_d=i;
		}
		if(max_o<o[i]) {
			max_o=o[i];
			poz_o=i;
		}
	 }
	 if(poz_d==poz_o){
		if(max_o >= PRAG){
			for(i=0; i<no; i++)
				if(o[i]<0) neg++;
			if(neg==no-1)
					recun++;
			else nerec++;
		}
		else
			if(max_o > 0){
				for(i=0; i<no; i++)
					if(o[i]<0) neg++;
				if(neg==no-1)
					incerti++;
				 else nerec++;
			}
			else nerec++;
	}
	 else nerec++;
}

void sigtabgen (void)
{
	unsigned int i;
	float x;
//  float bipsig [NSIG];

	for (i=0, x=-SIGB; i<NSIG; i++, x += 2*SIGB / NSIG)
		bipsig [i] = (2. / (1+exp(-x/T)) - 1) * ONE;
}

FILE* deschid(char *name, char *mode)
{	FILE *fp;
	if(!(fp=fopen(name,mode))) printf("\nNu pot deschide fisierul '%s'\n",name);
	return(fp);
}

int rd_int(FILE *fis, int *var)
{	if(!fscanf(fis,"%d",var))
	{	printf("\nEroare citire åntreg din fisier !");
		return 0;
	}
	return 1;
}

int rd_float(FILE *fis, float *var)
{	if(!fscanf(fis,"%f",var))
	{	printf("\nEroare citire float din fisier !");
		return 0;
	}
	return 1;
}

int read_test( void)
/* READ TEST VECTORS */
{
	FILE* fp;
	float fl;
	int dum;
	unsigned i, j;

	if(!(fp=deschid(namets,"rt"))) goto rd_vect_err;

	if(!rd_int(fp, &nts)) goto rd_vect_err;
	if(!rd_int(fp, &dum)) goto rd_vect_err;
	if(!rd_int(fp, &ni )) goto rd_vect_err;
	if(ni>NI)
	{	printf( "\nNumarul de intrari nu pusca\n");
		goto rd_vect_err;
	}
	if(!rd_int(fp, &no)) goto rd_vect_err;
	if(no>NO)
	{	printf("\nPrea multi neuroni de iesire !\n");
		goto rd_vect_err;
	}

/* BUILDING TEST VECTOR */

	for (i=0; i<nts; i++)
	{
		if(!rd_int(fp, &dum)) goto rd_vect_err;
		for(j=0;j<ni;j++)
		{
			if(!rd_float(fp, &fl)) goto rd_vect_err;
			ts[i][j] = fl * ONE;
		}

		for( j=0; j<no; j++)
			d[i][j] = -ONE;
		if(!rd_int (fp, &dum)) goto rd_vect_err;
		d[i][dum] = ONE;
	}

	fclose( fp);
	return 1;
rd_vect_err:;
	fclose(fp);
	return 0;
}


int read_pon(void)			/* READ WEIGHTS FILE */
{
	FILE *fp;				/* 	antet: */
	int i, j;				/*			no	ni	nwl=2	nmo 	*/
	float fl;				/*			nh	nhlast=0	*/
	int nwo, nwi, nwl, nmo, nwlast;
	int nwh;

	if(!(fp=deschid(namew,"rt"))) return 0;
	if(!rd_int(fp, &nwo)) goto rd_pon_err;
	if(!rd_int(fp, &nwi)) goto rd_pon_err;
	if(!rd_int(fp, &nwl)) goto rd_pon_err;
	if(!rd_int(fp, &nmo)) goto rd_pon_err;
	if(!rd_int(fp, &nwh)) goto rd_pon_err;
	if(!rd_int(fp, &nwlast)) goto rd_pon_err;
	if(nwi!=ni||nwl!=2||nwo!=no||nwlast!=0||nwh!=nh)
	{	printf("\nNumar de neuroni in fisierul de ponderi nu pusca !\n");
		goto rd_pon_err;
	}
// CITESC PONDERILE DIN IN
	for( i=0; i<nh; i++)
		for( j=0; j<ni; j++)
		{
			if( !rd_float( fp, &fl)) goto rd_pon_err;
			wi[i][j] = fl * ONE;
		}

// SI ACUM BIAS - URILE HIDDEN
	for(i=0; i<nh; i++)
	{
		if( !rd_float(fp, &fl)) goto rd_pon_err;
		th[i] = fl * ONE;
	}

// CITESC PONDERILE DIN IESIRE
	for( i=0; i<no; i++)
		for( j=0; j<nh; j++)
		{
			if( !rd_float( fp, &fl)) goto rd_pon_err;
			wo[i][j] = fl * ONE;
		}

// SI ACUM BIAS - URILE OUTPUT
	for(i=0; i<no; i++)
	{
		if( !rd_float(fp, &fl)) goto rd_pon_err;
		to[i] = fl * ONE;
	}

	fclose(fp);
	return 1;
rd_pon_err:;
	fclose(fp);
	return 0;
}

/*************************************************************************/
void feed_forward (unsigned testv)	/* FEED FORWARD */
{
	register unsigned i, j;
	int temp;
	long templ;

// CALCUL ACTIVARE HIDDEN LAYER
	for( i=0; i<nh; i++)
	{
		templ = th[i];
		templ <<= SHL;		// pregatesc accumulare pe 32 bits
		for( j=0; j<ni; j++)
		{
			templ += (long)wi[i][j] * ts[testv][j];
/*
			templ = (long)wi[i][j] * ts[j];
			t = temp;
			temp += (templ>>17);
			if (t>0 && templ>0 && temp<0 || t<0 && templ<0 && temp>0)
				printf ("\nHidden calculation OVERFLOW!");
 */
		}
//		ah[i] = (2 / (1+exp(-temp/T)) - 1);
		temp = templ >> SCAL;		// (templ>>15) / ONE /(2*SIGB) * NSIG
		temp += NSIG2;
		if (temp >= NSIG) temp = NSIG1;
		if (temp < 0) temp = 0;
		ah[i] = bipsig [temp];
	}

/* CALCUL ACTIVARE OUTPUT */
	for( i=0; i<no; i++)
	{
		templ = to[i];
		templ <<= SHL;
		for( j=0; j<nh; j++)
		{
			templ += (long)wo[i][j] * ah[j];
		}
		temp = templ >> SCAL;
		temp += NSIG2;
		if (temp >= NSIG) temp = NSIG1;
		if (temp < 0) temp = 0;
		o[i] = bipsig [temp];
	}
}

/*********************************************************************/

void main(int nparm)
{
	unsigned int i;
	unsigned int tv;
//	FILE *fp;

	nh = NH;
	T = TEMPER;

	if(nparm==1) config();
	sigtabgen();


	printf("\nCitesc fisierul de testare.....");
	if(!read_test()) goto err;

//	printf("\tSucces ! (free: %lu)", farcoreleft());
	printf("\nCitesc fisierul de ponderi.....");
	if(!read_pon()) goto err;

	printf( "\n\n\tFeed-forward result:\nDesired:\t\t\t\Net output:");

	for (tv=0; tv<nts; tv++)
	{
		feed_forward (tv);
		verif(tv);
		printf ("\n%d\t", tv);
		for( i=0; i<no; i++)
			printf( "%d ", d[tv][i]);
		printf ("\t");

		for( i=0; i<no; i++)
			printf( "%d ", o[i]);
		if (tv%20 == 0)
			getch();
	}
	getch();
	clrscr();
	printf("Recunoscuti : %d" , recun);
	printf("\nNerecunoscuti : %d" , nerec);
	printf("\nIncerti : %d" , incerti);
        getch();
	return;
err:;
	printf("\nåncheiere anormalÜ !");
}
