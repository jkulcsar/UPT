
;Comment:	Driver instalabil care afiseaza ceasul, fara a deranja
;		functionarea sistemului
;Istoric:	-
;------------------------------------------------------------------------------


	name	driver
	page	66,132
	title	'TIMER DEVICE DRIVER ... '

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
		db	'DRVCLK  '	;nume driver caracter

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
Dispatch:			; Tablou dispatch degenerat
	dw	Init		; 0  = Initializare driver
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
	xor	bx, bx			;BX = Cod rutina = Apel rutina init si atit
	call	word ptr [bx+Dispatch]	;se apeleaza rutina corespunzatoare
					;trebuie sa returneze un cod in AX
	les	di, [RH_Ptr]		;se reface ES:DI ca si mai sus
;
	or	ax, 0100h		;inscrie bitul DONE in status
	mov	es:[di.Status], ax	;si salveaza-l in REQUEST
;
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
Intr	endp
;
;
TimeInt	proc	far
	jmp	startint
;
	cont18	db	18		;contor trecere o secunda
	cont90	db	90		;contor corectie
	orez	db	'0'		;cifra pentru ore zeci
	ore	db	'0'		;cifra pentru ore unitati
		db	':'		;separator
	minz	db	'0'		;cifra pentru minute zeci
	min	db	'0'		;cifra pentru minute unitati
		db	':'		;separator
	secz	db	'0'		;cifra pentru secunde zeci
	sec	db	'0'		;cifra pentru secunde unitati
;
startint:
	push	ds
	push	cs
	pop	ds
	push	ax			;ne mai trebuie
	dec	[cont18]		;doar la cite 18 intreruperi trece
					;o secunda
	jz	gata_sec
	jmp	timeout			;pina atunci iesim din intrerupere
;
gata_sec:
	call	afis
	mov	al, 18
	mov	[cont18], al
	dec	[cont90]
	jnz	incsec
	mov	[cont90], 90
	jmp	timeout			;corectie ceas
incsec:
	inc	[sec]			;tic-tac
	cmp	[sec], '9'		;am ajuns la zeci de secunde?
	jle	timeout			;daca nu, gata
	mov	[sec],'0'		;daca da, secunde unitati pe 0
	inc	[secz]			;incr. zeci de secunde
	cmp	[secz],'6'		;a trecut un minut?
	jl	timeout			;daca nu, gata
	mov	[secz], '0'		;etc..
	inc	[min]
	cmp	[min], 9
	jle	timeout
	mov	[min], '0'
	inc	[minz]
	cmp	[minz],'6'
	jl	timeout
	mov	[minz], '0'
	inc	[ore]
	cmp	[ore], '4'
	jz	gata_zi
	cmp	[ore],'9'
	jl	timeout
	mov	[ore], '0'
	inc	[orez]
gata_zi:
	cmp	[orez], '2'
	jl	timeout
	mov	




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





