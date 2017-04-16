  

ASSEMBLER FORTH32 LINK    ASSEMBLER CONTEXT !	  FORTH32 CURRENT !

 CODE: w(swap_ab) 
  mov_rdx,# ' Pop @ , call_rdx 
  rol_rax,# 0x 10 B,  
  mov_rdx,# ' Push @ , call_rdx 
  ret 
  ALIGN
  
  CODE: ?MAX 
  mov_rdx,# ' Pop @ ,   call_rdx              
  xor_rcx,rcx
  mov_rcx,rax           
  call_rdx     
  cmp_rax,rcx
  cmovc_rax,rcx
  setc_cl
  mov_rdx,#  ' Push @ ,   call_rdx           
  mov_rax,rcx
  call_rdx
  ret
  ALIGN
  
  
  CREATE a_arg  0 , 0 , 0 , 0 ,
  CREATE b_arg  0 , 0 , 0 , 0 ,
  
  ASSEMBLER FORTH32 LINK  
  
  CODE: SADD  
   mov_rax,# a_arg ,
   movdqu_xmm1,[rax]
   mov_rax,#   b_arg , 
   movdqu_xmm2,[rax]  
   psubd_xmm2,xmm1
   pabsd_xmm1,xmm2
   phaddd_xmm1,xmm2 
   mov_rax,# a_arg , 
   movdqu_[rax],xmm2
  ret
  ALIGN
  
  
  EXIT  
