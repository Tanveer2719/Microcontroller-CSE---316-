.MODEL SMALL 
.STACK 100H 
.DATA

N DW 100
CR EQU 0DH
LF EQU 0AH

.CODE 
MAIN PROC 
    MOV AX, @DATA
    MOV DS, AX
    
    ; fast BX = 0
    XOR BX, BX
    
    INPUT_LOOP:
    ; char input 
    MOV AH, 1
    INT 21H
    
    ; if \n\r, stop taking input
    CMP AL, CR    
    JE END_INPUT_LOOP
    CMP AL, LF
    JE END_INPUT_LOOP
    
    ; fast char to digit
    ; also clears AH
    AND AX, 000FH
    
    ; save AX 
    MOV CX, AX
    
    ; BX = BX * 10 + AX
    MOV AX, 10D
    MUL BX
    ADD AX, CX
    MOV BX, AX
    JMP INPUT_LOOP
    
    END_INPUT_LOOP:
    ; PRINT NEW LINE
        MOV AH, 2
        MOV DL, CR
        INT 21H
        MOV DL, LF
        INT 21H
        
        MOV DX, N       ;AX = N
        
        CALL PRINT      ;CALL PRINT PROCEDURE 
    
        
        
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

