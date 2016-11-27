 FORTH32 CURRENT ! FORTH32 CONTEXT ! 


VOCABULARY constants

constants CURRENT !   constants FORTH32 LINK   constants CONTEXT !

WORD: ;Constants       break ;WORD

WORD: is    CONSTANT  ;WORD
 

FORTH32 CURRENT ! FORTH32 CONTEXT ! 


WORD: Constants:   Begin  PARSE  constants SFIND  EXECUTE  Again  ;WORD

 EXIT 

 Example:
 
Constants:  
  0x 999  is abc   
	0x 1234 is def  
	0x 456  abc + is erw   
;Constants 

 
  
