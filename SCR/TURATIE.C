#include<stdio.h>
#include<dos.h>
#include<conio.h>
#pragma inline
#define LPT1 0x3BC

static void far interrupt (*OldIRQ)(void);
void interrupt NewIRQ();

int contor = 0;
char pas = 0x11;
char opt;
char fanion;
int turatie;


void init_intr(void)
{
	disable();
	OldIRQ = getvect(0x08);
	setvect(0x08, NewIRQ);
	outportb(0x43, 0x34);   //8253 mod
	outportb(0x40, 0x77);   //119 in hexa = 0.1 ms
	outportb(0x40, 0x00);
	enable();
}

void rest_intr(void)
{
	disable();
	outportb(0x43, 0x34);    //8253 mod
	outportb(0x40, 0xff);
	outportb(0x40, 0xff);
	setvect(0x08, OldIRQ);
	enable();
}

/*static void far interrupt NewIRQ(void)
{
	contor++;

	outportb(0x20, 0x20);    //EOI for 8259
} */

static void far interrupt NewIRQ(void)
{
 asm {
     	mov dx, LPT1
	   mov al, pas
	   out dx, al      //outportb(LPT1, pas)

      mov bl, fanion
	   cmp bl, 0
	   je dre

	   rol al, 1
dre:	ror al, 1
	   mov dx, 20h
	   mov al, 20h      //outportb(0x20, 0x20)
	   out dx, al
     }
}

void main(void)
{
	clrscr();
   while(1)
   {
	printf("rotire la dreapta (d) sau la stanga (s) ?");
	scanf("%c", &opt);
	if(opt == 'd')
        fanion = 0;
   else
       if (opt == 's')
           fanion = 1;
       else
           printf("doar 's' sau 'd' !!");

   printf("turatia in pps: ", turatie);
   scanf("%d", &turatie);


	init_intr();
//	while(contor < 100);
	rest_intr();
   }
//	printf("contor =  %d", contor);
	getch();
}
