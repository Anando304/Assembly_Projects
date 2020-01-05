section .bss
		digitSpace resb 100
		digitSpacePos resb	8

section .text
		global _start
		
_start:
		mov rax, 123
		call _printRAX
		
		mov rax, 60
		mov rdi, 0
		syscall

_printRAX:
		mov rcx, digitSpace ;digitSpace stores the string that we are going to print out
		mov rbx, 10 ;10 is newline '\n' character
		mov [rcx], rbx ;Move as a pointer rbx into rcx
		inc rcx 
		mov [digitSpacePos], rcx 
		
_printRAXLoop:
		mov rdx, 0 ; Set rdx to 0 so that it doesn't get concatenated on the div when doing division later
		mov rbx, 10
		div rbx ;rax initially is 123, rax = rax / rbx where rbx is 10
		push rax ;pushes new value of rax onto the stack to store it
		add rdx, 48 ;The remainder gets stored in rdx. so 123 /10 has remainder 3. We can convert this to ASCII code of 3 by adding 48
		
		mov rcx, [digitSpacePos]
		mov [rcx], dl
		inc rcx
		mov [digitSpacePos], rcx
		
		pop rax
		cmp rax, 0
		jne _printRAXLoop
		;This results in getting the number in reverse since 123 has remainders 3 2 1.
		
		
	_printRAXLoop2:
		;Is used to get the number forwards
		mov rcx, [digitSpacePos]
		
		mov rax, 1
		mov rdi, 1
		mov rsi, rcx
		mov rdx, 1
		syscall
		
		mov rcx, [digitSpacePos]
		dec rcx
		mov [digitSpacePos], rcx
		
		cmp rcx, digitSpace
		jge _printRAXLoop2
		
		ret