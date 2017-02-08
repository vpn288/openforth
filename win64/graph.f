
FORTH32 CONTEXT ! FORTH32 CURRENT ! 

 TEMPORARY{  
 
 WORD: set_constant_xt    [ ' HERE @ LIT, ] LATEST NAME> ! ;WORD 
 
 WORD: NOOP    ;WORD 
 
 WORD: VECT   HEADER  [ ' BADWORD @ LIT, ] , [ ' NOOP  LIT, ] ,   ;WORD   
 
 WORD: mmn   ." vector tested " ;WORD 
 .( vector test )
 VECT nbh    nbh     ' mmn  ' nbh CELL+ !   nbh  .(  end vect test ) CRLF 
 
 
INCLUDE: winuser.f  
  
 FORTH32 CONTEXT ! FORTH32 CURRENT !
CREATE color_a   0x 889023 , 

z-str" _class opf_class" 
z-str" winc Edit" 
z-str" title wintitle" 
z-str" jjj kkkkk" 



WINAPIS:
     LIB: Gdi32.dll 
	     2_ints SelectObject 
	     3_ints CreatePen
		 3_ints Polyline 
		 3_ints PolyBezier
		 
     LIB: User32.dll
		 c_ints CreateWindowExA
		 1_int  RegisterClassExA
		 1_int  TranslateMessage
		 1_int  DispatchMessageA
		 1_int  GetDC 
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

 .( Create pen:) 
 0  0x 1 color_a CreatePen CONSTANT mypen  
 
VECT  inWinProc   
VARIABLE hwnd VARIABLE wmsg VARIABLE wparam VARIABLE lparam  

ASSEMBLER FORTH32 LINK   ASSEMBLER CONTEXT !

HEADER winproc HERE CELL+ ,
 push_r11 push_rcx push_rdx push_r8 push_r9 push_rbx push_rsi push_rdi 
 ( test_rcx,rcx
 je	forward> )
 mov_rax,# hwnd ,
 mov_[rax],rcx   
  mov_rax,# wmsg ,
 mov_[rax],rdx   
  mov_rax,# wparam ,
 mov_[rax],r8	 
  mov_rax,# lparam ,
 mov_[rax],r9	 
 cmp_rdx,d# 0x f D, 
 jne	forward> 
  mov_rax,# ' inWinProc  , 
  mov_r11,# ' Push @ ,  call_r11 
 mov_r11,# ' EXECUTE @ , call_r11 
 mov_r11,# ' Pop @ ,  call_r11 
 test_rax,rax
 jne	forward> 
 pop_rdi pop_rsi pop_rbx pop_r9 pop_r8 pop_rdx pop_rcx pop_r11 
 ret 
 
  >forward  >forward 
 pop_rdi pop_rsi pop_rbx pop_r9 pop_r8 pop_rdx pop_rcx pop_r11 
   push_r11 push_rcx push_rdx push_r8 push_r9 push_rbx push_rsi push_rdi 
 mov_r11,# ' DefWindowProcA CELL+ @ ,
sub_rsp,b# 0x 20 B,
 call_r11 
add_rsp,b# 0x 20 B, 
 pop_rdi pop_rsi pop_rbx pop_r9 pop_r8 pop_rdx pop_rcx pop_r11 
ret
ALIGN

FORTH32 CONTEXT !

 
   VARIABLE hdc 
CREATE myline  0x 11 D, 0x 13 D, 0x 44 D, 0x 32 D, 
CREATE mycurve 0d 10 D, 0d 20 D,   0d 40 D, 0d 30 D,  0d 60 D, 0d 50 D,   0d 80 D, 0d 90 D, 
CREATE msg  0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,
 
 WORD: hwnd@    msg @ ;WORD
 WORD: umsg     msg CELL+ @ ;WORD 
 WORD: wParam   msg CELL+ CELL+ @ ;WORD 
 WORD: lParam   msg CELL+ CELL+ CELL+ @ ;WORD 
 
 WORD: WinProc   hwnd@ umsg wParam lParam  DefWindowProcA  ;WORD 
 

WORD: gbd     wmsg @ hex, f  = bpoint  If  ." inmsg:"  0 hdc @ myline hex, 2 Polyline Pop  0 Else   1 Then     ;WORD 

' gbd   ' inWinProc CELL+ ! 

WORD: innerloop   0 Begin Pop msg hwnd @ 0 0  GetMessageA DUP  Until  ;WORD 

defines FORTH32 LINK  
WORD: MessageLoop  
          Begin innerloop 1+  ?break  
		  
		   ((     msg   CELL+ @ h. )
                msg TranslateMessage Pop  
				 
			((	hdc @ myline hex, 2 Polyline Pop )
			((	hdc @ mycurve hex, 4 PolyBezier Pop )
			((	hwnd @ 0 -1 InvalidateRect Pop   )
				msg  DispatchMessageA Pop
 
          Again   ;WORD

FORTH32 CONTEXT !

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

 ( defines FORTH32 LINK  defines CONTEXT !  )
WORD: opwn    0 _class title [ CONTEXT @ defines CONTEXT ! ]  WS_VISIBLE WS_DLGFRAME WS_SYSMENU [ CONTEXT ! ] + +  (( hex, c10480000 )  0 0 hex, 150 hex, 100  0 0 hInstance 0   CreateWindowExA ."  Hwnd:" DUP hwnd !  h. hwnd @ GetDC hex, ffffffff AND DUP hdc !  h.  hdc @ mypen SelectObject h. 
GetLastError h. CRLF  ." win closed" ;WORD 

FORTH32 CONTEXT ! 
 
WORD: anb  opwn MessageLoop ;WORD 

 
HERE h. 
anb 

.( slkdfj  )

}TEMPORARY
  
.( skjfsdkjh )

EXIT   
