#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <dos.h>
#include <mem.h>
#include "rtc86.h"

typedef struct{
	  TASK_ADR runadr;
	  uschar status;
	  usint ss;
	  usint sp;
	  usint up_stk_m;
	  uschar prior;
	  usint sltime;
	  uschar to;
	 uschar preempflg;
	 uschar en_des;
	}CONTLOG;

	CONTLOG _contlog[MAX_TSK+1];
	uschar _ltc[MAX_TSK];
	// uschar _lap[MAX_TSK+1];
	uschar _lap_t[MAX_TSK];
	uschar _lap_p[MAX_TSK+1];
	uschar _ltb[MAX_TSK];
	usshort _zonsti[DIM_ZONA_STIVE];

	HANDLER_ADR _vtvi[256];
	uschar BACK_GND;
	usshort _cas;
	uschar _to;
	uschar _tsk_crt;
	unsigned _stklen=32000;
	usshort _fltop;
	uschar _kbflg;

typedef struct{
			uschar flg;
		  uschar coada[MAX_FLG];
		  uschar *pie;
		}FLAG;

FLAG _flg[MAX_FLG];

typedef struct{
			short contor;
		  uschar coada[MAX_TSK];
		  uschar *pi;
		  uschar *pe;
		  uschar valinit;
		}SEMAPHORE;

SEMAPHORE _sem[MAX_SEM];

typedef struct{
			short contor;
		  uschar coada[MAX_TSK];
		  uschar *pi;
		  uschar *pe;
		  uschar propr;
		}RESOURCE;

		RESOURCE _res[MAX_RES];

typedef struct{
		  uschar coada[MAX_TSK];
		  uschar *pie;
		}EVENT;

EVENT _evn[MAX_EVN];

typedef struct{
		   usshort evntval;
			usshort mask;
			usshort oper;
		}FOR_ME;

typedef struct{
		   FOR_ME for_me[MAX_TSK];
		  uschar nfree;
		 }MULTIEVENT;

MULTIEVENT _me[MAX_ME];

typedef struct{
			short contor;
		  uschar coada[MAX_TSK];
		  uschar *pie;
		  usint timeout;
		  uschar status;
		 }RENDEZ_VOUS;

RENDEZ_VOUS _rv[MAX_RV];

typedef struct{
			uschar itp;
		  uschar itc;
		  usshort rs;
		  usshort rc;
		  usshort nocumul;
		  uschar conducta[DIM_COND];
		  uschar *ps;
		  uschar *pc;
		 }PIPE;

PIPE _pp[MAX_PP];

typedef struct{
		   void *pd;
		  usshort ld;
		  uschar ip;
		 }MESAJ;

typedef struct{
		   SEMAPHORE s1;
		   SEMAPHORE s2;
		   SEMAPHORE s3;
		  MESAJ buf[DIM_CP];
		  MESAJ *ps;
		  MESAJ *pc;
		 }MAILBOX;

MAILBOX _mb[MAX_MB];

SEM_IDENT chravail;

HANDLER intr7();

HANDLER scheduler(CONTFIZ contfiz);

HANDLER sched(void);

HANDLER kbdhndl(void);

HANDLER intr34();

HANDLER intr35();

HANDLER intr36();

HANDLER intr37();

HANDLER intr38();

HANDLER intr39();

HANDLER intr3a();

HANDLER intr3b();

HANDLER intr3c();

HANDLER intr3d();

HANDLER intr3e();

TASK bg(void);

void init_ltc(void);
void ins_ltc(TASK_IDENT tskid);
void elim_ltc(TASK_IDENT tskid);
uschar first_avail_ltc(void);

void init_lap(void);
void ins_lap(TASK_IDENT tskid);
void elim_lap(TASK_IDENT tskid);
uschar next_lap(void);

void init_ltb(void);
void ins_ltb(TASK_IDENT tskid);
void elim_ltb(TASK_IDENT tskid);
uschar search_ltb(TASK_IDENT tskid);

#define abort printf

HANDLER intr7()
{
 _fltop|=0x0800;
 putch('s');
 (*_vtvi[7])();
 _fltop&=0xf7ff;
}

HANDLER kbdhndl(void)
{
 if(!(--_kbflg))
 {
	_kbflg=1;
	_s_signal(chravail);
 }
	(*_vtvi[9])();
}

HANDLER _endmt(void)
{
 static CONTLOG *p;
 _cli();
 p=&_contlog[_tsk_crt];
 p->sp=_SP;
 p->ss=_SS;
 _tsk_crt=MAX_TSK;
 p=&_contlog[_tsk_crt];
 _SP=p->sp;
 _SS=p->ss;
}

HANDLER intr34()
{
 _fltop|=0x0001;
 putch('4');
 (*_vtvi[0x34])();
 _fltop&=0xfffe;
}

HANDLER intr35()
{
 _fltop|=0x0002;
 putch('5');
 (*_vtvi[0x35])();
 _fltop&=0xfffd;
}

HANDLER intr36()
{
 _fltop|=0x0004;
 putch('6');
 (*_vtvi[0x36])();
 _fltop&=0xfffb;
}

HANDLER intr37()
{
 _fltop|=0x0008;
 putch('7');
 (*_vtvi[0x37])();
 _fltop&=0xfff7;
}

HANDLER intr38()
{
 _fltop|=0x0010;
 putch('8');
 (*_vtvi[0x38])();
 _fltop&=0xffef;
}

HANDLER intr39()
{
 _fltop|=0x0020;
 putch('9');
 (*_vtvi[0x39])();
 _fltop&=0xffdf;
}

HANDLER intr3a()
{
 _fltop|=0x0040;
 putch('a');
 (*_vtvi[0x3a])();
 _fltop&=0xffbf;
}

HANDLER intr3b()
{
 _fltop|=0x0080;
 putch('b');
 (*_vtvi[0x3b])();
 _fltop&=0xff7f;
}

HANDLER intr3c()
{
 _fltop|=0x0100;
 putch('c');
 (*_vtvi[0x3c])();
 _fltop&=0xfeff;
}

HANDLER intr3d()
{
 _fltop|=0x0200;
 putch('d');
 (*_vtvi[0x3d])();
 _fltop&=0xfdff;
}

HANDLER intr3e()
{
 _fltop|=0x0400;
 putch('e');
 (*_vtvi[0x3e])();
 _fltop&=0xfbff;
}

void _init(void)
{
 uschar i;
 _lock();
 for(i=0;i<MAX_TSK;i++)
	{
		_contlog[i].status=NECREAT;
	}
 init_ltc();
 init_lap();
 init_ltb();
 _f_init();
 _s_init();
 _r_init();
 _e_init();
 _me_init();
 _rv_init();
 _p_init();
 _mb_init();
 _cas=0;
 _fltop=0;
 _kbflg=1;
 _tsk_crt=MAX_TSK;
 _contlog[_tsk_crt].preempflg=0;
 _s_create(chravail, 0);
 _create(BACK_GND, bg, MAX_PRIOR-1, 3, _to);
 _activate(BACK_GND);
 _unlock();
}

void create(TASK_IDENT *tskidadr, TASK_ADR runadr, uschar prior, usshort stksz, void *dadr)
{
 CONTLOG *p;
 uschar i;
 _lock();
 *tskidadr=MAX_TSK;
 i=first_avail_ltc();
 if(i<MAX_TSK&&prior<MAX_PRIOR){
   stksz*=128;
   if(_cas+stksz<DIM_ZONA_STIVE){
	 _zonsti[DIM_ZONA_STIVE-1-_cas]=0x200;
	 _zonsti[DIM_ZONA_STIVE-1-_cas-1]=FP_SEG(runadr);
	 _zonsti[DIM_ZONA_STIVE-1-_cas-2]=FP_OFF(runadr);
	 _zonsti[DIM_ZONA_STIVE-1-_cas-7]=FP_SEG(dadr);
	 _zonsti[DIM_ZONA_STIVE-1-_cas-8]=FP_SEG(dadr);
	 _zonsti[DIM_ZONA_STIVE-1-_cas-11]=FP_OFF(&_zonsti[DIM_ZONA_STIVE-1-_cas-11]);
	 p=&_contlog[i];
	 p->runadr=runadr;
	 p->status=CREAT;
	 p->ss=FP_SEG(&_zonsti[DIM_ZONA_STIVE-1-_cas]);
	  p->sp=FP_OFF(&_zonsti[DIM_ZONA_STIVE-1-_cas-11]);
	  p->up_stk_m=p->sp+23;
	 p->prior=prior;
	 p->sltime=0;
	 p->to=0;
	 p->preempflg=1;
	 p->en_des=0;
	 ins_ltc(i);
	 _cas+=stksz;
	 *tskidadr=i;
   }
   else{
	 abort("\nEsec la crearea taskului %2d: SPATIU PENTRU STIVA INSUFICIENT!", i);
	}
 }
 else{
   if(i>=MAX_TSK){
	 abort("\nEsec la crearea taskului %2d:  DEPASIRE NUMAR DE TASKURI MAXIM ADMIS (MAX_TSK=%2d)!", i, MAX_TSK);
   }
   if(prior>=MAX_PRIOR){
	 abort("\nEsec la crearea taskului %2d:  PRIORITATE PREA MARE (MAX_PRIOR=%2d)!", i, MAX_PRIOR);
   }
 }
 _unlock();
}

void _destroy(TASK_IDENT tskid)
{
 CONTLOG *p;
 _lock();
 p=&_contlog[tskid];
 if(p->status==CREAT||p->status==GATA){
   if(p->status==GATA){
	 elim_lap(tskid);
   }
   elim_ltc(tskid);
   p->status=NECREAT;
 }
 else{
   abort("\nEroare in taskul %2d: TENTATIVA DE DISTRUGERE A TASKULUI %2d, AFLAT IN UNA DIN STARILE \"EXECUTIE\" SAU \"BLOCAT\"!", _tsk_crt, tskid);
 }
 _unlock();
}

void _activate(TASK_IDENT tskid)
{
 CONTLOG *p;
 _lock();
 p=&_contlog[tskid];
 if(p->status!=NECREAT){
   if(p->status==CREAT){
	 ins_lap(tskid);
	 p->status=GATA;
   }
   p->en_des=1;
 }
 else{
   abort("\nEroare in taskul %2d: TENTATIVA DE ACTIVARE A TASKULUI %2d, AFLAT IN STAREA \"NECREAT\"!", _tsk_crt, tskid);
 }
 _unlock();
}

void _disactivate(TASK_IDENT tskid)
{
 CONTLOG *p;
 _lock();
 p=&_contlog[tskid];
 if(p->status!=NECREAT){
   p->en_des=0;
 }
 else{
   abort("\nEroare in taskul %2d: REFERIRE LA UN TASK NECREAT (in \"desactivate\")!", _tsk_crt);
 }
 _unlock();
}

void _run(usshort period)
{
 uslong aux;
 if(period<=65535UL*50000UL/59659UL){
   clrscr();
   _lock();
   aux=period*59659UL/50000UL;
   outportb(0x43, 0x36);
   outportb(0x40, (uschar)(aux%256));
   outportb(0x40, (uschar)(aux/256));
   _setvect(0x1b, (HANDLER_ADR)_endmt);
   _setvect(0x23, (HANDLER_ADR)_endmt);
   _setvect(8, (HANDLER_ADR)scheduler);
   _setvect(9, (HANDLER_ADR)kbdhndl);
//   _setvect(7, (HANDLER_ADR)intr7);
//   _setvect(0x34, (HANDLER_ADR)intr34);
//   _setvect(0x35, (HANDLER_ADR)intr35);
//   _setvect(0x36, (HANDLER_ADR)intr36);
//   _setvect(0x37, (HANDLER_ADR)intr37);
//   _setvect(0x38, (HANDLER_ADR)intr38);
//   _setvect(0x39, (HANDLER_ADR)intr39);
//   _setvect(0x3a, (HANDLER_ADR)intr3a);
//   _setvect(0x3b, (HANDLER_ADR)intr3b);
//   _setvect(0x3c, (HANDLER_ADR)intr3c);
//   _setvect(0x3d, (HANDLER_ADR)intr3d);
//   _setvect(0x3e, (HANDLER_ADR)intr3e);
   sched();
   outportb(0x43, 0x36);
   outportb(0x40, 0);
   outportb(0x40, 0);
//   _restvect(0x3e);
//   _restvect(0x3d);
//   _restvect(0x3c);
//   _restvect(0x3b);
//   _restvect(0x3a);
//   _restvect(0x39);
//   _restvect(0x38);
//   _restvect(0x37);
//   _restvect(0x36);
//   _restvect(0x35);
//   _restvect(0x34);
//   _restvect(7);
   _restvect(9);
   _restvect(8);
   _restvect(0x23);
   _restvect(0x1b);
   _unlock();
 }
 else{
   abort("\nEsec la amorsarea modului multitasking: PERIOADA A CEASULUI DE TIMP REAL PREA MARE (>55ms)!");
 }
}

HANDLER scheduler(CONTFIZ contfiz)
{
 static CONTLOG *p;
 static uschar i;
 static usint aux;
 for(i=0;i<MAX_TSK;i++){
   if(search_ltb(i)){
	 p=&_contlog[i];
	 if(p->sltime!=0){
	   if(--p->sltime==0){
		  p->to=1;
		  _wakeup(i);
	   }
	 }
   }
 }
 aux=contfiz.adr.cai.cs;
 if(((aux>=LIM_INF)&&(aux<=LIM_SUP))&&(!_fltop)&&(_contlog[_tsk_crt].preempflg)){
   p=&_contlog[_tsk_crt];
   p->sp=_SP;
   p->ss=_SS;
   _tsk_crt=next_lap();
   p=&_contlog[_tsk_crt];
   _SP=p->sp;
   _SS=p->ss;
   if(p->status==GATA){
	 p->status=EXECUTIE;
   }
 }
 (*_vtvi[8])();
}

HANDLER sched(void)
{
 static CONTLOG *p;
 _cli();
 p=&_contlog[_tsk_crt];
 p->sp=_SP;
 p->ss=_SS;
 _tsk_crt=next_lap();
 p=&_contlog[_tsk_crt];
 _SP=p->sp;
 _SS=p->ss;
 if(p->status==GATA){
   p->status=EXECUTIE;
 }
}

void _beg_cr(void)
{
 _lock();
 _contlog[_tsk_crt].preempflg=0;
 _unlock();
}

void _end_cr(void)
{
 _lock();
 _contlog[_tsk_crt].preempflg=1;
 _unlock();
}

void _lock_70(void)
{
 outportb(0x70, 11);
 outportb(0x71, 0x02);
}

void _unlock_70(void)
{
 outportb(0x70, 11);
 outportb(0x71, 0x42);
}

void _setvect(uschar intnum, HANDLER_ADR newvect)
{
 _lock();
 _vtvi[intnum]=getvect(intnum);
 setvect(intnum, newvect);
 _unlock();
}

void _restvect(uschar intnum)
{
 _lock();
 setvect(intnum, _vtvi[intnum]);
 _unlock();
}

void _sleep(usint timeout)
{
 CONTLOG *p;
 _lock();
 p=&_contlog[_tsk_crt];
 p->status=BLOCAT;
 p->sltime=timeout;
 p->to=0;
 elim_lap(_tsk_crt);
 ins_ltb(_tsk_crt);
 sched();
 _unlock();
}

void _wakeup(TASK_IDENT tskid)
{
 CONTLOG *p;
 _lock();
 p=&_contlog[tskid];
 if(p->status==NECREAT||p->status==CREAT){
   if(p->status==NECREAT){
	 abort("\nEroare in taskul %2d: REFERIRE LA UN TASK NECREAT (in \"_wakeup\")!", _tsk_crt);
   }
   else{
	 abort("\nEroare in taskul %2d: TENTATIVA DE TREZIRE A UNUI TASK IN STAREA \"CREAT\" (TASKUL %2d)!", _tsk_crt, tskid);
   }
 }
 else{
   if(p->status==BLOCAT){
	 p->status=EXECUTIE;
	 p->sltime=0;
	 elim_ltb(tskid);
	 ins_lap(tskid);
   }
 }
 _unlock();
}

void tochk(uschar *flgadr)
{
 _lock();
 *flgadr=_contlog[_tsk_crt].to;
 _contlog[_tsk_crt].to=0;
 _unlock();
}

void init_lap(void)
{
 uschar i;
 for(i=0;i<MAX_TSK;i++){
   _lap_t[i]=MAX_TSK;
   _lap_p[i]=MAX_TSK;
 }
 _lap_p[MAX_TSK]=MAX_TSK;
}

void ins_lap(TASK_IDENT tskid)
{
 uschar k;
 uschar i;
 k=_contlog[tskid].prior;
 if(_lap_p[k]==MAX_TSK){
   _lap_t[tskid]=tskid;
   _lap_p[k]=tskid;
   i=0;
   while((_lap_p[i]==MAX_TSK)&&(i<k)){
	 i++;
   }
   if(i==k){
	 _lap_p[MAX_TSK]=k;
   }
 }
 else{
   _lap_t[tskid]=_lap_t[_lap_p[k]];
   _lap_t[_lap_p[k]]=tskid;
 }
}

void elim_lap(TASK_IDENT tskid)
{
 uschar k;
 uschar j;
 k=_contlog[tskid].prior;
 j=_lap_p[k];
 while((_lap_t[j]!=tskid)&&(_lap_t[j]!=_lap_p[k])){
   j=_lap_t[j];
 }
 if(_lap_t[j]==tskid){
   if(_lap_p[k]==tskid){
	 if(_lap_t[j]==j){
	   _lap_t[tskid]=MAX_TSK;
	   _lap_p[k]=MAX_TSK;
	   if(_lap_p[MAX_TSK]==k){
		 j=k;
		 do{
		   j++;
		 }while(_lap_p[j]==MAX_TSK);
		 _lap_p[MAX_TSK]=j;
	   }
	 }
	 else{
	   _lap_p[k]=j;
	   _lap_t[j]=_lap_t[tskid];
	   _lap_t[tskid]=MAX_TSK;
	 }
   }
   else{
	 _lap_t[j]=_lap_t[tskid];
	 _lap_t[tskid]=MAX_TSK;
   }
 }
}

uschar next_lap(void)
{
 uschar i;
 uschar j;
 uschar k;
 j=0;
 do{
   k=_lap_t[_lap_p[_lap_p[MAX_TSK]+j]];
   i=k;
   while((_lap_t[k]!=i)&&(!_contlog[k].en_des)){
	 k=_lap_t[k];
   }
   j++;
 }while((k==i)&&(!_contlog[k].en_des));
 _lap_p[_lap_p[MAX_TSK]+j-1]=k;
 return(k);
}

//void init_lap(void)
//{
// uschar i;
// for(i=0;i<=MAX_TSK;i++){
//   _lap[i]=MAX_TSK;
// }
//}

//void ins_lap(TASK_IDENT tskid)
//{
// if(_lap[MAX_TSK]==MAX_TSK){
//   _lap[tskid]=tskid;
//   _lap[MAX_TSK]=tskid;
// }
// else{
//   _lap[tskid]=_lap[_lap[MAX_TSK]];
//   _lap[_lap[MAX_TSK]]=tskid;
// }
//}

//void elim_lap(TASK_IDENT tskid)
//{
// uschar i=0;
// while((_lap[i]!=tskid)&&(i<MAX_TSK)){
//   i++;
// }
// if(i!=MAX_TSK){
//   _lap[i]=_lap[tskid];
//   _lap[tskid]=MAX_TSK;
//   if(tskid==_lap[MAX_TSK]){
//     if(_lap[i]==MAX_TSK){
//       _lap[MAX_TSK]=MAX_TSK;
//     }
//	else{
//       _lap[MAX_TSK]=i;
//     }
//   }
// }
//}

//uschar next_lap(void)
//{
// if(_lap[_lap[MAX_TSK]]!=BACK_GND){
//   _lap[MAX_TSK]=_lap[_lap[MAX_TSK]];
// }
// else{
//   _lap[MAX_TSK]=_lap[BACK_GND];
// }
// return (_lap[MAX_TSK]);
//}

void init_ltb(void)
{
 uschar i;
 for(i=0;i<MAX_TSK;i++){
   _ltb[i]=MAX_TSK;
 }
}

void ins_ltb(TASK_IDENT tskid)
{
 _ltb[tskid]=tskid;
}

void elim_ltb(TASK_IDENT tskid)
{
 _ltb[tskid]=MAX_TSK;
}

uschar search_ltb(TASK_IDENT tskid)
{
 uschar aux;
 if(_ltb[tskid]==tskid){
   aux=1;
 }
 else{
   aux=0;
 }
 return(aux);
}

void init_ltc(void)
{
 uschar i;
 for(i=0;i<MAX_TSK;i++){
   _ltc[i]=MAX_TSK;
 }
}

void ins_ltc(TASK_IDENT tskid)
{
 _ltc[tskid]=tskid;
}

void elim_ltc(TASK_IDENT tskid)
{
 _ltc[tskid]=MAX_TSK;
}

uschar first_avail_ltc(void)
{
 uschar i;
 i=0;
 while((_ltc[i]!=MAX_TSK)&&(i<MAX_TSK)){
   i++;
 }
 return(i);
}

TASK bg(void)
{
	while( 1 )
	{
	}
}

void _f_init(void)
{
 FLAG *f;
 static uschar j;
 static uschar i;
 _lock();
 f=&_flg[0];
 for(j=0;j<MAX_FLG;j++){
   f->pie=NULL;
   for(i=0;i<MAX_TSK;i++){
	 f->coada[i]=MAX_TSK;
   }
   f++;
 }
 _unlock();
}

void f_create(FLG_IDENT *flgidadr)
{
 FLAG *f;
 uschar j;
 _lock();
 f=&_flg[0];
 j=0;
 while((f->pie)&&(j<MAX_FLG)){
   f++;
   j++;
 }
 if(j<MAX_FLG){
   f->pie=&(f->coada[0]);
   f->flg=0;
 }
 else{
   abort("Eroare in taskul %2d: Tentativa de a crea mai mult de MAX_FLG (%2d) fanioane!", _tsk_crt, MAX_FLG);
 }
 *flgidadr=j;
 _unlock();
}

void _f_destroy(FLG_IDENT flgid)
{
 FLAG *f;
 _lock();
 f=&_flg[flgid];
 if(f->pie!=&(f->coada[0])){
   abort("Eroare in taskul %2d: Tentativa de a distruge un fanion (%2d) cu coada nevida!", _tsk_crt, flgid);
 }
 else{
   f->pie=NULL;
 }
 _unlock();
}

void _f_wait(FLG_IDENT flgid, usint timeout)
{
 FLAG *f;
 _lock();
 f=&_flg[flgid];
 while((f->flg)&&(!_contlog[_tsk_crt].to)){
   *f->pie=_tsk_crt;
   (f->pie)++;
   _sleep(timeout);
 }
 if(!_contlog[_tsk_crt].to){
   f->flg=1;
 }
 _unlock();
}

void _f_signal(FLG_IDENT flgid)
{
 FLAG *f;
 uschar k;
 _lock();
 f=&_flg[flgid];
 while((f->pie)!=&(f->coada[0])){
   (f->pie)--;
   k=*(f->pie);
   *(f->pie)=MAX_TSK;
   _wakeup(k);
 }
 _unlock();
}

void _s_init(void)
{
 SEMAPHORE	*s;
 uschar j;
 uschar i;
 _lock();
 s=&_sem[0];
 for(j=0;j<MAX_SEM;j++){
   s->pi=NULL;
   for(i=0;i<MAX_TSK;i++){
     s->coada[i]=MAX_TSK;
   }
   s++;
 }
 _unlock();
}

void s_create(SEM_IDENT *semidadr, uschar initval)
{
 SEMAPHORE *s;
 uschar j;
 _lock();
 s=&_sem[0];
 j=0;
 while((s->pi)&&(j<MAX_SEM)){
   s++;
   j++;
 }
 if(j<MAX_SEM){
   s->contor=initval;
   s->pi=&(s->coada[0]);
   s->pe=&(s->coada[0]);
   s->valinit=initval;
 }
 else{
   abort("Eroare in taskul %2d: Tentativa de a crea mai mult de MAX_SEM (%2d) semafoare, _tsk_crt, MAX_SEM");
 }
 *semidadr=j;
 _unlock();
}

void _s_destroy(SEM_IDENT semid)
{
 SEMAPHORE *s;
 _lock();
 s=&_sem[semid];
 if(s->contor!=s->valinit){
   abort("Eroare in taskul %2d: Tentativa de a distruge un semafor (%2d) cu coada nevida!", _tsk_crt, semid);
 }
 else{
   s->pi=NULL;
 }
 _unlock();
}

void _s_wait(SEM_IDENT semid, usint timeout)
{
 SEMAPHORE *s;
 _lock();
 s=&_sem[semid];
 if(--s->contor<0){
   *s->pi=_tsk_crt;
   if(s->pi==&(s->coada[MAX_TSK-1])){
     s->pi=&(s->coada[0]);
   }
   else{
     (s->pi)++;
   }
   do{
     _sleep(timeout);
     if(_contlog[_tsk_crt].to){
       abort("Timeout taskul %2d la semaforul %2d", _tsk_crt, semid);
     }
   }while(_contlog[_tsk_crt].to);
 }
 _unlock();
}

void _s_signal(SEM_IDENT semid)
{
 SEMAPHORE *s;
 uschar k;
 _lock();
 s=&_sem[semid];
 if(++s->contor<=0){
   k=*(s->pe);
   *(s->pe)=MAX_TSK;
   if(s->pe==&(s->coada[MAX_TSK-1])){
     s->pe=&(s->coada[0]);
   }
   else{
     (s->pe)++;
   }
   _wakeup(k);
 }
 _unlock();
}

void _r_init(void)
{
 RESOURCE *r;
 uschar j;
 uschar i;
 _lock();
 r=&_res[0];
 for(j=0;j<MAX_RES;j++){
   r->pi=NULL;
   for(i=0;i<MAX_TSK;i++){
     r->coada[i]=MAX_TSK;
     r->propr=MAX_TSK;
   }
   r++;
 }
 _unlock();
}

void r_create(RES_IDENT *residadr)
{
 RESOURCE *r;
 uschar j;
 _lock();
 r=&_res[0];
 j=0;
 while((r->pi)&&(j<MAX_RES)){
   r++;
   j++;
 }
 if(j<MAX_RES){
   r->contor=1;
   r->pi=&(r->coada[0]);
   r->pe=&(r->coada[0]);
 }
 else{
   abort("Eroare in taskul %2d: Tentativa de a crea mai mult de MAX_RES (%2d) blocuri-resursa!", _tsk_crt, MAX_RES);
 }
 *residadr=j;
 _unlock();
}

void _r_destroy(RES_IDENT resid)
{
 RESOURCE *r;
 _lock();
 r=&_res[resid];
 if(r->contor!=1){
   abort("Eroare in taskul %2d: Tentativa de a distruge un bloc-resursa (%2d) cu coada nevida!", _tsk_crt, resid);
 }
 else{
   r->pi=NULL;
 }
 _unlock();
}

void _r_wait(RES_IDENT resid, usint timeout)
{
 RESOURCE *r;
 _lock();
 r=&_res[resid];
 if(--r->contor<0){
   *r->pi=_tsk_crt;
   if(r->pi==&(r->coada[MAX_TSK-1])){
     r->pi=&(r->coada[0]);
   }
   else{
     (r->pi)++;
   }
   do{
     _sleep(timeout);
     if(_contlog[_tsk_crt].to){
       abort("Timeout taskul %2d la resursa %2d", _tsk_crt, resid);
     }
   }while(_contlog[_tsk_crt].to);
 }
 r->propr=_tsk_crt;
 _unlock();
}

void _r_signal(RES_IDENT resid)
{
 RESOURCE *r;
 uschar k;
  _lock();
 r=&_res[resid];
 if(r->propr!=_tsk_crt){
   abort("Eroare in taskul %2d: Tentativa ilegala de eliberare a resursei %2d (proprietar este taskul %2d)!", _tsk_crt, resid, _res[resid].propr);
 }
 else{
   if(++r->contor<=0){
     k=*(r->pe);
     *(r->pe)=MAX_TSK;
     if(r->pe==&(r->coada[MAX_TSK-1])){
       r->pe=&(r->coada[0]);
     }
     else{
       (r->pe)++;
     }
     _wakeup(k);
   }
 }
 r->propr=MAX_TSK;
 _unlock();
}

void _e_init(void)
{
 EVENT *e;
 uschar j;
 uschar i;
 _lock();
 e=&_evn[0];
 for(j=0;j<MAX_EVN;j++){
   e->pie=NULL;
   for(i=0;i<MAX_TSK;i++){
     e->coada[i]=MAX_TSK;
   }
   e++;
 }
 _unlock();
}

void e_create(EVN_IDENT *evnidadr)
{
 EVENT *e;
 uschar j;
 _lock();
 e=&_evn[0];
 j=0;
 while((e->pie)&&(j<MAX_EVN)){
   e++;
   j++;
 }
 if(j<MAX_EVN){
   e->pie=&(e->coada[0]);
 }
 else{
   abort("Eroare in taskul %2d: Tentativa de a crea mai mult de MAX_EVN (%2d) blocuri-eveniment", _tsk_crt, MAX_EVN);
 }
 *evnidadr=j;
 _unlock();
}

void _e_destroy(EVN_IDENT evnid)
{
 EVENT *e;
 _lock();
 e=&_evn[evnid];
 if(e->pie!=&(e->coada[0])){
   abort("Eroare in taskul %2d: Tentativa de a distruge un bloc-eveniment (%2d) cu coada nevida!", _tsk_crt, evnid);
 }
 else{
   e->pie=NULL;
 }
 _unlock();
}

void _e_wait(EVN_IDENT evnid, usint timeout)
{
 EVENT *e;
 _lock();
 e=&_evn[evnid];
 *e->pie=_tsk_crt;
 (e->pie)++;
 do{
   _sleep(timeout);
   if(_contlog[_tsk_crt].to){
     abort("Timeout taskul %2d la evenimentul %2d", _tsk_crt, evnid);
   }
 }while(_contlog[_tsk_crt].to);
 _unlock();
}

void _e_signal(EVN_IDENT evnid)
{
 EVENT *e;
 uschar k;
 _lock();
 e=&_evn[evnid];
 while(e->pie!=&(e->coada[0])){
   (e->pie)--;
   k=*(e->pie);
   *(e->pie)=MAX_TSK;
   _wakeup(k);
 }
 _unlock();
}

void _me_init(void)
{
 MULTIEVENT *m;
 uschar j;
 uschar i;
 _lock();
 m=&_me[0];
 for(j=0;j<MAX_ME;j++){
   m->nfree=0;
   for(i=0;i<MAX_TSK;i++){
     m->for_me[i].mask=0;
   }
   m++;
 }
 _unlock();
}

void me_create(ME_IDENT *meidadr)
{
 MULTIEVENT *m;
 uschar j;
 uschar i;
 _lock();
 m=&_me[0];
 j=0;
 while((m->nfree)&&(j<MAX_ME)){
   m++;
   j++;
 }
 if(j<MAX_ME){
   m->nfree=1;
   for(i=0;i<MAX_TSK;i++){
     m->for_me[i].mask=0;
   }
 }
 else{
   abort("Eroare in taskul %2d: Tentativa de a crea mai mult de MAX_ME (%2d) blocuri-multieveniment", _tsk_crt, MAX_ME);
 }
 *meidadr=j;
 _unlock();
}

void _me_destroy(ME_IDENT meid)
{
 MULTIEVENT *me;
 uschar j;
 _lock();
 me=&_me[meid];
 j=0;
 while((me->for_me[j].mask==0)&&(j<MAX_TSK)){
   j++;
 }
 if(j<MAX_TSK){
   abort("Eroare in taskul %2d: Tentativa de a distruge un bloc-multieveniment (%2d) cu coada nevida!", _tsk_crt, meid);
 }
 else{
   me->nfree=0;
 }
 _unlock();
}

void _me_wait(uschar meid, usshort evv,
				usshort msk, usshort op, usint timeout)
{
 FOR_ME *fm;
 _lock();
 fm=&_me[meid].for_me[_tsk_crt];
 fm->evntval=msk&(evv^op);
 fm->mask=msk;
 fm->oper=op;
 do{
     _sleep(timeout);
     if(_contlog[_tsk_crt].to){
       abort("Timeout taskul %2d la multievenimentul %2d", _tsk_crt, meid);
	 }
   }while(_contlog[_tsk_crt].to);
 _unlock();
}

void _me_signal(uschar meid, usshort evv)
{
 FOR_ME *fm;
 uschar k;
 uschar aux;
 _lock();
 fm=&_me[meid].for_me[0];
 for(k=0;k<MAX_TSK;k++){
   if(fm->mask){
     aux=(fm->evntval==((fm->mask)&evv));
     if(((!(fm->oper))&&(aux))||((fm->oper)&&(!aux))){
       fm->mask=0;
       _wakeup(k);
     }
   }
   fm++;
 }
 _unlock();
}

void _rv_init(void)
{
 RENDEZ_VOUS *rv;
 uschar j;
 uschar i;
 _lock();
 rv=&_rv[0];
 for(j=0;j<MAX_RV;j++){
   rv->contor=0;
   for(i=0;i<MAX_TSK;i++){
     rv->coada[i]=MAX_TSK;
   }
   rv++;
 }
 _unlock();
}

void rv_create(RV_IDENT *rvidadr, uschar ntv, usint timeout)
{
 RENDEZ_VOUS *rv;
 uschar j;
 _lock();
 rv=&_rv[0];
 j=0;
 while((rv->contor)&&(j<MAX_RV)){
   rv++;
   j++;
 }
 if(j<MAX_RV){
   rv->contor=ntv;
   rv->pie=&(rv->coada[0]);
   rv->timeout=timeout;
   rv->status=0;
 }
 else{
   abort("Eroare in taskul %2d: Tentativa de a crea mai mult de MAX_RV (%2d) blocuri-rendez_vous", _tsk_crt, MAX_RV);
 }
 _unlock();
 *rvidadr=j;
}

void _rv_destroy(RV_IDENT rvid)
{
 RENDEZ_VOUS *rv;
 _lock();
 rv=&_rv[rvid];
 if(rv->pie!=&(rv->coada[0])){
   abort("Eroare in taskul %2d: Tentativa de a distruge un bloc-rendez_vous (%2d) cu coada nevida!", _tsk_crt, rvid);
 }
 else{
   rv->contor=0;
 }
 _unlock();
}

void _rv_signal(uschar rvid)
{
 RENDEZ_VOUS *rv;
 uschar k;
 _lock();
 rv=&_rv[rvid];
 rv->contor--;
 if(!(rv->contor)){
   rv->status=0;
   while(rv->pie!=&(rv->coada[0])){
     rv->pie--;
     k=*(rv->pie);
     *(rv->pie)=MAX_TSK;
     _wakeup(k);
   }
 }
 else{
   *(rv->pie)=_tsk_crt;
   rv->pie++;
   _sleep(rv->timeout);
   if(rv->contor){
     rv->status=1;
     rv->contor=0;
     while(rv->pie!=&(rv->coada[0])){
       rv->pie--;
       k=*(rv->pie);
       *(rv->pie)=MAX_TSK;
       _wakeup(k);
     }
   }
 }
 _contlog[_tsk_crt].to|=rv->status;
 _unlock();
}

void _p_init(void)
{
 PIPE *p;
 uschar j;
 _lock();
 p=&_pp[0];
 for(j=0;j<MAX_PP;j++){
   p->ps=NULL;
   p->pc=NULL;
   p->itp=0xff;
   p->itc=0xff;
   p++;
 }
 _unlock();
}

void p_create(PP_IDENT *ppidadr, uschar prod, uschar cons)
{
 PIPE *p;
 uschar j;
 _lock();
 p=&_pp[0];
 j=0;
 while((p->ps!=NULL)&&(j<MAX_PP)){
   p++;
   j++;
 }
 if(j<MAX_PP){
   p->itp=prod;
   p->itc=cons;
   p->rs=0;
   p->rc=0;
   p->nocumul=0;
   p->ps=&(p->conducta[0]);
   p->pc=&(p->conducta[0]);
 }
 else{
   abort("Eroare in taskul %2d: Tentativa de a crea mai mult de MAX_PP (%2d) conducte!", _tsk_crt, MAX_PP);
 }
 *ppidadr=j;
 _unlock();
}

void _p_destroy(PP_IDENT ppid)
{
 PIPE *p;
 _lock();
 p=&_pp[ppid];
 if(p->rs||p->rc){
   abort("Eroare in taskul %2d: Tentativa de a distruge o conducta (%2d) nevida!", _tsk_crt, ppid);
 }
 else{
   p->ps=NULL;
   p->itp=0xff;
   p->itc=0xff;
 }
 _unlock();
}

void p_receive(PP_IDENT ppid, void *pdata, usshort ldata)
{
 PIPE *p;
 uschar *q;
 usshort noc;
 _lock();
 p=&_pp[ppid];
 if(_tsk_crt!=p->itc){
   abort("Eroare in taskul %2d: taskul curent nu este asociat drept consumator la conducta %2d!", _tsk_crt, ppid);
 }
 else{
   q=(uschar *)pdata;
   noc=ldata;
   while(noc){
     if(p->nocumul){
       *q++=*p->pc;
       if(p->pc==&(p->conducta[DIM_COND-1])){
         p->pc=&(p->conducta[0]);
       }
       else{
         p->pc++;
       }
       noc--;
       p->nocumul--;
       if(noc&&(p->rs)&&(p->rs<=(DIM_COND-(p->nocumul)))){
         p->rc=noc;
		 p->rs=0;
         _wakeup(p->itp);
         while(p->rc){
           _sleep(0);
         }
       }
     }
     else{
       p->rc=noc;
       if(p->rs){
         p->rs=0;
         _wakeup(p->itp);
       }
       while(p->rc){
         _sleep(0);
       }
     }
   }
   if(p->rs){
     p->rs=0;
	 _wakeup(p->itp);
   }
 }
 _unlock();
}

void p_send(PP_IDENT ppid, void *pdata, usshort ldata)
{
 PIPE *p;
 uschar *q;
 usshort nos;
 _lock();
 p=&_pp[ppid];
 if(_tsk_crt!=p->itp){
   abort("Eroare in taskul %2d: taskul curent nu este asociat drept producator la conducta %2d!", _tsk_crt, ppid);
 }
 else{
   q=(uschar *)pdata;
   nos=ldata;
   while(nos){
	 if(p->nocumul<DIM_COND){
       *p->ps=*q++;
       if(p->ps==&(p->conducta[DIM_COND-1])){
         p->ps=&(p->conducta[0]);
       }
       else{
         p->ps++;
       }
       nos--;
       p->nocumul++;
     }
     else{
       p->rs=nos;
       if(p->rc){
         p->rc=0;
         _wakeup(p->itc);
       }
       while(p->rs){
         _sleep(0);
       }
	 }
   }
   if(p->rc){
     p->rc=0;
     _wakeup(p->itc);
   }
 }
 _unlock();
}

void _mb_init(void)
{
 MAILBOX *m;
 uschar j;
 uschar i;
 _lock();
 m=&_mb[0];
 for(j=0;j<MAX_MB;j++){
   m->ps=NULL;
   for(i=0;i<MAX_TSK;i++){
	 m->s1.coada[i]=MAX_TSK;
     m->s2.coada[i]=MAX_TSK;
     m->s3.coada[i]=MAX_TSK;
   }
   m++;
 }
 _unlock();
}

void mb_create(MB_IDENT *mbidadr)
{
 MAILBOX *m;
 uschar j;
 _lock();
 m=&_mb[0];
 j=0;
 while((m->ps!=NULL)&&(j<MAX_MB)){
   m++;
   j++;
 }
 if(j<MAX_MB){
   _mb[j].s1.contor=1;
   _mb[j].s1.pi=&(_mb[j].s1.coada[0]);
   _mb[j].s1.pe=&(_mb[j].s1.coada[0]);
   _mb[j].s2.contor=0;
   _mb[j].s2.pi=&(_mb[j].s2.coada[0]);
   _mb[j].s2.pe=&(_mb[j].s2.coada[0]);
   _mb[j].s3.contor=DIM_CP;
   _mb[j].s3.pi=&(_mb[j].s3.coada[0]);
   _mb[j].s3.pe=&(_mb[j].s3.coada[0]);
   m->ps=&(m->buf[0]);
   m->pc=&(m->buf[0]);
 }
 else{
   abort("Eroare in taskul %2d: Tentativa de a crea mai mult de MAX_MB (%2d) cutii postale!", _tsk_crt, MAX_MB);
 }
  *mbidadr=j;
 _unlock();
}

void _mb_destroy(MB_IDENT mbid)
{
 MAILBOX *m;
 _lock();
 m=&_mb[mbid];
 if(m->ps!=m->pc){
   abort("Eroare in taskul %2d: Tentativa de a distruge o cutie postala (%2d) nevida!", _tsk_crt, mbid);
 }
 else{
   m->ps=NULL;
 }
 _unlock();
}

void mb_receive(MB_IDENT mbid, void *pdata, MB_IDENT *prodindadr)
{
 SEMAPHORE *p1, *p2, *p3;
 uschar k;
 uschar indprd;
 usshort ldata;
 char *p, *q;
 _lock();
 p1=&_mb[mbid].s1;
 p2=&_mb[mbid].s2;
 p3=&_mb[mbid].s3;
 if(--p2->contor<0){
   *p2->pi=_tsk_crt;
   if(p2->pi==&(p2->coada[MAX_TSK-1])){
     p2->pi=&(p2->coada[0]);
   }
   else{
     p2->pi++;
   }
   _sleep(0);
 }
 if(--p1->contor<0){
   *p1->pi=_tsk_crt;
   if(p1->pi==&(p1->coada[MAX_TSK-1])){
     p1->pi=&(p1->coada[0]);
   }
   else{
     p1->pi++;
   }
   _sleep(0);
 }
 p=(char *)pdata;
 q=(char *)(_mb[mbid].pc->pd);
 ldata=_mb[mbid].pc->ld;
 while(ldata--){
   *p++=*q++;
 }
 indprd=_mb[mbid].pc->ip;
 if(_mb[mbid].pc==&(_mb[mbid].buf[DIM_CP-1])){
   _mb[mbid].pc=&(_mb[mbid].buf[0]);
 }
 else{
   _mb[mbid].pc++;
 }
 if(++p3->contor<=0){
   k=*(p3->pe);
   *(p3->pe)=MAX_TSK;
   if(p3->pe==&(p3->coada[MAX_TSK-1])){
     p3->pe=&(p3->coada[0]);
   }
   else{
     p3->pe++;
   }
   _wakeup(k);
 }
 if(++p1->contor<=0){
   k=*(p1->pe);
   *(p1->pe)=MAX_TSK;
   if(p1->pe==&(p1->coada[MAX_TSK-1])){
     p1->pe=&(p1->coada[0]);
   }
   else{
     p1->pe++;
   }
   _wakeup(k);
 }
 *prodindadr=indprd;
 _unlock();
}

void mb_send(MB_IDENT mbid, void *pdata, usshort ldata)
{
 SEMAPHORE *p1, *p2, *p3;
 uschar k;
 _lock();
 p1=&_mb[mbid].s1;
 p2=&_mb[mbid].s2;
 p3=&_mb[mbid].s3;
 if(--p3->contor<0){
   *p3->pi=_tsk_crt;
   if(p3->pi==&(p3->coada[MAX_TSK-1])){
	 p3->pi=&(p3->coada[0]);
   }
   else{
	 p3->pi++;
   }
   _sleep(0);
 }
 if(--p1->contor<0){
   *p1->pi=_tsk_crt;
   if(p1->pi==&(p1->coada[MAX_TSK-1])){
	 p1->pi=&(p1->coada[0]);
   }
   else{
	 p1->pi++;
   }
   _sleep(0);
 }
 _mb[mbid].ps->pd=pdata;
 _mb[mbid].ps->ld=ldata;
 _mb[mbid].ps->ip=_tsk_crt;
 if(_mb[mbid].ps==&(_mb[mbid].buf[DIM_CP-1])){
   _mb[mbid].ps=&(_mb[mbid].buf[0]);
 }
 else{
   _mb[mbid].ps++;
 }
 if(++p2->contor<=0){
   k=*(p2->pe);
   *(p2->pe)=MAX_TSK;
   if(p2->pe==&(p2->coada[MAX_TSK-1])){
	 p2->pe=&(p2->coada[0]);
   }
   else{
	 p2->pe++;
   }
   _wakeup(k);
 }
 if(++p1->contor<=0){
   k=*(p1->pe);
   *(p1->pe)=MAX_TSK;
   if(p1->pe==&(p1->coada[MAX_TSK-1])){
	 p1->pe=&(p1->coada[0]);
   }
   else{
	 p1->pe++;
   }
   _wakeup(k);
 }
 _unlock();
}

int _getch(void)
{
 _s_wait(chravail, 0);
 return(getch());
}

void _kbwait(void)
{
 _s_wait(chravail, 0);
}