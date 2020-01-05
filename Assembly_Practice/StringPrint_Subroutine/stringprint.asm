;Assembly code used to print a string dynamically without specifying the length explicitly
section .data
		text db "Hello, World!",10,0
		text2 db "World?",10,0

section .text
		global _start

_start:
		mov rax, text
		call _print ;calls take values of whatever register had previously. so will take rax text
		
		mov rax,text2
		call _print
		
		mov rax, 60
		mov rdi, 0
		syscall
		
;input: rax as pointer to string
;rbx register will be used as a counter to keep track of length of string
;output: print string at rax location/register

_print: ;_print consists of _printLoop label as the ret(return) is placed at the end
		push rax ;Pointer to string
		mov rbx, 0 
		
_printLoop:
		inc rax ;Used to go through each element in the string. Think of it as a pointer to first element that reads each character via incrementation
		inc rbx	;Used to keep track of each position in the string
		mov cl, [rax] ; Will hold next value in the string via pointer pointing to next element as it gets incremented
		cmp cl, 0 ;Compare to see if next value is NULL(0). If so, then reached end of string
		jne _printLoop ;Keep relooping aslong as cl is not 0.
		
		mov rax, 1
		mov rdi, 1
		pop rsi ;Takes the pointer that was saved in rax and saves it into rsi. recall rsi is address argument
		mov rdx,rbx ;move length_counter rbx into rdx
		syscall
		
		ret