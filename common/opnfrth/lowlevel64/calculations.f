 ASSEMBLER CONTEXT !	  FORTH32 CURRENT !   

 HEADER 1+	   HERE CELL+ ,
 mov_rdx,#  ' Pop @ ,            call_rdx
 inc_rax
 mov_rdx,#  ' Push @ ,           call_rdx
 ret

 ALIGN
  
 
 HEADER 2+         HERE CELL+ ,       
 mov_rdx,#  ' Pop @ ,            call_rdx       
 inc_rax    inc_rax        
 mov_rdx,#  ' Push @ ,           call_rdx           
 ret        
 ALIGN  
   
 HEADER +	 HERE CELL+ ,
 mov_rdx,# ' Pop @ ,   call_rdx
 mov_rcx,rax
 call_rdx
 add_rax,rcx
 mov_rdx,#  ' Push @ ,   call_rdx
 ret
 ALIGN
 
 HEADER -      HERE CELL+ ,      
 mov_rdx,# ' Pop @ ,    call_rdx           
 mov_rcx,rax       
 call_rdx          
 sub_rax,rcx       
 mov_rdx,#  ' Push @ ,  call_rdx    
 ret         
 ALIGN  
 
 HEADER 1-	   HERE CELL+ ,
 mov_rdx,#  ' Pop @ ,            call_rdx
 dec_rax
 mov_rdx,#  ' Push @ ,           call_rdx
 ret
 ALIGN
 
 HEADER NOT         HERE CELL+ ,       
 mov_rdx,#  ' Pop @ ,            call_rdx       
 not_rax            
 mov_rdx,#  ' Push @ ,           call_rdx           
 ret        
 ALIGN    
 
 HEADER NEGATE         HERE CELL+ ,       
 mov_rdx,#  ' Pop @ ,            call_rdx       
 neg_rax            
 mov_rdx,#  ' Push @ ,           call_rdx           
 ret        
 ALIGN    

 HEADER SWAP-      HERE CELL+ ,     
 mov_rdx,# ' Pop @ ,    call_rdx      
 mov_rcx,rax         
 call_rdx            
 sub_rax,rcx  neg_rax     
 mov_rdx,#  ' Push @ ,  call_rdx                                  
 ret           
 ALIGN    
 

 
 HEADER  CELL-	   HERE CELL+ ,
 mov_rdx,#  ' Pop @ ,   call_rdx
 sub_rax,b# 0x 8 B, 
 mov_rdx,#  ' Push @ ,  call_rdx
 ret
 ALIGN
 
 HEADER  CELLs    HERE CELL+ ,
 mov_rdx,#  ' Pop @ ,   call_rdx
 shl_rax,# 0x 3 B, 
 mov_rdx,#  ' Push @ ,  call_rdx
 ret
 ALIGN 
 
 
HEADER =        HERE CELL+ ,                
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

 HEADER <>	  HERE CELL+ ,
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

 HEADER <	 HERE CELL+ ,
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

 HEADER AND        HERE CELL+ ,               
 mov_rdx,# ' Pop @ ,   call_rdx              
 mov_rbp,rax           
 call_rdx                    
 and_rax,rbp          
 mov_rdx,#  ' Push @ ,   call_rdx            
 ret                                     
 ALIGN   

 HEADER OR        HERE CELL+ ,               
 mov_rdx,# ' Pop @ ,   call_rdx              
 mov_rbp,rax           
 call_rdx                    
 or_rax,rbp          
 mov_rdx,#  ' Push @ ,   call_rdx            
 ret                                     
 ALIGN 

 HEADER MAX        HERE CELL+ ,               
 mov_rdx,# ' Pop @ ,   call_rdx              
 mov_rbp,rax           
 call_rdx     
 cmp_rax,rbp
 cmovc_rax,rbp 
 mov_rdx,#  ' Push @ ,   call_rdx            
 ret                                     
 ALIGN  

HEADER Rshift         HERE CELL+ ,       
mov_rdx,#  ' Pop @ ,            call_rdx       
mov_rcx,rax  
call_rdx 
shr_rax,cl            
mov_rdx,#  ' Push @ ,           call_rdx           
ret        
ALIGN    

HEADER 2/         HERE CELL+ ,       
mov_rdx,#  ' Pop @ ,            call_rdx       
shr_rax,1            
mov_rdx,#  ' Push @ ,           call_rdx           
ret        
ALIGN

HEADER Lshift         HERE CELL+ ,       
 mov_rdx,#  ' Pop @ ,            call_rdx      
 mov_rcx,rax  
 call_rdx 
 shl_rax,cl            
 mov_rdx,#  ' Push @ ,           call_rdx           
 ret        
 ALIGN    

 EXIT   
