  ASSEMBLER FORTH32 LINK    ASSEMBLER CONTEXT !    FORTH32 CURRENT !

 CREATE win_param
  0x 0 , 0x 0 ,

  ASSEMBLER FORTH32 LINK
  
  HEADER SF_CREATE_WINDOW
  xor_eax,eax
  mov_ebx,[] win_param ,
  mov_ecx,[] win_param CELL+ ,
  mov_edx,# 0x 030000000 , 
  mov_esi,# 0x 03f3f3f , 
  mov_edi,# 0x 3f3f3fh ,
  int_40h
  ret
  ALIGN
  
  HEADER PAUSE	 HERE CELL+ ,
  mov_edx,# ' Pop @ ,  call_edx
  mov_ebx,eax
  mov_eax,#  0x 5 ,
  int_40h
  ret
  ALIGN

  HEADER SF_PUT_IMAGE  HERE CELL+ ,
  mov_edx,# ' Pop @ ,  call_edx
  mov_ebx,eax
  mov_eax,# 0x 7 ,
  mov_ecx,[] win_param ,
  mov_edx,[] win_param CELL+ ,
  int_40h
  ret
  ALIGN

  HEADER SF_GET_IMAGE  HERE CELL+ ,
  mov_edx,# ' Pop @ ,  call_edx
  mov_ebx,eax
  mov_eax,# 0x 24 ,
  mov_ecx,[] win_param ,
  mov_edx,[] win_param CELL+ ,
  int_40h
  ret
  ALIGN

  HEADER SF_GET_KEY   HERE  CELL+ ,
  mov_eax,# 0x 2 ,
  int_40h
  mov_edx,# ' Push @ ,  call_edx
  ret
  ALIGN
  
  HEADER SF_WAIT_EVENT HERE CELL+ ,
  mov_eax,# 0x a ,
  int_40h
  ret
  
  HEADER SF_DRAW_LINE  HERE CELL+ ,
  mov_edx,# ' Pop @ ,  call_edx 
  
  mov_eax,# 0x 26 ,
  int_40h
  ret
  ALIGN
  
EXIT

