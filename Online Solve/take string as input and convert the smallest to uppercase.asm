.model small
.stack 100h
.data
    least db 'z'
.code

main proc 
    
    
    mov ax, @data
    mov ds, ax
    
    
    mov ah, 1
    

repeat:
    int 21h ;take input
    cmp al,'a'
    jl print
    cmp al,'z'
    jg print
    cmp al, least
    jl change
jmp repeat

 

change:
    mov least, al
    jmp repeat
    

print:
    mov ah, 2
    mov dl, 0dh
    int 21h
    mov dl, 0ah
    int 21h
    
    ;cl = least
    mov cl, least
    
    ;lower to upper
    sub CL, 'a'
    add cl, 'A'
    
    mov dl, cl
    int 21h
    
exit:
    mov ah, 4ch
    int 21h
    
    
   
main endp
end main



