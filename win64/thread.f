  
z-str" _class opf_class" 
z-str" title wintitle" 

VARIABLE hwnd VARIABLE wmsg VARIABLE wparam VARIABLE lparam  
  
VECT  inWinProc  

INCLUDE: winuser.f 
INCLUDE: struct.f  
INCLUDE: reverse.f  

WINAPIS:
 LIB: User32.dll
		 c_ints CreateWindowExA
		 1_int  RegisterClassExA
		 1_int  TranslateMessage
		 1_int  DispatchMessageA
		 1_int  GetDC 
		 1_int  UpdateWindow
		 2_ints UnregisterClassA
		 2_ints LoadIconA
		 2_ints LoadCursorA
		 3_ints InvalidateRect 
		
		 4_ints DefWindowProcA
		 4_ints MessageBoxA 
		 4_ints GetMessageA
		 
   LIB: Kernel32.dll
       6_ints CreateThread
	   4_ints VirtualAlloc 
	   3_ints OpenThread 
	   1_int  ExitThread
	   1_int  ResumeThread
	   1_int  SuspendThread
	   1_int GetModuleHandleA
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

				 

WORD: SetModule:  HERE PARSE 1+ (SetModule) ;WORD 
WORD: Lib:        HERE PARSE 1+ (LIB)       ;WORD 				 
 
WORD: starttr:  >R 0 0 R>  DUP  ."  thread_low:"  h. 
                 0  hex, 10000   hex, 3000  hex, 40    VirtualAlloc 
 				 hex, 4  0   CreateThread    ;WORD 
 
ASSEMBLER FORTH32 LINK ASSEMBLER CONTEXT ! 
ASSEMBLER CURRENT ! 

            0x 57 0x 1 opcode push_rdi
            0x 56 0x 1 opcode push_rsi
      0x 51 0x 41 0x 2 opcode push_r9
      0x 50 0x 41 0x 2 opcode push_r8 
0x 10 0x 89 0x 48 0x 3 opcode mov_[rax],rdx 
0x 00 0x 89 0x 4C 0x 3 opcode mov_[rax],r8 
0x 08 0x 89 0x 4C 0x 3 opcode mov_[rax],r9 
            0x 5F 0x 1 opcode pop_rdi 	 
			0x 5E 0x 1 opcode pop_rsi
	  0x 58 0x 41 0x 2 opcode pop_r9
	  0x 58 0x 41 0x 2 opcode pop_r8
	        0x 5A 0x 1 opcode pop_rdx
0x EC 0x 83 0x 48 0x 3 opcode sub_rsp,b#
0x C4 0x 83 0x 48 0x 3 opcode add_rsp,b# 
0x E8 0x 89 0x 48 0x 3 opcode mov_rax,rbp
0x 09 0x 8B 0x 48 0x 3 opcode mov_rcx,[rcx] 
0x C9 0x 85 0x 48 0x 3 opcode test_rcx,rcx 

ASSEMBLER FORTH32 LINK ASSEMBLER CONTEXT !

IMMEDIATES CURRENT ! 

WORD:  thread_low 
    LATEST NAME>  HERE >R
	mov_rax,rcx
    mov_rbp,rsp
    sub_rsp,b# hex, 70 B, 

    mov_[rbp+b#],rax 0 B,
    xor_rax,rax
    mov_[rbp+b#],rax hex, F8 B,
	mov_rax,rbp
	mov_r11,#  COMPILE [ ' Push @ , ]    call_r11 
	mov_rax,#   , 
    mov_r11,#  COMPILE [ ' Push @ , ]    call_r11 
    mov_r11,#  COMPILE [ ' EXECUTE @ , ]   call_r11
   (( thread finish )
 
    mov_r11,# COMPILE [ ' ExitThread , ] call_r11
ALIGN  R>
 ;WORD 


 FORTH32 CURRENT ! 
 
  CODE: winproc 
  push_rcx push_rdx push_r8 push_r9 push_rbx push_rsi push_rdi push_rbp
 
  mov_rax,# hwnd ,   mov_[rax],rcx   
  mov_rax,# wmsg ,   mov_[rax],rdx   
  mov_rax,# wparam , mov_[rax],r8	 
  mov_rax,# lparam , mov_[rax],r9	 
  
  mov_r11,# ' restore_rbp @ ,
  call_r11
  ( mov_rbp,[rsp+d#] 0x 830 D, )
  nop
  
  nop
  mov_rax,# ' inWinProc  , 
  mov_r11,# ' Push @ ,    call_r11 
  mov_r11,# ' EXECUTE @ , call_r11 
  mov_r11,# ' Pop @ ,     call_r11 
  
  test_rax,rax
  jne	forward> 
   pop_rbp pop_rdi pop_rsi pop_rbx pop_r9 pop_r8 pop_rdx pop_rcx
  ret 
 
  >forward  
   pop_rbp pop_rdi pop_rsi pop_rbx pop_r9 pop_r8 pop_rdx pop_rcx 
  push_rcx     push_rdx push_r8 push_r9 push_rbx push_rsi push_rdi push_rbp
	 
  mov_r11,# ' DefWindowProcA CELL+ @ ,
  sub_rsp,b# 0x 20 B,
  call_r11 
  add_rsp,b# 0x 20 B, 
  pop_rbp pop_rdi pop_rsi pop_rbx pop_r9 pop_r8 pop_rdx pop_rcx
  ret
 ALIGN
 
 CODE: rbp@ 
     mov_rax,rbp
	 mov_r11,#   ' Push @ ,     call_r11 
	 ret 
 ALIGN
 
 CODE: tr>mem
 
       mov_r11,#  Lib: Kernel32.dll    SetModule: GetCurrentThreadId ,
       call_r11
       mov_rcx,# n_th ,
	   mov_rcx,[rcx]
	   mov_rdx,# threads CELL- , 
	   xor_rsi,rsi
	   backward<
	   nop nop
	   test_rcx,rcx 
	   nop nop
	(   je forward> )
	   sub_rcx,b# 0x 8 B, 
	   add_rsi,d# 0x 8 D, 
	   cmp_rax,[rsi+rdx] 
	   jne  <backward
	   mov_rdx,# mems CELL- , 
	   mov_rax,[rsi+rdx]
	   mov_r11,# ' Push @ , 
	   call_r11 
	   ret
	   
	(   >forward)
	   ret
	   ALIGN

  CODE: restore_rbp
 
       mov_r11,#  Lib: Kernel32.dll    SetModule: GetCurrentThreadId ,
       call_r11
       mov_rcx,# n_th ,
	   mov_rcx,[rcx]
	   mov_rdx,# threads CELL- , 
	   xor_rsi,rsi
	   backward<
	   nop nop
	   test_rcx,rcx 
	   nop nop
	(   je forward> )
	   sub_rcx,b# 0x 8 B, 
	   add_rsi,d# 0x 8 D, 
	   cmp_rax,[rsi+rdx] 
	   jne  <backward
	   mov_rdx,# mems CELL- , 
	   mov_rax,[rsi+rdx]
	   mov_rbp,rax
	   ret
	   
	(   >forward)
	   ret
	   ALIGN
	   
 FORTH32 CONTEXT ! 

 

Lib: Kernel32.dll SetModule:  GetCurrentThreadId h. 


 
WORD: tread+ 
                  
				  n_th @ mems + !  
				  get_thread_handle n_th @ threads + !
                  n_th @ CELL+ n_th !  				  ;WORD 
				  
 rbp@ DUP h. tread+ 

				  
WORD: thread>mem 
                  GetCurrentThreadId 
				  0 n_th @ Do DUP  threads R@ CELLs + @ <> If Pop  R@ CELLs mems + @ RDROP n_th @ >R   Then   Loop ;WORD 				  

WORD: inthread1     
                  tread+
				  Begin thr @ 1+ DUP thr !  h. ." thred 2 "   tr>mem  h. SP@ h.   hex, 1700 Sleep Pop Again    thread_low  ;WORD
 
starttr: CONSTANT mytr1


WORD: inthread2  
                 tread+
                 Begin thr @ 1+ DUP thr !  h. ." thred 3 " thread>mem   h. SP@ h. hex, 1937 Sleep Pop Again      thread_low   ;WORD
 
starttr: CONSTANT mytr2

CREATE msg  0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,

0 GetModuleHandleA  CONSTANT hInstance 

CREATE wc   0x 50 D, 0 D, ' winproc @ , 0 D, 0 D, hInstance , 
 0 IDI_APPLICATION LoadIconA  ,
 0 IDC_ARROW LoadCursorA   , 
 COLOR_BTNFACE , 0 , _class , 0 ,
 
  wc   RegisterClassExA  h.  

 STRUC: winparam
  QWORD ExStyle
  QWORD ClassName
  QWORD WindowName
  QWORD Style 
  QWORD x
  QWORD y
  QWORD Width
  QWORD Height 
  QWORD WndParent
  QWORD Menu
  QWORD Instance
  QWORD Param
  ;STRUC 
  
winparam    _class ClassName store   
            title WindowName store
WS_VISIBLE WS_DLGFRAME WS_SYSMENU   + + Style store 
	        0d 250 Width store  
			0d 200 Height store  
			hInstance Instance store  
			  
FORTH32 CONTEXT !  


WORD: innerloop    0 Begin Pop msg hwnd @ 0 0  bpoint GetMessageA DUP ." mesage " Until  ;WORD 


WORD: MessageLoop  
 tread+ hex, 1000 Sleep Pop 
 *{ winparam  get  }* CRLF ." new thread " CRLF 
  CreateWindowExA ." wincreated:" h. 
  
  thr @ 1+  thr ! 
          Begin  innerloop 1+  ?break  
		 
		        msg TranslateMessage Pop  	msg DispatchMessageA Pop 
 
          Again  thread_low  ;WORD
		  
		  starttr: CONSTANT mytr3
 
EXIT 

 
 
 
