TITLE Packed Decimal Examples

COMMENT !

Extend the AddPacked procedure from Section 7.6.1 so that it adds two packed decimal integers
of arbitrary size (both lengths must be the same). Write a test program that passes
AddPacked several pairs of integers: 4-byte, 8-byte, and 16-byte. We suggest that you use the
following registers to pass information to the procedure:
ESI - pointer to the first number
EDI - pointer to the second number
EDX - pointer to the sum
ECX - number of bytes to add

!


INCLUDE Irvine32.inc

.data
packed_1 WORD 4536h
packed_2 WORD 7207h
sum DWORD ?

.code
main PROC
; Initialize sum and index.
	mov	sum,0
	mov	esi,0
	
; Add low bytes.
	mov	al,BYTE PTR packed_1[esi]
	add	al,BYTE PTR packed_2[esi]
	daa
	mov	BYTE PTR sum[esi],al
	
; Add high bytes, include carry.
	inc	esi
	mov	al,BYTE PTR packed_1[esi]
	adc	al,BYTE PTR packed_2[esi]
	daa
	mov	BYTE PTR sum[esi],al

; Add final carry, if any.
	inc	esi
	mov	al,0
	adc	al,0
	mov	BYTE PTR sum[esi],al
	
; Display the sum in hexadecimal.	
	mov	eax,sum
	call	WriteHex
	call	Crlf
	exit
main ENDP
END main