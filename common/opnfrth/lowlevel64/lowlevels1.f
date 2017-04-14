 
  ASSEMBLER CONTEXT ! ASSEMBLER CURRENT !

    HEADER CODE:  interpret# ,  ' HEADER ,  ' HERE , ' CELL+ , ' , ,  ' EXIT ,

  
  ASSEMBLER FORTH32 LINK ASSEMBLER CONTEXT ! FORTH32 CURRENT !
  
  CODE:  ALLOT	      
  mov_rdx,#  ' Pop @ ,            call_rdx
  mov_rdx,#  ' HERE CELL+ ,
  add_[rdx],rax 
  mov_rdx,# ' ALIGN @ ,   call_rdx
  ret
  ALIGN

  
  CODE: bpoint 
  int3
  ret
  ALIGN
  
  
  CODE: DUP	   
  mov_rdx,#  ' Pop @ ,            call_rdx
  mov_rdx,#  ' Push @ ,  call_rdx  call_rdx
  ret
  ALIGN
  
  CODE: C!         
  mov_rdx,#  ' Pop @ ,            call_rdx      
  mov_rsi,rax  
  call_rdx         
  mov_[rsi],al      
  ret        
  ALIGN  
  
  CODE: 0!           
  mov_rdx,#  ' Pop @ ,            call_rdx      
  xor_rcx,rcx  
  mov_[rax],rcx      
  ret        
  ALIGN  
  
  CODE: SWAP!	       
  mov_rdx,#  ' Pop @ ,            call_rdx
  mov_rcx,rax
  call_rdx
  mov_[rax],rcx
  ret
  ALIGN

  CODE: >R	    
  mov_rdx,#  ' Pop @ ,   call_rdx
  pop_rbx
  pop_rcx
  push_rax
  push_rcx
  push_rbx
  ret
  ALIGN

  CODE: R>	   
  pop_rbx
  pop_rcx
  pop_rax
  push_rcx
  push_rbx
  mov_rdx,#  ' Push @ ,  call_rdx
  ret
  ALIGN
  
  CODE: RDROP	    
  pop_rbx
  pop_rcx
  pop_rax
  push_rcx
  push_rbx
  ret
  ALIGN

  CODE: R@	    
  pop_rbx
  pop_rcx
  pop_rax
  push_rax
  push_rcx
  push_rbx
  mov_rdx,#  ' Push @ ,  call_rdx
  ret
  ALIGN

  
  CODE: C@	    
  mov_rdx,#  ' Pop @ ,            call_rdx
  movzx_rax,b[rax]
  mov_rdx,#  ' Push @ ,           call_rdx
  ret
  ALIGN
  
  
  CODE: SP@ 
  mov_rdx,# ' Pop @ , call_rdx   
  mov_rdx,# ' Push @ , call_rdx   
  mov_rax,r10 
  call_rdx 
  ret 
  ALIGN      
  
  CODE: b(swap_ab) 
  mov_rdx,# ' Pop @ , call_rdx 
  xchg_al,ah  
  mov_rdx,# ' Push @ , call_rdx 
  ret 
  ALIGN
  
 

  CODE: SWAP 
  mov_rdx,# ' Pop @ , call_rdx   
  mov_rcx,rax 
  call_rdx    
  xchg_rax,rcx
  mov_rdx,# ' Push @ , call_rdx   
  mov_rax,rcx
  call_rdx 
  ret 
  ALIGN  
 
  CODE: clear           
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
  
