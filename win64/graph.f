
FORTH32 CONTEXT ! FORTH32 CURRENT ! 

 TEMPORARY{  
 
 WORD: set_constant_xt    [ ' HERE @ LIT, ] LATEST NAME> ! ;WORD 
 
 
INCLUDE: winuser.f  
INCLUDE: reverse.f 
  
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
		 3_ints  LineTo 
		 4_ints MoveToEx 
		 5_ints Ellipse 
		 9_ints Arc
		 
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

INCLUDE: graphics.f 

  0x ff        Color: color_a 
  0x ff00      Color: color_green
  0x 00ff0000  Color: color_blue
  
 .( Create pens:) 
   0 0x 6  color_a      Pen: mypen  
   1 0d 2  color_green  Pen: green_pen 
0x 2 0d 3  color_blue   Pen: blue_pen

           color_blue   SolidBrush: mybrush   mybrush h. 
		   
  *{ 0x 3 0x 3  0x 5 0x 18  0x 34 0x 88 }*  reversed 2/  Points: mypoints 
*{  0d 10 0d 20  0d 140 0d 40   0d 45 0d 95   0d 100 0d 120   0d 110 0d 130   0d 140 0d 160  0d 160 0d 165  }* reversed 2/ Points: mypts   

   
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
  
   mypts   PolyLine:   Myline
  
   mypts  PolyBezier: Mycurve
   
 0d 57 0d 220  0d 100 0d 18 Ellipse: myellipse 
 
 CREATE dragpoint 0x 145 D, 0x 45 D,  
  
 CREATE msg  0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,
 
 VARIABLE dragon  1 dragon !    VARIABLE ndot
 
 WORD: delta_xy      a_arg !  b_arg !  SADD a_arg @  hex, ffffffff AND    hex, 3 < NOT  ;WORD 
 
 ( hex, 4 isdot? ) 
 
 WORD: isdot?    DUP  CELLs mypts + @   lparam @   lparam2points  delta_xy  ;WORD 
 WORD: thedot    ndot !  0 dragon !  ;WORD 
 
 WORD: find_dot    
    Case
  hex, 1 isdot?  Of   thedot  EndOf
  hex, 2 isdot?  Of   thedot  EndOf
  hex, 3 isdot?  Of   thedot  EndOf
  hex, 4 isdot?  Of   thedot  EndOf
  hex, 5 isdot?  Of   thedot  EndOf 
  hex, 6 isdot?  Of   thedot  EndOf 
  hex, 7 isdot?  Of   thedot  EndOf 
     EndCase
 ;WORD
 
  defines  FORTH32 LINK
  
WORD: gbd    
				Case 
				
  wmsg @ [ CONTEXT @  defines CONTEXT ! ] WM_LBUTTONDOWN [ CONTEXT ! ] =  Of  
	 
		   find_dot  
	   hdc @ green_pen SelectObject Pop 
     Myline 
		
	   hdc @ blue_pen SelectObject Pop 
     Mycurve 
	 
    0 EndOf
	
  wmsg @ [ CONTEXT @  defines CONTEXT ! ] WM_LBUTTONUP [ CONTEXT ! ] = Of  
  
          1 dragon ! 
		  
    0 EndOf
	
  wmsg @ [ CONTEXT @  defines CONTEXT ! ] WM_MOUSEMOVE [ CONTEXT ! ] = Of  
  
 lparam @  lparam2points  mypts ndot @ CELLs + @   <> If 
 
         ."  dot " 
 hdc @ mypen SelectObject Pop     
 hdc @  lparam @  lparam2points splitqd 0 MoveToEx Pop 
 hdc @  lparam @  lparam2points splitqd LineTo Pop 
 
                                                     Then 
 
 
    dragon @ If  
	
  lparam @ lparam2points  mypts ndot @ CELLs +  !    

  hwnd @  0  1 InvalidateRect Pop    hwnd @ UpdateWindow Pop 
    		   
  hdc @ green_pen SelectObject Pop 
  
  Myline 
		
  hdc @ blue_pen SelectObject Pop 

  Mycurve 
    
	Then 
		 
0 EndOf

 ((  msg @ [ CONTEXT @  defines CONTEXT ! ] WM_PAINT [ CONTEXT ! ] =   Of  
 
  (( hdc @ green_pen SelectObject Pop 
   
   Myline 
		
   hdc @ blue_pen SelectObject Pop 
   

   0 EndOf )

   1 EndCase 	
    
 ;WORD 



INCLUDE: ww1.f  

' gbd   ' inWinProc CELL+ ! 


anb 

}TEMPORARY
  

EXIT   
