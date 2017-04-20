 FORTH32 CURRENT !  ASSEMBLER CONTEXT !  ASSEMBLER FORTH32 LINK 
 
 WORD:  invoke  
 
 mov_r11,#  , 
 call_[r11] 
 cdqe 
 mov_rcx,# hex, 78 , 
 add_rsp,rcx
 mov_rdx,# COMPILE [ ' Push @ , ] call_rdx
 ret
 ALIGN
 ;WORD 

 FORTH32 CONTEXT !
 
 WORD: setmodule     
              HERE  (HEADER) HERE 0 ,  SWAP   1+ (SetModule)  ,  HERE SWAP!  EXECUTE  LATEST NAME> CELL+  invoke ;WORD 
  
 

VOCABULARY  winapis

winapis CURRENT !  winapis FORTH32 LINK    FORTH32 CONTEXT !


WORD: ;WINAPIS  quit ;WORD 
WORD: LIB:  PARSE HERE  1+  (LIB)   ;WORD 

ASSEMBLER CONTEXT !
  XT: void
  sub_rsp,d# hex, 78 D,
  ;XT 

  XT: 1_int
   sub_rsp,d# hex, 78 D,
  mov_rdx,# COMPILE [ ' Pop @ ,  ]  call_rdx
  mov_rcx,rax
 ;XT
 
 XT: 2_ints
  sub_rsp,d# hex, 78 D,
 mov_r11,# COMPILE [ ' Pop @ , ] 
 call_r11 mov_rdx,rax
 call_r11 mov_rcx,rax
 ;XT
 
 XT: 3_ints
  sub_rsp,d# hex, 78 D,
 mov_r11,# COMPILE [ ' Pop @ , ] call_r11
 mov_r8,rax
 call_r11
 mov_rdx,rax
 call_r11
 mov_rcx,rax
 ;XT
 
 
  XT: 4_ints
  sub_rsp,d# hex, 78 D,
 mov_r11,# COMPILE [ ' Pop @ , ] call_r11
 mov_r9,rax
 call_r11
 mov_r8,rax
 call_r11
 mov_rdx,rax
 call_r11
 mov_rcx,rax
 ;XT
 
 XT: 5_ints
 
  sub_rsp,d# hex, 78 D,
  mov_r11,# COMPILE [ ' Pop @ , ] call_r11
  
  mov_[rsp+b#],rax  hex, 20 B, 
  call_r11
  mov_r9,rax
  call_r11
  mov_r8,rax
  call_r11
  mov_rdx,rax
  call_r11
  mov_rcx,rax
  ;XT
 
 XT: 6_ints
 
  sub_rsp,d# hex, 78 D,
  mov_r11,# COMPILE [ ' Pop @ , ] 
  
  call_r11    mov_[rsp+b#],rax  hex, 28 B,
  call_r11    mov_[rsp+b#],rax  hex, 20 B, 
  call_r11    mov_r9,rax
  call_r11    mov_r8,rax
  call_r11    mov_rdx,rax
  call_r11    mov_rcx,rax
  ;XT
 
 
  XT: 9_ints
  sub_rsp,d# hex, 78 D,
  mov_r11,# COMPILE [ ' Pop @ , ] 
  call_r11    mov_[rsp+b#],rax  hex, 40 B,
  call_r11    mov_[rsp+b#],rax  hex, 38 B,
  call_r11    mov_[rsp+b#],rax  hex, 30 B,
  call_r11    mov_[rsp+b#],rax  hex, 28 B,
  call_r11    mov_[rsp+b#],rax  hex, 20 B, 
  
  call_r11  mov_r9,rax
  call_r11  mov_r8,rax
  call_r11  mov_rdx,rax
  call_r11  mov_rcx,rax
 ;XT 
 
 
 
 XT: b_ints
  sub_rsp,d# hex, 78 D,
  mov_r11,# COMPILE [ ' Pop @ , ] 
  call_r11    mov_[rsp+b#],rax  hex, 50 B,  
  call_r11    mov_[rsp+b#],rax  hex, 48 B,
  call_r11    mov_[rsp+b#],rax  hex, 40 B,
  call_r11    mov_[rsp+b#],rax  hex, 38 B,
  call_r11    mov_[rsp+b#],rax  hex, 30 B,
  call_r11    mov_[rsp+b#],rax  hex, 28 B,
  call_r11    mov_[rsp+b#],rax  hex, 20 B, 
  
  call_r11  mov_r9,rax
  call_r11  mov_r8,rax
  call_r11  mov_rdx,rax
  call_r11  mov_rcx,rax
 ;XT
 
  XT: c_ints
  sub_rsp,d# hex, 78 D,
  mov_r11,# COMPILE [ ' Pop @ , ] 
  call_r11    mov_[rsp+b#],rax  hex, 58 B,
  call_r11    mov_[rsp+b#],rax  hex, 50 B,  
  call_r11    mov_[rsp+b#],rax  hex, 48 B,
  call_r11    mov_[rsp+b#],rax  hex, 40 B,
  call_r11    mov_[rsp+b#],rax  hex, 38 B,
  call_r11    mov_[rsp+b#],rax  hex, 30 B,
  call_r11    mov_[rsp+b#],rax  hex, 28 B,
  call_r11    mov_[rsp+b#],rax  hex, 20 B, 
  
  call_r11  mov_r9,rax
  call_r11  mov_r8,rax
  call_r11  mov_rdx,rax
  call_r11  mov_rcx,rax
 ;XT
 
 FORTH32 CONTEXT !  winapis CONTEXT !  


' setmodule   ' BADWORD  CELL+ ! 

 

FORTH32 CONTEXT !   FORTH32 CURRENT !
winapis UNLINK


WORD: WINAPIS:     Begin    PARSE   winapis SFIND  EXECUTE Again ;WORD 
 
EXIT ;

 
  
