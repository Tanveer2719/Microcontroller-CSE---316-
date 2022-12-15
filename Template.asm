.MODEL SMALL
.STACK 100H
.DATA

    cr equ 0dh
    nl equ 0ah
    
.CODE
MAIN PROC
    
    mov ax, @data
    mov ds, ax
    
    
    
    

    mov ah, 4ch
    int 21h 
    
MAIN ENDP
END MAIN

