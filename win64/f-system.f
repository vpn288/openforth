FORTH32 CONTEXT !    FORTH32 CURRENT !

 0x 40 CONSTANT tib# 
 
 VARIABLE chars   CREATE tib   tib# ALLOT 

 WORD: EXPECT   iHandle tib  tib#  chars 0 ReadConsoleA Pop ;WORD 

 
  WORD: set_console_input    tib# tib clear 
                             tib  BUFFER   !    0 BUFFER CELL+ !  
                            tib# >IN CELL+  ! 
 ;WORD
 
 WORD: WAIT    Sleep Pop ;WORD 
 
 WORD: BYE  CRLF  ." Bye-bye in 12 seconds..."  0d, 12000 WAIT   0 ExitProcess ;WORD 

 WORD: ABORT    ." Badword:" HERE TYPE  ."   Abort!  " BYE ;WORD 
 
 ' ABORT  ' BADWORD CELL+ !
 
 WORD: F-SYSTEM  
           Begin  
		     set_console_input   CRLF  ." SP:" SP@ h. ." HERE:" HERE h. CRLF 
                  ." OK>"  EXPECT   CRLF 0 >IN ! INTERPRET    Again  ;WORD 

F-SYSTEM

EXIT
