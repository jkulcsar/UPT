	  org $100

* 1xxxxxxx .1111 .1111 .. 8 octeti 8*8=64 biti
*   1octet    1octet
*
*  vor fi necesare 2 reg pe 32 biti pentru numar bcd
*  1 octet pentru semn

nrocteti   equ 8				;numarul de octeti de dupa semn
semn       dc.b 128				; semnul bcd 7 Lsb nesemnificativi
bcdnr      dc.b $10,$20,$30,$40,$50,$60,$70,$80	; numarul in bcd fara semn

	   org $50

* total 72 biti
           move.b semn,d0			; pune in d0 semnul
           btst d0,7				; testesaza bitul 7
           beq pozitiv				; daca=0 atunci bcd pozitiv
*	   write -				; altfel negativ
	   jmp always
pozitiv   
* 	   write +	
always
           move.w #bcdnr,(A0)			; incarca in a0 adresa de unde ince nr bcd
	   move.b nrocteti,d1			; in d1 nr de octeti
nextdig
	   move.b (a0),d2			; in d2 primii 2 digiti MSB
	   move.b d2,-(a7)			; salveaxa d2 in stiva
	   and.b $f0,d2				; mascheaza MSB digit
	   ror.b #4,d2				; muta pe pozitia LSB
*	   call	 @wrdigit
	   move.b (a7)+,d2
	   and.b $0f,d2
*	   call  @wrdigit
	   add.w #1,a0
	   dbne d1,nextdig
