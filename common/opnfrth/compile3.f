
  FORTH32 CONTEXT ! FORTH32 CURRENT !
  
  WORD: NOOP    ;WORD 
  WORD: (   )   WORD         ;WORD
  WORD: NAME>   N>LINK CELL+ ;WORD
 
  WORD: NONAME:   interpret# ,  immediator ;WORD 
 
  WORD: XT:  HEADER COMPILE [ ' 0 @ , ]  HERE CELL+ ,  NONAME:  ;WORD 
  
  WORD: VECT   HEADER  [ ' BADWORD @ LIT, ] , [ ' NOOP  LIT, ] ,   ;WORD 
  
  WORD: nopsing    hex, ffffffff  AND  hex, 9090909000000000 + ;WORD 
  
  ASSEMBLER FORTH32 LINK   ASSEMBLER CONTEXT !  ASSEMBLER CURRENT !  

  WORD: forward>     HERE  0 ,   HERE      ;WORD 
  WORD: >forward     HERE  hex, 4 + SWAP- nopsing SWAP!     ;WORD 
  WORD: backward<    HERE                    ;WORD 
  WORD: <backward    HERE  hex, 4 + -  nopsing ,       ;WORD 
  
  FORTH32 CONTEXT ! FORTH32 CURRENT !
  
 

  EXIT
  
