
FORTH32 CONTEXT ! FORTH32 CURRENT ! 

 TEMPORARY{  
 
 WORD: set_constant_xt    [ ' HERE @ LIT, ] LATEST NAME> ! ;WORD 
 
  
z-str" _class opf_class" 
z-str" title wintitle" 
z-str" menu menuname"

INCLUDE: reverse.f 
INCLUDE: graphics.f 
INCLUDE: winwindow.f    

( creating colors ) 
  0x ff        Color: color_a 
  0x ff00      Color: color_green
  0x 00ff0000  Color: color_blue

 ( Creating pens ) 
   0 0x 6  color_a      Pen: mypen  
   1 0d 2  color_green  Pen: green_pen 
0x 2 0d 3  color_blue   Pen: blue_pen

 ( making brush )
           color_blue   SolidBrush: mybrush  
		 

  *{ 0x 3 0x 3  0x 5 0x 18  0x 34 0x 88 }*  reversed 2/  Points: mypoints 
 
  *{  0d 10  0d 20    0d 140 0d 40    0d 45  0d 95
      0d 100 0d 120   0d 110 0d 130   0d 140 0d 160  
	  0d 160 0d 165  }* reversed 2/ Points: mypts   

   mypts   PolyLine:   Myline
  
   mypts  PolyBezier: Mycurve
  
  
 0d 57 0d 220  0d 100 0d 18 Ellipse: myellipse 
 
 
 
 VARIABLE dragon  1 dragon !    VARIABLE ndot
 
 WORD: delta_xy      a_arg !  b_arg !  SADD a_arg @  LowDword   hex, 3 <   ;WORD 
 
 ( hex, 4 isdot? ) 
 
 WORD: isdot?    DUP  CELLs mypts + @   lparam @   lparam2points  delta_xy  ;WORD 
 WORD: thedot    ndot !  0 dragon !  ;WORD 
 
  
 WORD: find_dot    1  hex, 7 Do R@ isdot?  If thedot Then  Loop ;WORD 
 
 
 WORD: on_lbttndown 
 
     find_dot  ." btndon " 

	 hdc @ green_pen SelectObject Pop      Myline 
		
	 hdc @ blue_pen  SelectObject Pop      Mycurve  ;WORD 
	 
	 WORD: (wm_lbuttondown) wmsg @  WM_LBUTTONDOWN = ;WORD 
	 
	 
	 IMMEDIATES CURRENT ! 
 
WORD:   WM_LBUTTONDOWN{       COMPILE (wm_lbuttondown) COMPILE ?OF HERE    COMPILE 0 ;WORD 

 WORD: }WM_LBUTTONDOWN     THEN  COMPILE 0 ;WORD 
 
 FORTH32 CURRENT ! 
 
  
WORD: gbd    
			
        WM_LBUTTONDOWN{ on_lbttndown }WM_LBUTTONDOWN 
		
			Case 
				
    (( wmsg @  WM_LBUTTONDOWN =  Of  

	 find_dot  

	 hdc @ green_pen SelectObject Pop      Myline 
		
	 hdc @ blue_pen  SelectObject Pop      Mycurve 
	 
    0 EndOf )
	
     wmsg @  WM_LBUTTONUP  = Of  
  
          1 dragon ! 
		  
    0 EndOf
	
    wmsg @  WM_MOUSEMOVE  = Of  
  
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

  msg @  WM_PAINT =   Of  
 
  
   Myline 
		
   hdc @ blue_pen SelectObject Pop 
   

   0 EndOf 
   msg @ WM_CLOSE = Of    EndOf 

   1 EndCase 	
    
 ;WORD 



' gbd   ' inWinProc CELL+ ! 


anb 

}TEMPORARY
  

EXIT   
