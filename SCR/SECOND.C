#include <stdio.h>
#include <dos.h>

#define LPT1 0x3BC
#define d 1

void main(void)
{
   while(1)
   {
	outportb(LPT1, 0x01);
	delay(d);
	outportb(LPT1, 0x03);
	delay(d);
	outportb(LPT1, 0x02);
	delay(d);
	outportb(LPT1, 0x05);
	delay(d);
	outportb(LPT1, 0x04);
	delay(d);
	outportb(LPT1, 0x0C);
	delay(d);
	outportb(LPT1, 0x08);
	delay(d);
   }
}