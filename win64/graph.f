
FORTH32 CONTEXT ! FORTH32 CURRENT ! 


.( asdkja )  


( WORD: z-str"  CREATE  ,"  Pop DOES>  CELL+ 1+ ;WORD )

 TEMPORARY{   HERE h.
 
 WORD: set_constant_xt    [ ' HERE @ LIT, ] LATEST NAME> ! ;WORD 
 
 SP@ h. 
 
 
 
.( on to winuser )  SP@ h. 
INCLUDE: winuser.f  

 

.(   back to graph ) SP@ h.

  defines FORTH32 LINK  defines CONTEXT ! 
  DS_SHELLFONT  h.  DS_SETFONT h.  DS_FIXEDSYS h.  CRLF
  
 FORTH32 CONTEXT ! FORTH32 CURRENT !
CREATE color_a   0x 889023 , 

z-str" _class opf_class" 
z-str" winc Edit" 
z-str" title wintitle" 
z-str" jjj kkkkk" 



WINAPIS:
     LIB: Gdi32.dll 
	     3_ints CreatePen
		 3_ints Polyline 
		 
     LIB: User32.dll
		 c_ints CreateWindowExA
		 1_int  RegisterClassExA
		 1_int  TranslateMessage
		 1_int  DispatchMessageA
		 1_int  GetDC 
		 2_ints UnregisterClassA
		 2_ints LoadIconA
		 2_ints LoadCursorA
		 4_ints DefWindowProcA
		 4_ints MessageBoxA 
		 4_ints GetMessageA
		 
		 
	 LIB: Kernel32.dll
	      1_int GetModuleHandleA
		 
		 
;WINAPIS

 .( Create pen:) 
 0  0x 3 color_a CreatePen h. 
 
ASSEMBLER FORTH32 LINK   ASSEMBLER CONTEXT !

HEADER winproc HERE CELL+ ,
push_r11 push_rcx push_rdx push_r8 push_r9
mov_r11,# ' DefWindowProcA CELL+ @ ,
sub_rsp,b# 0x 20 B,
call_r11
add_rsp,b# 0x 20 B, 
pop_r9 pop_r8 pop_rdx pop_rcx pop_r11 
ret
ALIGN

FORTH32 CONTEXT !
 
VARIABLE hwnd   VARIABLE hdc 
CREATE myline  0x 11 D, 0x 13 D, 0x 44 D, 0x 32 D, 
CREATE msg  0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,

WORD: innerloop   0 Begin Pop msg hwnd @ 0 0  GetMessageA DUP  Until  ;WORD 

WORD: MessageLoop  
          Begin innerloop 1+  ?break  
                msg TranslateMessage Pop  
				hdc myline hex, 2 Polyline h.  GetLastError h. 
				msg  DispatchMessageA Pop
 
          Again   ;WORD

0 GetModuleHandleA  CONSTANT hInstance .( winclass ) 

CREATE wc   0x 50 D, 0 D, ' winproc @ , 0 D, 0 D, hInstance , 
 0 0d 32512 LoadIconA  0 ,
 0 0d 32512 LoadCursorA  , 
 defines FORTH32 LINK  defines CONTEXT !  
 COLOR_BTNFACE , 0 , _class , 0 ,

.( Registering class:) 
  wc   RegisterClassExA  h.  GetLastError h. CRLF



_class TYPEZ 
title TYPEZ
CRLF .( creating window )

  defines FORTH32 LINK  defines CONTEXT !  
WORD: opwn    0 _class title   WS_VISIBLE WS_DLGFRAME WS_SYSMENU + +  (( hex, c10480000 )  0 0 hex, 150 hex, 100  0 0 hInstance 0   CreateWindowExA ."  Hwnd:" DUP hwnd !  h. hwnd @ GetDC hex, ffffffff AND DUP hdc !  h.  
GetLastError h. CRLF  ." win closed" ;WORD 

FORTH32 CONTEXT ! 
 
WORD: anb  opwn MessageLoop ;WORD 

 
HERE h. 
anb 

.( slkdfj  )

}TEMPORARY
  
.( skjfsdkjh )

EXIT   