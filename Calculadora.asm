pila segment para stack 'stack'
	db 1024 dup('stack')
pila ends

datos segment para public 'data'
mensaje  db "Proporcione un numero: $"
mresult  db "Resultado: $"
merror db "Error, entrada de datos incorrecta$"
mensaje2  db "Resta$"
suma db "1) Suma$"
resta db "2) Resta$"
divicion2 db "3) Divicion$"
multiplicacion db "4) Multiplicacion$"
var dw 0
var2 dw 0
datos ends
codigo segment para public 'code'
	public compa
compa proc far
	assume cs:codigo, ds:datos, ss:pila
	push ds
	mov ax,0h
	push ax

	mov ax,datos
	mov ds,ax

;codigo
	mov ah,00h;	Limpiar Pantalla
	mov al,03h
 	int 10h
	mov cx,02h
	
	mov dh,1;	Posicionar cursor
    mov dl,1
    mov ah,02h
    int 10h
go:
	push cx
	lea dx,mensaje; Imprime cadena
    mov ah,09h
	int 21h

	mov cx,02h;		contador

Entrada:

	mov ah,07h;	Pide caracter
	int 21h

	cmp al,30h;	comparador
	jl Entrada

	cmp al,39h
    ja Entrada
	
	mov dl,al
	mov ah,02h;	Imprime caracter
	int 21h

	sub al,30h
	mov ah,0
	push ax

loop Entrada

	mov dh,2;	Posicionar cursor
    mov dl,1
    mov ah,02h
    int 10h      

	pop dx
	pop ax
	mov cl,10
	mul cl
    add ax,dx
	pop cx
	cmp var,0h
	jne Terminar
	mov var,ax
Terminar:
	loop go
    mov var2,ax
	
    mov dh,5; Posicionar cursor
    mov dl,1
    mov ah,02h
    int 10h
	lea dx,suma; Imprime cadena
    mov ah,09h
	int 21h
	
	mov dh,6; Posicionar cursor
    mov dl,1
    mov ah,02h
    int 10h
	lea dx,resta; Imprime cadena
    mov ah,09h
	int 21h
	
	mov dh,7; Posicionar cursor
    mov dl,1
    mov ah,02h
    int 10h
	lea dx,divicion2; Imprime cadena
    mov ah,09h
	int 21h
	
	mov dh,8; Posicionar cursor
    mov dl,1
    mov ah,02h
    int 10h
	lea dx,multiplicacion; Imprime cadena
    mov ah,09h
	int 21h
	mov dh,9; Posicionar cursor
    mov dl,1
    mov ah,02h
    int 10h
	lea dx,mensaje; Imprime cadena
    mov ah,09h
	int 21h
	
	mov ah,01h;	Pide caracter
	int 21h
	xor ah,ah
	sub al,30h
	
	cmp al,1;	comparador
	je Suma1
	cmp al,2;	comparador
	je resta1
	cmp al,3;	comparador
	je divicion1
	cmp al,4;	comparador
	je multiplicacion1
	jmp error1
	
Suma1:	
    mov  ax,var2
	add ax,var ;Suma
	jmp termino
	
;Menu Operaciones	
resta1:
  mov  ax,var
  sub ax,var2
  jmp termino
multiplicacion1:
  mov ax,var
  mov dx,var2
  mul dx
  jmp termino
divicion1:
  mov ax,var
  mov bx,var2
  div bx
  jmp termino
;Fin Menu  

termino:
    mov dl,10
	mov cx,4h
	mov bx,0h
divicion:
	div dl
	mov bl,ah
	add bx,30h
	push bx	
	mov ah,0
loop divicion

    mov dh,11;Posicionamiento del Cursor
    mov dl,1
    mov ah,02h
    int 10h
	lea dx,mresult; Imprime cadena
    mov ah,09h
	int 21h
	
	mov cx,4h
imprimir:	
	pop dx
	mov ah,02h
	int 21h
loop imprimir  

jmp fin	
error1:

    mov dh,11; Posicionar cursor
    mov dl,5
    mov ah,02h
    int 10h
	lea dx,merror; Imprime cadena
    mov ah,09h
	int 21h
	
fin:
	mov ah,7
	int 21h
	ret

compa endp
	codigo ends
	end compa