
;Comment:	Nucleul unui driver instalabil care nu face decit sa se
;		instaleze corect. Mai ramin de implementat rutinele concrete
;		de in/out.
;Istoric:	-
;------------------------------------------------------------------------------


	name	driver
	page	66,132
	title	'DEVICE DRIVER ... schelet instalabil'

	Max_Cmd		equ	16
	cr		equ	0Dh
	lf		equ	0Ah
	eom		equ	'$'

;
;Driver-ul se organizeaza ca si un program COM dar cu ORG 0
;Un driver nu are PSP
;

code	segment	para	public	'CODE'
	assume	cs:code, ds:code, es:code, ss:code
driver  proc	far
;
	org	0
;
;Header driver instalabil
;
	Header	dd	-1		;legatura cu driver-ul urmator
					;-1 == sfirsit lista
		dw	8000h		;cuvint atribut driver
					;bit 15 =1 ==> dispozitiv caracter
		dw	Strat		;offset rutina strategica
		dw	Intr		;offset rutina intrerupere
		db	'DRIVER  '	;nume driver caracter

;
;Pointer la structura REQUEST
;Adresa de inceput a structurii request este transmisa de catre SO
;rutinei strategice prin ES:BX, iar aceasta o salveaza in locatia de mai jos
;
	RH_Ptr	dd	?
;
;Tabloul cu adresele rutinelor ce implementeaza driver-ul.
;Rutina de intrerupere foloseste acest tablou precum si 
;cimpul COMMAND din structura Request pentru a apela rutina
;dorita
;
Dispatch:
	dw	Init		; 0  = Initializare driver
	dw	Media_Chk	; 1  = media check (bloc)
	dw	Build_BPB	; 2  = cost. bloc param BIOS
	dw	IOCTL_Rd	; 3  = I/O control read
	dw	Read		; 4  = citire de la dispozitiv
	dw	ND_Read		; 5  = citire nedistructiva
	dw	Inp_Stat	; 6  = intoarce stare curenta citire
	dw	Inp_Flush	; 7  = golire buffer dispozitiv intrare
	dw	Write		; 8  = scriere la dispozitiv
	dw	Write_Vfy	; 9  = scriere cu verificare
	dw	Outp_Stat	; 10 = intoarce stare curenta iesire
	dw	Outp_Flush	; 11 = golire buffer dispozitiv iesire
	dw	IOCTL_Wrt	; 12 = I/O control write
	dw	Dev_Open	; 13 = deschidere dispozitiv
	dw	Dev_Close	; 14 = inchidere dispozitiv
	dw	Rem_Media	; 15 = mediu interschimbabil
	dw	Out_Busy	; 16 = iesire pina la Busy
;
;
;Structura REQUEST prin care SO transfera informatii driver-ului
;si prin care acesta intoarce informatie in SO
;Atentie! Tot ce este cuprins intre <struc> si <ends>
;constituie declaratia unui nou tip de date. NU se aloca memorie!
;
Request		struc
		Rlenght		db	?	;lungimea structurii request
		Unit		db	?	;numar unitate
		Command		db	?	;cod comanda (corespunde
						;unei rutine)
		Status		dw	?	;cuvintul de stare intors de
						;driver 
						; - bit 15 = Eroare
						; - bit 10-14 = Rezervati
						; - bit 9 = Busy
						; - bit 8 = Done
						; - bit 0-7 = Cod eroare
		Reserve		db	8 dup(?);zona rezervata
		Media		db	?	;octet descriptor mediu
		Address		dd	?	;adresa zonei de memorie pentru
						;transfer
		Count		dw	?	;valoare contor octet/sector
		Sector		dw	?	;nr. de ordine al primului sector
Request		ends
;
;
;De fiecare data cind se lanseaza o cerere catre dispozitivul corespunzator
;intii se apeleaza rutina strategica, apoi rutina de intrerupere
;
;Rutinei strategice i se transmite adresa structurii REQUEST prin ES:BX, care
;este salvata in locatii de memorie apoi se revine in MS-DOS
;
Strat	proc	far
	mov	word ptr cs:[RH_Ptr], bx
	mov	word ptr cs:[RH_Ptr+2], es
	ret
Strat	endp
;
;Acest punct (adresa) este apelat de MS-DOS imediat dupa
;apelarea rutinei strategice. Rutina de intrerupere foloseste
;codul inscris in cimpul COMMAND din structura REQUEST pentru a
;determina rutina efectiva care se va executa. Rutina inscrie 
;in cimpul Status informatie de intoarcere
;
Intr	proc	far
	push	ax 
	push	bx 
	push	cx 
	push	dx 
	push	ds 
	push	es 
	push	di 
	push	si
	push	bp

	push	cs	;astfel datele locale devin adresabile 
	pop	ds

	les	di, [RH_Ptr]		;ES:DI = Adresa structurii REQUEST
	mov	bl, es:[di.Command]
	xor	bh, bh			;BX = Cod rutina

	cmp	bx, Max_Cmd		;trebuie sa fie cod corect
	jle	ok
	mov	ax, 8003h		;cod eroare: rutina necunoscuta
	jmp	out_drv
ok:	
	shl	bx, 1			;BX=BX*2 => index in tabela de salturi
	call	word ptr [bx+Dispatch]	;se apeleaza rutina corespunzatoare
					;trebuie sa returneze un cod in AX
	les	di, [RH_Ptr]		;se reface ES:DI ca si mai sus
;
out_drv:
	or	ax, 0100h		;inscrie bitul DONE in status
	mov	es:[di.Status], ax	;si salveaza-l in REQUEST

	pop	bp
	pop	si
	pop	di
	pop	es
	pop	ds
	pop	dx
	pop	cx
	pop	bx
	pop	ax

	ret				;revenire in MS-DOS
;
;Driver-ul fiind un drv model, nu va implementa efectiv
;rutinele. Corpul lor depinde de la dispozitiv la disp.
;si de la cuplor la cuplor
;
;
Media_Chk	proc	near
		xor	ax, ax
		ret
Media_Chk	endp
;
;
Build_BPB	proc	near
		xor	ax, ax
		ret
Build_BPB	endp
;
;
IOCTL_Rd	proc	near
		xor	ax, ax
		ret
IOCTL_Rd	endp
;
;
Read		proc	near
		xor	ax, ax
		ret
Read		endp
;
;
ND_Read		proc	near
		xor	ax, ax
		ret
ND_Read		endp
;
;
Inp_Stat	proc	near
		xor	ax, ax
		ret
Inp_Stat	endp
;
;
Inp_Flush	proc	near
		xor	ax, ax
		ret
Inp_Flush	endp
;
;
Write		proc	near
		xor	ax, ax
		ret
Write		endp
;
;
Write_Vfy	proc	near
		xor	ax, ax
		ret
Write_Vfy	endp
;
;
Outp_Flush	proc	near
		xor	ax, ax
		ret
Outp_Flush	endp
;
;
IOCTL_Wrt	proc	near
		xor	ax, ax
		ret
IOCTL_Wrt	endp
;
;
Outp_Stat	proc	near
		xor	ax, ax
		ret
Outp_Stat	endp
;
;
Dev_Open	proc	near
		xor	ax, ax
		ret
Dev_Open	endp
;
;
Dev_Close	proc	near
		xor	ax, ax
		ret
Dev_Close	endp
;
;
Rem_Media	proc	near
		xor	ax, ax
		ret
Rem_Media	endp
;
;
Out_Busy	proc	near
		xor	ax, ax
		ret
Out_Busy	endp
;
;
;
;
;Rutina de initializare are sarcinile: sa initializeze perifericul,
;sa completeze pozitii in TVI (Tabela Vectori Intreruperi), 
;sa determine prima adresalibera. In cazul nostru adresa aceasta coincide
;cu adresa rutinei Init, astfel aceasta va fi rescrisa de driver-ul
;urmator
;
Init	proc	near
	push	es
	push	di
	mov	ax, cs
	mov	bx, offset DHaddr
	call	hexasc
	mov	ah, 9
	mov	dx, offset Ident
	int	21h
	pop	di
	pop	es
	mov	word ptr es:[di.Address], offset init
	mov	word ptr es:[di.Address+2], cs
	xor	ax, ax
	ret
Init	endp
;
Ident	db	cr,lf,lf
	db	'Exemplu driver instalabil', cr,lf
	db	'Adresa Header la '
 DHAddr	db	'xxxx:0000'
	db	cr,lf,lf,eom
Intr	endp
;
;
;Rutina 'hexasc' converteste un numar pe 16 biti in sir ASCII
;Intrari:	AX = valoare de convertit
;		DS:BX = adresa de inceput a sirului
;Iesiri:	AX, BX distrusi
;
hexasc	proc	near
	push	cx
	push	dx
	mov	dx,4
ha1:
	mov	cx, 4
	rol	ax, cl
	mov	cx, ax
	and	cx, 0Fh
	add	cx,'0'
	cmp	cx,'9'
	jbe	ha2
	add	cx, 'A'-'9'-1
ha2:
	mov	[bx], cl
	inc	bx
	dec	dx
	jnz	ha1
	
	pop	dx
	pop	cx
	ret
hexasc	endp
;
driver	endp
;
code 	ends
	end	;End of file ...





