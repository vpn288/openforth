
FORTH32 CONTEXT ! FORTH32 CURRENT ! 

 TEMPORARY{  
 
 WORD: set_constant_xt    [ ' HERE @ LIT, ] LATEST NAME> ! ;WORD 
 
 
INCLUDE: winuser.f  
  
 FORTH32 CONTEXT ! FORTH32 CURRENT !


 
 

z-str" _class opf_class" 
z-str" winc Edit" 
z-str" title wintitle" 
z-str" jjj kkkkk" 



WINAPIS:
     LIB: Gdi32.dll 
	     1_int  CreateSolidBrush 
	     2_ints SelectObject 
	     3_ints CreatePen
		 3_ints Polyline 
		 3_ints PolyBezier
		 5_ints Ellipse 
		 9_ints Arc
		 
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

INCLUDE: graphics.f 

  0x ff        Color: color_a 
  0x ff00      Color: color_green
  0x 00ff0000  Color: color_blue
  
 .( Create pens:) 
   0 1     color_a      Pen: mypen  
   1 0d 2  color_green  Pen: green_pen 
0x 2 0d 3  color_blue   Pen: blue_pen
           color_blue   SolidBrush: mybrush   mybrush h. 
   
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

 
 
  
  (  *{ x1 y1  x2 y2 }*  ) 
  
 0x 40 0x 20  0x 87 0x 34 0x 45 0x 145    0x 40 0x 20   0x 4 PolyLine:   Myline
 0x 40 0x 20  0x 87 0x 34 0x 45 0x 145    0x 40 0x 20   0x 4 PolyBezier: Mycurve
 0d 57 0d 220  0d 100 0d 18 Ellipse: myellipse 
 CREATE dragpoint 0x 145 D, 0x 45 D,  
  
 CREATE msg  0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,
 
  defines  FORTH32 LINK (  defines CONTEXT ! )
WORD: gbd    

				Case 
           wmsg @ [ CONTEXT @  defines CONTEXT ! ] WM_MOUSEMOVE [ CONTEXT ! ] =   Of  
		   
   hdc @ green_pen SelectObject Pop 
    Myline 
	
		
	(( hdc @ mypen SelectObject Pop 
    myellipse )  
	
	hdc @ blue_pen SelectObject Pop 
	
	Mycurve 
	." button down:" lparam @ h. 
	
    0 EndOf
	
	wmsg @ [ CONTEXT @  defines CONTEXT ! ] WM_LBUTTONUP [ CONTEXT ! ] = Of  ." button up:" lparam @ h. 
    0 EndOf

    1 EndCase 	
    
 ;WORD 

' gbd   ' inWinProc CELL+ ! 

WORD: innerloop   0 Begin Pop msg hwnd @ 0 0  GetMessageA DUP  Until  ;WORD 

defines FORTH32 LINK  
WORD: MessageLoop  
          Begin innerloop 1+  ?break  
		  
		        msg TranslateMessage Pop  
				 
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
WORD: opwn    0 _class title [ CONTEXT @ defines CONTEXT ! ]  WS_VISIBLE WS_DLGFRAME WS_SYSMENU [ CONTEXT ! ] + +  (( hex, c10480000 )  0 0 hex, 150 hex, 100  0 0 hInstance 0   CreateWindowExA ."  Hwnd:" DUP hwnd !  h. hwnd @ GetDC hex, ffffffff AND DUP hdc !  h.   hdc @ mybrush SelectObject Pop   
 ." win closed" ;WORD 

FORTH32 CONTEXT ! 
 
WORD: anb  opwn MessageLoop ;WORD 

 
HERE h. 
anb 

.( slkdfj  )

}TEMPORARY
  
.( skjfsdkjh )

EXIT   
