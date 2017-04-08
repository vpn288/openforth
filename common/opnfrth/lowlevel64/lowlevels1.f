ASSEMBLER CONTEXT ! FORTH32 CURRENT !

  
  HEADER ALLOT	    HERE CELL+ ,
  mov_rdx,#  ' Pop @ ,            call_rdx
  mov_rdx,#  ' HERE CELL+ ,
  add_[rdx],rax 
  mov_rdx,# ' ALIGN @ ,   call_rdx
  ret
  ALIGN

  
  HEADER bpoint HERE CELL+ ,
  int3
  ret
  ALIGN
  
  
  HEADER DUP	    HERE CELL+ ,
  mov_rdx,#  ' Pop @ ,            call_rdx
  mov_rdx,#  ' Push @ ,  call_rdx  call_rdx
  ret
  ALIGN
  
  HEADER C!         HERE CELL+ ,   
  mov_rdx,#  ' Pop @ ,            call_rdx      
  mov_rsi,rax  
  call_rdx         
  mov_[rsi],al      
  ret        
  ALIGN  
  
  HEADER 0!         HERE CELL+ ,   
  mov_rdx,#  ' Pop @ ,            call_rdx      
  xor_rcx,rcx  
  mov_[rax],rcx      
  ret        
  ALIGN  
  
  HEADER SWAP!	       HERE CELL+ ,
  mov_rdx,#  ' Pop @ ,            call_rdx
  mov_rcx,rax
  call_rdx
  mov_[rax],rcx
  ret
  ALIGN

  HEADER >R	    HERE CELL+ ,
  mov_rdx,#  ' Pop @ ,   call_rdx
  pop_rbx
  pop_rcx
  push_rax
  push_rcx
  push_rbx
  ret
  ALIGN

  HEADER R>	    HERE CELL+ ,
  pop_rbx
  pop_rcx
  pop_rax
  push_rcx
  push_rbx
  mov_rdx,#  ' Push @ ,  call_rdx
  ret
  ALIGN
  
  HEADER RDROP	    HERE CELL+ ,
  pop_rbx
  pop_rcx
  pop_rax
  push_rcx
  push_rbx
  ret
  ALIGN

  HEADER R@	    HERE CELL+ ,
  pop_rbx
  pop_rcx
  pop_rax
  push_rax
  push_rcx
  push_rbx
  mov_rdx,#  ' Push @ ,  call_rdx
  ret
  ALIGN

  
  HEADER C@	    HERE CELL+ ,
  mov_rdx,#  ' Pop @ ,            call_rdx
  movzx_rax,b[rax]
  mov_rdx,#  ' Push @ ,           call_rdx
  ret
  ALIGN
  
  
  HEADER SP@ HERE CELL+ , 
  mov_rdx,# ' Pop @ , call_rdx   
  mov_rdx,# ' Push @ , call_rdx   
  mov_rax,r10 
  call_rdx 
  ret 
  ALIGN      
  
  HEADER b(swap_ab) HERE CELL+ , 
  mov_rdx,# ' Pop @ , call_rdx 
  xchg_al,ah  
  mov_rdx,# ' Push @ , call_rdx 
  ret 
  ALIGN
  
 

  HEADER SWAP HERE CELL+ , 
  mov_rdx,# ' Pop @ , call_rdx   
  mov_rcx,rax 
  call_rdx    
  xchg_rax,rcx
  mov_rdx,# ' Push @ , call_rdx   
  mov_rax,rcx
  call_rdx 
  ret 
  ALIGN  
 
  HEADER clear            HERE CELL+ ,                      
  mov_rdx,#  ' Pop @ ,  call_rdx         
  mov_rdi,rax        
  mov_rdx,#  ' Pop @ ,    call_rdx       
  mov_rcx,rax                
  xor_rax,rax                
  cld               
  rep_stosb                  
  ret      
  ALIGN    
 
 
   EXIT
