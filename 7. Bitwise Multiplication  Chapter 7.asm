TITLE Bitwise Multiplication

COMMENT !

Write a procedure named BitwiseMultiply that multiplies any unsigned 32-bit integer by
EAX, using only shifting and addition. Pass the integer to the procedure in the EBX register,
and return the product in the EAX register. Write a short test program that calls the procedure
and displays the product. (We will assume that the product is never larger than 32 bits.) This is
a fairly challenging program to write. One possible approach is to use a loop to shift the multiplier
to the right, keeping track of the number of shifts that occur before the Carry flag is set.
The resulting shift count can then be applied to the SHL instruction, using the multiplicand as
the destination operand. Then, the same process must be repeated until you find the last 1 bit
in the multiplier.

!




INCLUDE Irvine32.inc

.CODE
main PROC
	mov	eax,123
	mov	ebx,36
	call	BitwiseMultiply
	call	DumpRegs			; EAX = 114Ch, 4428d
	exit
main ENDP

;-----------------------------------------------------
BitwiseMultiply PROC USES ebx edx
;
; Multiplies any unsigned 32-bit integer by EAX, using only shifting and
; addition.
; Receives: EAX = multiplicand, EBX = multiplier
; Returns: EAX = product
	mov	edx,eax		; EDX = multiplicand
	mov	eax,0		; initialise result
	jmp	CmpMultiplier	; while multiplier > 0
TestMultiplier:
	test	ebx,1
	jp	NotOdd		; if multiplier is odd, add multiplicand to result
	add	eax,edx
NotOdd:
	shl	edx,1		; double multiplicand
	shr	ebx,1		; halve multiplier
CmpMultiplier:
	cmp	ebx,0
	ja	TestMultiplier
	ret
BitwiseMultiply ENDP
END main