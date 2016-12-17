FORTH32 CONTEXT !   FORTH32 CURRENT !

 WORD: (EMIT)	SP@  TYPEZ  ;WORD   
 WORD: EMIT   (EMIT)  Pop ;WORD
 WORD: .(       )   WORD   HERE   TYPE  ;WORD
 WORD: SPACE   hex, 20  EMIT ;WORD
  
  FORTH32 CONTEXT !  IMMEDIATES CURRENT !
  
  WORD: ."      ,"     COMPILE TYPE  ;WORD 
  
  FORTH32 CONTEXT !   FORTH32 CURRENT !
  
  WORD: a_b->ab   >R  hex, 10 Lshift R> + ;WORD
  WORD: ab->a_b   DUP hex, ffff AND >R  hex, 10 Rshift R> ;WORD
  WORD: cursor_left  ;WORD
  WORD: cursor_right ;WORD
  
  WORD: cursor_xy   (( position_x position_y -- position_x position_y )
              DUP hex, 10 + a_b->ab >R    
			  DUP a_b->ab R>
  ;WORD
  
 
 ASSEMBLER FORTH32 LINK    ASSEMBLER CONTEXT !    FORTH32 CURRENT !
 
 HEADER  cursor   HERE CELL+ , ( position -- )
 mov_edx,#  ' Pop @ , call_edx
 mov_ecx,eax
 mov_ebx,eax
 and_ecx,# 0x ffff , ( coord y )
 and_ebx,# 0x ffff0000 ,
 mov_eax,ebx
 shr_ebx,# 0x 10 B,  ( coord x )
 add_eax,# 0x 80000 ,
 or_ebx,eax 
 mov_eax,ecx
 shl_eax,# 0x 10 B,
 add_ecx,# 0x 18 ,
 or_ecx,eax
 mov_edx,# 0x 01000000 ( 0ab0000 ) ,
 mov_eax,# 0x 26 ,
 int_40h
 ret
 ALIGN
 
 HEADER  cursor2   HERE CELL+ , ( position -- )
 mov_edx,#  ' Pop @ , call_edx
 mov_ecx,eax
 mov_ebx,eax
 and_ecx,# 0x ffff , ( coord y )
 and_ebx,# 0x ffff0000 ,
 mov_eax,ebx
 shr_ebx,# 0x 10 B,  ( coord x )
 or_ebx,eax
 mov_eax,ecx
 shl_eax,# 0x 10 B,
 add_ecx,# 0x 18 ,
 or_ecx,eax
 mov_edx,# 0x 01000000 ( 0ab0000 ) ,
 mov_eax,# 0x 26 ,
 int_40h
 ret
 ALIGN
  
  FORTH32 CONTEXT !   FORTH32 CURRENT !
  
 EXIT   
