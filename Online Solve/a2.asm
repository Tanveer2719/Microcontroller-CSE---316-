;take input three characters and output a pattern

.model small
.stack 100h
.data
    char1 db ?
    char2 db ?
    char3 db ?
.code
main proc
    mov ax, @data
    mov ds,ax
    
    mov ah, 1
    int 21h
    mov char1,al
    int 21h
    mov char2,al
    int 21h
    mov char3,al
    
    
    mov ah, 2
    mov bl,8
    
    mov dl, 0dh
    int 21h
    mov dl, 0ah 
    int 21h
    
    PRINT:
        dec bl
        cmp bl,7
        je print_5_stars
        cmp bl,6
        je print_5_stars
        cmp bl,5
        je print_c1
        cmp bl,4
        je print_c
        cmp bl,3
        je print_c3 
        cmp bl,2
        je print_5_stars
        cmp bl,1
        je print_5_stars
                         
        jmp e;
        
        
    print_5_stars:
        mov cx, 5
        mov dl, '*'
        F1:
            int 21h
        loop f1
        
        mov dl, 0dh
        int 21h
        mov dl, 0ah
        int 21h
        
    jmp print
    
    
    print_c1:
        mov cx,5
        F2:
            cmp cx,3
            je c1
            mov dl,'*'
            int 21h
        loop f2
            
            mov dl, 0dh
            int 21h
            mov dl, 0ah
            int 21h
      jmp print
            
        c1:
            mov dl, char1
            int 21h
            dec cx
        jmp f2
        
        
      print_c:
        mov cx,5
        F3:
            cmp cx,4
                je ch1
            cmp cx,3
                je ch2
            cmp cx,2
                je ch3
            
            mov dl,'*'
            int 21h
        loop f3
            
            mov dl, 0dh
            int 21h
            mov dl, 0ah
            int 21h
      jmp print
            
        ch1:
            mov dl, char1
            int 21h
            dec cx
        jmp f3
         ch2:
            mov dl, char2
            int 21h
            dec cx
        jmp f3
         ch3:
            mov dl, char3
            int 21h
            dec cx
        jmp f3
        
      print_c3:
        mov cx,5
        F4:
            cmp cx,3
            je c3
            mov dl,'*'
            int 21h
        loop f4
            
            mov dl, 0dh
            int 21h
            mov dl, 0ah
            int 21h
      jmp print
            
        c3:
            mov dl, char3
            int 21h
            dec cx
        jmp f4
    
            
    
        
    
    
    
    
    e:
        mov ah, 4ch
        int 21h
        
        
main endp
end main