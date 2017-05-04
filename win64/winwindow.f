

VARIABLE hwnd VARIABLE wmsg VARIABLE wparam VARIABLE lparam  
  
VECT  inWinProc  

INCLUDE: winuser.f  
 INCLUDE: thread.f 

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


  



ASSEMBLER FORTH32 LINK   ASSEMBLER CONTEXT !

HEADER winproc HERE CELL+ ,
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

 HEADER  qmove   HERE CELL+ , ( addr_from addr_to count_in_cells )
 mov_rdx,# ' Pop @ ,  call_rdx 
 mov_rcx,rax
 call_rdx
 mov_rdi,rax
 call_rdx
 mov_rsi,rax
 cld
 rep movsq
 ret
 ALIGN
 
FORTH32 CONTEXT !


CREATE msg  0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,

WORD: innerloop   0 Begin Pop msg hwnd @ 0 0  GetMessageA DUP  Until  ;WORD 


WORD: MessageLoop  
          Begin innerloop 1+  ?break  
		 
		        msg TranslateMessage Pop  	msg DispatchMessageA Pop ." msgloop " 
 
          Again   ;WORD
		  
menu TYPEZ 

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

  
WORD: opwn  
*{ winparam  get  }* 
  CreateWindowExA    DUP ." hwnd:" h.  hwnd !   hwnd @ GetDC hdc !     
   
;WORD 
 
WORD: anb       opwn ." opwn " MessageLoop  ;WORD 

EXIT 
 0 _class title WS_VISIBLE WS_DLGFRAME WS_SYSMENU + + 0 0 hex, 150 hex, 100 0 0 hInstance 0   


((    0 _class title WS_VISIBLE WS_DLGFRAME WS_SYSMENU + + 0 0 hex, 150 hex, 100 0 0 hInstance 0 )
  
  
 ( 
			  
  ( winparam  get   TYPE  TYPEZ  TYPEZ h. h. h. h. h. h. h. h.  h.     ( EXPECT ( UNLINK Pop )
