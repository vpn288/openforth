WORD: QWORD  VARIABLE    ['] @   ,  ['] !  ,  ;WORD 

WORD: get   (( elem_addr -- elem_value )   DUP CELL+  @ EXECUTE ;WORD 
WORD: store (( new_value elem_addr --  )   DUP CELL+ CELL+  @ EXECUTE ;WORD 

WORD: next_elem     N>LINK DUP h.  @ DUP h. CRLF ;WORD 
WORD: elem_name		DUP TYPE SPACE ;WORD 
 
WORD: get_struct  
            Begin @  N>LINK DUP CELL+ CELL+ get SWAP  Again   ;WORD 
			
WORD: on_bad   Pop Pop RDROP RDROP RDROP RDROP  RDROP   ;WORD 
		 
WORD: (struct) CREATE HERE  0 , ['] get_struct ,  ['] NOOP , DOES>   DUP CONTEXT !  ;WORD 

		 
WORD:  STRUC:  
          CURRENT @ 
		  (struct)   DUP  
		   
		  HERE SWAP! make_badword  
		  ['] on_bad ,  ['] NOOP , 
		  DUP CURRENT ! DUP CONTEXT @ LINK   CONTEXT ! 
		  
		    ;WORD 

WORD:  ;STRUC      CURRENT  !   ;WORD 

STRUC: strucname    
QWORD abc  
QWORD bde   
QWORD tyu 
QWORD edf  
;STRUC  

strucname  0x edf edf store  0x 128 tyu store 0x bde bde store 0x abc abc store

strucname get h. h. h. h. 


EXIT


WORD: nxt  CRLF @ DUP TYPE N>LINK DUP CELL+ CELL+ ;WORD 
 strucname @ elem_name next_elem  elem_name next_elem  elem_name next_elem  elem_name next_elem  elem_name  next_elem h. 
 
CRLF .(  manual_get_struct ) CRLF 



 strucname  nxt get h.   nxt get h. nxt get h.  nxt get h.     
 
 
CRLF .(  store-get_test )
strucname   0x ead tyu store  tyu  get h.  0x 4 edf get + edf store   CRLF 

 strucname get  h. h. h. h. h. .( jkhh )

FORTH32 CONTEXT !

 WORD: sss h. ;WORD 
 
 0x aaa sss 
Header записывает в поле связи значение, полученное по latest. a here записывает в CURRENT @ 
HERE N>LINK LATEST SWAP!   HERE CURRENT @ ! 


 strucname @ elem_name next_elem  elem_name next_elem  elem_name next_elem  elem_name next_elem  elem_name  next_elem elem_name


strucname get  h. h. h. h. h. 

strucname UNLINK 
  















STRUC: strucname 
 fistname qword
 scndname dword
 3rdname  byte
;STRUC

Слово STRUC: создает словарь strucname в котором создаются слова fistname scndname 3rdname и для них отводится соответственно места. 

strucname scndname @    3rdname @ +  fistname ! 
