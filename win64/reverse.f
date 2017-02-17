FORTH32 CONTEXT ! FORTH32 CURRENT ! 

VARIABLE sp_temp

ASSEMBLER FORTH32 LINK    ASSEMBLER CONTEXT !

HEADER (reverse)  HERE CELL+ ,
mov_r11,# ' Pop @ , call_r11
mov_rcx,rax
call_r11
backward<
mov_rsi,[rax]
mov_rdi,[rcx]
mov_[rcx],rsi
mov_[rax],rdi 
sub_rcx,b# 0x 8 B,
add_rax,b# 0x 8 B,
cmp_rax,rcx
jb	<backward 
ret
ALIGN

FORTH32 CONTEXT ! 

WORD: *{    SP@ CELL+  sp_temp !  ;WORD 

WORD: (reversed)    sp_temp @ SP@    ;WORD  

WORD: reversed     (reversed) SWAP- hex, 3 Rshift ;WORD 

WORD: }*    (reversed) CELL- (reverse)  ;WORD 


*{ 0x 1 0x 2 0x 3 0x 4 0x 5 0x 6  0x 7  }*  reversed h. 

EXIT 

Reverse переставляет в обратном порядке элементы стека между тегами *{  }*

*{ 0x 1 0x 2 0x 3 0x 4 0x 5 0x 6  0x 7  }* 
