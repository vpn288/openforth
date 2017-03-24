WORD: QWORD  VARIABLE    ['] @   ,  ['] !  ,  ;WORD 
WORD: sp_word   HERE DUP HEADER  hex, 20202003 SWAP!  CELL+ (( name field )
                 0 SWAP!  (( Link field )
				 ['] NOOP @  ;WORD 


WORD: get   (( elem_addr -- elem_value )   DUP CELL+  @ EXECUTE ;WORD 
WORD: store (( new_value elem_addr --  )   DUP CELL+ CELL+  @ EXECUTE ;WORD 

WORD: next_elem     N>LINK @ DUP h. ;WORD 
WORD: elem_name		DUP TYPE ;WORD 

WORD: get_st  ." get_struct " @ 1 hex, 4 Do  elem_name DUP NAME> CELL+ get h. next_elem Loop elem_name  ;WORD 

VARIABLE tmp 
WORD: get_struct  ." get_str " tmp !  @ Begin  elem_name DUP NAME> CELL+ get h. next_elem tmp @ <> UNTIL ;WORD 

WORD:  STRUC:  CURRENT @  VARIABLE ['] get_struct ,  ['] NOOP ,  LATEST N>LINK CELL+ CELL+    DOES>  DUP DUP  FORTH32 SWAP LINK   CONTEXT !  ;WORD 
WORD:  ;STRUC  DUP h. LATEST SWAP!   CURRENT !   ;WORD 

STRUC: strucname 

QWORD abc  
QWORD bde
QWORD tyu 

QWORD edf
;STRUC 


.(    sdlfk )
strucname   abc h.  abc get DUP h.  0x 3456 + abc store   abc get h. 
.( wew )

strucname get 
  

EXIT

STRUC: strucname 
 fistname qword
 scndname dword
 3rdname  byte
;STRUC

Слово STRUC: создает словарь strucname в котором создаются слова fistname scndname 3rdname и для них отводится соответственно места. 

strucname scndname @    3rdname @ +  fistname ! 
