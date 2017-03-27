WORD: QWORD  VARIABLE    ['] @   ,  ['] !  ,  ;WORD 

WORD: get   (( elem_addr -- elem_value )   DUP CELL+  @ EXECUTE ;WORD 
WORD: store (( new_value elem_addr --  )   DUP CELL+ CELL+  @ EXECUTE ;WORD 

WORD: next_elem     N>LINK DUP h.  @ ;WORD 
WORD: elem_name		DUP TYPE SPACE ;WORD 
 
WORD: get_struct  
         DUP  >R  @ Begin  DUP NAME> CELL+ get SWAP  next_elem DUP R@ < NOT Until RDROP ;WORD 

WORD:  STRUC:  
          HERE
		  VARIABLE ['] 
		  get_struct ,  ['] NOOP ,  
		  LATEST NAME> CELL+ (( N>LINK CELL+ CELL+   )
		  make_badword
		  DOES>  DUP DUP  FORTH32  LINK   CONTEXT !  ;WORD 

WORD:  ;STRUC   LATEST SWAP!   CURRENT @ !   ;WORD 


STRUC: strucname 

QWORD abc  
QWORD bde
QWORD tyu 

QWORD edf
;STRUC 

.(    sdlfk )
  strucname h.     abc h.  abc get DUP h.  0x 3456 + abc store   abc get h.  abc get 0x 9 + bde  store  0x 9 tyu  store 0x 4 edf store  FORTH32 CONTEXT !  strucname UNLINK 
.( wew )

CURRENT @ @ TYPE 


 WORD: nhj    [ strucname  abc LIT, ]  get   h. ;WORD  

LATEST TYPE 
 nhj FORTH32 CONTEXT !  strucname UNLINK 
 
 WORD: wordlist   0 hex, 13 Do elem_name next_elem Loop   ;WORD 

 
EXIT






strucname get  h. h. h. h. h. 

strucname UNLINK 
  















STRUC: strucname 
 fistname qword
 scndname dword
 3rdname  byte
;STRUC

Слово STRUC: создает словарь strucname в котором создаются слова fistname scndname 3rdname и для них отводится соответственно места. 

strucname scndname @    3rdname @ +  fistname ! 
