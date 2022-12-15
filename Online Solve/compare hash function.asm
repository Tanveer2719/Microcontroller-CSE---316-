.model small
.stack 100h
.data
    hash1 dw ?
    msg db 'PE','$'
    msg1 db 'NE','$'
    
    cr equ 0dh
    nl equ 0ah
.code

main proc 
    
    
    mov ax, @data
    mov ds, ax
    
    mov cl, 6 ;max size of string
    mov ch, 0 ;current length of string
    
    ;for storing hash temporarily
    mov bx, 0 
    
    ;take first string as input
    
input1:
    mov ah, 1    
    cmp ch, cl ;if length == 6 take second input
        jge new
    
    int 21h
    
    cmp al, cr
        je new
    cmp al, nl
        je new
        
        
    inc ch  ;increase length 
    jmp find_hash1
    
    
find_hash1:
    cmp al, 'a'
    je a1
    cmp al, 'b'
    je b1
    cmp al, 'c'
    je c1
    cmp al, 'd'
    je d1
    cmp al, 'e'
    je e1
    
    
a1:
    mov ax, 1
    mul ch
    add bx, ax
jmp input1

b1:  
    mov ax, 2
    mul ch
    add bx, ax
jmp input1
 
c1:
    mov ax, 3
    mul ch
    add bx, ax
jmp input1
  
d1:
    mov ax, 4
    mul ch
    add bx, ax
jmp input1

e1:
    mov ax, 5
    mul ch
    add bx, ax
jmp input1



new:
    mov hash1, bx
    mov bx, 0
    mov ch, 0
    
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h
    mov ah, 1
   
    

input2:
    mov ah, 1
    cmp ch, cl ;if length == 6 take second input
        jge new1
    
    int 21h
    
    cmp al, cr
        je new1
    cmp al, nl
        je new1
        
        
    inc ch  ;increase length 
    jmp find_hash2
    
find_hash2:
    cmp al, 'a'
    je a2
    cmp al, 'b'
    je b2
    cmp al, 'c'
    je c2
    cmp al, 'd'
    je d2
    cmp al, 'e'
    je e2
    
a2:
    mov ax, 1
    mul ch
    add bx, ax
jmp input2

b2:  
    mov ax, 2
    mul ch
    add bx, ax
jmp input2
 
c2:
    mov ax, 3
    mul ch
    add bx, ax
jmp input2
  
d2:
    mov ax, 4
    mul ch
    add bx, ax
jmp input2

e2:
    mov ax, 5
    mul ch
    add bx, ax
jmp input2


new1:
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h
    
    cmp hash1, bx
    je print_PE
    jmp p_NE
    

print_pe:
    mov ah, 09h
    lea dx, msg
    int 21h
    jmp exit
    
p_NE:
    mov ah, 09h
    lea dx, msg1
    int 21h


    
exit:
    mov ah, 4ch
    int 21h
    
    
   
main endp
end main



