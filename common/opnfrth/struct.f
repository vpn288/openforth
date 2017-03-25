WORD: QWORD  VARIABLE    ['] @   ,  ['] !  ,  ;WORD 
WORD: sp_word   HERE DUP HEADER  hex, 20202003 SWAP!  CELL+ (( name field )
                 0 SWAP!  (( Link field )
				 ['] NOOP @  ;WORD 


WORD: get   (( elem_addr -- elem_value )   DUP CELL+  @ EXECUTE ;WORD 
WORD: store (( new_value elem_addr --  )   DUP CELL+ CELL+  @ EXECUTE ;WORD 

WORD: next_elem     N>LINK @ ;WORD 
WORD: elem_name		DUP TYPE ;WORD 
 

WORD: get_struct  ." get_str " CRLF >R @ Begin  elem_name DUP NAME> CELL+ get h. CRLF  next_elem DUP R@ < NOT Until RDROP ;WORD 

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
