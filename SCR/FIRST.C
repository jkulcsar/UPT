#include <stdio.h>
#include <dos.h>

#define LPT1 0x3BC

void main(void)
{
   while(1)
   {
	outportb(LPT1, 0x01);
	delay(3);
	outportb(LPT1, 0x02);
	delay(3);
	outportb(LPT1, 0x04);
	delay(3);
	outportb(LPT1, 0x08);
	delay(3);
   }
}