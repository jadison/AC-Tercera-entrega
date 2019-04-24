TITLE Show Procedure Parameters


COMMENT !

Write a procedure named ShowParams that displays the address and hexadecimal value of the
32-bit parameters on the runtime stack of the procedure that called it. The parameters are to be
displayed in order from the lowest address to the highest. Input to the procedure will be a single
integer that indicates the number of parameters to display. For example, suppose the following
statement in main calls MySample, passing three arguments:
INVOKE MySample, 1234h, 5000h, 6543h

Next, inside MySample, you should be able to call ShowParams, passing the number of parameters
you want to display:
MySample PROC first:DWORD, second:DWORD, third:DWORD
paramCount = 3
call ShowParams, paramCount
ShowParams should display output in the following format:
Stack parameters:
---------------------------
Address 0012FF80 = 00001234
Address 0012FF84 = 00005000
Address 0012FF88 = 00006543

!



INCLUDE Irvine32.inc

.data

	str1 BYTE "Address ",0
	str2 BYTE " = ",0
	str3 BYTE "Stack Parameters:",0dh,0ah
		 BYTE "---------------------------",0dh,0ah,0

	MySample PROTO first:DWORD, second:DWORD, third:DWORD
	ShowParams PROTO numParams:DWORD

.code
main PROC

	INVOKE MySample, 1234h,5000h,6543h

	exit

main ENDP

MySample PROC,
	first:DWORD, second:DWORD, third:DWORD
	paramCount = 3

	INVOKE ShowParams, paramCount

	ret
MySample ENDP

ShowParams PROC, numParams:DWORD
	STACK_DEPTH = 5 * TYPE DWORD

	mov edx, offset str3
	call WriteString

	mov ecx, numParams
	mov esi, esp
	add esi, 20

L1: mov edx, offset str1
	call WriteString

	mov eax, esi
	call WriteHex

	mov edx, offset str2
	call WriteString

	mov eax, [esi]
	call WriteHex
	call Crlf

	add esi, 4
	loop L1

	ret
ShowParams ENDP

END main
