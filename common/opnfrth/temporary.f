
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

How to use:

TEMPORARY{
.... some code ...
}TEMPORARY

What happend?

By opening TEMPORARY{ tag you fix the state of context current vocabularies and here value. By closing }TEMPORARY tag you 
restore that values. I.e. your ... some code ... exection and even compiling had no trace in system. You load program execute it
and clean all word defined in it. 
