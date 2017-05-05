
FORTH32 CONTEXT ! FORTH32 CURRENT ! 

(  TEMPORARY{  )
 
 WORD: set_constant_xt    (( [ ' HERE @ LIT, ] ) ['] HERE @  LATEST NAME> ! ;WORD 
 
  
z-str" _class opf_class" 
z-str" title wintitle" 
z-str" menu menuname"

INCLUDE: struct.f  .(  struct loaded )
INCLUDE: reverse.f  
INCLUDE: graphics.f .( graphics loded )
INCLUDE: winwindow.f    

 .( creating colors ) 
  0x ff        Color: color_a 
  0x ff00      Color: color_green
  0x 00ff0000  Color: color_blue

 ( Creating pens ) 
   0 0x 6  color_a      Pen: mypen  
   1 0d 2  color_green  Pen: green_pen 
0x 2 0d 3  color_blue   Pen: blue_pen

  ( making brush )
           color_blue   SolidBrush: mybrush  
		 

  *{ 0x 3 0x 3  0x 5 0x 18  0x 34 0x 88 }*  reversed   2/  Points: mypoints .(  hhhhhh )
 
  *{  0d 10  0d 20    0d 140 0d 40    0d 45  0d 95
      0d 100 0d 120   0d 110 0d 130   0d 140 0d 160  
	  0d 160 0d 165  }* reversed 2/ Points: mypts   

   mypts   PolyLine:   Myline
  
   mypts  PolyBezier: Mycurve
  
  
 0d 57 0d 220  0d 100 0d 18 Ellipse: myellipse 
 
 
 
 VARIABLE dragon  1 dragon !    VARIABLE ndot
 
 WORD: delta_xy      a_arg !  b_arg !  SADD a_arg @  LowDword   hex, 3 < NOT   ;WORD 
 
 
 
 WORD: isdot?    DUP  CELLs mypts + @   lparam @   lparam2points  delta_xy  ;WORD 
 WORD: thedot    ndot !  0 dragon !  ;WORD 
 
 
  
 WORD: find_dot    1  hex, 7 Do R@ isdot?  If Pop Else thedot Then  Loop ;WORD 
 
 0d 80 0d 90 0d 20 0d 10 0d 90 0d 80 0d 20 0d 10 myArcParam store FORTH32 CONTEXT ! 
 
 WORD: param2points    	lparam @  lparam2points ;WORD 
	
 WORD: drawpoint   	
					hdc @  mypen SelectObject Pop     
					hdc @  param2points splitqd 0 MoveToEx Pop 
					hdc @  param2points splitqd   LineTo   Pop    ;WORD 
					
WORD: drawdot   >R  
                hdc @  mypen SelectObject Pop 
				hdc @  R@ splitqd  0 MoveToEx Pop 
				hdc @  R@ splitqd  LineTo   Pop    RDROP  ;WORD 
	
 WORD: drawpoints   1 hex, 7 Do  mypts R@ CELLs + @  drawdot Loop  ;WORD 
 
 WORD: drawlines      hdc @ green_pen SelectObject Pop   Myline 		
                      hdc @ blue_pen  SelectObject Pop   Mycurve 
				((	  hdc @   myArcParam get   Arc Pop 
					  hdc @ myellipse Pop )
					  drawpoints 
 ;WORD 
 
     WORD: on_lbttndown      find_dot  drawlines   ;WORD  
		
  
	 
	 WORD: nsdot  param2points  mypts ndot @ CELLs + ;WORD 
	
	
	WORD: clearwin    hwnd @  0  1 InvalidateRect Pop    hwnd @ UpdateWindow Pop  ;WORD 
	
	

 
 MESSAGES{{ 
   
			WM_LBUTTONDOWN{{  on_lbttndown   }}
			WM_CREATE{{        drawlines      }} 
			WM_LBUTTONUP{{    1 dragon !     }}
			WM_MOUSEMOVE{{    nsdot  @   <> If  ."  dot "  drawpoint   Then  
 
                             dragon @ If  nsdot !  clearwin drawlines Then }} 
				  
 }}MESSAGES  

 
  winparam 0d 400 Width store   0d 400 Height store       FORTH32 CONTEXT !  
  .( anb start ) 
  anb 

( }TEMPORARY )
  

EXIT  


250317
