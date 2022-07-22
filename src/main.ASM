dosseg
.model small
.stack 100h
.data
	input db ?
	str1 db "Enter an alphabet: $"
	str2 db "Invalid Input$"
	str3 db "Enter a number: $"
	First_Term dw 0
	Second_Term dw 1
	num db ?
.code
main proc
	mov ax, @data
	mov ds, ax
	
	mov dx, OFFSET str1
	mov ah, 09h
	int 21h
	
	mov ah,01h
	int 21h
	mov input, al
	
	CMP input, 'U'
	JE UpperCase_Letters
	CMP input, 'L'
	JE LowerCase_Letters
	CMP input, 'N'
	JE Number
	CMP input, 'F'
	JE SetBound1
	CMP input, 'P'
	JE SetBound3
	JNE	SetBound2
	
	UpperCase_Letters:
		mov bx, 'A'
		mov cx, 26
		
		mov ah,02h
		mov dl,10
		int 21h
		
		L1:
			mov ah, 02h
			mov dx,bx
			int 21h
			
			INC bx
		LOOP L1
		
	JMP End_Programme
		
	LowerCase_Letters:
		mov bx, 'a'
		mov cx, 26
		
		mov ah,02h
		mov dl,10
		int 21h
		
		L2:
			mov ah, 02h
			mov dx,bx
			int 21h
			
			INC bx
		LOOP L2
		
	JMP End_Programme

	SetBound1:
		JMP Fibonacci_Series
		
	SetBound2:
		JMP Invalid_Input
		
	SetBound3:
		JMP Prime

	Number:
		mov bx, '0'
		mov cx, 10
		
		mov ah,02h
		mov dl,10
		int 21h
		
		L3:
			mov ah, 02h
			mov dx,bx
			int 21h
			
			INC bx
		LOOP L3
		
	JMP End_Programme
		
	Fibonacci_Series:
		mov ah, 02h
		mov dl, 10
		int 21h

		mov ah, 02h
		mov dx,First_Term
		add dx,48
		int 21h
		
		mov ah, 02h
		mov dx,Second_Term
		add dx,48
		int 21h
		
		mov cx,5
		L4:
			mov bx, First_Term
			add bx, Second_Term
			mov dx, Second_Term
			mov First_Term, dx
			mov Second_Term, bx
		
			mov ah, 02h
			mov dx,Second_Term
			add dx,48
			int 21h
		
		LOOP L4
		
	JMP End_Programme
		
	Prime:
		mov ah,02h
		mov dl,10
		int 21h
	
		mov dx,OFFSET str3
		mov ah,09h
		int 21h
	
		mov ah,01h
		int 21h
		mov num,al
		sub num,48
		
		CMP num,1
		JE Print_Prime

		CMP num,2
		JE Print_Prime

		mov bl,2
		J1:
			mov ax,0
			mov al,num
			DIV bl
			
			CMP ah,0
			JE Print_NotPrime
			
			INC bl
		CMP bl,num
		JE Print_Prime
		JNE J1
		
	JMP End_Programme
		
	Invalid_Input:
		mov ah,02h
		mov dl,10
		int 21h
		
		mov dx, OFFSET str2
		mov ah, 09h
		int 21h
		
		JMP End_Programme
		
	Print_Prime:
		mov ah,02h
		mov dl,10
		int 21h
		
		mov ah,02h
		mov dl, 'P'
		int 21h
		
		JMP End_Programme
		
	Print_NotPrime:
		mov ah,02h
		mov dl,10
		int 21h
		
		mov ah,02h
		mov dl, 'N'
		int 21h
		
		JMP End_Programme
		
	End_Programme:		
		mov ah,04ch
		int 21h
		
main endp
end main