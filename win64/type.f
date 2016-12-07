FORTH32 CONTEXT !    FORTH32 CURRENT !

 VARIABLE NumberOfCharsWritten
 
 WORD: COUNT   DUP 1+ SWAP C@ ;WORD 
 
  

WORD: TYPE   oHandle SWAP  COUNT  NumberOfCharsWritten 0 WriteConsoleA  Pop ;WORD

WORD: TYPEZ  oHandle SWAP  ASCIIZ>COUNT  NumberOfCharsWritten 0 WriteConsoleA  Pop ;WORD 

WORD: EMIT    SP@ oHandle SWAP 1 NumberOfCharsWritten 0 WriteConsoleA  Pop Pop  ;WORD 

WORD: nEMIT   >R SP@ oHandle SWAP R>  NumberOfCharsWritten 0 WriteConsoleA  Pop Pop  ;WORD 


 
WORD: .(       )   WORD   HERE   TYPE  ;WORD 

WORD: CRLF  hex, 200d0a2004  SP@ TYPE Pop      ;WORD 

   IMMEDIATES CURRENT !
   
WORD: ."     ," COMPILE TYPE ;WORD

   FORTH32 CURRENT ! 
   
 
EXIT
