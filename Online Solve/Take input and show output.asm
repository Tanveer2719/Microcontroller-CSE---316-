.MODEL SMALL
.STACK 100H
.DATA

N DW 0
CR EQU 0DH
LF EQU 0AH

.CODE
MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    XOR BX, BX      ;BX = 0 
    
    
    TAKE_INPUT:
        
        MOV AH, 1
        INT 21H
        
        ; IF CARRIAGE RETURN OR NEW LINE, INPUT FINISHED
        CMP AL, CR
        JE PRINT_NUMBER
        CMP AL, LF
        JE PRINT_NUMBER
        
        
        AND AH, 00H
        MOV BX, AX      ;BX = AX
        MOV AX, 10      ;AX = 10
        MOV CX, N
        MUL CX           ;AX = 10*N
        ADD AX, BX       ;AX =AX+BX
        MOV N, AX        ;N = AX
        
        XOR AX, AX       ;AX = 0
        XOR CX, CX 
        
        MOV BX, N
        JMP S
        
        
        JMP TAKE_INPUT
    
         
    
    
    
    PRINT_NUMBER:
        
        ; PRINT NEW LINE
        MOV AH, 2
        MOV DL, CR
        INT 21H
        MOV DL, LF
        INT 21H
        
        MOV AX, N       ;AX = N
        
        CALL PRINT      ;CALL PRINT PROCEDURE 
        
    S:
        MOV AH, 2
        MOV DX, BX
        INT 21H
        
        
     MOV AH, 4CH
     INT 21H   
    
        
MAIN ENDP 

PRINT PROC
      
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
          DEC CL
          JMP SHOW
           
      E:
        RET
      
    
    
    
PRINT ENDP
END MAIN




