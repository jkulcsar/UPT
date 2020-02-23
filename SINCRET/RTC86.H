#ifndef __RTC86_H
#define __RTC86_H

#define NECREAT	0
#define CREAT		1
#define GATA		2
#define BLOCAT		3
#define EXECUTIE	4

#define MAX_TSK 11
#define MAX_PRIOR MAX_TSK
#define MAX_FLG 1
#define MAX_SEM 10
#define MAX_RES 3
#define MAX_EVN 5
#define MAX_ME 1
#define MAX_RV 1
#define MAX_PP 4
#define MAX_MB 2

#define DIM_COND 256
#define DIM_CP 64

#define DIM_1_STIVA 512
#define DIM_ZONA_STIVE MAX_TSK*DIM_1_STIVA
#define LIM_INF _psp
#define LIM_SUP 0x9FFF

#define INT_ACK 0x20
#define PORT_CDA_8259 0X20

#define _AND_ 0x0000
#define _OR_ 0xffff
#define uschar unsigned char
#define usshort unsigned short
#define usint  unsigned int
#define uslong unsigned long

#define TASK void far cdecl
typedef TASK (*TASK_ADR)(void);

#define HANDLER void interrupt
typedef HANDLER (*HANDLER_ADR)(...);
typedef struct{
		usint bp, di, si, ds, es, dx, cx, bx, ax;
          union{
            TASK_ADR cs_ip;
            struct{
              usint ip;
	      usint cs;
	    }cai;
	  }adr;
	  usint f;
	   }CONTFIZ;

typedef HANDLER(*HANDLER_CF_ADR)(CONTFIZ);

#define TASK_IDENT uschar

#define TSK_IDENT uschar

#define FLG_IDENT uschar

#define SEM_IDENT uschar

#define RES_IDENT uschar

#define EVN_IDENT uschar

#define ME_IDENT uschar

#define RV_IDENT uschar

#define PP_IDENT uschar

#define MB_IDENT uschar

#define _declare(tskid, tsknm) TASK_IDENT tskid;TASK tsknm(void)

void _init(void);
void create(TASK_IDENT *tskidadr, TASK_ADR runadr, uschar prior, usshort stksz, void *dadr);
#define _create(tskid, runadr, prior, stksz, data) create(&tskid, runadr, prior, stksz, &data)
void _destroy(TASK_IDENT tskid);
void _activate(TASK_IDENT tskid);
void _disactivate(TASK_IDENT tskid);
void _sleep(usint timeout);
void _wakeup(TASK_IDENT tskid);
void _run(usshort period);
HANDLER _endmt(void);

void _beg_cr(void);
void _end_cr(void);

void _lock_70(void);
void _unlock_70(void);

#define _execute _init();
#define _exit() };{

#define _install() _init()

#define _lock() asm{pushf; cli;}
#define _unlock() asm{popf;}

//#define _lock() _lock_70()
//#define _unlock() _unlock_70()

#define _cli() asm{cli;}

void _setvect(uschar intnumb, HANDLER_ADR newvect);
void _restvect(uschar intnumb);

#define _a_wait(flag) asm{flag db 0; mov al, 1; \
			 loop xchg al, flag; or al, al; jnz loop;}
#define _a_signal(flag) asm{mov, flag, 0;}

void _f_init(void);
void f_create(FLG_IDENT *flgidadr);
#define _f_create(flgid) f_create(&flgid)
void _f_destroy(FLG_IDENT flgid);
void _f_wait(FLG_IDENT flgid, usint timeout);
void _f_signal(FLG_IDENT flgid);
//#define _f_wait(flgid, timeout) f_wait(flgid, timeout);{
//#define _f_signal(flgid) }f_signal(flgid)

void _s_init(void);
void s_create(SEM_IDENT *semidadr, uschar initval);
#define _s_create(semid, initval) s_create(&semid, initval)
void _s_destroy(SEM_IDENT semid);
void _s_wait(SEM_IDENT semid, usint timeout);
void _s_signal(SEM_IDENT semid);
//#define _s_wait(semid, timeout) s_wait(semid, timeout);{
//#define _s_signal(semid) }s_signal(semid)

void _r_init(void);
void r_create(RES_IDENT *residadr);
#define _r_create(resid) r_create(&resid)
void _r_destroy(RES_IDENT resid);
void _r_wait(RES_IDENT resid, usint timeout);
void _r_signal(RES_IDENT resid);
//#define _r_wait(resid, timeout) r_wait(resid, timeout);{
//#define _r_signal(resid) }r_signal(resid)

void _e_init(void);
void e_create(EVN_IDENT *evnidadr);
#define _e_create(evnid) e_create(&evnid)
void _e_destroy(EVN_IDENT evnid);
void _e_wait(EVN_IDENT evnid, usint timeout);
void _e_signal(EVN_IDENT evnid);
//#define _e_wait(evnid, timeout) e_wait(evnid, timeout);{
//#define _e_signal(evnid) }e_signal(evnid)

void _me_init(void);
void me_create(ME_IDENT *meidadr);
#define _me_create(meid) me_create(&meid)
void _me_destroy(ME_IDENT meid);
void _me_wait(uschar meid, usshort evv,
				usshort msk, usshort op, usint timeout);
void _me_signal(uschar meid, usshort evv);
//#define _me_wait(meid, evv, msk, op, timeout) me_wait(meid, evv, msk, op, timeout);{
//#define _me_signal(meid, evv) }me_signal(meid, evv)

void _rv_init(void);
void rv_create(RV_IDENT *rvidadr, uschar ntv, usint timeout);
#define _rv_create(rvid, ntv, timeout) rv_create(&rvid, ntv, timeout)
void _rv_destroy(RV_IDENT rvid);
void _rv_signal(uschar rvid);

void _p_init(void);
void p_create(PP_IDENT *ppidadr, uschar prod, uschar cons);
#define _p_create(ppid, prod, cons) p_create(&ppid, prod, cons)
void _p_destroy(PP_IDENT ppid);
void p_receive(PP_IDENT ppid, void *pdata, usshort ldata);
void p_send(PP_IDENT ppid, void *pdata, usshort ldata);
#define _p_receive(ppid, dataid) p_receive(ppid, &dataid, sizeof(dataid))
#define _p_send(ppid, dataid) p_send(ppid, &dataid, sizeof(dataid))

void _mb_init(void);
void mb_create(MB_IDENT *mbidadr);
#define _mb_create(mbid) mb_create(&mbid)
void _mb_destroy(MB_IDENT mbid);
void mb_receive(MB_IDENT mbid, void *pdata, MB_IDENT *prodindadr);
void mb_send(MB_IDENT mbid, void *pdata, usshort ldata);
#define _mb_receive(mbid, dataid, prodid) mb_receive(mbid, &dataid, &prodid)
#define _mb_send(mbid, dataid) mb_send(mbid, &dataid, sizeof(dataid))

void tochk(uschar *flgadr);
#define _tochk(to) tochk(&to)

int _getch(void);

void _kbwait(void);

#endif