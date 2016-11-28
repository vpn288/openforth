FORTH32 CONTEXT !    FORTH32 CURRENT !
 

Word: BEGIN    ', HERE ', CELL-   ;Word

Word: AGAIN    ', COMPILE    ',  BRANCH  ', , ;Word 


Word: UNTIL    ', COMPILE    ', ?OF  ', , ;Word

Word: IF       ', COMPILE   ', ?BRANCH    ', HERE	', 0 ', , ;Word

Word: THEN     ', HERE    ', CELL- ', SWAP!  ;Word

Word: ELSE     ', COMPILE    ', BRANCH   ', HERE  ', >R   ', 0   ', ,
	       ', HERE ', CELL-  ', SWAP! ', R>   ;Word

Word: ENDOF	  ',   COMPILE ', BRANCH  ', HERE ', >R  ', COMPILE ', 0 ', THEN  ', R> ;Word

Word: OF	  ',   COMPILE ', ?OF	  ', HERE        ', COMPILE ', 0     ;Word

EXIT
