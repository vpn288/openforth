FORTH32 CONTEXT ! FORTH32 CURRENT !

WORD: autocreate   HERE (HEADER) COMPILE [ ' 0 @ , ] ,   ;WORD

VOCABULARY autoword

autoword CURRENT !

WORD: ;Autowords    quit ;WORD

autoword FORTH32 LINK  autoword CONTEXT !

' autocreate ' BADWORD CELL+ ! 

FORTH32 CONTEXT ! FORTH32 CURRENT !  autoword UNLINK 

WORD: Autowords:    Begin  PARSE  autoword SFIND  EXECUTE  Again ;WORD 


Autowords:
 type_on_you   hi there! again 
;Autowords

type_on_you TYPE  hi TYPE  there! TYPE  again TYPE 

EXIT


 FORTH32 CURRENT ! FORTH32 CONTEXT ! 


VOCABULARY constants

constants CURRENT !   constants FORTH32 LINK   

WORD: ;Constants       break ;WORD

WORD: is    CONSTANT  ;WORD
WORD: 0x 	0x ;WORD 
 

FORTH32 CURRENT !   FORTH32 CONTEXT !   constants UNLINK


WORD: Constants:   Begin  PARSE  constants SFIND  EXECUTE  Again  ;WORD


( Constants:  0x 999 is abc   0x 1234 is def  0x 456 is erw   ;Constants 

abc h. erw h. def h. )
 
FORTH32 CURRENT ! FORTH32 CONTEXT !

 EXIT   
