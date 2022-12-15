.MODEL SMALL
.STACK 100H
.DATA

    a dw 15 dup (?)
    cr equ 0dh
    nl equ 0ah
    
.CODE
MAIN PROC
    
    mov ax, @data
    mov ds, ax
    
    lea si, a
    mov di, si      ; si and di points to start of the array
    
    mov cx, 0       ; for array length
    
;take the array input
inp:   
    cmp cx, 15
        je newLine      ;if cx == 15 print
         
    xor bx,bx 
    call take_input
    cmp bx, 0
        je newLine      ;if cx == 0 then print
         
    mov [si], bx
    inc cx          ;increase cx
    add si,2
    
jmp inp 
    


newLine:     
    mov ah,2
    mov dl, cr
    int 21h
    mov dl, nl
    int 21h
    
    ;mov cx, 3
    
    
    call ascent     ; call the procedure ascent
    
    mov ax, bx
    
    call print
    
    jmp exit
    
; print the array
pri:
    
    mov ax, [di]
    call print
    add di,2
    mov ah,2
    mov dl,' '
    int 21h
    
Loop pri

exit:  
    mov ah, 4ch
    int 21h 
    
MAIN ENDP
 
; take decimal input to bx
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

;print the number in ax
print proc 
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
        
print endp 


ascent proc
       push dx
       push ax
       push si
       push di
       push cx
       ;push bx
       
       ;cx size of the array
       ;si, di contains the start of the array
       ;bx keeps the count of the max ascent
       
       mov bx, 1    ;bx = 1,,,initialy
       mov dx, 1    ;dx = 1...another counter
       mov si, di   ; si set to 0
       dec cx       ; we run the for loop for n-1
   
for: 
       mov ax, [si] ; ax = [si]
       add si, 2    ; i = i+1
       cmp ax, [si]
            jg comp
         
       inc dx           ; else increse the temporary count
loop for

jmp ex                  ; skip the comp label

comp:
    call compare
    loop for

ex: 
    call compare        ; for final comparisn
    ;pop bx
    pop cx
    pop di
    pop si
    pop ax
    pop dx
    ret

ascent endp


compare proc
         cmp bx, dx
         jg ext
         mov bx, dx
         mov dx,1
      
ext:
    ret         
         
         
    
compare endp
            

END MAIN

