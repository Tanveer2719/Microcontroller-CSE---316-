.MODEL SMALL
.STACK 100H
.DATA
    a dw 10 dup (1)
    cr equ 0dh
    nl equ 0ah
    
.CODE
MAIN PROC
    
    mov ax, @data
    mov ds, ax
    
    xor bx, bx
    
    call take_input
    
    ; save to the array
    mov si, 0
    mov a[si], bx
    
    ;new line
    mov ah, 2
    mov dl, cr
    int 21h
    mov dl, nl
    int 21h
    
    ;print the number 
    mov dx, a[si]
    mov ah, 2
    int 21h
    
    ;new line
    mov ah, 2
    mov dl, cr
    int 21h
    mov dl, nl
    int 21h
    
    mov ax, a[si]
    
    call print

    mov ah, 4ch
    int 21h

MAIN ENDP

take_input proc 
    push ax
    push cx
    
    mov bx, 0
    start:
        mov ah, 1
        int 21h
        
        cmp al,' '       ; if al = ' ' then return
            je return
        
        cmp al, cr       ; if enter is pressed return
            je return
            
        
        cmp al, '0'
            jl start
        cmp al, '9'
            jg start 
            
        xor ah, ah         ; make the upper byte 0
            
        sub ax, '0'     ; ax contains original value
        mov cx, ax      ; cx = input
        mov ax,  10      ; ax = 10
        mul bx          ; ax = 10*bx
        add ax, cx      ; ax = 10*bx + input
        mov bx, ax      ; bx = ax
        
        jmp start
        
     return:
        pop cx
        pop ax
        ret

take_input endp 

PRINT PROC
      push cx
      push bx
      push dx
      push ax
      
      ;INITIALIZE COUNT
      MOV CX, 0
      MOV DX, 0
      
      EXTRACT:
           CMP AX, 0
           JE SHOW
           
           MOV BX, 10
        
           DIV BX      ; AX/BX
        
           PUSH DX     ;PUSH THE REMAINDER IN STACK
        
           XOR DX, DX  ;CLEAR THE REMAINDER
           INC CX      ;INCREASE COUNT
        
           JMP EXTRACT
           
      
      SHOW:
          CMP CX, 0
          JE E       ; IF COUNT = 0 RETURN
          
          POP DX
          ADD DX, 48    ;POP DX AND ADD 48 WITH DX TO MAKE IT ASCII
          
          MOV AH, 2
          INT 21H
          DEC CX
          JMP SHOW
           
      E: 
        POP AX
        POP DX
        POP BX
        POP CX
        
        RET
      
    
    
    
PRINT ENDP

END MAIN

