.MODEL SMALL
.STACK 100H
.DATA  
    arr DB 2,1,5,7,3,9

.CODE
MAIN PROC
    
    mov ax, @data
    mov ds, ax
    
    lea si, arr     ; load arr to si
    mov bx, 6       ; size of the array
    
    call SELECT_SORT 
    
    
    ; print the array 
    mov ah, 02h
    mov cx,bx 
    mov bx, si
    print:
        mov dl,[bx]
        add dl, '0'
  
        int 21h
        mov dl,' '
        int 21h
        inc bx
   Loop print
         
        
    
    mov ah, 4ch     
    int 21h 
    
MAIN ENDP

SELECT_SORT proc
    push bx         ; push bx to the stack
    push cx          
    push si
    push dx 
    
    
    mov dx, si      ; dx contains the base of the array
    dec bx          ; bx = n-1
    
    cmp bx, 0
        je end_sort     ; if size = 1 then return
        
start_loop:
    mov si, dx      ; si points to the base of the array
    mov al, [si]    ; let al = arr[0]   ax contains the max number
    mov cx, bx      ; no of checks
    mov di, si      ; pointer to the max
    
find_big:
    add si, 1
    cmp [si], al
        jng next   ; if arr[i] is not greater than ax, then go next else update
    mov al, [si]   
    mov di, si
        
next:
    Loop find_big
    
swap:
    xchg al, [bx]   ; arr[bx] = al, al = arr[bx]
    mov [di], al    ; arr[di] = al
    
update:
    dec bx          ; bx = bx - 1
    jne start_loop  ; if bx <> 0, move to the start
         
end_sort: 

    pop dx 
    pop si
    pop cx
    pop bx
    
    ret
    

SELECT_SORT endp

END MAIN

