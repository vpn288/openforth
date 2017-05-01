WINAPIS:
   LIB: Kernel32.dll
       6_ints CreateThread
	   4_ints VirtualAlloc 
	   3_ints OpenThread 
	   1_int  ExitThread
	   1_int  ResumeThread
	   1_int  SuspendThread
	   void   GetCurrentThreadId
;WINAPIS 
 
WORD: get_thread_handle 
                 GetCurrentThreadId 
;WORD 

CREATE threads 0 , 0 , 0 , 0 , 0 , 0 ,
CREATE mems    0 , 0 , 0 , 0 , 0 , 0 , 
VARIABLE n_th   

get_thread_handle h. 
	
VECT ThreadProc

VARIABLE thr 
VARIABLE thr_stack
VARIABLE thread_id

				 
 
WORD: starttr:  >R 0 0 R>  DUP  ."  thread_low:"  h. 
                 0  hex, 10000   hex, 3000  hex, 40    VirtualAlloc 
 				 hex, 4  0   CreateThread    ;WORD 
 
ASSEMBLER FORTH32 LINK ASSEMBLER CONTEXT ! IMMEDIATES CURRENT ! 

WORD:  thread_low 
    LATEST NAME>  HERE >R
	mov_rax,rcx
    mov_rbp,rsp
    sub_rsp,b# hex, 70 B, 

    mov_[rbp+b#],rax 0 B,
    xor_rax,rax
    mov_[rbp+b#],rax hex, F8 B,
	mov_rax,rcx
	mov_r11,#  COMPILE [ ' Push @ , ]    call_r11 
	mov_rax,#   , 
    mov_r11,#  COMPILE [ ' Push @ , ]    call_r11 
    mov_r11,#  COMPILE [ ' EXECUTE @ , ]   call_r11
   (( thread finish )
 
    mov_r11,# COMPILE [ ' ExitThread , ] call_r11
ALIGN  R>
 ;WORD 


FORTH32 CONTEXT ! FORTH32 CURRENT ! 

WORD: tread+ 
                  
				  n_th @ mems + !  
				  get_thread_handle n_th @ threads + !
                  n_th @ CELL+ n_th !  				  ;WORD 
				  
 thread+ 
				  
WORD: thread>mem 
                  GetCurrentThreadId 
				  0 n_th @ Do DUP  threads R@ CELLs + @ <> If Pop  R@ CELLs mems + @ RDROP n_th @ >R   Then   Loop ;WORD 				  

WORD: inthread1     
                  tread+
				  Begin thr @ 1+ DUP thr !  h. ." thred 2 "   thread>mem  h.   hex, 1700 Sleep Pop Again    thread_low  ;WORD
 
starttr: CONSTANT mytr1


WORD: inthread2  
                 tread+
                 Begin thr @ 1+ DUP thr !  h. ." thred 3 " thread>mem   h. hex, 1937 Sleep Pop Again      thread_low   ;WORD
 
starttr: CONSTANT mytr2

 
EXIT 

starttr: CONSTANT mytr 

 WORD: inthread     Begin thr @ 1+ DUP thr !  h. ." thred 2 " GetCurrentThreadId  h.    hex, 400 Sleep Pop Again ;WORD 

   ' inthread TO ThreadProc   
 WORD: alloc_mem  0  hex, 10000   hex, 3000  hex, 40    VirtualAlloc ;WORD 

 DUP .( virt_alloc:) h. thr_stack ! 
 
  0 0   ' thread_low @                    thr_stack @ 
 				 0x 4   thread_id CreateThread  


hex, 10000   hex, 3000  hex, 40    VirtualAlloc DUP h.

				  
  
				
				  
 starttr



VARIABLE RSP 
WORD: stack_base_address   ['] Pop CELL- CELL- CELL- CELL- ;WORD 

ASSEMBLER CURRENT !
0x 22 0x 89 0x 48 0x 3 opcode mov_[rdx],rsp 

FORTH32 CURRENT ! 

HEADER rsp@  HERE CELL+ ,
 mov_rdx,# RSP , 
  mov_[rdx],rsp
ret
ALIGN 

 HERE
  mov_rax,# ' ThreadProc  , 
  mov_r11,# ' Push @ ,    call_r11 
  mov_r11,# ' EXECUTE @ , call_r11 

 mov_r11,#  , 
  jmp_r11   
  
  
( HEADER abcd  ' thread_start @ ,  HERE SWAP! interpret# ,  ' inthread , ' EXIT , )

WORD: Thread:  CREATE  
               0 0  ['] thread_test @ 
               0 hex, 12000 hex, 3000 hex, 40  VirtualAlloc  
			   hex, 4 CreateThread  , DOES> @ 
;WORD 

FORTH32 CONTEXT !
