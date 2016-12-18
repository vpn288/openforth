 ASSEMBLER FORTH32 LINK    ASSEMBLER CONTEXT !	  FORTH32 CURRENT !

 HEADER 1+	   HERE CELL+ ,
 mov_edx,#  ' Pop @ ,            call_edx
 inc_eax
 mov_edx,#  ' Push @ ,           call_edx
 ret
 ALIGN
 
 HEADER 2+         HERE CELL+ ,       
 mov_edx,#  ' Pop @ ,            call_edx       
 inc_eax    inc_eax        
 mov_edx,#  ' Push @ ,           call_edx           
 ret        
 ALIGN  
 
 HEADER +	 HERE CELL+ ,
 mov_edx,# ' Pop @ ,   call_edx
 mov_ebp,eax
 call_edx
 add_eax,ebp
 mov_edx,#  ' Push @ ,   call_edx
 ret
 ALIGN
 
 HEADER -      HERE CELL+ ,      
 mov_edx,# ' Pop @ ,    call_edx           
 mov_ebp,eax       
 call_edx          
 sub_eax,ebp       
 mov_edx,#  ' Push @ ,  call_edx    
 ret         
 ALIGN  
 
 HEADER 1-	   HERE CELL+ ,
 mov_edx,#  ' Pop @ ,            call_edx
 dec_eax
 mov_edx,#  ' Push @ ,           call_edx
 ret
 ALIGN
 
 HEADER NOT         HERE CELL+ ,       
 mov_edx,#  ' Pop @ ,            call_edx       
 not_eax            
 mov_edx,#  ' Push @ ,           call_edx           
 ret        
 ALIGN    

 HEADER SWAP-      HERE CELL+ ,     
 mov_edx,# ' Pop @ ,    call_edx      
 mov_ebp,eax         
 call_edx            
 sub_eax,ebp  neg_eax     
 mov_edx,#  ' Push @ ,  call_edx                                  
 ret           
 ALIGN    
 
 HEADER  CELL-	   HERE CELL+ ,
 mov_edx,#  ' Pop @ ,   call_edx
 sub_eax,4
 mov_edx,#  ' Push @ ,  call_edx
 ret
 ALIGN
 
HEADER =        HERE CELL+ ,                
mov_edx,# ' Pop @ ,   call_edx              
mov_ebp,eax           
call_edx                 
cmp_eax,ebp          
sete_al            
and_eax,# 0x FF , 
neg_eax   
mov_edx,#  ' Push @ ,   call_edx            
ret                                     
ALIGN        

 HEADER <>	  HERE CELL+ ,
 mov_edx,# ' Pop @ ,   call_edx
 mov_ebp,eax
 call_edx
 cmp_eax,ebp
 setne_al
 and_eax,# 0x FF ,
 neg_eax
 mov_edx,#  ' Push @ ,   call_edx
 ret
 ALIGN

 HEADER <	 HERE CELL+ ,
 mov_edx,# ' Pop @ ,   call_edx
 mov_ebp,eax
 call_edx
 cmp_eax,ebp
 seta_al
 and_eax,# 0x FF ,
 neg_eax
 mov_edx,#  ' Push @ ,   call_edx
 ret
 ALIGN

 HEADER AND        HERE CELL+ ,               
mov_edx,# ' Pop @ ,   call_edx              
mov_ebp,eax           
call_edx                    
and_eax,ebp          
mov_edx,#  ' Push @ ,   call_edx            
ret                                     
ALIGN      

 HEADER MAX        HERE CELL+ ,               
 mov_edx,# ' Pop @ ,   call_edx              
 mov_ebp,eax           
 call_edx     
 cmp_eax,ebp
 cmovc_eax,ebp 
 mov_edx,#  ' Push @ ,   call_edx            
 ret                                     
 ALIGN  

HEADER Rshift         HERE CELL+ ,       
mov_edx,#  ' Pop @ ,            call_edx       
mov_ecx,eax  
call_edx 
shr_eax,cl            
mov_edx,#  ' Push @ ,           call_edx           
ret        
ALIGN    

HEADER Lshift         HERE CELL+ ,       
 mov_edx,#  ' Pop @ ,            call_edx      
 mov_ecx,eax  
 call_edx 
 shl_eax,cl            
 mov_edx,#  ' Push @ ,           call_edx           
 ret        
 ALIGN    

 EXIT   
