 ASSEMBLER CONTEXT !	  FORTH32 CURRENT !   

 CODE: 1+	  
 mov_rdx,#  ' Pop @ ,            call_rdx
 inc_rax
 mov_rdx,#  ' Push @ ,           call_rdx
 ret

 ALIGN
  
 
 CODE: 2+         
 mov_rdx,#  ' Pop @ ,            call_rdx       
 inc_rax    inc_rax        
 mov_rdx,#  ' Push @ ,           call_rdx           
 ret        
 ALIGN  
   
 CODE: +	 
 mov_rdx,# ' Pop @ ,   call_rdx
 mov_rcx,rax
 call_rdx
 add_rax,rcx
 mov_rdx,#  ' Push @ ,   call_rdx
 ret
 ALIGN
 
 CODE: -      
 mov_rdx,# ' Pop @ ,    call_rdx           
 mov_rcx,rax       
 call_rdx          
 sub_rax,rcx       
 mov_rdx,#  ' Push @ ,  call_rdx    
 ret         
 ALIGN  
 
 CODE: 1-	   
 mov_rdx,#  ' Pop @ ,            call_rdx
 dec_rax
 mov_rdx,#  ' Push @ ,           call_rdx
 ret
 ALIGN
 
 CODE: NOT         
 mov_rdx,#  ' Pop @ ,            call_rdx       
 not_rax            
 mov_rdx,#  ' Push @ ,           call_rdx           
 ret        
 ALIGN    
 
 CODE: NEGATE        
 mov_rdx,#  ' Pop @ ,            call_rdx       
 neg_rax            
 mov_rdx,#  ' Push @ ,           call_rdx           
 ret        
 ALIGN    

 CODE: SWAP-     
 mov_rdx,# ' Pop @ ,    call_rdx      
 mov_rcx,rax         
 call_rdx            
 sub_rax,rcx  neg_rax     
 mov_rdx,#  ' Push @ ,  call_rdx                                  
 ret           
 ALIGN    
 

 CODE:  CELL-	   
 mov_rdx,#  ' Pop @ ,   call_rdx
 sub_rax,b# 0x 8 B, 
 mov_rdx,#  ' Push @ ,  call_rdx
 ret
 ALIGN
 
 CODE:  CELLs   
 mov_rdx,#  ' Pop @ ,   call_rdx
 shl_rax,# 0x 3 B, 
 mov_rdx,#  ' Push @ ,  call_rdx
 ret
 ALIGN 
 
 
CODE: =       
mov_rdx,# ' Pop @ ,   call_rdx              
mov_rbp,rax           
call_rdx                 
cmp_rax,rbp          
sete_al            
and_rax,d# 0x FF D, 
neg_rax   
mov_rdx,#  ' Push @ ,   call_rdx            
ret                                     
ALIGN        

 CODE: <>	 
 mov_rdx,# ' Pop @ ,   call_rdx
 mov_rbp,rax
 call_rdx
 cmp_rax,rbp
 setne_al
 and_rax,d# 0x FF D,
 neg_rax
 mov_rdx,#  ' Push @ ,   call_rdx
 ret
 ALIGN

 CODE: <	 
 mov_rdx,# ' Pop @ ,   call_rdx
 mov_rbp,rax
 call_rdx
 cmp_rax,rbp
 seta_al
 and_rax,d# 0x FF D,
 neg_rax
 mov_rdx,#  ' Push @ ,   call_rdx
 ret
 ALIGN

 CODE: AND       
 mov_rdx,# ' Pop @ ,   call_rdx              
 mov_rcx,rax           
 call_rdx                    
 and_rax,rcx          
 mov_rdx,#  ' Push @ ,   call_rdx            
 ret                                     
 ALIGN   

 CODE: OR        
 mov_rdx,# ' Pop @ ,   call_rdx              
 mov_rbp,rax           
 call_rdx                    
 or_rax,rbp          
 mov_rdx,#  ' Push @ ,   call_rdx            
 ret                                     
 ALIGN 

 CODE: MAX       
 mov_rdx,# ' Pop @ ,   call_rdx              
 mov_rbp,rax           
 call_rdx     
 cmp_rax,rbp
 cmovc_rax,rbp 
 mov_rdx,#  ' Push @ ,   call_rdx            
 ret                                     
 ALIGN  

CODE: Rshift       
mov_rdx,#  ' Pop @ ,            call_rdx       
mov_rcx,rax  
call_rdx 
shr_rax,cl            
mov_rdx,#  ' Push @ ,           call_rdx           
ret        
ALIGN    

CODE: 2/         
mov_rdx,#  ' Pop @ ,            call_rdx       
shr_rax,1            
mov_rdx,#  ' Push @ ,           call_rdx           
ret        
ALIGN

CODE: Lshift       
 mov_rdx,#  ' Pop @ ,            call_rdx      
 mov_rcx,rax  
 call_rdx 
 shl_rax,cl            
 mov_rdx,#  ' Push @ ,           call_rdx           
 ret        
 ALIGN    

 EXIT   
