ASSEMBLER CONTEXT !    FORTH32 CURRENT !

CODE: B,     
mov_rdx,# ' Pop @ , call_rdx
mov_rdx,#  ' HERE CELL+ , 
mov_r11,[rdx]
mov_[r11],al
inc_[rdx]
ret
ALIGN

CODE: W,     
mov_rdx,# ' Pop @ , call_rdx
mov_rdx,#  ' HERE CELL+ , 
mov_r11,[rdx]
mov_[r11],ax
inc_[rdx]
inc_[rdx]
ret
ALIGN

ASSEMBLER FORTH32 LINK 

CODE: D,     
mov_rdx,# ' Pop @ , call_rdx
mov_rdx,#  ' HERE CELL+ , 
mov_r11,[rdx]
mov_[r11],eax
add_[rdx],b# 0x 4 B, 
ret
ALIGN

ASSEMBLER FORTH32 LINK 

EXIT   
