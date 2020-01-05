%include "simple_io.inc"

;;NAME: ANANDO ZAMAN
;; COMPLETED: DECEMBER 1ST,2019

global asm_main
extern rperm

section .data
	array: dq 1,2,3,4,5,6,7,8
	prompt1: db "enter a,b to swap", 10,0
;;10 is new line, 0 is null char(start new line, end null)
	prompt2: db "0 to terminate: ", 0
	a1: db "first coordinate not 1..8",10,0
	a2: db "missing comma",10,0
	a3: db "Second coordinate not 1..8",10,0
	a4: db "Cannot be same number",10,0
	
	print_1: db ".....+....",0
	print_2: db ".....++...",0
	print_3: db "....+-+...",0
	print_4: db "....+--+..",0
	print_5: db "...+---+..",0
	print_6: db "...+----+.",0
	print_7: db "..+-----+.",0
	print_8: db "..+------+",0
	
	print_space_1: db "      +   ",0
	print_space_2: db "     ++   ",0
	print_space_3: db "    + +   ",0
	print_space_4: db "    +  +  ",0
	print_space_5: db "   +   +  ",0
	print_space_6: db "   +    + ",0
	print_space_7: db "  +     + ",0
	print_space_8: db "  +      +",0
	
	print_1a: db "     1    ",0
	print_2a: db "     2    ",0
	print_3a: db "     3    ",0
	print_4a: db "     4    ",0
	print_5a: db "     5    ",0
	print_6a: db "     6    ",0
	print_7a: db "     7    ",0
	print_8a: db "     8    ",0
	
	

section .bss
	arrays: resq 8 ;resq allocates 8 bytes

section .text

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

display: ;;Used to display the array. Add 8 to check next element of array due to bytesizes initialized earlier
		enter 0,0
		saveregs
		
		;NOW print the pattern
		mov r12, qword 0
		push r12
		mov rax, [array]
		jmp printer

printer:
		mov rax, [array + r12] ;;r12 is a preserved register containing an integer used to check next index of the array
		cmp rax, qword 1
		jne two
		mov rax, print_1
		call print_string
		
		
		two:
			cmp rax, qword 2
			jne three
			mov rax, print_2
			call print_string

		three:
			cmp rax, qword 3
			jne four
			mov rax, print_3
			call print_string
			
		four:
			cmp rax, qword 4
			jne five
			mov rax, print_4
			call print_string
			
		five:
			cmp rax, qword 5
			jne six
			mov rax, print_5
			call print_string
			
		six:
			cmp rax, qword 6
			jne seven
			mov rax, print_6
			call print_string
			
		seven:
			cmp rax, qword 7
			jne eight
			mov rax, print_7
			call print_string
			
		eight:
			cmp rax, qword 8
			jne next_array_index
			mov rax, print_8
			call print_string
			
		next_array_index: ;;Used to increment r12 by 8 which is needed to find next element of the array
			add r12, 8
			push r12 ;;Since r12 is a preserved register, we must push it to the stack to save it
			cmp r12, qword 56 ;;if r12 is below or equal to 56, then reloop printer
			jbe printer
			call print_nl
			mov r12, qword 0
			
			
			
print_array: ;Used to print the randomly generated array

	mov rax, [array + r12] 
	cmp rax, qword 1
	jne two_a
	mov rax, print_1a
	call print_string
		
	two_a:
		cmp rax, qword 2
		jne three_a
		mov rax, print_2a
		call print_string
	
	three_a:
		cmp rax, qword 3
		jne four_a
		mov rax, print_3a
		call print_string
		
	four_a:
		cmp rax, qword 4
		jne five_a
		mov rax, print_4a
		call print_string
		
	five_a:
		cmp rax, qword 5
		jne six_a
		mov rax, print_5a
		call print_string
		
	six_a:
		cmp rax, qword 6
		jne seven_a
		mov rax, print_6a
		call print_string
		
	seven_a:
		cmp rax, qword 7
		jne eight_a
		mov rax, print_7a
		call print_string
		
	eight_a:
		cmp rax, qword 8
		jne next_array_index_a
		mov rax, print_8a
		call print_string
		
	next_array_index_a: 
		add r12, 8
		push r12 ;;save the new r12 counter value
		cmp r12, qword 56
		jbe print_array
		jmp newLine
	

asm_main:	

		enter	0,0
		saveregs

		mov	rdi, array     ;1st param for rperm
		mov	rsi, qword 8   ;2nd param for rperm
		call rperm

		;; now the array 'array' is randomly initialzed

		call display
		jmp asm_main_end
		
newLine:
	call print_nl
	
prompt: ;Prints the prompt text
		mov rax, prompt1
		call print_string
		mov rax, prompt2
		call print_string

read:
	call read_char
	
	cmp al, '0'
	je asm_main_end

	cmp al, 10
	je read
	
	cmp al, '1'
	jb error1
	cmp al, '8'
	ja error1

	mov r12, 0
	mov r12b, al
	sub r12b, '0'
	
	call read_char
	cmp al, ','
	jne error2

	call read_char
	cmp al, '1'
	jb error3
	cmp al, '8'
	ja error3
	
	mov r13, 0
	mov r13b, al
	sub r13b, '0'

	cmp r12, r13
	je error4

	mov r14, array

LOOP1:
	cmp [r14], r12
	je LOOP2
	add r14, 8
	jmp LOOP1

LOOP2:
	mov r15, array

LOOP3:
	cmp [r15], r13
	je LOOP4
	add r15, 8
	jmp LOOP3

LOOP4:
	mov [r14], r13
	mov [r15], r12
	call display
	jmp asm_main_end

error1:
	
	mov rax, a1
	call print_string

L1:
	cmp al,10
	je L2
	call read_char
	jmp L1

L2:
	jmp prompt

error2:
	mov rax, a2
	call print_string

K1:
	cmp al,10
	je K2
	call read_char
	jmp K1

K2:
	jmp prompt

error3:
	mov rax, a3
	call print_string

T1:
	cmp al,10
	je T2
	call read_char
	jmp T1

T2:
	jmp prompt

error4:
	mov rax, a4
	call print_string

Q1:
	cmp al,10
	je Q2
	call read_char
	jmp Q1

Q2:
	jmp prompt
	
asm_main_end:
		restoregs
		leave
		ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
