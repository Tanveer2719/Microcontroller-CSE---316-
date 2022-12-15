.model small
.stack 100h
.data
    hash1 dw ?
    msg2 db 'Isoscales','$'
    msg1 db 'equilateral','$'
    msg3 db 'scalene','$'
    
    cr equ 0dh
    nl equ 0ah
.code

main proc 
    
    
    mov ax, @data
    mov ds, ax
    
   
    mov ah, 1
    int 21h
    mov cl, al  ; a = cl
    int 21h
    mov ch, al  ; b = ch
    int 21h
    mov dl, al  ; c = dl
    
compare:
    cmp cl, ch
    je a_b
    cmp cl, dl
    je iso
    jne sca
    
    
    
    a_b:
        cmp cl, dl  ;a=c && a=b
        je eq
        jmp iso
        
    eq:
        mov ah, 2
        mov dl, 0Dh
        int 21h
        mov dl, 0ah
        int 21h
        
        mov ah, 09h
        lea dx, msg1
        int 21h
        jmp exit
        
    iso:
        mov ah, 2
        mov dl, 0Dh
        int 21h
        mov dl, 0ah
        int 21h
        
        mov ah, 09h
        lea dx, msg2
        int 21h
        jmp exit
        
    sca:
        mov ah, 2
        mov dl, 0Dh
        int 21h
        mov dl, 0ah
        int 21h
        
        mov ah, 09h
        lea dx, msg3
        int 21h
        jmp exit        
        
        
         
        
    

    
exit:
    mov ah, 4ch
    int 21h
    
    
   
main endp
end main



