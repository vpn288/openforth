ASSEMBLER CONTEXT ! FORTH32 CURRENT !

  CODE: lit#	    
  mov_rax,[rsp+b#] 0x 8 B, 
  mov_rax,[rax+b#] 0x 8 B,
  mov_rdx,#  ' Push @ , call_rdx
  add_q[rsp+b#],b# 0x 8 B, 0x 8 B,
  ret
  ALIGN

  
  CODE: SLIT	       
  mov_rax,[rsp+b#] 0x 8 B, 
  add_rax,b# 0x 8 B,
  mov_rdx,#  ' Push @ ,           call_rdx
  mov_rax,[rsp+b#]  0x 8 B, 
  movzx_rbx,b[rax+b#] 0x 8 B, 
  inc_rbx  inc_rbx
  add_rax,rbx
  and_rax,b# 0x F8 B, 
  and_rbx,b# 0x 7 B, 
  setne_bl
  shl_rbx,# 0x 3 B,
  add_rax,rbx
  mov_[rsp+b#],rax 0x 8 B,
  ret
  ALIGN

 
  CODE: quit 
  mov_rax,[rsp+b#] 0x 20 B,
  add_rax,b# 0x 10 B, 
  mov_[rsp+b#],rax 0x 20 B,
  ret
  ALIGN
  
  CODE: break	    
  pop_rbx
  pop_rcx
  pop_rax

  ret
  ALIGN
    
  CODE: dodoes  
  add_rax,b# 0x 8 B, 
  mov_rdx,#  ' Push @ ,     call_rdx  
  pop_rax
  sub_rax,b# 0x 8 B, 
  mov_rdx,# ' ' @ , 
  push_rdx
  ret
  ALIGN
  
  CODE: here   
  mov_rax,[rsp+b#]   0x 8 B,            
  mov_rdx,#  ' Push @ ,           call_rdx        
  ret 
  ALIGN

  
  CODE: COMPILE	     
  mov_rax,[rsp+b#] 0x 8 B,
  mov_rax,[rax+b#] 0x 8 B, 
  mov_rdx,#  ' Push @ ,           call_rdx
  add_q[rsp+b#],b# 0x 8 B, 0x 8 B,
  mov_rdx,# ' , @ ,  call_rdx
  ret
  ALIGN

  CODE: BRANCH 	 	
  mov_rax,[rsp+b#] 0x 8 B,
  mov_rax,[rax+b#] 0x 8 B,
  mov_[rsp+b#],rax 0x 8 B,
  ret
  ALIGN

  CODE: ?OF	      
  mov_rcx,[rsp+b#] 0x 8 B,
  mov_rsi,[rcx+b#] 0x 8 B,
  add_rcx,b# 0x 8 B, 
  mov_rdx,#  ' Pop @ ,            call_rdx
  test_rax,rax
  cmove_rcx,rsi
  mov_rax,rcx
  mov_[rsp+b#],rcx 0x 8 B,
  ret
  ALIGN

  CODE: ?BRANCH	 
  mov_rcx,[rsp+b#] 0x 8 B, 
  mov_rsi,[rcx+b#] 0x 8 B,
  add_rcx,b# 0x 8 B,
  mov_rdx,#  ' Pop @ ,   call_rdx
  test_rax,rax
  cmovne_rcx,rsi
  mov_rax,rcx
  mov_[rsp+b#],rcx 0x 8 B, 
  ret
  ALIGN
  
  CODE: ?break 
  mov_rcx,d# 0x 10 D,
  xor_rsi,rsi
  mov_rdx,#  ' Pop @ ,   call_rdx
  test_rax,rax
  cmovne_rcx,rsi 
  add_rsp,rcx
  ret
  
  ALIGN

  CODE: strcopy	    
  mov_rdx,#  ' Pop @ ,            call_rdx
  mov_rdi,rax
  mov_rdx,#  ' Pop @ ,            call_rdx
  mov_rsi,rax
  movzx_rcx,b[rsi]
  shr_rcx,# 0x 3 B,
  inc_rcx
  cld
  rep movsq
  ret
  ALIGN

   
  CODE: 2@	    
  mov_rdx,#  ' Pop @ ,            call_rdx
  mov_rcx,rax
  mov_rsi,[rcx+b#] 0x 8 B,
  mov_rax,[rax]
  mov_rdx,#  ' Push @ ,           call_rdx
  mov_rax,rsi
  call_rdx
  ret
  ALIGN
  
  CODE: ASCIIZ>COUNT  
  mov_rdx,#  ' Pop @ ,            call_rdx
  mov_rdi,rax
  mov_rsi,rax
  xor_rax,rax 
  xor_rcx,rcx
  dec_rcx
  cld
  repne scasb
  neg_rcx
  mov_rax,rsi  
  mov_rdx,#  ' Push @ ,            call_rdx
  mov_rax,rcx
  call_rdx
  ret
  ALIGN
  
  
 CODE: b_swap_split    
 mov_rdx,# ' Pop @ , call_rdx 
 mov_ch,ah 
 and_rax,d#  0x ff D,
 mov_rdx,# ' Push @ , call_rdx 
 mov_al,ch
 call_rdx 
 ret
 ALIGN
 
 CODE: w_swap_split     
 mov_rdx,# ' Pop @ , call_rdx 
 mov_rcx,rax 
 and_rax,d#  0x ffff D,
 mov_rdx,# ' Push @ , call_rdx 
 shr_rcx,# 0x 10 B, 
 mov_rax,rcx
 and_rax,d#  0x ffff D,
 call_rdx 
 ret
 ALIGN 
 
 CODE: LowDword    
 mov_rdx,# ' Pop @ , call_rdx 
 mov_rcx,# 0x ffffffff , 
 and_rax,rcx
 mov_rdx,# ' Push @ , call_rdx 
 ret
 ALIGN 
 
   EXIT 
