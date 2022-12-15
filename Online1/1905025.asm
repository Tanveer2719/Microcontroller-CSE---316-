.model small
.stack 100h
.data
    hash1 dw ?
    msg1 db ''
    
    cr equ 0dh
    nl equ 0ah
    
.code

main proc
    
    mov ax, @data
    mov ds, ax
    
    mov bx,0        ;bx = 0 
    mov ax, 0
    ;input ternery number 
    ;bx = bx*3 + input
    
    
    input:
        mov ah, 1
        int 21h
        
        cmp al, cr
            je prev
        cmp al, nl
            je prev
            
        xor ah, ah      ; clear ah
        
        cmp ax, '0'
            jl input
        cmp ax, '2'
            jg input
        
        sub ax, '0'     ; ax contains original value
        mov cx, ax      ; cx = input
        mov ax,  3      ; ax = 3
        mul bx          ; ax = 3*bx
        add ax, cx      ; ax = 3*bx + input
        mov bx, ax      ; bx = ax
        
    jmp input
    
    
    prev:
        mov ah, 2
        mov dl, cr
        int 21h
        mov dl,nl
        int 21h
        
         
        mov ax, bx     ; ax = bx
        cmp ax, 0
        je next 
        jmp find_number
    
    
    
    find_number:
        cmp ax, 0
            je exit
             
        xor dx,dx      ; clear dx
        
        mov bx, 2      ; bl = 2
        div bx         ; ax/bl
        mov bx, ax     ; bx = ans
        add dx, '0'    ; dx = ascii value
        mov ah, 2
        int 21h        ;print the remainder
        
        mov ax, bx     ;ax = ans
    jmp find_number
    
    
    next:
        mov dx, 0
        add dx, '0'
        mov ah, 2
        int 21h
        
  
exit:
    mov ah, 4ch
    int 21h
    
    
   
main endp
end main



