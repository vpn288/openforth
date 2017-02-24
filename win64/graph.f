
FORTH32 CONTEXT ! FORTH32 CURRENT ! 

 TEMPORARY{  
 
 WORD: set_constant_xt    [ ' HERE @ LIT, ] LATEST NAME> ! ;WORD 
 
 
INCLUDE: winuser.f  
INCLUDE: reverse.f 
INCLUDE: graphics.f 
  
 FORTH32 CONTEXT ! FORTH32 CURRENT !

z-str" _class opf_class" 
z-str" title wintitle" 


 INCLUDE: winwindow.f  
 
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




 
  
  (  *{ x1 y1  x2 y2 }*  ) 
  
   mypts   PolyLine:   Myline
  
   mypts  PolyBezier: Mycurve
   
 0d 57 0d 220  0d 100 0d 18 Ellipse: myellipse 
 
 CREATE dragpoint 0x 145 D, 0x 45 D,  
  
 
 
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





' gbd   ' inWinProc CELL+ ! 


anb 

}TEMPORARY
  

EXIT   
