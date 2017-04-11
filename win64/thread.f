WINAPIS:
   LIB: Kernel32.dll
       5_ints CreateThread
	   4_ints VirtualAlloc 
	   void   GetCurrentThread
;WINAPIS 


 
 GetCurrentThread .( main thread ) h. 

	
VECT ThreadProc

VARIABLE thr 
VARIABLE thr_stack
VARIABLE RSP 
WORD: stack_base_address   ['] Pop CELL- CELL- CELL- CELL- ;WORD 

0 0x 10000 0x 3000  0x 40  VirtualAlloc thr_stack !  thr_stack @ h. 

ASSEMBLER FORTH32 LINK ASSEMBLER CONTEXT !
ASSEMBLER CURRENT !
0x 22 0x 89 0x 48 0x 3 opcode mov_[rdx],rsp 

FORTH32 CURRENT ! 

HEADER rsp@  HERE CELL+ ,
 mov_rdx,# RSP , 
  mov_[rdx],rsp
ret
ALIGN 

HEADER  thread_test  HERE CELL+ , 
    mov_rax,rcx
    mov_rbp,rsp
   sub_rsp,b# 0x 70 B, 
    mov_[rbp+b#],rax 0 B,
   xor_rax,rax
   mov_[rbp+b#],rax 0x F8 B,
   
   HERE
  mov_rax,# ' ThreadProc  , 
  mov_r11,# ' Push @ ,    call_r11 
  mov_r11,# ' EXECUTE @ , call_r11 

 mov_r11,#  , 
  jmp_r11   
  
 
ALIGN

WORD: Thread:  CREATE  
               0 0  (( здесь должен быть адрес начала треда )
               0 hex, 12000 hex, 3000 hex, 40  VirtualAlloc  
			   hex, 4 CreateThread 
;WORD 

FORTH32 CONTEXT !

WORD: tred   thr @ 1+ DUP thr !  h.  ." thred 2 "  hex, 40 Sleep Pop ;WORD 

' tred   ' ThreadProc CELL+ ! 


 0 0 ' thread_test @  thr_stack @  0 CreateThread h. 

EXIT 
