; Author: Austin Chayka
; Project name: Program #3
; Description: 
;	Gets negative numbers from the user, then calculates number of terms,
;	the sum, and the rounded average

INCLUDE irvine32.inc

MAX_NAME_SIZE = 32
LOWER_LIMIT = -100

.data
	;print strings
	welcome BYTE "Welcome to the Integer Accumulator by Austin Chayka", 13, 10, 0
	getName BYTE "What is your name? ", 0
	hello BYTE "Hello, ", 0
	newLine BYTE 13, 10, 0
	instructions BYTE "Please enter numbers in [", 0
	instructions2 BYTE ", -1]", 13, 10, 0
	instructions3 BYTE "Enter a non-negative number when you are finished to see results.", 13, 10, 0
	prompt BYTE "Enter number: ", 0
	inputErrorMsg BYTE "Number not in bounds.", 13, 10, 0
	count BYTE "You entered ", 0
	count2 BYTE " valid numbers.", 13, 10, 0
	sum BYTE "The sum of your valid numbers is ", 0
	average BYTE "The rounded average is ", 0
	goodbye BYTE "Thank you for playing Integer Accumulator! It's been aaa pleasure to meet you, ", 0
	period BYTE ".", 13, 10, 0
	;variables
	username BYTE MAX_NAME_SIZE + 1 DUP (?)
	n DWORD 0
	counter DWORD 0
	avg	DWORD ?

.code

main PROC
;print intro
	mov		edx, OFFSET welcome
	call	WriteString
;get name
	mov		edx, OFFSET getName
	call	WriteString
	mov		ecx, MAX_NAME_SIZE
	mov		edx, OFFSET username
	call	ReadString
;greet user
	mov		edx, OFFSET hello
	call	WriteString
	mov		edx, OFFSET username
	call	WriteString
	mov		edx, OFFSET newLine
	call	WriteString
;print instructions
	mov		edx, OFFSET instructions
	call	WriteString
	mov		eax, LOWER_LIMIT
	call	WriteInt
	mov		edx, OFFSET instructions2
	call	WriteString
	mov		edx, OFFSET instructions3
	call	WriteString
	jmp		getInput

inputError:
;range error
	mov		edx, OFFSET inputErrorMsg
	call	WriteString
	
getInput:
;get input from user
	mov		edx, OFFSET prompt
	call	WriteString
	call	ReadInt
	;check bounds
	cmp		eax, -1
	jg		compute
	cmp		eax, LOWER_LIMIT
	jl		inputError
	;increment counter
	add		counter, 1
	;add number to sum
	add		n, eax
	jmp		getInput

compute:
;print results of inputs
	;print counter
	mov		edx, OFFSET count
	call	WriteString
	mov		eax, counter
	call	WriteInt
	mov		edx, OFFSET count2
	call	WriteString
	;print sum
	mov		edx, OFFSET sum
	call	WriteString
	mov		eax, n
	call	WriteInt
	mov		edx, OFFSET newLine
	call	WriteString
	;calculate average
	mov		edx, OFFSET average
	call	WriteString
	mov		edx, 0
	mov		eax, n
	cdq
	idiv	counter
	;check for rounding
	mov		avg, eax
	mov		eax, edx
	neg		eax
	mov		edx, 2
	mul		edx
	cmp		eax, counter
	jge		round
	jmp		printRound
round:
;round average
	add		avg, -1
printRound:
;print average
	mov		eax, avg
	call	WriteInt
	mov		edx, OFFSET newLine
	call	WriteString
;print goodbye
	mov		edx, OFFSET goodbye
	call	WriteString
	mov		edx, OFFSET username
	call	WriteString
	mov		edx, OFFSET period
	call	WriteString

	exit
main ENDP

end main