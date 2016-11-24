 
ASSEMBLER FORTH32 LINK    
FORTH32 CURRENT ! ASSEMBLER CONTEXT ! 

CREATE   decimalv           0 , 0 , 0 , 0 , 
CREATE   hex_dot_value  0xd 0 , , 0xd 0 , ,  
CREATE   sixes          0x  06060606060606060606060606060606 DUP , , 0x  06060606060606060606060606060606 DUP  , ,  
CREATE   efes           0x 0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F DUP , , 0x   0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F DUP , ,  
CREATE   sevens         0x 07070707070707070707070707070707 DUP , , 0x   07070707070707070707070707070707 DUP , ,  
CREATE   zeroes         0x 30303030303030303030303030303030 DUP , , 0x   30303030303030303030303030303030 DUP , ,  
CREATE   hexstr         0x 33323235363941433332323536394143 DUP , , 0x 20 DUP , , 0x 20 ,            

 
ASSEMBLER FORTH32 LINK 

HEADER    inverse_hexstr  HERE CELL+ ,    
mov_rcx,#  hexstr ,       
mov_rax,[rcx]                           
mov_rbx,[rcx+b#]  0x  8 B, 
mov_rdx,[rcx+b#]  0x 10 B,
mov_rsi,[rcx+b#]  0x 18 B,

bswap_rax  bswap_rbx  bswap_rdx  bswap_rsi 

mov_[rcx],rsi 
mov_[rcx+b#],rdx 0x  8 B, 
mov_[rcx+b#],rbx 0x 10 B,
mov_[rcx+b#],rax 0x 18 B, 
ret                                              
ALIGN      



HEADER (hex_pop) HERE CELL+ ,     
mov_rdx,#  ' Pop @ , call_rdx                    
mov_[],rax   hex_dot_value  ,                    
ret 
ALIGN   

HEADER (hex_pop2) HERE CELL+ ,     
mov_rdx,#  ' Pop @ , call_rdx                    
mov_[],rax   hex_dot_value  CELL+ ,              
ret 
ALIGN   



HEADER (hex_convert) HERE CELL+ , 

mov_rax,# hex_dot_value  ,
movdqu_xmm0,[rax]                   
pxor_xmm1,xmm1        
     movdqu_xmm5,[rax+b#]  0x 8 B,
punpcklbw_xmm0,xmm1  
     punpcklbw_xmm5,xmm1 
mov_rax,# efes ,                           
movdqa_xmm1,xmm0   
     movdqa_xmm6,xmm5                               
movdqu_xmm2,[rax]                             
pand_xmm1,xmm2    
     pand_xmm6,xmm2                                    
psllq_xmm0,4     
      psllq_xmm5,4                                
pand_xmm0,xmm2   
      pand_xmm5,xmm2                           
por_xmm0,xmm1    
      por_xmm5,xmm6
mov_rax,# sixes ,                                 
movdqa_xmm1,xmm0     
      movdqa_xmm6,xmm5                               
movdqu_xmm4,[rax] 
paddb_xmm1,xmm4  
      paddb_xmm6,xmm4                                 
psrlq_xmm1,4   
      psrlq_xmm6,4                                   
pand_xmm1,xmm2   
       pand_xmm6,xmm2                          
pxor_xmm3,xmm3    
       pxor_xmm7,xmm7
mov_rax,# sevens ,                               
psubb_xmm3,xmm1   
       psubb_xmm7,xmm6                                
movdqu_xmm2,[rax] 
pand_xmm3,xmm2    
       pand_xmm7,xmm2
mov_rax,# zeroes ,                               
paddb_xmm0,xmm3                                  
       paddb_xmm5,xmm7
movdqu_xmm2,[rax] 
paddb_xmm0,xmm2   
       paddb_xmm5,xmm2
mov_rax,# hexstr ,                               
movdqu_[rax],xmm0                    
       movdqu_[rax+b#],xmm5 0x 10 B, 
ret                                              
ALIGN   
        
HEADER (clear_hex)   HERE CELL+ ,        
mov_rax,# hex_dot_value  ,          
pxor_xmm0,xmm0                             
movdqu_[rax],xmm0  
ret 
ALIGN   

HEADER (2d)  HERE CELL+ , 
  
fldz 
mov_rdx,# 0x 13 , 
mov_r11,# decimalv ,
fbstp_[r11] 
mov_rax,[] ' HERE CELL+ , 
movzx_rcx,b[rax] 
cmp_rcx,rdx 
cmovnc_rcx,rdx    
inc_rax
mov_rsi,rax 
cld 
lodsb 
xor_rdx,rdx 
and_al,# 0x f B, 
mov_ah,al 
sub_al,# 0x b B, 
jb forward> 
shl_al,# 0x 6 B, 
mov_[],al decimalv 0x 9 + , 

lodsb 
and_al,# 0x f B, 
dec_rcx

mov_ah,al    
>forward 
mov_al,ah     

nop
backward<    
nop 
or_dl,al      
mov_rbx,rcx   
shr_rbx,1     
jnb forward>  
mov_[rbx+r11],dl  
xor_dl,dl      
>forward       
shl_dl,# 0x 4 B, 

lodsb    
and_al,# 0x F B, 
sub_rcx,b# 1 B, 
jnb       <backward 

fbld_[r11]  
fistp_[r11] 
ret 
ALIGN 

HEADER (dec_pop) HERE CELL+ ,   
  
mov_rdx,#  ' Pop @ , call_rdx                    
mov_[],rax   decimalv  ,                    
ret 
ALIGN   

HEADER (dec_pop2) HERE CELL+ ,     
mov_rdx,#  ' Pop @ , call_rdx                
mov_[],rax   decimalv  CELL+ ,               
ret 
ALIGN   



HEADER (d.) HERE CELL+ , 
mov_r11,# decimalv , 
fild_[r11] 
fbstp_[r11]   
mov_rsi,# decimalv 0x 9 + , 
mov_rax,[] ' HERE CELL+ , 
mov_rdi,rax
std 
lodsb 
shr_al,# 0x 6 B, 
cld      
add_al,# 0x 2b B, 
stosb 
mov_rcx,d# 0x 9 D,  
backward< 
std 
lodsb 
mov_ah,al 
shr_al,# 0x 4 B, 
add_al,# 0x 30 B, 
cld 
stosb 
mov_al,ah 
and_al,# 0x f B, 
add_al,# 0x 30 B, 
stosb 
dec_rcx    
jne <backward 
xor_al,al 
stosb 
ret 
ALIGN 

EXIT  
