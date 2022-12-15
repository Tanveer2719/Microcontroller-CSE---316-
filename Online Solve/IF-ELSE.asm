.model small
.stack 100h
.data
    hash1 dw ?
    msg2 db '->','$'
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
    mov cl, al
    
    NOT cl
    ;sub cl, 1
    
    mov ah, 2
    mov dl, cl
    int 21h
    
exit:
    mov ah, 4ch
    int 21h
    
    
   
main endp
end main



