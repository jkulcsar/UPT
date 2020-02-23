#include<stdio.h>
#include<dos.h>
#include<conio.h>
#define LPT1 0x3BC
#define ESC 27

static void far interrupt (*OldIRQ)(void);
void interrupt NewIRQ();

unsigned CT, tempCT;
int     turatie;
char    sens, ch;
char    out_byte = 8;

void init_intr(void)
{
        disable();
        outportb(0x43, 0x34);   //8253 mod
        outportb(0x40, 0x53);   //0.5 ms
	outportb(0x40, 0x02);
        enable();
}

void rest_intr(void)
{
	disable();
	outportb(0x43, 0x34);    //8253 mod
	outportb(0x40, 0xff);
	outportb(0x40, 0xff);
	enable();
}

static void far interrupt NewIRQ(void)
//static void far NewIRQ(void)
{

	tempCT --;
	if ( tempCT == 0 )
	{
		if ( sens == 's' )
		{
			out_byte >>= 1;
			if( out_byte == 0 )
				out_byte = 8;
			 outportb( LPT1, out_byte );
		}
		else
		{
			out_byte <<= 1;
			if( out_byte == 16 )
				out_byte = 1;
			outportb( LPT1, out_byte );

		}
		tempCT = CT;
	}
	outportb( 0x20, 0x20 );     //EOI for 8259
}



void main(void)
{
	init_intr();            //8253 la 0.5 ms
	OldIRQ = getvect(0x08);
	setvect(0x08, NewIRQ);  //instalare intrerupere

	do{
		clrscr();

		printf("\nTURATIA (in pps) = ");
		scanf("%d", &turatie);

		printf("\nSENS\nStinga -- S\nDreapta -- D\n");
		sens = getch();

//		printf("\nTURATIA (in pps) = ");
//                scanf("%d", &turatie);



		clrscr();
		printf("\nENTER -- Continua ...");
		printf("\nESC   -- Iesire   ...");

		CT = (unsigned int)( 2000 / turatie) ;
		tempCT = CT;
		out_byte = 8;

	}
	while((ch = getch()) != ESC);

	rest_intr();
	setvect(0x08, OldIRQ);
}