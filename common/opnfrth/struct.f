WORD: QWORD  VARIABLE    ['] @   ,  ['] !  ,  ;WORD 


WORD: get   (( elem_addr -- elem_value )   DUP CELL+  @ EXECUTE ;WORD 
WORD: store (( new_value elem_addr --  )   DUP CELL+ CELL+  @ EXECUTE ;WORD 

WORD:  STRUC:  CURRENT @  VARIABLE   LATEST N>LINK CELL+ CELL+  DUP CURRENT !  DOES> DUP h.  ;WORD 
WORD:  ;STRUC  LATEST SWAP!  CURRENT !   ;WORD 

STRUC: strucname 

QWORD abc  
QWORD bde
QWORD tyu 

QWORD edf
;STRUC 


 strucname FORTH32 LINK  
strucname h.  strucname @ DUP TYPE SPACE N>LINK @ DUP TYPE SPACE  N>LINK @ DUP TYPE SPACE  N>LINK  @ DUP  TYPE SPACE  N>LINK @ h. 

CRLF
.(    sdlfk )
strucname  CONTEXT !  abc h.  abc get h.  0x 3456 abc store   abc get h. 
.( wew )
.( abc .( wkl;j ) .( h.   abc get h.   0x 1234 abc store     abc get h. )

  WORD: QWORD  VARIABLE    ['] @   ,  ['] !  ,  ;WORD 


WORD: get   (( elem_addr -- elem_value )   DUP CELL+  @ EXECUTE ;WORD 
WORD: store (( new_value elem_addr --  )   DUP CELL+ CELL+  @ EXECUTE ;WORD 

WORD: use   DUP   FORTH32 LINK   CONTEXT ! ;WORD 
WORD:  STRUC:  CURRENT @  CREATE 0 ,    LATEST N>LINK CELL+ CELL+    DOES>   use ;WORD 
WORD:  ;STRUC  LATEST SWAP!  CURRENT !   ;WORD 

STRUC: strucname 

QWORD abc  
QWORD bde
QWORD tyu 

QWORD edf
;STRUC 


.(    sdlfk )
strucname   abc h.  abc get DUP h.  0x 3456 + abc store   abc get h. 
.( wew )


  

EXIT

STRUC: strucname 
 fistname qword
 scndname dword
 3rdname  byte
;STRUC

Слово STRUC: создает словарь strucname в котором создаются слова fistname scndname 3rdname и для них отводится соответственно места. 

strucname scndname @    3rdname @ +  fistname ! 

EXIT

STRUC: strucname 
 fistname qword
 scndname dword
 3rdname  byte
;STRUC

Слово STRUC: создает словарь strucname в котором создаются слова fistname scndname 3rdname и для них отводится соответственно места. 

strucname scndname @    3rdname @ +  fistname ! 
