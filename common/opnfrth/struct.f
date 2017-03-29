WORD: QWORD  VARIABLE    ['] @   ,  ['] !  ,  ;WORD 

WORD: get   (( elem_addr -- elem_value )   DUP CELL+  @ EXECUTE ;WORD 
WORD: store (( new_value elem_addr --  )   DUP CELL+ CELL+  @ EXECUTE ;WORD 

WORD: next_elem     N>LINK DUP h.  @ DUP h. CRLF ;WORD 
WORD: elem_name		DUP TYPE SPACE ;WORD 
 
WORD: get_struct  ."  getting_struct "
         DUP  >R  @ Begin  DUP NAME> CELL+ get SWAP  next_elem elem_name DUP R@ < NOT Until RDROP ;WORD 
		 
WORD: (struct) CREATE HERE  0 , ['] get_struct ,  ['] NOOP , DOES>   DUP CONTEXT !  ;WORD 
		 
WORD:  STRUC:  
          CURRENT @ 
		  (struct)   DUP  
		   
		  HERE SWAP! make_badword  
		  DUP CURRENT ! DUP CONTEXT @ LINK   CONTEXT ! 
		  
		    ;WORD 

WORD:  ;STRUC      CURRENT  !   ;WORD 


STRUC: strucname    
QWORD abc  
QWORD bde   
QWORD tyu 
QWORD edf  
;STRUC  .(  closetrucname )  

 strucname @ elem_name next_elem  elem_name next_elem  elem_name next_elem  elem_name next_elem  elem_name  next_elem h. 

strucname   0x ead tyu store  tyu  get h. CRLF 
strucname get  h. h. h. h. h. 

 
EXIT

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
