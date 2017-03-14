ASSEMBLER FORTH32 LINK   ASSEMBLER CONTEXT ! FORTH32 CURRENT !

 Word: (jsr)   ', nop ', nop ', nop ', nop  
               ', mov_rdx,#    ' dodoes @ LIT,  ', ,  ', call_rdx    ;Word 
 
 Word: (does>)  ', RDROP  ', R> ', CELL+ ', LATEST ', N>LINK  ', CELL+  ', ! ;Word

 
 FORTH32 CONTEXT !  FORTH32 CURRENT !
 
Word: immediator    BEGIN  ', PARSE  ', IMMEDIATES ', SFIND   ', EXECUTE   AGAIN   ;Word

Word: WORD:	', Word:  ', immediator  ;Word

 
 
 IMMEDIATES CURRENT !  FORTH32 CONTEXT ! 
 

WORD: Begin	  BEGIN  ;WORD 

WORD: Until	  UNTIL  ;WORD

WORD: Again	  AGAIN  ;WORD 

WORD: If	  IF	 ;WORD

WORD: Then	  THEN	 ;WORD

WORD: Else	  ELSE	 ;WORD 

FORTH32 CURRENT !

WORD: (EndCase)    Begin DUP 0 <> If	-1 Else THEN 0 Then Until Pop ;WORD 

IMMEDIATES CURRENT !  FORTH32 CONTEXT ! 

WORD: Case	 0  ;WORD 

WORD: Of	 COMPILE ?OF	 HERE	 COMPILE 0    ;WORD   

 WORD: EndOf	 COMPILE BRANCH  HERE >R COMPILE 0 THEN  R>    ;WORD

 WORD: EndCase	(EndCase) ;WORD

 WORD: Do	BEGIN	 COMPILE >R   COMPILE >R   ;WORD

 WORD: Loop	COMPILE R>   COMPILE 1+   COMPILE DUP	COMPILE R@   COMPILE <	 COMPILE R>
		COMPILE SWAP	COMPILE ?OF ,		COMPILE Pop   COMPILE Pop ;WORD

 WORD: does>    COMPILE COMPILE 
                COMPILE BRANCH   HERE  CELL+ CELL+ CELL+  LIT,  
			    COMPILE ,	;Word   
			   ;WORD
			   
			   
 WORD: DOES>  COMPILE (does>) (jsr)   ;WORD 
 
 WORD: [   IMMEDIATES CONTEXT @ LINK   ;WORD 

 WORD: ]   IMMEDIATES UNLINK	 ;WORD   
 
 WORD: [']  ' LIT,  ;WORD 
 
 WORD: hex,	  0x,	  ;WORD
 
 
 
 WORD: ((   ) WORD             ;WORD   
 
 
 FORTH32 CURRENT !  FORTH32 CONTEXT !    IMMEDIATES UNLINK

EXIT  Begin DUP   0 <>   If	 -1  Else  THEN  0 Then   Until Pop	

