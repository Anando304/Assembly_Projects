section .data
		text1 db "What is your name? " ;Comments are done using semi-colons. db means type byte
		text2 db "Hello, " 
		
section .bss
		name resb 16
		
section .text
		global _start

_start:

		call _printText1
		call _getName
		call _printText2
		call _printName
		
		mov rax, 60 ;Needed to end program gracefully
		mov rdi, 0 ;Error code
		syscall
	
_getName: ;getName subroutine is like a function used to retrieve user input and save it to the unitialized register called 'name'
		mov rax, 0 ; ID number for rax is 0 if trying to get user input
		mov rdi, 0 ;standard input is 0
		mov rsi, name  ; rsi is always for memory address to save to either from .data or .bss. bss is uninitialized data. data is initialized data.
		mov rdx, 16 ; Length of input we want to get. Allocated 16 bytes in bss as the 'name' label
		syscall
		ret
		
		
_printText1:
		mov rax, 1
		mov rdi, 1
		mov rsi, text1 
		mov rdx, 19
		syscall
		ret
		
_printText2:
		mov rax, 1
		mov rdi, 1
		mov rsi, text2
		mov rdx, 7
		syscall
		ret
	
_printName:
		mov rax, 1 ;To print to the screen
		mov rdi, 1 ;standard output
		mov rsi, name
		mov rdx, 16 ; This is for the 16 bit input that is saved. It will be displayed to the screen
		syscall
		ret