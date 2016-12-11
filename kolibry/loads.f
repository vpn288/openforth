   INCLUDE: includes.f

   INCLUDE: osapi.f
   INCLUDE: lowlevel/type.f
   INCLUDE: lowlevel/numbers_low.f
   INCLUDE: numbers.f
   INCLUDE: type.f
   INCLUDE: keys.f

   FORTH32 CONTEXT !   FORTH32 CURRENT !
   
  
  WORD: PAD	   HERE   hex, 200   +	 ;WORD

  WORD: S"        QUOTE   BUFFER  @ PAD  (WORD)    PAD  ;WORD
 
 
  WORD: set_console_input   tib# tib clear
                            tib  BUFFER  !    
                            tib# filestruc CELL+ CELL+ CELL+ !
							       ;WORD
								   
  								   
WORD: badmsg   ."  Badword:" HERE TYPE ;WORD

' badmsg  ' BADWORD CELL+ !  
 
WORD: F-SYSTEM  
           Begin  
		   set_console_input  CRLF  ." SP:" SP@ h. ." HERE:" HERE h. CRLF 
                  ." OK>"  EXPECT   CRLF 0 >IN !  INTERPRET   Again  ;WORD 

    
	
  F-SYSTEM
  
  
   BYE
