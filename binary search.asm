.MODEL SMALL
.STACK 100H
.DATA
    a dw 1,2,3,4,5,6,7,8,9
    msg1 db "found","$"
    msg2 db "not found","$"
    
.CODE
MAIN PROC
    
    mov ax, @data
    mov ds, ax
    
    mov cx, 8
    
    
    mov bx, 8   ; right
    mov dx, 0   ; left
    
start:
    cmp dx, bx
        jg not_found
        
    mov ax, dx
    add ax, bx
    shr ax, 1
    
    mov si, ax
    add si, si
    
    cmp a[si], cx
    je found
    jg smaller
    jmp greater
    
greater:
       inc ax
       mov dx, ax           ; since cx is bigger than the middle element we move the left index to ax
       jmp start
   
smaller:
       dec ax
       mov bx, ax           ; move rigt index to middle
       jmp start
       
found:
      mov ah, 09h
      lea dx, msg1
      int 21h
      jmp exit 
      
not_found:
      mov ah,09h
      lea dx, msg2
      int 21h
      jmp exit
      
      
exit:
    mov ah, 4ch
    int 21h       
    
    
    
MAIN ENDP
    
END MAIN

