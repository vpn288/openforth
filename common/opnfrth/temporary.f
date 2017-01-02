
FORTH32 CONTEXT ! FORTH32 CURRENT ! 

CREATE temporary_state 0 , 0 , 0 , 

WORD: TEMPORARY{    
                CONTEXT @ @ temporary_state ! 
				CURRENT @ @ temporary_state CELL+ ! 
				HERE temporary_state  CELL+ CELL+ ! 
				;WORD
				
WORD: }TEMPORARY    
                temporary_state @  CONTEXT @ ! 
				temporary_state CELL+ @  CURRENT @ ! 
				temporary_state CELL+ CELL+ @  [ ' HERE CELL+ LIT, ] ! ;WORD 

EXIT

