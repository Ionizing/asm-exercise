DATA    SEGMENT 
SEGMENT1C DW 0 
OFF1C DW 0  
SCORE DB 5 DUP('0'),'$' 
PADMSG DB 44 DUP(219) 
TMPMSG DB 25 DUP(?) 
STARTMSG1 DB 0DH,0AH,'SELECT SPEED.',0DH,0AH,'$' 
STARTMSG2 DB 20H,20H,'1. FAST',0DH,0AH,'$' 
STARTMSG3 DB 20H,20H,'2. MIDDLE',0DH,0AH,'$' 
STARTMSG4 DB 20H,20H,'3. SLOW',0DH,0AH,'$' 
STARTMSG5 DB 20H,20H,'0. EXIT',0DH,0AH,'$' 
ENDMSG  DB 0DH,0AH,'GOOD BYE!',0DH,0AH,'$' 
SCOREMSG1       DB      201,11 DUP(205),187 
SCOREMSG2       DB      186,'SCORE:     ',186 
SCOREMSG3       DB      204,11 DUP(205),185 
SCOREMSG4       DB      186,'LEFT  : A  ',186 
SCOREMSG5       DB      186,'RIGHT : D  ',186 
SCOREMSG6       DB      186,'UP    : W  ',186 
SCOREMSG7       DB      186,'DOWN  : S  ',186 
SCOREMSG8       DB      186,'-----------',186 
SCOREMSG9       DB      186,'EXIT  : ESC',186 
SCOREMSG10      DB      200,11 DUP(205),188 
SPEED DB 0 
TIM DB 0 
CON DB ? 
NUM DW ? 
PADMSG1 DB 400 DUP(?,?,?) 
FORM  DB 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2 
      DB 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2 
DATA ENDS  

STACK SEGMENT STACK 
DB 200 DUP(?) 
STACK ENDS  

CODE SEGMENT 
ASSUME  CS:CODE,DS:DATA,ES:DATA,SS:STACK 
START:  MOV AX,DATA 
MOV DS,AX 
PUSH DS 
;GET INT 1C ADRESS 
MOV AL,1CH 
MOV AH,35H 
INT 21H 
MOV SEGMENT1C,ES 
MOV OFF1C,BX 
;SET INT 1C ADRESS 
MOV DX,OFFSET INT1C 
MOV AX,SEG INT1C 
MOV DS,AX 
MOV AL,1CH 
MOV AH,25H 
INT 21H 
POP DS 

GAMEOVER:  
MOV AH,00H 
MOV AL,03H 
INT  10H 
SELECTSPEED: 
MOV AH,09H 
MOV DX,OFFSET STARTMSG1 
INT 21H 
MOV DX,OFFSET STARTMSG2 
INT 21H 
MOV DX,OFFSET STARTMSG3 
INT 21H 
MOV DX,OFFSET STARTMSG4 
INT 21H 
MOV DX,OFFSET STARTMSG5 
INT 21H 
MOV AH,08H 
INT  21H 
SUB AL,'0' 
MOV CL,AL 
AND AL,3 
CMP AL,CL 
        JNE     SELECTSPEED 
        INC AL 
INC CL 
MUL CL 
        CMP     AL,1H 
        JE EXIT1 
MOV SPEED,AL 
   
;SET GRAPHICS 
MOV AH,00H 
MOV AL,12H 
INT 10H 
MOV AH,0BH 
MOV BH,01 
MOV BL,00H 
INT 10H 
;START  GAME 
CALL INITGAME 
CALL DISPSCORE 
CALL RANDOM 
CALL  DELAY 

MOV TIM,0H 
LOOP1: 
STI 
CMP CON,0 
JZ LOOP11 
MOV DL,07H 
MOV AH,02H 
INT  21H 
MOV AH,08H 
INT  21H 
JMP GAMEOVER 
LOOP11: 

MOV AL,TIM 
CMP AL,SPEED 
JG TIME 
JMP LOOP1 

TIME:  
MOV TIM,0H 
MOV  AH,1 
INT  16H 
JNZ  FLAG3 
CALL BLANK  
  JMP LOOP1 
FLAG3: 
MOV  AH,0 
INT  16H 
PUSH AX 
MOV  AH,1 
INT  16H 
JZ FLAG2 
  POP AX 
JMP FLAG3 
EXIT1: 
JMP EXIT 
FLAG2: 
  POP AX 
   CMP  AL,1BH 
   JZ  EXIT 
   CMP AL,'a' 
   JZ KA 
   CMP AL,'s' 
   JZ KS 
   CMP AL,'d' 
   JZ KD 
   CMP AL,'w' 
   JZ KW 
   CALL BLANK 
   JMP LOOP1 
KA: 
CALL LEFT 
JMP  LOOP1 
KS: 
CALL DOWN    
JMP LOOP1 
KD: 
CALL  RIGHT 
JMP LOOP1 
KW: 
CALL  UP 
JMP LOOP1 

EXIT:  
;SET GRAPHICS 
MOV AX,0003H 
INT  10H 
MOV AX,DATA 
MOV DS,AX 
MOV DX,OFFSET ENDMSG 
MOV AH,09H 
INT  21H 
;SET INT 1C ADRESS 
MOV DX,OFF1C 
MOV AX,SEGMENT1C 
MOV DS,AX 
MOV AL,1CH 
MOV AH,25H 
INT 21H 
MOV AX,4C00H 
INT 21H  

INT1C PROC 
STI 
PUSH AX 
PUSH DX 
MOV AX,DATA 
MOV DS,AX 
INC TIM 
POP  DX 
POP AX 
IRET 
INT1C ENDP  

LEFT PROC NEAR 
MOV SI,0 
MOV AX,NUM 
DEC AX 
MOV BX,3 
MUL BX 
ADD SI,AX 
MOV CH,PADMSG1[SI] 
MOV CL,PADMSG1[SI+1] 
CMP PADMSG1[SI+2],1 
JNZ LEFT1 
CALL CHECK1 
JMP LEXIT1 
LEFT1: 
CALL CHECK3 
LEXIT1: 
RET 
LEFT ENDP 

RIGHT PROC NEAR 
MOV SI,0 
MOV AX,NUM 
DEC AX 
MOV BX,3 
MUL BX 
ADD SI,AX 
MOV CH,PADMSG1[SI] 
MOV CL,PADMSG1[SI+1] 
CMP PADMSG1[SI+2],3 
JNZ RIGHT1 
CALL CHECK3 
JMP REXIT1 
RIGHT1: 
CALL CHECK1 
REXIT1: 
RET 
RIGHT ENDP 

CHECK1 PROC NEAR 
MOV AL,CH 
SUB AL,3 
MOV BL,22 
MUL BL 
MOV SI,0 
ADD SI,AX 
ADD CL,2 
SHR CL,1 
SUB CL,2 
MOV CH,0 
ADD SI,CX 
CMP FORM[SI],0 
JNZ CHECK11 
CALL FORM10 
JMP C1EXIT1 
CHECK11: 
CMP FORM[SI],1 
JNZ CHECK12 
CALL FORM11 
JMP C1EXIT1 
CHECK12: 
CMP FORM[SI],3 
JNZ CHECK13 
CALL FORM13 
JMP C1EXIT1 
CHECK13: 
MOV CON,1 
C1EXIT1: 
RET 
CHECK1 ENDP 


FORM10 PROC NEAR 
MOV BL,0 
CALL CLEAR0 
MOV SI,OFFSET PADMSG1 
MOV DH,[SI] 
MOV DL,[SI+1] 
CALL DISPCELL 
MOV DI,SI 
ADD SI,3 
MOV AX,NUM 
DEC AX 
MOV BX,3 
MUL BX 
MOV CX,AX 
CLD 
FORM101: 
LODSB 
STOSB 
LOOP FORM101 
DEC DI 
MOV BYTE PTR [DI],1 
DEC SI 
MOV BYTE PTR [SI],1 
DEC SI 
ADD BYTE PTR [SI],2 
MOV DH,[SI-1] 
MOV DL,[SI] 
MOV BL,01010101B 
CALL DISPCELL 
MOV BL,1 
CALL CLEAR0 
RET 
FORM10 ENDP 


FORM11 PROC NEAR 
MOV SI,OFFSET PADMSG1 
MOV CH,[SI] 
MOV CL,[SI+1] 
MOV AX,NUM 
DEC AX 
MOV BX,3 
MUL BX 
ADD SI,AX 
MOV BH,[SI] 
MOV BL,[SI+1] 
ADD BL,2 
CMP BH,CH 
JNZ FORM111 
CMP BL,CL 
JNZ FORM111 
CALL FORM10 
JMP F11EXIT1 
FORM111: 
MOV CON,1 
F11EXIT1: 
RET 
FORM11 ENDP 

FORM13 PROC NEAR 
MOV BL,0 
CALL CLEAR0 
MOV SI,OFFSET PADMSG1 
MOV AX,NUM 
MOV BX,3 
MUL BX 
ADD SI,AX 
MOV AL,[SI-3] 
MOV [SI],AL 
MOV AL,[SI-2] 
ADD AL,2 
MOV [SI+1],AL 
MOV BYTE PTR [SI-1],1 
MOV BYTE PTR [SI+2],1 
INC NUM 
MOV DH,[SI] 
MOV DL,[SI+1] 
MOV BL,01010101B 
CALL DISPCELL 
MOV BL,1 
CALL CLEAR0 
INC SCORE[4] 
MOV CX,05H 
MOV SI,04H 
FORM131: CMP SCORE[SI],'9' 
JNG FORM132 
INC SCORE[SI-1] 
SUB SCORE[SI],0AH 
FORM132: DEC SI 
LOOP FORM131 
CALL DISPSCORE 
CALL RANDOM 
RET 
FORM13 ENDP 

CHECK3 PROC NEAR 
MOV AL,CH 
SUB AL,3 
MOV BL,22 
MUL BL 
MOV SI,0 
ADD SI,AX 
SUB CL,2 
SHR CL,1 
SUB CL,2 
MOV CH,0 
ADD SI,CX 
CMP FORM[SI],0 
JNZ CHECK31 
CALL FORM30 
JMP C3EXIT1 
CHECK31: 
CMP FORM[SI],1 
JNZ CHECK32 
CALL FORM31 
JMP C3EXIT1 
CHECK32: 
CMP FORM[SI],3 
JNZ CHECK33 
CALL FORM33 
JMP C3EXIT1 
CHECK33: 
MOV CON,1 
C3EXIT1: 
RET 
CHECK3 ENDP 

FORM30 PROC NEAR 
MOV BL,0 
CALL CLEAR0 
MOV SI,OFFSET PADMSG1 
MOV DH,[SI] 
MOV DL,[SI+1] 
CALL DISPCELL 
MOV DI,SI 
ADD SI,3 
MOV AX,NUM 
DEC AX 
MOV BX,3 
MUL BX 
MOV CX,AX 
CLD 
FORM301: 
LODSB 
STOSB 
LOOP FORM301 
DEC DI 
MOV BYTE PTR [DI],3 
DEC SI 
MOV BYTE PTR [SI],3 
DEC SI 
SUB BYTE PTR [SI],2 
MOV BL,01010101B 
MOV DH,[SI-1] 
MOV DL,[SI] 
MOV BL,01010101B 
CALL DISPCELL 
MOV BL,1 
CALL CLEAR0 
RET 
FORM30 ENDP 

FORM31 PROC NEAR 
MOV SI,OFFSET PADMSG1 
MOV CH,[SI] 
MOV CL,[SI+1] 
MOV AX,NUM 
DEC AX 
MOV BX,3 
MUL BX 
ADD SI,AX 
MOV BH,[SI] 
MOV BL,[SI+1] 
SUB BL,2 
CMP BH,CH 
JNZ FORM311 
CMP BL,CL 
JNZ FORM311 
CALL FORM30 
JMP F31EXIT1 
FORM311: 
MOV CON,1 
F31EXIT1: 
RET 
FORM31 ENDP 

FORM33 PROC NEAR 
MOV BL,0 
CALL CLEAR0 
MOV SI,OFFSET PADMSG1 
MOV AX,NUM 
MOV BX,3 
MUL BX 
ADD SI,AX 
MOV AL,[SI-3] 
MOV [SI],AL 
MOV AL,[SI-2] 
SUB AL,2 
MOV [SI+1],AL 
MOV BYTE PTR [SI-1],3 
MOV BYTE PTR [SI+2],3 
INC NUM 
MOV DH,[SI] 
MOV DL,[SI+1] 
MOV BL,01010101B 
CALL DISPCELL 
MOV BL,1 
CALL CLEAR0 
INC SCORE[4] 
MOV CX,05H 
MOV SI,04H 
FORM331: CMP SCORE[SI],'9' 
JNG FORM332 
INC SCORE[SI-1] 
SUB SCORE[SI],0AH 
FORM332: DEC SI 
LOOP FORM331 
CALL DISPSCORE 
CALL RANDOM 
RET 
FORM33 ENDP 

DOWN PROC NEAR 
MOV SI,0 
MOV AX,NUM 
DEC AX 
MOV BX,3 
MUL BX 
ADD SI,AX 
MOV CH,PADMSG1[SI] 
MOV CL,PADMSG1[SI+1] 
CMP PADMSG1[SI+2],4 
JNZ DOWN1 
CALL CHECK4 
JMP DEXIT1 
DOWN1: 
CALL CHECK2 
DEXIT1: 
RET 
DOWN ENDP 

UP PROC NEAR 
MOV SI,0 
MOV AX,NUM 
DEC AX 
MOV BX,3 
MUL BX 
ADD SI,AX 
MOV CH,PADMSG1[SI] 
MOV CL,PADMSG1[SI+1] 
CMP PADMSG1[SI+2],2 
JNZ UP1 
CALL CHECK2 
JMP UEXIT1 
UP1: 
CALL CHECK4 
UEXIT1: 
RET 
UP ENDP 

CHECK2 PROC NEAR 
MOV AL,CH 
SUB AL,2 
MOV BL,22 
MUL BL 
MOV SI,0 
ADD SI,AX 
SHR CL,1 
SUB CL,2 
MOV CH,0 
ADD SI,CX 
CMP FORM[SI],0 
JNZ CHECK21 
CALL FORM20 
JMP C2EXIT1 
CHECK21: 
CMP FORM[SI],1 
JNZ CHECK22 
CALL FORM21 
JMP C2EXIT1 
CHECK22: 
CMP FORM[SI],3 
JNZ CHECK23 
CALL FORM23 
JMP C2EXIT1 
CHECK23: 
MOV CON,1 
C2EXIT1: 
RET 
CHECK2 ENDP 

FORM20 PROC NEAR 
MOV BL,0 
CALL CLEAR0 
MOV SI,OFFSET PADMSG1 
MOV DH,[SI] 
MOV DL,[SI+1] 
CALL DISPCELL 
MOV DI,SI 
ADD SI,3 
MOV AX,NUM 
DEC AX 
MOV BX,3 
MUL BX 
MOV CX,AX 
CLD 
FORM201: 
LODSB 
STOSB 
LOOP FORM201 
DEC DI 
MOV BYTE PTR [DI],2 
DEC SI 
MOV BYTE PTR [SI],2 
DEC SI 
DEC SI 
INC BYTE PTR [SI] 
MOV DH,[SI] 
MOV DL,[SI+1] 
MOV BL,01010101B 
CALL DISPCELL 
MOV BL,1 
CALL CLEAR0 
RET 
FORM20 ENDP  

FORM21 PROC NEAR 
MOV SI,OFFSET PADMSG1 
MOV CH,[SI] 
MOV CL,[SI+1] 
MOV AX,NUM 
DEC AX 
MOV BX,3 
MUL BX 
ADD SI,AX 
MOV BH,[SI] 
MOV BL,[SI+1] 
ADD BH,1 
CMP BH,CH 
JNZ FORM211 
CMP BL,CL 
JNZ FORM211 
CALL FORM20 
JMP F21EXIT1 
FORM211: 
MOV CON,1 
F21EXIT1: 
RET 
FORM21 ENDP 

FORM23 PROC NEAR 
MOV BL,0 
CALL CLEAR0 
MOV SI,OFFSET PADMSG1 
MOV AX,NUM 
MOV BX,3 
MUL BX 
ADD SI,AX 
MOV AL,[SI-3] 
INC AL 
MOV [SI],AL 
MOV AL,[SI-2] 
MOV [SI+1],AL 
MOV BYTE PTR [SI-1],2 
MOV BYTE PTR [SI+2],2 
INC NUM 
MOV DH,[SI] 
MOV DL,[SI+1] 
MOV BL,01010101B 
CALL DISPCELL 
MOV BL,1 
CALL CLEAR0 
INC SCORE[4] 
MOV CX,05H 
MOV SI,04H 
FORM231: CMP SCORE[SI],'9' 
JNG FORM232 
INC SCORE[SI-1] 
SUB SCORE[SI],0AH 
FORM232: DEC SI 
LOOP FORM231 
CALL DISPSCORE 
CALL RANDOM 
RET 
FORM23 ENDP 

CHECK4 PROC NEAR 
MOV AL,CH 
SUB AL,4 
MOV BL,22 
MUL BL 
MOV SI,0 
ADD SI,AX 
SHR CL,1 
SUB CL,2 
MOV CH,0 
ADD SI,CX 
CMP FORM[SI],0 
JNZ CHECK41 
CALL FORM40 
JMP C4EXIT1 
CHECK41: 
CMP FORM[SI],1 
JNZ CHECK42 
CALL FORM41 
JMP C4EXIT1 
CHECK42: 
CMP FORM[SI],3 
JNZ CHECK43 
CALL FORM43 
JMP C4EXIT1 
CHECK43: 
MOV CON,1 
C4EXIT1: 
RET 
CHECK4 ENDP 

FORM40 PROC NEAR 
MOV BL,0 
CALL CLEAR0 
MOV SI,OFFSET PADMSG1 
MOV DH,[SI] 
MOV DL,[SI+1] 
CALL DISPCELL 
MOV DI,SI 
ADD  SI,3 
MOV AX,NUM 
DEC AX 
MOV BX,3 
MUL BX 
MOV CX,AX 
CLD 
FORM401: 
LODSB 
STOSB 
LOOP FORM401 
DEC DI 
MOV BYTE PTR [DI],4 
DEC SI 
MOV BYTE PTR [SI],4 
DEC SI 
DEC SI 
DEC BYTE PTR [SI] 
MOV DH,[SI] 
MOV DL,[SI+1] 
MOV BL,01010101B 
CALL DISPCELL 
MOV BL,1 
CALL CLEAR0 
RET 
FORM40 ENDP 

FORM41 PROC NEAR 
MOV SI,OFFSET PADMSG1 
MOV CH,[SI] 
MOV CL,[SI+1] 
MOV AX,NUM 
DEC AX 
MOV BX,3 
MUL BX 
ADD SI,AX 
MOV BH,[SI] 
MOV BL,[SI+1] 
SUB BH,1 
CMP BH,CH 
JNZ FORM411 
CMP BL,CL 
JNZ FORM411 
CALL FORM40 
JMP F41EXIT1 
FORM411: 
MOV CON,1 
F41EXIT1: 
RET 
FORM41 ENDP 

FORM43 PROC NEAR 
MOV BL,0 
CALL CLEAR0 
MOV SI,OFFSET PADMSG1 
MOV AX,NUM 
MOV BX,3 
MUL BX 
ADD SI,AX 
MOV AL,[SI-3] 
DEC AL 
MOV [SI],AL 
MOV AL,[SI-2] 
MOV [SI+1],AL 
MOV BYTE PTR [SI-1],4 
MOV BYTE PTR [SI+2],4 
INC NUM 
MOV DH,[SI] 
MOV DL,[SI+1] 
MOV BL,01010101B 
CALL DISPCELL 
MOV BL,1 
CALL CLEAR0 
INC SCORE[4] 
MOV CX,05H 
MOV SI,04H 
FORM431: CMP SCORE[SI],'9' 
JNG FORM432 
INC SCORE[SI-1] 
SUB SCORE[SI],0AH 
FORM432: DEC SI 
LOOP FORM431 
CALL DISPSCORE 
CALL RANDOM 
RET 
FORM43 ENDP 

CLEAR0 PROC NEAR 
MOV SI,OFFSET PADMSG1 
MOV CX,NUM 
CLEAR01:  
PUSH BX 
MOV DI,OFFSET FORM 
MOV AL,[SI] 
SUB AL,3 
MOV BL,22 
MUL BL 
ADD DI,AX 
MOV AL,[SI+1] 
SHR AL,1 
SUB AL,2 
MOV AH,0 
ADD DI,AX 
POP BX 
MOV [DI],BL 
ADD SI,3 
LOOP CLEAR01 
RET 
CLEAR0 ENDP 

BLANK PROC NEAR 
MOV SI,0 
MOV AX,NUM 
DEC AX 
MOV BX,3 
MUL BX 
ADD SI,AX 
MOV CH,PADMSG1[SI] 
MOV CL,PADMSG1[SI+1] 
CMP PADMSG1[SI+2],1 
JNZ BLANK1 
CALL CHECK1 
JMP BEXIT1 
BLANK1: 
CMP PADMSG1[SI+2],2 
JNZ BLANK2 
CALL  CHECK2 
JMP BEXIT1 
BLANK2: 
CMP PADMSG1[SI+2],3 
JNZ BLANK3 
CALL CHECK3 
JMP BEXIT1 
BLANK3: 
CALL CHECK4 
BEXIT1: 
RET 
BLANK ENDP 

DELAY PROC NEAR 
PUSH CX 
        MOV     CX,00FFH 
LOOP20: LOOP    LOOP20  
POP CX 
RET 
DELAY ENDP 

DISPSCORE PROC NEAR 
MOV AX,DATA 
MOV ES,AX 
MOV BP,OFFSET SCORE 
MOV CX,05H 
        MOV     DX,0643H 
MOV BH,0H 
MOV AL,0H 
MOV BL,00110100B 
MOV AH,13H 
INT 10H 
RET 
DISPSCORE ENDP  

DISPPAD PROC NEAR   ;BX BH=PAGE BL=COLOR 
MOV SI,OFFSET PADMSG1 
MOV CX,NUM 
MOV BH,0 

DISPPAD1: 
MOV DH,[SI] 
MOV DL,[SI+1] 
CALL DISPCELL 
ADD SI,3 
LOOP DISPPAD1  

RET 
DISPPAD ENDP  

DISPCELL PROC NEAR;DH=ROW DL=COL BH=PAGE BL=COLOR 
PUSH AX 
PUSH BX 
PUSH CX 
PUSH DX 
PUSH DI 
PUSH SI 
MOV BP,OFFSET PADMSG 
MOV CX,02H 
MOV AX,1300H 
INT  10H 
CMP BL,0H 
JE SKIP20 
;CALC ROW 
MOV AH,0H 
MOV AL,DH 
        MOV     CL,16 
MUL CL 
MOV SI,AX 
;CALC COL 
MOV AH,0H 
MOV AL,DL 
MOV CL,8 
MUL CL 
MOV DI,AX 
;DRAW 
MOV AX,0C00H 
MOV DX,SI 
        ADD     DX,15 
MOV CX,16 
LOOP21: ADD CX,DI 
DEC CX 
INT 10H 
INC CX 
SUB CX,DI 
LOOP LOOP21 

        MOV     DX,SI 
        MOV     CX,15 
        ADD     DI,15 
LOOP22: PUSH    CX 
        MOV     CX,DI 
        INT     10H 
        INC     DX 
        POP     CX 
        LOOP    LOOP22  

        SUB     DI,2 
        DEC     DX 
        MOV     CX,13 
LOOP23: PUSH    CX 
        DEC     DX 
        MOV     CX,DI 
        INT     10H 
        SUB     CX,12 
        MOV     AL,07H 
        INT     10H 
        MOV     AL,00H 
        POP     CX 
        LOOP    LOOP23  

        MOV     AX,0C07H 
MOV DX,SI 
        ADD     DX,1 
        MOV     CX,12 
        SUB     DI,12 
LOOP24: ADD     CX,DI 
INT 10H 
SUB CX,DI 
        LOOP    LOOP24 

SKIP20: POP SI 
POP DI 
POP DX 
POP CX 
POP BX 
POP AX 
RET 
DISPCELL ENDP 

CLS PROC NEAR 
MOV CX,0 
MOV DH,24 
MOV DL,79 
MOV BH,0 
MOV AX,600H 
INT 10H 
RET 
CLS ENDP  

RANDOM PROC NEAR 
RANDOM1: 
IN AX,40H 
INC AH 
INC AL 
AND AH,15 
MOV DH,AH 
AND AL,15 
MOV DL,AL 
IN AX,40H 
INC AH 
INC AL 
AND AH,3 
ADD DH,AH 
AND AL,3 
ADD DL,AL 
IN AX,40H 
INC AH 
INC AL 
AND AH,1 
ADD DH,AH 
AND AL,1 
ADD DL,AL 

MOV SI,0 
MOV AL,DH 
INC AL 
MOV BL,22 
MUL BL 
ADD SI,AX 
MOV AL,DL 
INC AL 
MOV AH,0 
ADD SI,AX 
CMP FORM[SI],0 
JNZ RANDOM1 

MOV FORM[SI],3 
ADD DH,4 
SHL DL,1 
ADD DL,6 
MOV BL,01011001B 
MOV BH,0 
CALL  DISPCELL 
RET 
RANDOM ENDP 



INITGAME PROC NEAR 
CALL CLS 
;DRAW   TEXTFRAME 
MOV AX,DATA 
MOV ES,AX 
        MOV     CX,10 
MOV BP,OFFSET SCOREMSG1 
        MOV     DX,053CH 
LOOP72: PUSH CX 
        MOV     CX,13 
MOV AL,0H 
MOV BH,0H 
        MOV     BL,01011010B 
MOV AH,13H 
INT 10H 
        ADD     BP,13 
INC DH 
POP CX 
LOOP LOOP72 

;DRAW BOARDFRAME 
MOV BP,OFFSET PADMSG 
        MOV     CX,0044 
        MOV     DX,0304H 
MOV BH,0H 
MOV AL,0H 
MOV BL,00110100B 
MOV AH,13H 
INT 10H 
        MOV     DX,1804H 
INT 10H  

MOV CX,20 
        MOV     DX,0304H 
LOOP4: MOV SI,CX 
MOV CX,02 
INC DH 
INT 10H 
MOV CX,SI 
LOOP LOOP4  

MOV CX,20 
        MOV     DX,032EH 
INITGAME1: MOV SI,CX 
MOV CX,02 
INC DH 
INT 10H 
MOV CX,SI 
LOOP INITGAME1 
;FORMAT SCORE 
MOV DI,OFFSET SCORE 
MOV AL,'0' 
MOV CX,05H 
REP STOSB 

MOV CON,0 
MOV NUM,4 
MOV DI,OFFSET PADMSG1 
MOV CX,1200 
MOV AX,0 
CLD 
REP STOSB 
MOV SI,OFFSET FORM 
MOV CX,484 
IN1: 
MOV AL,[SI] 
CMP AL,1 
JNZ IN2 
MOV BYTE PTR [SI],0 
JMP IN3 
IN2: 
CMP AL,3 
JNZ IN3 
MOV BYTE PTR [SI],0 
IN3: 
INC SI 
LOOP IN1 

MOV SI,OFFSET FORM 
ADD SI,46 
MOV BYTE PTR [SI],1 
INC SI 
MOV BYTE PTR [SI],1 
INC SI 
MOV BYTE PTR[SI],1 
INC SI 
MOV BYTE PTR [SI],1 

MOV SI,OFFSET PADMSG1 
MOV AL,5 
MOV [SI],AL 
INC SI 
MOV AL,8 
MOV [SI],AL 
INC SI 
MOV AL,1 
MOV [SI],AL 
INC SI 

MOV AL,5 
MOV [SI],AL 
INC SI 
MOV AL,10 
MOV [SI],AL 
INC SI 
MOV AL,1 
MOV [SI],AL 
INC SI 

MOV AL,5 
MOV [SI],AL 
INC SI 
MOV AL,12 
MOV [SI],AL 
INC SI 
MOV AL,1 
MOV [SI],AL 
INC SI 

MOV AL,5 
MOV [SI],AL 
INC SI 
MOV AL,14 
MOV [SI],AL 
INC SI 
MOV AL,1 
MOV [SI],AL 

MOV BL,01010101B 
CALL DISPPAD 
RET 
INITGAME ENDP  

CODE ENDS 
END START  
