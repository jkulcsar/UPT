
#include <dos.h>
#include <conio.h>
#include <stdio.h>


void interrupt far (*old_int8)();
int poz=0;
int viteza=1000;
int contor=1;
int sens=1;

void motor(void);

void motor()
{
 switch( poz)
 {
  case 0: outportb(0x3bc,1);break;
  case 1: outportb(0x3bc,3);break;
  case 2: outportb(0x3bc,2);break;
  case 3: outportb(0x3bc,6);break;
  case 4: outportb(0x3bc,4);break;
  case 5: outportb(0x3bc,12);break;
  case 6: outportb(0x3bc,8);break;
  case 7: outportb(0x3bc,9);break;

 }
 if (++poz==8) poz=0;
}

void interrupt far  new_int8(void)
{
 if (contor++>=viteza)
 {
  switch( poz)
  {
   case 0: outportb(0x3bc,1);break;
   case 1: outportb(0x3bc,3);break;
   case 2: outportb(0x3bc,2);break;
   case 3: outportb(0x3bc,6);break;
   case 4: outportb(0x3bc,4);break;
   case 5: outportb(0x3bc,12);break;
   case 6: outportb(0x3bc,8);break;
   case 7: outportb(0x3bc,9);break;
  }
 if (sens>0)
   {if (++poz==8) poz=0;}
   else
   {if (--poz<0) poz=7;}


  contor=1;
 }
 outportb(0x20,0x20);
}

void ch_timer(unsigned int val)
{
 // initializare timer
 outportb(0x43,0x36); //00110110
 outportb(0x40,(val | 256));
 outportb(0x40,(val/256));

}

void main (void)
{
 float val;
 unsigned int t;
 old_int8=getvect(8);
 setvect(8,new_int8);
 ch_timer(1191/2); //intreruperi cu perioada de 0.5ms
 do
 {
  printf("\n\nviteza [p/s]=");
  scanf("%f",&val);
  if (val<0) {sens=-1;val=0-val;}else {sens=1;}

   if (val!=0)
    {
     if (val<19)
     {
      val=1/val;
      viteza=(float)(val*1000/54.9+1);
      t=(float)(val*1000/viteza*0xffff/54.9);
      ch_timer(t);
     }
     else
     {
      viteza=1;
      t=(float)55*val/18*55/0xffff;
      ch_timer(t);
     }


      printf("viteza=%f\n",val);
      printf("timer=%u\n",(float)t*55/0xffff);
      printf("ct=%u\n",viteza);
    }
 } while(val!=0);
 setvect(8,old_int8);
}

