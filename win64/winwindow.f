INCLUDE: winuser.f  

FORTH32 CONTEXT !     FORTH32 CURRENT !

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
	      1_int GetModuleHandleA
;WINAPIS


   
VECT  inWinProc   

VARIABLE hwnd VARIABLE wmsg VARIABLE wparam VARIABLE lparam  


ASSEMBLER FORTH32 LINK   ASSEMBLER CONTEXT !

HEADER winproc HERE CELL+ ,
   push_rcx push_rdx push_r8 push_r9 push_rbx push_rsi push_rdi 
  mov_rax,# hwnd ,
 mov_[rax],rcx   
  mov_rax,# wmsg ,
 mov_[rax],rdx   
  mov_rax,# wparam ,
 mov_[rax],r8	 
  mov_rax,# lparam ,
 mov_[rax],r9	 
 
  mov_rax,# ' inWinProc  , 
  mov_r11,# ' Push @ ,  call_r11 
 mov_r11,# ' EXECUTE @ , call_r11 
 mov_r11,# ' Pop @ ,  call_r11 
 test_rax,rax
 jne	forward> 
 pop_rdi pop_rsi pop_rbx pop_r9 pop_r8 pop_rdx pop_rcx
 ret 
 
  >forward  
 pop_rdi pop_rsi pop_rbx pop_r9 pop_r8 pop_rdx pop_rcx
push_rcx     push_rdx push_r8 push_r9 push_rbx push_rsi push_rdi 
	 
 mov_r11,# ' DefWindowProcA CELL+ @ ,
sub_rsp,b# 0x 20 B,
 call_r11 
add_rsp,b# 0x 20 B, 
 pop_rdi pop_rsi pop_rbx pop_r9 pop_r8 pop_rdx pop_rcx
ret
ALIGN

FORTH32 CONTEXT !


CREATE msg  0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,

WORD: innerloop   0 Begin Pop msg hwnd @ 0 0  GetMessageA DUP  Until  ;WORD 


WORD: MessageLoop  
          Begin innerloop 1+  ?break  
		  
		        msg TranslateMessage Pop  	msg DispatchMessageA Pop
 
          Again   ;WORD

FORTH32 CONTEXT !

0 GetModuleHandleA  CONSTANT hInstance .( winclass ) 

CREATE wc   0x 50 D, 0 D, ' winproc @ , 0 D, 0 D, hInstance , 
 0 IDI_APPLICATION LoadIconA  0 ,
 0 IDC_ARROW LoadCursorA  , 
 
 COLOR_BTNFACE , 0 , _class , 0 ,
 
 FORTH32 CONTEXT ! 
.( Registering class:) 
  wc   RegisterClassExA  h.  GetLastError h. CRLF

CRLF .( creating window )

.(  ww1 file is here ) 

WORD: opwn 
   0 _class title  WS_VISIBLE WS_DLGFRAME WS_SYSMENU  + +    0 0 hex, 150 hex, 100  0 0 hInstance 0   CreateWindowExA ."  Hwnd:" DUP hwnd !   hwnd @ GetDC hex, ffffffff AND DUP hdc !     
   
;WORD 

WORD: anb  opwn MessageLoop ;WORD 

EXIT 
