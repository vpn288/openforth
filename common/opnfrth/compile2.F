  FORTH32 CONTEXT !  FORTH32 CURRENT !	ASSEMBLER UNLINK

  HEADER LIT,  interpret# ,    ' lit# , ' lit# , ' , ,  ' , ,  ' EXIT ,

  HEADER ;Word     interpret# ,  ' COMPILE , ' EXIT  ,    ' EXIT ,

  HEADER Word:	   interpret# ,   ' HEADER , ' interpret# ,  ' , ,  ;Word

  Word: CONSTANT    ' HEADER ,   ' COMPILE ,  ' interpret# @ ,  ' , ,  ;Word

 0x 0	             CONSTANT 0
 0x 1	             CONSTANT 1
 0x FFFFFFFFFFFFFFFF CONSTANT -1
 0x 20	             CONSTANT BL
 0x 29	             CONSTANT )
 0x 22	             CONSTANT QUOTE
 

  

  Word: ',      ' ' ,   ' , ,	    ;Word
  
  Word: CREATE      ', HEADER  ', COMPILE  ' CONTEXT @  , ;Word
  Word: VARIABLE    ', CREATE  ', 0  ', , ;Word

  Word: 0x, 	 ', 0x   ', LIT,     ;Word
  
  Word: PAD  ', HERE 0x, 200 ', + ;Word 

  Word: SPACE   0x, 2001   ', SP@ ', TYPE ', Pop ;Word 
  
  Word: WORD	', BUFFER  ', @ ', HERE  ', (WORD) ;Word

 
  

  Word: S"  ', QUOTE ', BUFFER  ', @  ', PAD ', (WORD) ;Word 
  Word: ."   ', S" ', HERE 0x, 200 ', + ',  TYPE  ;Word 
 
 
  
  Word: ,"         ', COMPILE  ', SLIT      ', HERE   ', QUOTE   ', WORD   ', C@
		 ', 1+   ', 1+	 ', ALLOT   ;Word
		 
	
 
  Word: make_badword   
		," BADWORD"	 ', DUP     ', HERE   ', strcopy    ', C@
		', CELL+   ', ALLOT   0x, 0    ',  ,  ', COMPILE	' BADWORD @ ,
		', COMPILE   ', ABORT    ;Word

		
  Word: make_exit
	       ," EXIT"     ', DUP    ', HERE	', strcopy   ', C@
	           ', ALLOT  ', ,   ', COMPILE   ', EXIT    ;Word

 
  Word: VOCABULARY
		', VARIABLE    ', HERE	', CELL-    ', HERE    ', make_badword  
		', HERE   ', >R   ', make_exit   ', R>	 ', SWAP!      ;Word
		
 Word: jiop ', SPACE  ', HERE ', TYPE ;Word
 
  Word: compiler	  ', CONTEXT ', @ ', SFIND ', ,  ;Word
  
 

  
  EXIT  
