

        org $a00
* aici se plaseaza datele de intrare in format BCD signed
datain  dc.b $80,$00,$00,$00,$00,$00,$00,$00

* aici va rezulta conversia BCD2ASCII in formatul
* byte  1   semn
* byte  7*2 number digits
* total 15  digits EX: -12345678901234h
dataout	dc.b $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00 

* aici se gaseste tabela de conversie BCD2HEX (0123456789ABCDEF)
aschex  dc.b 48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70

        org $50
	lea.l datain,a0		; a0 adresa la numarul BCD
	lea.l dataout,a1	; a1 adresa la numarul ASCII
	lea.l aschex,a2		; a2 adresa la tabela de conversie
	move.b (a0)+,d1		; in d1 octetul de semn
	btst.l #7,d1		; testeaza MSB (semn)
        beq pozitiv		; if MSB=0 then pozitiv 
	move.b #45,d1		;   in d1 ASCII '-'  
	jmp always		; fill ASCII
pozitiv move.b #43,d1		; else ASCII '+'
always	move.b d1,(a1)+		;  put 2 destination
    	move.b #7,d0		; seteaza contorul de bucla (7*8 bytes)
bucla	move.b (a0)+,d1		; next BCD byte
	move.b d1,d5		;   se salveaza d1 in d5
	andi.b #$f0,d1		; mascheaza digitul LSB
        ror.b #4,d1		; roteste pe pozitia LSB
	move.b (a2,d1),d4	; converteste in ASCII MSB digit
	move.b d4,(a1)+		; pune digitul MSB in destinatie
	move.b d5,d1		;  restaureaza octetul care trebuie convertit
	andi.b #$0f,d1		; mascheaza MSB
	move.b (a2,d1),d4	; conversie
	move.b d4,(a1)+		; pune digitul LSB in destinatie
	subi.b #$01,d0		; verifica daca a ajuns contorul la zero
	bne bucla		; 7 iteratii
	nop

	
	
        

 
