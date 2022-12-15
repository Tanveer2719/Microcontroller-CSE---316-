.MODEL SMALL
.STACK 100H
.DATA
    MSG DB "=>","$"
    N DW 17D
.CODE
MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    MOV DL, 0                                                                                                                
    
    INPUT:
        MOV AH, 1
        INT 21H
        MOV CL, AL
        CMP CL, 'H'
        JL PRINT
        JE PRINT_EXIT
        JMP EXIT
        
    PRINT:
        MOV AH, 09H
        LEA DX, MSG
        INT 21H
        JMP PRINT_NUMBER
        
        ; PRINT NEW LINE
    PRINT_NEW_LINE:
        MOV AH, 2
        MOV DL, 0DH
        INT 21H
        MOV DL, 0AH
        INT 21H
        
        ;AGAIN GO FOR INPUT
        JMP INPUT
    
        
    PRINT_NUMBER:
        MOV AX, N       ;AX = N
        MOV BX, 10D     ;BX = 10
        CALL PRINT_PROC
        
        MOV AX, N       
        DEC AX          ;AX = N-1
        MOV N, AX       ;N = N-1
        JMP PRINT_NEW_LINE
        
    
       
    PRINT_EXIT:
        MOV AH, 09H
        LEA DX, MSG
        INT 21H
           
    
    EXIT:
        MOV AH, 4CH
        INT 21H
    
    
    
    
MAIN ENDP


PRINT_PROC PROC
    
    ;INITIALIZE COUNT
    MOV CL, 0
    
    ;DIVISOR  'DL'
    
    
    
    INITIALS:
        CMP AX, 0
        JE PRINT_N        ; IF AX = 0 THEN EXTRACTION COMPLETED
        
        DIV BX          ;17/10.....result is in AL, remainder is in AH
        MOV BX, DX      ;EXTRACT THE REAMAINDER
        XOR DX, DX      ;SET THE HIGH BITS = 0
        PUSH BX         ;PUSH BL TO THE STACK
        INC CL          ;INCREASE COUNT
        
        JMP INITIALS 
        
    PRINT_N:
        CMP CL, 0       ; IF COUNT COMPLETE THEN EXIT
        JE E
        
        POP BX                          
        ADD BX, 48D     ;CONVERT THE DIGIT TO ASCII
        
        ;PRINT THE DIGIT
        MOV DX, BX
        MOV AH, 2
        INT 21H
        
        ;DECREMENT THE COUNT
        DEC CL
        JMP PRINT_N
        
        
        
    
    E:
        RET
    

PRINT_PROC ENDP
    
    
END MAIN
 