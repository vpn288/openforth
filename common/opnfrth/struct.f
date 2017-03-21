WORD: QWORD  VARIABLE    ['] @   ,  ['] !  ,  ;WORD 


WORD: get   (( elem_addr -- elem_value )   DUP CELL+  @ EXECUTE ;WORD 
WORD: store (( new_value elem_addr --  )   DUP CELL+ CELL+  @ EXECUTE ;WORD 


VARIABLE strucname 
( here must be zero lfa )
strucname CURRENT ! 
QWORD abc  
QWORD bde
QWORD tyu 
HERE
QWORD edf
strucname !

FORTH32 CURRENT !

strucname FORTH32 LINK  
strucname h.  strucname @ DUP TYPE SPACE N>LINK @ DUP TYPE SPACE  N>LINK @ DUP TYPE SPACE  N>LINK  @ DUP  TYPE SPACE  N>LINK @ h. 

CRLF
.(    sdlfk )
strucname CONTEXT !  abc h.  abc get h.  0x 3456 abc store   abc get h. 
.( wew )
.( abc .( wkl;j ) .( h.   abc get h.   0x 1234 abc store     abc get h. )

EXPECT  

EXIT

STRUC: strucname 
 fistname qword
 scndname dword
 3rdname  byte
;STRUC

Слово STRUC: создает словарь strucname в котором создаются слова fistname scndname 3rdname и для них отводится соответственно места. 

strucname scndname @    3rdname @ +  fistname ! 
